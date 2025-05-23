ONCOEDC ;HINES OIFO/GWB - ABSTRACT STATUS (165.5,91) Input Transform ;10/19/11
 ;;2.2;ONCOLOGY;**1,5,6,10,19,20,21**;Jul 31, 2013;Build 6
 ;p20 -Abstract Status change
CHECK ;Required field check
 ;CLASS OF CASE   = 00-22
 ;SEQUENCE NUMBER = 00-59 or 99
 ;DATE DX > 12/31/95
 N ABSTAT,CC,CMPLT,CNT,DCC,DCLC,DTDX,ERRFLG,EX,FDNUM,FLDNAME,FN,LINE,ONCX
 N NODE0,ONCANL,ONCFILE,PAUSE,PRM,PTN,SQN
 ;next line added to set Abstracted By field for Accession Only cases
 I X="A",$P(^ONCO(165.5,D0,7),U,3)="" S $P(^ONCO(165.5,D0,7),U,3)=DUZ
 S PRM=D0
 I X'=($P(^ONCO(165.5,D0,7),U,2)) S $P(^ONCO(165.5,D0,7),U,22)=DUZ,$P(^ONCO(165.5,D0,7),U,21)=DT
 I (X=0)!(X=1)!(X=2)!(X="A")!(X="D") Q
 S PTN=$P($G(^ONCO(165.5,D0,0)),U,2)
 S CMPLT=1,NODE0=$G(^ONCO(165.5,D0,0)),ONCTYP="",ONCANL="" K LIST
 S (COC,CC)=$E($$GET1^DIQ(165.5,D0,.04),1,2)
 S SQN=$P(NODE0,U,6),DTDX=$P(NODE0,U,16)
 S ABSTAT=$P($G(^ONCO(165.5,D0,7)),U,2)
 I DTDX>3171231 D OBS2018^ONCOEDC2
 I CC="" D  S ONCTYP="" K X Q
 .W !
 .W !?5,"CLASS OF CLASS is blank."
 .W !?5,"""Required"" field checking requires CLASS OF CASE."
 .W !
 I +CC<23,(+SQN<60)!(SQN=99),DTDX>2951231 S ONCANL=1 D CHKFLDS
 ;follow-up and approach fields must be entered.
 N ONCFOLDT,ONCAUDT
 I $D(^ONCO(160,PTN,1)) S ONCAUDT=$P(^ONCO(160,PTN,1),U,9)
 S ONCFOLDT=$O(^ONCO(160,PTN,"F","B",9999999),-1)
 I '$G(ONCAUDT) D
 .I (ONCFOLDT="")!(ONCFOLDT<DTDX) S LIST("DATE OF LAST CONTACT OR DEATH")="" S CMPLT=0
 I (DTDX>3091231),($$GET1^DIQ(165.5,PRM,234,"I")="") S CMPLT=0,LIST($P($G(^DD(165.5,234,0)),U,1))=""
 ;
 I CMPLT=0 S ONCTYP="A" K X Q
 I CMPLT=1 D
 .I $G(ONCANL)=1 D
 ..W !!," All required data fields have been entered."
 ..W !!," Beginning inter-field edit checks..." Q
 .W ! D ^ONCEDIT
 I CMPLT=1 W !," No inter-field edit check warnings.",! D EDITS Q
 I $G(OVERRIDE)="NO" G QUIT
 K DIR S DIR(0)="YA"
 S DIR("A",1)=" This abstract has inter-field WARNINGS."
 S DIR("A")=" Do you wish to ignore them and proceed to the EDITS API? "
 S DIR("B")="No" D ^DIR K DIR
 I Y=1 S X=3 W ! D EDITS Q
QUIT K OVERRIDE
 S EDIT="YES"
 S ONCTYP="B" W ! S X=ABSTAT Q
 ;
CHKFLDS ;Check ONCOLOGY PRIMARY (165.5) and ONCOLOGY PATIENT (160)
 S ONCFILE=165.5 D F1655^ONCOEDC1
 S ONCFILE=160 D F160
 Q
 ;
F160 ;ONCOLOGY PATIENT (160)
 F FDNUM=2,3,7,8,9,10,43  D
 .D:$$GET1^DIQ(160,PTN,FDNUM,"I")="" CMPLT
 Q
 ;
CMPLT ;Set CMPLT = 0 and add field to list of fields needed to be filled in.
 S FLDNAME=$P($G(^DD(ONCFILE,FDNUM,0)),U,1) S FDNUM=""
 S CMPLT=0,LIST(FLDNAME)=""
 Q
 ;
PRINT ;Display results
 I $G(ONCTYP)="" Q
 I ONCTYP="A" D REQ
 I ONCTYP="B" D INTER
 W !
 K ONCTYP
 Q
 ;
REQ ;Missing "required" data item list
 W !,"  ABSTRACT STATUS may not be set to COMPLETE unless"
 W !,"  all ""required"" data items have been entered.",!
 W !,"  The following ""required"" data items have not been"
 W !,"  entered for this primary:",!
 S EX="",LINE=$S($E(IOST,1,2)="C-":IOSL-2,1:IOSL-6),CNT=0
 S FN=""
 F  S FN=$O(LIST(FN)),CNT=CNT+1 Q:FN=""  W !,?2,FN I CNT>14 D PCHK Q:EX=U
 Q
 ;
INTER ;Interfield edit warnings
 ;W !?5,"ABSTRACT STATUS may not be set to COMPLETE until all interfield"
 ;W !?5,"warnings listed above have been cleared."
 Q
 ;
PCHK ;Enter RETURN to continue or '^' to exit:
 I ($Y'<(LINE-1)) D  Q:EX=U  W !
 .W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .W @IOF Q
 Q
 ;
EDITS ;Call to EDITS API
 ; p21-do not allow completion of 2025+ cases. These comments and
 ; the following line will be removed in p22. X=2 because its Input Transform
 I DATEDX>3241231 W !!,"THIS CASE HAS A DATE DX OF 2025 AND CANNOT BE COMPLETED YET",! S $P(^ONCO(165.5,D0,7),U,2)=2 S X=2 R !?1,"  press RETURN to continue->",ANSWER:DTIME Q
 S ERRFLG=0
 ;Q:($G(ONCOEDIT)=1)
 W !," Calling EDITS API..."
 N ONCDST,ONCSAPI,ONCDTTIM,ONCDTEMP
 D NOW^%DTC S ONCDTTIM=%
 S DCC=$P($G(^ONCO(165.5,D0,7)),U,1)
 S DCLC=$P($G(^ONCO(165.5,D0,7)),U,21)
 I DCC="" D
 .S $P(^ONCO(165.5,PRM,7),U,1)=ONCDTTIM
 .S ^ONCO(165.5,"AAD",ONCDTTIM,PRM)=""
 .S $P(^ONCO(165.5,PRM,7),U,3)=DUZ
 .S $P(^ONCO(165.5,PRM,"EDITS"),U,3)="N"
 I ABSTAT=3,$P($G(^ONCO(165.5,D0,7)),U,3)="" S $P(^ONCO(165.5,PRM,7),U,3)=DUZ
 I DCC'="",$P($G(^ONCO(165.5,D0,7)),U,3)="" S $P(^ONCO(165.5,PRM,7),U,3)=DUZ
 D ^ONCGENED
 K EDIT
 I ERRFLG'=0 D  Q
 .I ABSTAT=3 W !!,"EDITS errors were encountered. ABSTRACT STATUS changed to 0 (Incomplete).",!
 .I ABSTAT'=3 W !!,"EDITS errors were encountered. ABSTRACT STATUS is unchanged.",!
 .I DCC="" D
 ..S $P(^ONCO(165.5,D0,7),U,1)=""
 ..K ^ONCO(165.5,"AAD",ONCDTTIM,PRM)
 ..S $P(^ONCO(165.5,D0,7),U,3)=""
 ..S $P(^ONCO(165.5,D0,"EDITS"),U,3)=""
 .K DIR S DIR(0)="YA"
 .S DIR("A")=" Do you wish to return to the Primary Menu Options? "
 .S DIR("B")="Yes" D ^DIR K DIR
 .I Y=1 S EDIT="YES"
 .S X=$S(ABSTAT=3:0,1:ABSTAT)
 W !," No EDITS errors or warnings."
 S SAVEX=3,$P(^ONCO(165.5,D0,7),U,2)=3,^ONCO(165.5,"AS",3,D0)=""
 ;S ONCEDC3=1,DIE="^ONCO(165.5,",DA=D0,DR="91///^S X=3" D ^DIE K ONCEDC3
 I DCC'="" D
 .I DCLC'="" K ^ONCO(165.5,"AAE",DCLC,PRM)
 .S $P(^ONCO(165.5,PRM,7),U,21)=ONCDTTIM
 .S ^ONCO(165.5,"AAE",DT,PRM)=""
 .S $P(^ONCO(165.5,PRM,7),U,22)=DUZ
 .S:$P(^ONCO(165.5,PRM,7),U,3)="" $P(^ONCO(165.5,PRM,7),U,3)=DUZ
 W !
 W !," ABSTRACT STATUS.............: ",$$GET1^DIQ(165.5,D0,91,"E")
 W !," DATE CASE INITIATED.........: ",$$GET1^DIQ(165.5,D0,236,"E")
 W !," INITIATED BY................: ",$$GET1^DIQ(165.5,D0,244,"E")
 W !," DATE OF FIRST CONTACT.......: ",$$GET1^DIQ(165.5,D0,155,"E")
 W !," DATE CASE COMPLETED.........: " S ONCDTEMP=$P($G(^ONCO(165.5,D0,7)),U,1) W $$FMTE^XLFDT(ONCDTEMP,"5P")
 W !," ELAPSED DAYS TO COMPLETION..: ",$$GET1^DIQ(165.5,D0,157,"E")
 ;W !," ELAPSED MONTHS TO COMPLETION: ",$$GET1^DIQ(165.5,D0,157.1,"E")
 W !," ABSTRACTED BY...............: ",$$GET1^DIQ(165.5,D0,92,"E")
 W !," DATE CASE LAST CHANGED......: " S ONCDTEMP=$P($G(^ONCO(165.5,D0,7)),U,21) W $$FMTE^XLFDT(ONCDTEMP,"5P")
 W !," CASE LAST CHANGED BY........: ",$$GET1^DIQ(165.5,D0,199,"E")
 W !
 S EDITS="NO" D NAACCR^ONCGENED K EDITS
 S ONCDST=$NA(^TMP("ONC",$J))
 D CHKSUM^ONCGENED
 W ! R "Enter RETURN to continue: ",PAUSE:30
 I $G(SAVEX)=3 S X=3
 Q
 ;
CLEANUP ;Cleanup
 K COC,D0,Y
