DGPFLMA4 ;ALB/KCL - PRF ASSIGNMENT LM PROTOCOL ACTIONS CONT. ; 10/18/06 9:41am
 ;;5.3;Registration;**425,554,650,951,1113**;Aug 13, 1993;Build 10
 ;
 ;no direct entry
 Q
 ;
 ;
CO ;Entry point for DGPF CHANGE ASSIGNMENT OWNERSHIP action protocol.
 ;
 ;  Input: None
 ;
 ; Output:
 ;   VALMBCK - 'R' = refresh screen
 ;
 N DIC,DGWPROOT,DIWETXT,DIWESUB,DWLW,DDWC,DWPK  ;input vars for EN^DIWE 
 N DGCROOT  ;assignment history comment word processing root
 N DGABORT  ;abort flag for entering assignment narrative
 N DGOK     ;ok flag for entering assignment narrative
 N DGIEN    ;assignment ien
 N DGINST   ;institution ien
 N DGPFA    ;assignment array
 N DGPFAH   ;assignment history array
 N DGRESULT ;result of STOALL api call
 N DGERR    ;error if unable to edit assignment
 N DGETEXT  ;error text
 N DGPFERR  ;if error returned from STOALL api call
 N DGOWN    ;valid owner list array
 N SEL      ;user selection (list item)
 N VALMY    ;output of EN^VALM2 call, array of user selected entries
 N DBRSDATA ;array containing DBRS data from file 26.13
 N DBRSCNT  ;DBRS counter
 N DBRSNUM  ;DBRS #
 ;
 ; set screen to full scroll region
 D FULL^VALM1
 ; quit if selected action is not appropriate
 I '$D(@VALMAR@("IDX")) D  Q
 .S DGETEXT(1)="Patient has no record flag assignments."
 .I '$G(DGDFN) S DGETEXT(1)="Patient has not been selected."
 .D BLD^DIALOG(261129,.DGETEXT,"","DGERR","F")
 .D MSG^DIALOG("WE","","","","DGERR") W *7
 .D PAUSE^VALM1
 .S VALMBCK="R"
 .Q
 ; allow user to select a SINGLE flag assignment for ownership change
 S (DGIEN,VALMBCK)=""
 D EN^VALM2($G(XQORNOD(0)),"S")
 ; process user selection
 S SEL=$O(VALMY(""))
 I SEL,$D(@VALMAR@("IDX",SEL,SEL)) D
 .S DGIEN=$P($G(@VALMAR@("IDX",SEL,SEL)),U)
 .S DGDFN=$P($G(@VALMAR@("IDX",SEL,SEL)),U,2)
 .; attempt to obtain lock on assignment record
 .I '$$LOCK^DGPFAA3(DGIEN) D  Q
 ..W !!,"Record flag assignment currently in use, can not be edited!",*7
 ..D PAUSE^VALM1
 ..Q
 .; get assignment into DGPFA array
 .I '$$GETASGN^DGPFAA(DGIEN,.DGPFA,1) D  Q
 ..W !!,"Unable to retrieve the record flag assignment selected.",*7
 ..D PAUSE^VALM1
 ..Q
 .; check for pending transfer requests
 .I $O(^DGPF(26.22,"D",DGDFN,$P($P(DGPFA("FLAG"),U),";"),2,""))'="" D  Q
 ..W !!,"Please review active FT request to complete ownership transfer.",*7
 ..D PAUSE^VALM1
 ..Q
 .; can site change ownership of the assignment?
 .I '$$CHGOWN^DGPFAA2(.DGPFA,$G(DUZ(2)),"DGERR") D  Q
 ..W !!,"Changing the ownership of this record flag assignment not allowed...",*7
 ..D MSG^DIALOG("WE","","",5,"DGERR")
 ..D PAUSE^VALM1
 ..Q
 .; prompt for new OWNER SITE of the assignment
 .;
 .;-create selection list of enabled division owners
 .S DGINST=0 F  S DGINST=$O(^DG(40.8,"APRF",DGINST)) Q:'DGINST  D
 ..I $$TF^XUAF4(DGINST) S DGOWN(DGINST)=""
 ..Q
 .;-add treating facilities to selection list for Cat I assignments
 .I $G(DGPFA("FLAG"))["26.15",$$BLDTFL^DGPFUT2(DGDFN,.DGOWN)
 .;-remove existing owner from selection list
 .K DGOWN(+$G(DGPFA("OWNER")))
 .;
 .S DGPFA("OWNER")=$$ANSWER^DGPFUT("Select new owner site for this record flag assignment","","P^4:EMZ","","I $D(DGOWN(+Y))")
 .Q:(DGPFA("OWNER")'>0)
 .; prompt for APPROVED BY person
 .S DGPFAH("APPRVBY")=$$ANSWER^DGPFUT("Approved By","","P^200:EMZ")
 .Q:(DGPFAH("APPRVBY")'>0)
 .; allow user to enter HISTORY COMMENTS (edit reason)
 .S DGCROOT=$NA(^TMP($J,"DGPFCMNT"))  ;init WP array for hist comments
 .K @DGCROOT
 .S (DGABORT,DGOK)=0
 .F  D  Q:(DGOK!DGABORT)
 ..W !!,"Enter the reason for editing this assignment:"  ;needed for line editor
 ..S @DGCROOT@(1,0)="Change of flag assignment ownership.  "
 ..S DIC=$$OREF^DILF(DGCROOT)
 ..S DIWETXT="Enter the reason for record flag assignment ownership change:"
 ..S DIWESUB="Change of Ownership Reason"
 ..S DWLW=75   ;max # of chars allowed to be stored on WP global node
 ..S DWPK=1    ;if line editor, don't join lines
 ..S DDWC="E"  ;initially place cursor at end of line 1
 ..D EN^DIWE
 ..I $$CKWP^DGPFUT(DGCROOT) S DGOK=1 Q
 ..W !,"The reason for editing this record flag assignment is required!",*7
 ..I '$$CONTINUE^DGPFUT() S DGABORT=1
 ..Q
 .; quit if required HISTORY COMMENTS not entered
 .Q:$G(DGABORT)
 .; place HISTORY COMMENTS into history array
 .M DGPFAH("COMMENT")=@DGCROOT K @DGCROOT
 .; setup remaining assignment history array nodes for filing
 .S DGPFAH("ACTION")=2                ;continue
 .S DGPFAH("ASSIGNDT")=$$NOW^XLFDT()  ;current date/time
 .S DGPFAH("ENTERBY")=DUZ             ;current user
 .S DGPFAH("ORIGFAC")=+$$SITE^VASITE
 .; relinquishing ownership should remove existing review date when
 .; new owner is not a local division
 .I '$D(^DG(40.8,"APRF",DGPFA("OWNER"))) S DGPFA("REVIEWDT")=""
 .; add DBRS data to DGPFAH array
 .D GETDBRS^DGPFUT6(.DBRSDATA,DGIEN)
 .S (DBRSCNT,DBRSNUM)=0 F  S DBRSNUM=$O(DBRSDATA(DBRSNUM)) Q:DBRSNUM=""  D
 ..S DBRSCNT=DBRSCNT+1
 ..S DGPFAH("DBRS",DBRSCNT)=DBRSNUM_U_$P($G(DBRSDATA(DBRSNUM,"OTHER")),U)_U_$P($G(DBRSDATA(DBRSNUM,"DATE")),U)
 ..S DGPFAH("DBRS",DBRSCNT)=DGPFAH("DBRS",DBRSCNT)_U_"N"_U_$P($G(DBRSDATA(DBRSNUM,"SITE")),U)
 ..Q
 .; display flag assignment review screen to user
 .D REVIEW^DGPFUT3(.DGPFA,.DGPFAH,DGIEN,XQY0,XQORNOD(0))
 .; ask user if ok to file ownership change 
 .Q:$$ANSWER^DGPFUT("Would you like to file the assignment ownership change","YES","Y")'>0
 .; file the assignment and history using STOALL api
 .W !!,"Updating the ownership of this patient's record flag assignment..."
 .S DGRESULT=$$STOALL^DGPFAA(.DGPFA,.DGPFAH,.DGPFERR,"")
 .W !?5,"Update was "_$S(+$G(DGRESULT):"successful",1:"not successful")_"."
 .; send HL7 ORU msg if editing assignment to a Cat I flag
 .I +$G(DGRESULT),$G(DGPFA("FLAG"))["26.15",$$SNDORU^DGPFHLS(+DGRESULT) W !?5,"Message sent...updating patient's sites of record."
 .D PAUSE^VALM1
 .; rebuild list of flag assignments for patient
 .D BLDLIST^DGPFLMU(DGDFN)
 .; release lock after CO edit
 .D UNLOCK^DGPFAA3(DGIEN)
 .Q
 ;return to LM (refresh screen)
 S VALMBCK="R"
 ;
 Q
