DGRNCVNP ;HDSO/RTW - Run Patient Name Standardization ; 25 OCT 2023 10:21
 ;;5.3;Registration;**1107**;Aug 13, 1993;Build 29
 ;DG RUN FILE 2 NAME COMPONENT POINTER TO VA(20, NAME COMPONENT FILE
 ;ADAPTED FROM DG53244U PATCH DG*5.3*620
 ;ICR#: 10103 $$FMADD^XLFDT
EN ;
 S DGNMSP="DPTNAME"
 D LOOP
 D RESULTS
 I '$D(^XTMP("UPDATE")) W !,"No Patient records found requiring the DG NAME COMPONENT UPDATE",!! H 5 Q
 H 5
 K DGXRARY,DGFIELD,DGNMSP,DGDFN
 Q
LOOP     ;Loop through Patient file
 N DGNAME,DGNAMEC,DGCNT
 K ^XTMP("UPDATE"),^XTMP("RESULTS")
 S DGCNT=1
 S ^XTMP("RESULTS",0)=$$FMADD^XLFDT(DT,180)_"^"_DT
 S ^XTMP("RESULTS",DGCNT)="VALID FINDINGS THAT REQUIRE PATIENT NAME COMPONENT UPDATE",DGCNT=DGCNT+1
 S ^XTMP("RESULTS",DGCNT)="  DGDFN   "_"PATIENT NAME",DGCNT=DGCNT+1
 S ^XTMP("RESULTS",DGCNT)="",DGCNT=DGCNT+1
 S ^XTMP("RESULTS",DGCNT)="No Patient records found requiring the PATIENT NAME COMPONENT UPDATE"
 S DGDFN=0 F  S DGDFN=$O(^DPT(DGDFN)) Q:'DGDFN  D
 . I $D(^DPT(DGDFN,0)) S DGNAME=$P(^DPT(DGDFN,0),U)
 .;Skip merging patients
 .Q:$P($G(^DPT(DGDFN,0)),U)["MERGING INTO"
 .;Skip patients that have been merged to another record
 .Q:$D(^DPT(DGDFN,-9))
 .;Evaluate field values
 . I $D(^DPT(DGDFN,"NAME")) D
 . . I '$P(^DPT(DGDFN,"NAME"),U,1) D
 . . . S ^XTMP("UPDATE",DGDFN)=DGNAME,^XTMP("RESULTS",DGCNT)=DGDFN_"^"_DGNAME,DGCNT=DGCNT+1
 Q
RESULTS ;
 I $D(^XTMP("UPDATE")) D 
 . W !!,"   Records were found, and the Missing Name Components message was sent to your mailman acct."
 . W " The DG NAME COMPONENT UPDATE option needs to be run after reviewing the findings",!
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
