DGRNCVNC ;HDSO/RTW - Run Patient Name Standardization ; 25 OCT 2023 10:21
 ;;5.3;Registration;**1107**;Aug 13, 1993;Build 29
 ;DG RUN FILE 2 NAME COMPONENT POINTER TO VA(20, NAME COMPONENT FILE
 ;ADAPTED FROM DG53244U PATCH DG*5.3*620
 ;ICR#: 3065 API: $$NAMEFMT^XLFNAME()
 ;ICR#: 2701 $$GETICN^MPIF001
 ;ICR#: 3765 $$A31^MPIFA31B
 ;ICR#: 10103 $$FMADD^XLFDT
 Q  ;NO DIRECT ENTRY
EN ;
 S DGFLAG="P",DGNMSP="DPTNAME"
 S DGFIL=2
 D DIRHL7 Q:X["N"!(X["n")!(X["^")  ;ONLY ASKS IF FILERS ARE SHUT DOWN.
 D RUN(DGFLAG)
 D LOOP
 D RESULTS
 I '$D(^XTMP("UPDATE")) D  Q
 . W !!,"No Patient records found requiring the PATIENT NAME COMPONENT UPDATE",!!
 . W !,"****Warning ensure you restart the filers. Use the Monitor, Start, Stop Filers [HL FILER MONITOR] option to properly restart to avoid errors while editing the patient file****",!!
 D DIR ;IF YES DO LOOP2 AND PROCESSES ALL.
 W !!,"****Warning ensure you restart the filers.",!!," Use the Monitor, Start, Stop Filers [HL FILER MONITOR] option to properly restart to avoid errors while editing the patient file****",!!
 K DGXRARY,DGFIELD
 Q
DIRHL7 ;
 ;
 N DIROUT,DIRUT,DTOUT,DUOUT,DGNMSP,Y
 S DIR(0)="YAO"
 S DIR("A")="Are the HL7 filers shut down "
 S DIR("A",1)=""
 S DIR("A",2)="****Use the Monitor, Start, Stop Filers [HL FILER MONITOR] option"
 S DIR("A",3)="to properly shut down to avoid errors while editing the patient file****"
 S DIR("A",4)=""
 S DIR("A",5)="   A ""NO"" answer will stop the Name Component restoration process."
 S DIR("A",6)=" Answer YES OR NO  OR '^' TO EXIT "
 S DIR("A",7)=""
 S DIR("B")="NO" D ^DIR I Y'>0!($G(DTOUT))!($D(DUOUT))!($D(DIROUT))!($D(DIRUT)) K DIR Q
 I Y=0 Q
 Q
RUN(DGFLAG) ;Convert PATIENT file names;
 ;[ "P"  : Kill ^XTMP, update names, generate global
 ;
 N DGA,DGET,DGI,DGFILE,DGENUPLD,DGNOFDEL,DGPRUN,DGOUT,DGQ,DGY,VAFCA08,VAFCNO,VAFHCA08
 K ^XTMP(DGNMSP)
 I '$D(^XTMP(DGNMSP,"STATS")) D
 .S $P(^XTMP(DGNMSP,"STATS",2,.01),U,7)="Patient name"
 .S $P(^XTMP(DGNMSP,"STATS",2,.211),U,7)="Primary NOK name"
 .S $P(^XTMP(DGNMSP,"STATS",2,.2191),U,7)="Secondary NOK name"
 .S $P(^XTMP(DGNMSP,"STATS",2,.2401),U,7)="Father's name"
 .S $P(^XTMP(DGNMSP,"STATS",2,.2402),U,7)="Mother's name"
 .S $P(^XTMP(DGNMSP,"STATS",2,.2403),U,7)="Mother's maiden name"
 .S $P(^XTMP(DGNMSP,"STATS",2,.331),U,7)="Prim. E-contact name"
 .S $P(^XTMP(DGNMSP,"STATS",2,.3311),U,7)="2nd E-contact name"
 .S $P(^XTMP(DGNMSP,"STATS",2,.341),U,7)="Designee name"
 .S $P(^XTMP(DGNMSP,"STATS",2.01,.01),U,7)="Alias name"
 .S $P(^XTMP(DGNMSP,"STATS",2.101,30),U,7)="Attorney's name"
 ;Initialize variables
 S DGQ="""",DGOUT=0
 F DGI=1:1 S DGA=$T(FIELD+DGI) Q:(DGA'[";;")  D
 .S DGFIELD(DGI,$P($P(DGA,";;",2),U,3))=$P(DGA,";;",2) Q
 D XRARY
 S DGFILE=0
 F  S DGFILE=$O(^XTMP(DGNMSP,"STATS",DGFILE)) Q:'DGFILE!DGOUT  D
 .S (DGFLD,DGET)=0
 .F  S DGFLD=$O(^XTMP(DGNMSP,"STATS",DGFILE,DGFLD)) Q:'DGFLD!DGOUT  D
 ..S DGY=^XTMP(DGNMSP,"STATS",DGFILE,DGFLD),DGX=DGFILE_","_DGFLD
 ..S $E(DGX,10)=$P(DGY,U,7),$E(DGX,30)=$J(+$P(DGY,U),9,0)
 ..S $E(DGX,41)=$J(+$P(DGY,U,2),7,0),$E(DGX,50)=$J(+$P(DGY,U,3),6,0)
 ..S $E(DGX,58)=$J(+$P(DGY,U,4),6,0),$E(DGX,66)=$J(+$P(DGY,U,5),6,0)
 ..S $E(DGX,74)=$J(+$P(DGY,U,6),6,0),DGET=DGET+$P(DGY,U)
 ;Set up ^XTMP
 I '$G(^XTMP(DGNMSP,0,0)) D
 .S ^XTMP(DGNMSP,0)=$$FMADD^XLFDT(DT,90)_"^"_DT
 .I DGFLAG="P" D
 ..S ^XTMP(DGNMSP,0,0)=$$NOW^XLFDT(),$P(^XTMP(DGNMSP,0),U,4)=0
 ..S $P(^XTMP(DGNMSP,0),U,3)="Perform Name Conversion"
 ..Q
 I DGFLAG="P" D
 .S $P(^XTMP(DGNMSP,0),U)=$$FMADD^XLFDT(DT,90)
 .S $P(^XTMP(DGNMSP,0),U,5)="RUN"
 .S DGPRUN=$O(^XTMP(DGNMSP,0,""),-1)+1
 .S ^XTMP(DGNMSP,0,DGPRUN)=$$NOW^XLFDT()_"^^"_+$P($G(^XTMP(DGNMSP,"STATS")),U)
 .Q
 ;
 ;Prevent messages to HEC
 S DGENUPLD="ENROLLMENT/ELIGIBILITY UPLOAD IN PROGRESS"
 S VAFCNO=1  ;Prevent MPI messages
 S (VAFCA08,VAFHCA08)=1  ;Prevent PIMS Generic Messaging
 S DGNOFDEL=1  ;Prevent deletion of contact address fields
 ;
 Q
LOOP     ;Loop through Patient file
 N DGNAME,DGNAMEC,DGCNT
 K ^XTMP("UPDATE"),^XTMP("RESULTS")
 S DGDFN=+$P(^XTMP(DGNMSP,0),U,4)
 S DGCNT=1
 S ^XTMP("RESULTS",0)=$$FMADD^XLFDT(DT,180)_"^"_DT
 S ^XTMP("RESULTS",DGCNT)="VALID FINDINGS THAT REQUIRE PATIENT NAME COMPONENT UPDATE",DGCNT=DGCNT+1
 S ^XTMP("RESULTS",DGCNT)="  DGDFN   "_"PATIENT NAME",DGCNT=DGCNT+1
 S ^XTMP("RESULTS",DGCNT)="",DGCNT=DGCNT+1
 S ^XTMP("RESULTS",DGCNT)="No Patient records found requiring the PATIENT NAME COMPONENT UPDATE"
 F  S DGDFN=$O(^DPT(DGDFN)) Q:'DGDFN  D
 . Q:'$D(^DPT(DGDFN,0))
 . S DGNAME=$P(^DPT(DGDFN,0),U)
 .;Skip merging patients
 .Q:$P($G(^DPT(DGDFN,0)),U)["MERGING INTO"
 .;Skip patients that have been merged to another record
 .Q:$D(^DPT(DGDFN,-9))
 .;Evaluate field values
 . I $D(^DPT(DGDFN,"NAME")) D
 . . I '$P(^DPT(DGDFN,"NAME"),U,1) D
 . . . S ^XTMP("UPDATE",DGDFN)=DGNAME,^XTMP("RESULTS",DGCNT)=DGDFN_"^"_DGNAME,DGCNT=DGCNT+1
 Q
DIR ;
 N DIROUT,DIRUT,DTOUT,DUOUT,DGNMSP,Y
 S DGNMSP="DPTNAME"
 S DIR(0)="YAO"
 S DIR("?")="Answering yes restores Missing Name Components in the patient file"
 S DIR("?",1)=""
 S DIR("?",2)="****Warning the process updates missing PATIENT File name component"
 S DIR("?",3)=" entries and re-indexes existing name component entries"
 S DIR("?",4)=" in the patient file****"
 S DIR("?",5)=""
 S DIR("?",6)=""
 S DIR("A")="Are prepared to restore Patient file Name Components: "
 S DIR("A",1)=""
 S DIR("A",2)="Have you reviewed the Missing Name Components Message ?"
 S DIR("A",3)=""
 S DIR("A",4)=""
 S DIR("A",5)="!!!Enter ""?"" for more information, and ""^"" to EXIT"
 S DIR("A",6)=""
 S DIR("B")="NO" D ^DIR I Y'>0!($G(DTOUT))!($D(DUOUT))!($D(DIROUT))!($D(DIRUT)) K DIR Q
 I Y=0 Q
 I Y=1 S DGFLAG="P",DGFIL=2 I Y=1 S DGFLAG="P" W !!,"The ""Missing Name Components"" message can be found in your mailman messages" D LOOP2
 D CONFIRM
 Q
LOOP2 ;
 N DGTYPE,DPTFIL,FPTFLD,DPTI,DPTFLD,DPTIENS,DPTINV,DPTVALUE
 S DGDFN=7
 F  S DGDFN=$O(^XTMP("UPDATE",DGDFN)) Q:'DGDFN  D
 .S DGIENS=DGDFN_",",DGMPI=0
 .S DGZ=0 F  S DGZ=$O(DGFIELD(DGZ)) Q:'DGZ  D
 ..S DPTA=""  F  S DPTA=$O(DGFIELD(DGZ,DPTA)) Q:DPTA=""  D
 ...Q:'$D(^DPT(DGDFN,$P(DPTA,";")))
 ...S DGTYPE=DGFIELD(DGZ,DPTA),DPTFLD=$P(DGTYPE,U,2)
 ...S DPTMAX=$P(DGTYPE,U,5) S:'DPTMAX DPTMAX=35
 ...I $L(DPTA,";")=3 D  Q
 ....F DPTI=0:0 S DPTI=$O(^DPT(DGDFN,$P(DPTA,";"),DPTI)) Q:'DPTI  D
 .....S DPTIENS=DGDFN_","_DPTI_",",DPTFIL=$P(DGTYPE,U,6)
 .....S DPTVALUE=$P($G(^DPT(DGDFN,$P(DPTA,";"),DPTI,$P(DPTA,";",2))),U,$P(DPTA,";",3))
 .....Q:'$L(DPTVALUE)
 .....D UPDATE(DGFLAG,DPTFIL,DPTIENS,DPTFLD,DPTVALUE,DGNMSP,DPTMAX,DPTA)
 ...S DPTIENS=DGDFN_",",DPTFIL=2
 ...S DPTVALUE=$P($G(^DPT(DGDFN,$P(DPTA,";"))),U,$P(DPTA,";",2))
 ...Q:'$L(DPTVALUE)
 ...D UPDATE(DGFLAG,DPTFIL,DPTIENS,DPTFLD,DPTVALUE,DGNMSP,DPTMAX,DPTA,.DGMPI)
 ..S $P(^XTMP(DGNMSP,0),U,4)=DGDFN
 Q
 ;
UPDATE(DGFLAG,DGFIL,DGIENS,DGFLD,DGNAM,DGNMSP,DPTMAX,DPTA,DGMPI) ;Process name field
 ;
 N DGAUD,DGFDA,DGMSG,DIERR,DGOLD,DGTINV
 ;Total names evaluated
 S $P(^XTMP(DGNMSP,"STATS"),U)=$P($G(^XTMP(DGNMSP,"STATS")),U)+1
 ;Total evaluated by field
 S $P(^XTMP(DGNMSP,"STATS",DGFIL,DGFLD),U)=$P($G(^XTMP(DGNMSP,"STATS",DGFIL,DGFLD)),U)+1
 ;Format name
 S DGOLD=$G(DGNAM)
 S DGNAM=$$FORMAT^XLFNAME7(.DGNAM,3,DPTMAX,,2,.DGAUD,$S(DGFLD=.2403:1,1:0))
 Q:$P(^DPT(DGDFN,0),U)["ERROR"
 D:(DGAUD'=0) RECORD(DGFIL,DGFLD,DGIENS,DGNAM,.DGAUD,DGNMSP,DGDFN,DGOLD)
 Q:DGFLAG'="P"  ;Processing only
 Q:DGAUD=2  ;Unconvertible
 ;Update components if name is not changed
 I DGAUD=0 D  Q
 .N DGI,DA,X,DG20NAME,XUNOTRIG
 .F DGI=2.1,1.1 D
 ..S:(DGFIL=2) DA=DGDFN S:(DGFIL'=2) DA(1)=DGDFN,DA=$P(DGIENS,",",2)
 ..S X=DGNAM X DGXRARY($P(DGFIELD(DGZ,DPTA),U,7),DGI)
 ..Q
 .Q
 ;Update source name if different
 S DPTINV=$TR($$INV(DGIENS),":",",")_","
 S DGFDA(DGFIL,DPTINV,DGFLD)=DGNAM
 D FILE^DIE("","DGFDA","DGMSG") K DIERR,DGMSG
 ;Changes of interest to MPI
 I DGAUD=1,DGFIL=2 D
 .I DGFLD=.01 S DGMPI=1
 .I DGFLD=.2403,DGOLD_","'=DGNAM S DGMPI=1
 Q
 ;
RECORD(DGFIL,DGFLD,DGREC,DGNAM,DGAUD,DGNMSP,DGDFN,DGOLD) ;file changes in ^XTMP
 ;^XTMP global format:
 ;^XTMP(DGNMSP,0)=purge_date^date_created^process^last_ien^
 ;stop_flag^name_change_mail_group
 ;^XTMP(DGNMSP,0,0)=conversion_start^conversion_end
 ;^XTMP(DGNMSP,0,n)=conversion_start^conversion_end^
 ;pts_evaluated_start^pts_evaluated_end
 ;^XTMP(DGNMSP,DFN,FILE,IFN,FIELD)=old_value^new_value^change_types
 ;^XTMP(DGNMSP,DFN,"MPI")=1^1^1^1^1^1 (status of MPI messaging)
 ;^XTMP(DGNMSP,DFN,"MPI","A31")=the result of call to $$A31^MPIFA31B
 ;^XTMP(DGNMSP,"STATS")=names_evaluated^pts_w/changes^total_changes^
 ;type1_changes^type2_changes^type3_changes^
 ;type4_changes
 ;^XTMP(DGNMSP,"STATS",FILE,FIELD)=total_evaluated^total_changed^
 ;type1_changes^type2_changes^
 ;type3_changes^type4_changes
 ;^XTMP(DGNMSP,"B",NAME)=dfn
 ;
 ;Data change types: 1=name contains no comma
 ;2=parenthetical text is removed
 ;3=value could not be converted
 ;4=characters are removed or changed
 ;
 N DGIENS,DGIEN2,DGTSTR,DGI,DGN S DGTSTR=""
 S DGIEN2=$S($P(DGREC,",",2):$P(DGREC,",",2),1:DGDFN)
 ;Record values
 F DGI=1:1:4 I $D(DGAUD(DGI)) D
 .S DGTSTR=DGTSTR_DGI
 .;Field changes by type
 .S $P(^XTMP(DGNMSP,"STATS",DGFIL,DGFLD),U,(DGI+2))=$P($G(^XTMP(DGNMSP,"STATS",DGFIL,DGFLD)),U,(DGI+2))+1
 .;Total changes by type
 .S $P(^XTMP(DGNMSP,"STATS"),U,(DGI+3))=$P($G(^XTMP(DGNMSP,"STATS")),U,(DGI+3))+1
 .Q
 ;Total patients with changes
 I '$D(^XTMP(DGNMSP,DGDFN)) S $P(^XTMP(DGNMSP,"STATS"),U,2)=$P($G(^XTMP(DGNMSP,"STATS")),U,2)+1
 ;Total fields with changes
 S $P(^XTMP(DGNMSP,"STATS"),U,3)=$P($G(^XTMP(DGNMSP,"STATS")),U,3)+1
 ;Total changes by field
 S $P(^XTMP(DGNMSP,"STATS",DGFIL,DGFLD),U,2)=$P($G(^XTMP(DGNMSP,"STATS",DGFIL,DGFLD)),U,2)+1
 ;PATIENT field name change and types
 S ^XTMP(DGNMSP,DGDFN,DGFIL,DGIEN2,DGFLD)=DGOLD_U_DGNAM_U_DGTSTR
 ;Name x-ref
 S DGN=$P($G(^DPT(DGDFN,0)),U) S:DGN="" DGN=" "
 S ^XTMP(DGNMSP,"B",DGN,DGDFN)=""
 Q
 ;
INV(DGIENS) ;Invert the IENS CALL FROM UPDATE
 N DGI,DGX
 Q:DGIENS?."," ""
 S:DGIENS'?.E1"," DGIENS=DGIENS_","
 S DGX="" F DGI=$L(DGIENS,",")-1:-1:1 S DGX=DGX_$P(DGIENS,",",DGI)_":"
 S:DGX?.E1":" DGX=$E(DGX,1,$L(DGX)-1)
 Q DGX
 ;
FIELD    ;;
 ;;NAME^.01^0;1^1.01^30^^ANAM01
 ;;K-NAME^.211^.21;1^1.02^^^ANAM211
 ;;K2-NAME^.2191^.211;1^1.03^^^ANAM2191
 ;;FATHER'S NAME^.2401^.24;1^1.04^^^ANAM2401
 ;;MOTHER'S NAME^.2402^.24;2^1.05^^^ANAM2402
 ;;MOTHER'S MAIDEN^.2403^.24;3^1.06^^^ANAM2403
 ;;E-NAME^.331^.33;1^1.07^^^ANAM331
 ;;E2-NAME^.3311^.331;1^1.08^^^ANAM3311
 ;;D NAME^.341^.34;1^1.09^^^ANAM341
 ;;ALIAS^.01^.01;0;1^100.03^30^2.01^ANAM201
 ;;ATTORNEY^30^DIS;3;1^100.21^30^2.101^ANAM1001
XRARY ;Gather xref kills and sets
 N DGI,DGII,DGDFN,DGVAL,DGDATA,DGZ
 S DGI="",DGVAL(1)=2,DGZ=0
 F  S DGZ=$O(DGFIELD(DGZ)) Q:'DGZ  D
 .F  S DGI=$O(DGFIELD(DGZ,DGI)) Q:DGI=""  D
 ..S DGVAL(2)=$P(DGFIELD(DGZ,DGI),U,7)
 ..D FIND^DIC(.11,"","@;IXIE","KP",.DGVAL,"","","","","DGDATA")
 ..S DGDFN=+DGDATA("DILIST",1,0)_"," K DGDATA
 ..D GETS^DIQ(.11,DGDFN,"1.1;2.1","","DGDATA")
 ..F DGII=1.1,2.1 S DGXRARY(DGVAL(2),DGII)=DGDATA(.11,DGDFN,DGII)
 ..Q
 .Q
 Q
CONFIRM ; SEND A CONFIRMATION MAILMAN MESSAGE
 S DGDFN=0
 K ^XTMP("CONFIRM")
 I $D(^XTMP("UPDATE")) W !!,"The Name Component restore results was sent to your mailman acct.",!
 S ^XTMP("CONFIRM",0)=$$FMADD^XLFDT(DT,180)_"^"_DT
 F  S DGDFN=$O(^XTMP("UPDATE",DGDFN)) Q:'DGDFN  D
 . S DGNAME=$P(^XTMP("UPDATE",DGDFN),U)
 . S DGNAMEC=$G(^DPT(DGDFN,"NAME"))
 . S ^XTMP("CONFIRM",DGDFN)="^DPT("_DGDFN_",""NAME""""="_DGNAMEC
 S XMDUZ=DUZ
 S XMSUBJ="Restored Name Components"
 S XMBODY="^XTMP(""CONFIRM"")"
 S XMTO(DUZ)=""
 S XMINSTR("FLAGS")="P"
 S (XMZ,XMATTACH)=""
 D SENDMSG(.XMDUZ,.XMSUBJ,.XMBODY,.XMTO,.XMINSTR,.XMZ,.XMATTACH)
 Q
RESULTS ;
 ;W !!,"        The Missing Name Components message was sent to your mailman acct."
 I $D(^XTMP("UPDATE")) W !,"        Please review the findings",!
 S XMDUZ=DUZ
 S XMSUBJ="Missing Name Components"
 S XMBODY="^XTMP(""RESULTS"")"
 S XMTO(DUZ)=""
 S XMINSTR("FLAGS")="P"
 S (XMZ,XMATTACH)=""
 D SENDMSG(.XMDUZ,.XMSUBJ,.XMBODY,.XMTO,.XMINSTR,.XMZ,.XMATTACH)
 Q
SENDMSG(XMDUZ,XMSUBJ,XMBODY,XMTO,XMINSTR,XMZ,XMATTACH) ; Send a msg
 ; In:  User, basket (if you are recipient), all msg parts,
 ;      priority?, closed?, (info?,cc?), send now or later (when?),
 ;      (KIDS,MIME,text,PackMan), delete date (if to shared,mail)
 ; XMINSTR("RCPT BSKT")
 N DIERR,XMERR ; ADDED IN PATCH XM*8.0*41 JDG
 I '$D(XMV) N XMV,XMDISPI,XMDUN,XMNOSEND,XMPRIV
 ; ** XM*8*47 Adds code to automatically truncate subject line if too long or concatenate if too short. **
 I $L(XMSUBJ)<3,XMSUBJ'="" S XMSUBJ=XMSUBJ_"..."
 I $L(XMSUBJ)>65 S XMSUBJ=$E(XMSUBJ,1,65)
 D SENDMSG^XMXPARM(.XMDUZ,.XMSUBJ,.XMBODY,.XMTO,.XMINSTR,.XMATTACH) Q:$D(XMERR)
 D SENDMSG^XMXSEND(XMDUZ,XMSUBJ,XMBODY,.XMTO,.XMINSTR,.XMZ,.XMATTACH)
 Q
