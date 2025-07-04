GMRCIBKG ;SLC/JFR - IFC BACKGROUND ERROR PROCESSOR; Jan 09, 2025@09:43:28
 ;;3.0;CONSULT/REQUEST TRACKING;**22,28,30,35,58,92,154,189,201**;DEC 27, 1997;Build 7
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; This routine invokes IA# 3335
 ;
EN ;process file 123.6 and take action
 ;Start background process
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
 ; OK to run?
 I '$$GONOGO Q
 ;
 ; set start param to NOW and run
 D EN^XPAR("SYS","GMRC IFC BACKGROUND START",1,$$NOW^XLFDT)
 ;
 N GMRCLOG,GMRCTIM,GMRCLOG0
 S GMRCLOG=0
 S GMRCTIM=$$FMADD^XLFDT($$NOW^XLFDT,,-1)
 F  S GMRCLOG=$O(^GMR(123.6,GMRCLOG)) Q:'GMRCLOG  D
 . S GMRCLOG0=$G(^GMR(123.6,GMRCLOG,0))
 . ;
 . ;  v-- resend if couldn't update file immediately
 . I $P(GMRCLOG0,U,6),$P(GMRCLOG0,U,8)=901 D  Q
 .. D TRIGR^GMRCIEVT($P(GMRCLOG0,U,4),$P(GMRCLOG0,U,5)) ;re-send activity
 . ;
 . ;  wait at least 10 minutes for 205 errors (Waiting for treating facility to update) - p189 wtc 6/18/2024
 . ;
 . I $P(GMRCLOG0,U,6),$P(GMRCLOG0,U,8)=205 D  Q  ;
 .. ;
 .. I $P(GMRCLOG0,U,1)<$$FMADD^XLFDT($$NOW^XLFDT,,-10/60) D TRIGR^GMRCIEVT($P(GMRCLOG0,U,4),$P(GMRCLOG0,U,5)) ;re-send activity
 . ;
 . ;  wait a day for 203 errors (Patient not in Cerner) - p189 wtc 5/4/22
 . ;
 . I $P(GMRCLOG0,U,6),$P(GMRCLOG0,U,8)=203 D  Q  ;
 .. ;
 .. I $P(GMRCLOG0,U,1)<$$FMADD^XLFDT($$NOW^XLFDT,-1) D TRIGR^GMRCIEVT($P(GMRCLOG0,U,4),$P(GMRCLOG0,U,5)) ;re-send activity
 . ;
 . ;  wait an hour for 204 errors (Waiting for IFC order to be processed in Cerner) - p201 wtc 12/1/23
 . ;
 . I $P(GMRCLOG0,U,6),$P(GMRCLOG0,U,8)=204 D  Q  ;
 .. ;
 .. I $P(GMRCLOG0,U,1)<$$FMADD^XLFDT($$NOW^XLFDT,,-1) D  ;
 ... I $P(^GMR(123,$P(GMRCLOG0,U,4),0),U,22)'="" D TRIGR^GMRCIEVT($P(GMRCLOG0,U,4),$P(GMRCLOG0,U,5)) ;re-send activity
 . ;
 . ;  wait a day for 206 errors (ICN missing from incoming order). P201 WTC 5/6/24 
 . ;
 . I $P(GMRCLOG0,U,6),$P(GMRCLOG0,U,8)=206 D  Q  ;
 .. ;
 .. I $P(GMRCLOG0,U,1)'<$$FMADD^XLFDT($$NOW^XLFDT,-1) Q  ;
 .. I $P(GMRCLOG0,U,1)<$$FMADD^XLFDT($$NOW^XLFDT,-7) D  Q  ;  Mark complete if not resolved in 7 days.
 ... ;
 ... ;  Clear do not purge flag for incoming order.
 ... ;
 ... N MSGID,HLMTIENS S MSGID=$P(GMRCLOG0,U,3),HLMTIENS=$O(^HLMA("C",MSGID,0)) ;
 ... I $G(HLMTIENS) N RTNCODE S RTNCODE=$$SETPURG^HLUTIL(0) ;
 ... ;
 ... N DIE,DA,DR ;
 ... S DIE="^GMR(123.6,",DA=GMRCLOG,DR=".06///@" D ^DIE ;
 .. ;
 .. ;  Determine of ICN has been entered for the patient.  If so, insert into PID segment of HL7 message then re-process.
 .. ;
 .. N GMRCICN,IEN772,IEN773,MSGID,PID,N,EDIPI,DGKEY,DGOUT ;
 .. S MSGID=$P(GMRCLOG0,U,3) Q:MSGID=""  ;
 .. S IEN773=$O(^HLMA("C",MSGID,0)) Q:'IEN773  ;
 .. S IEN772=$P($G(^HLMA(IEN773,0)),U,1) Q:'IEN772  ;
 .. ;
 .. S PID="" F N=1:1 Q:'$D(^HL(772,IEN772,"IN",N,0))  I $P(^(0),"|",1)="PID" S PID=^(0) Q  ;
 .. Q:PID=""  ;
 .. S EDIPI=$P($P($P(PID,"|",4),"~",2),U,1),DGKEY=EDIPI_"^NI^USDOD^200DOD" D TFL^VAFCTFU2(.DGOUT,DGKEY) ;
 .. S GMRCICN="" F N=1:1 Q:'$D(DGOUT(N))  I $P(DGOUT(N),U,2,5)="NI^USVHA^200M^A" S GMRCICN=$P(DGOUT(N),U,1) Q  ;
 .. Q:GMRCICN=""  ;
 .. S PID=$$ADDICN(PID,GMRCICN),^HL(772,IEN772,"IN",N,0)=PID ;
 .. ;
 .. N RTNCODE S RTNCODE=$$REPROC^HLUTIL(IEN773,"IN^GMRCIMSG") Q:RTNCODE<0  ;
 .. ;
 .. N DIE,DA,DR ;
 .. S DIE="^GMR(123.6,",DA=GMRCLOG,DR=".06///@" D ^DIE ;
 .. ;
 .. ;  Clear do not purge flag from incoming order.
 .. ;
 .. N HLMTIENS S HLMTIENS=IEN773,RTNCODE=$$SETPURG^HLUTIL(0) ;
 . ;
 . ;  v-- wait at least 1 hour on all other errors
 . I $P(GMRCLOG0,U)>GMRCTIM Q
 . ;  v-- if incomplete activity is now the earliest, resend it
 . I $P(GMRCLOG0,U,6),$P(GMRCLOG0,U,8)=902 D  Q
 .. Q:$O(^GMR(123.6,"AC",$P(GMRCLOG0,U,4),$P(GMRCLOG0,U,5)),-1)
 .. D DELALRT(GMRCLOG)
 .. D TRIGR^GMRCIEVT($P(GMRCLOG0,U,4),$P(GMRCLOG0,U,5)) ;re-send activity
 . ; v-- delete complete entries after # in GMRC RETAIN IFC ACTIVITY DAYS
 . I '$P(GMRCLOG0,U,6) D  Q
 .. N DIK,DA,GMRCRETN
 .. S GMRCRETN=$$GET^XPAR("SYS","GMRC RETAIN IFC ACTIVITY DAYS",1)
 .. I 'GMRCRETN S GMRCRETN=7
 .. I $P(GMRCLOG0,U)>$$FMADD^XLFDT(GMRCTIM,(0-GMRCRETN)) Q  ;don't delete
 .. S DIK="^GMR(123.6,",DA=GMRCLOG
 .. D ^DIK ;remove old completed entries
 . ;
 . ;  v-- resend unknown patient errors after 3 hours
 . I $P(GMRCLOG0,U,8)=201,GMRCLOG0<$$FMADD^XLFDT($$NOW^XLFDT,,-1) D  Q
 .. N GMRCSND,GMRCPAR,DOW
 .. S GMRCPAR=$$GET^XPAR("SYS","GMRC IFC SKIP WEEKEND RE-TRANS",1)
 .. S DOW=$$DOW^XLFDT(DT,1)
 .. S GMRCSND=$S('GMRCPAR:1,(+DOW&(DOW<6)):1,1:0)
 .. I GMRCSND D  ;re-send based on parameter and day of week
 ... D DELALRT(GMRCLOG) ;delete previous alerts on same transaction
 ... D TRIGR^GMRCIEVT($P(GMRCLOG0,U,4),$P(GMRCLOG0,U,5))
 .. I '($P(GMRCLOG0,U,7)#8),GMRCSND D
 ... ;alert CAC's about errors every 24 hrs.
 ... D DELALRT(GMRCLOG) ;delete previous alerts on same transaction
 ... D SNDALRT^GMRCIERR(GMRCLOG,"C") ; alert CAC's to patient errors
 ... D  ; send mail to remote CAC group
 .... N GMRCLNK,GMRCIQT,HL,HLECH,HLFS,HLQ,PID,DOM,STA,GMRCLNK,OBR
 .... D INIT^HLFNC2("GMRC IFC ORM EVENT",.HL)
 .... D  I $D(GMRCIQT) Q  ;build PID seg if nat'l ICN
 ..... N GMRCDFN S GMRCDFN=$P(^GMR(123,+$P(GMRCLOG0,U,4),0),U,2)
 ..... I '$G(GMRCDFN) S GMRCIQT=1 Q
 ..... I $$GETICN^MPIF001(GMRCDFN)<1 S GMRCIQT=1 Q
 ..... I $$IFLOCAL^MPIF001(GMRCDFN) S GMRCIQT=1 Q
 ..... S PID=$$EN^VAFCPID(GMRCDFN,"1,2,3,4,5,7,8,19")
 ..... S PID=$P(PID,"|",2,999)
 .... D LINK^HLUTIL3($P(GMRCLOG0,U,2),.GMRCLNK)
 .... ;BL GMRC*3.0*154; Need to check if site has been converted to Cerner and if so route properly
 .... ; S:$$CNVTD^GMRCIEVT($P(GMRCLOG0,U,2)) GMRCLNK(1)=$$GET^XPAR("SYS","GMRC IFC REGIONAL ROUTER",1)
 .... ; S:$$CNVTD^GMRCIEVT($P(GMRCLOG0,U,4)) GMRCLNK(1)=$$GET^XPAR("SYS","GMRC IFC REGIONAL ROUTER",1)
 .... N CNVDT
 .... S CNVDT=$$CNVTD^GMRCIEVT($P(GMRCLOG0,U,4))
 .... I CNVDT D
 ..... S GMRCLNK(1)=$$GET^XPAR("SYS","GMRC IFC REGIONAL ROUTER",1)
 ..... S GMRCLNK=$$FIND1^DIC(870,,"EX",GMRCLNK(1))
 .... I 'CNVDT S GMRCLNK=$O(GMRCLNK(0))
 .... I 'GMRCLNK Q  ;no link set up
 .... S DOM=$$GET1^DIQ(870,+GMRCLNK,.03)
 .... S STA=$$STA^XUAF4($P(GMRCLOG0,U,2))
 .... S OBR=$E($$OBR^GMRCISG1(+$P(GMRCLOG0,U,4),+$P(GMRCLOG0,U,5)),5,999)
 .... ;N DIV S DIV=STA,STA=+$$SITE^VASITE
 .... N DIV S DIV=STA,STA=+$P($$SITE^VASITE,U,3) ;Changed to return correct station number
 .... D PTERRMSG^GMRCIERR(PID,STA,DOM,OBR)
 . ;
 . ;  v-- resend local ICN errors after 3 hours
 . I $P(GMRCLOG0,U,8)=202,GMRCLOG0<$$FMADD^XLFDT($$NOW^XLFDT,,-3) D  Q
 .. ;re-send based on parameter and day of week
 .. N GMRCSND,GMRCPAR,DOW
 .. S GMRCPAR=$$GET^XPAR("SYS","GMRC IFC SKIP WEEKEND RE-TRANS",1)
 .. S DOW=$$DOW^XLFDT(DT,1)
 .. S GMRCSND=$S('GMRCPAR:1,(+DOW&(DOW<6)):1,1:0)
 .. I 'GMRCSND Q  ;don't re-send activity
 .. D TRIGR^GMRCIEVT($P(GMRCLOG0,U,4),$P(GMRCLOG0,U,5)) ;re-send activity
 .. I '($P(GMRCLOG0,U,7)#8) D  ;alert CAC's about errors every 24 hrs 
 ... D DELALRT(GMRCLOG) ;delete previous alerts on same transaction
 ... D SNDALRT^GMRCIERR(GMRCLOG,"C") ; alert CAC's to patient errors
 . ;  v-- re-process implementation errors
 . ;I $P(GMRCLOG0,U,8)>300,$P(GMRCLOG0,U,8)<702 D  Q
 . I $P(GMRCLOG0,U,8)>300,$P(GMRCLOG0,U,8)<704 D  Q
 .. D DELALRT(GMRCLOG) ;delete previous alerts on same transaction
 .. D TRIGR^GMRCIEVT($P(GMRCLOG0,U,4),$P(GMRCLOG0,U,5)) ;re-send activity
 . ;  v-- if incomplete and no error, alert tech group
 . I '$P(GMRCLOG0,U,8)!($P(GMRCLOG0,U,8)>902) D  Q
 .. D DELALRT(GMRCLOG) ;delete previous alerts on same transaction
 .. D SNDALRT^GMRCIERR(GMRCLOG,"T")
 . Q
 ;
 ;  v-- set finish param 
 D EN^XPAR("SYS","GMRC IFC BACKGROUND FINISH",1,$$NOW^XLFDT)
 ;  v-- start it again one hour after completing
 D REQUEUE
 Q
 ;
REQUEUE ;task job to start up again one hour after completing
 N ZTRTN,ZTSK,ZTIO,ZTDESC,ZTDTH
 S ZTDESC="IF Consults background error processor"
 S ZTIO=""
 S ZTRTN="EN^GMRCIBKG"
 S ZTDTH=$$FMTH^XLFDT($$FMADD^XLFDT($$NOW^XLFDT,,1))
 D ^%ZTLOAD
 Q
DELALRT(MSGLOG) ;delete obsolete alerts for an entry
 ; Input:
 ;   MSGLOG = ien from file 123.6
 ;
 N XQAID,XQAKILL
 S XQAID="GMRCIFC,trans error,"_MSGLOG,XQAKILL=0
 D DELETEA^XQALERT
 Q
 ;
OVERDUE ; write message for alert to tell IRM job is overdue
 W @IOF
 W !,"The Inter-facility Consults background job is overdue."
 W !,"This is likely due to an error while the job runs. It is suggested"
 W !,"that you check the systems for errors. If the errors are resolved"
 W !,"the background job will catch up and run normally. There is a "
 W !,"remote possibility that the GMRC IFC BACKGROUND... parameters have"
 W !,"been edited and are out of synch."
 S XQAKILL=0
 Q
 ;
GONOGO() ; determine if background job should run or not
 ;Output: 
 ;  1 = go ahead and run
 ;  0 = don't run for some reason
 N GMRCQT
 S GMRCQT=1
 D
 . N GMRCBST,GMRCNOW,GMRCBFI
 . S GMRCBST=$$GET^XPAR("SYS","GMRC IFC BACKGROUND START",1)
 . I 'GMRCBST Q  ; has never run or needs to
 . S GMRCNOW=$$NOW^XLFDT
 . I GMRCBST>GMRCNOW S GMRCQT=0 Q  ;set to future date/time - don't run
 . S GMRCBFI=$$GET^XPAR("SYS","GMRC IFC BACKGROUND FINISH",1)
 . I $$FMDIFF^XLFDT(GMRCNOW,GMRCBFI,2)<3600,GMRCBFI>GMRCBST S GMRCQT=0 Q
 . ;                 ^--ran < 1 hr ago
 . I $$FMDIFF^XLFDT(GMRCBST,GMRCBFI,2)>4500 D  Q
 .. ; >1.5 hrs and job not finishing for some reason, alert techies
 .. N XQA,XQAMSG,XQAROU,XQAID,XQAKILL
 .. S XQAID="GMRC IFC BKG",XQAKILL=0 D DELETEA^XQALERT
 .. S XQA("G.IFC TECH ERRORS")=""
 .. S XQAMSG="IFC Background job overdue."
 .. S XQAID="GMRC IFC BKG"
 .. S XQAROU="OVERDUE^GMRCIBKG"
 .. D SETUP^XQALERT
 .. Q
 . Q
 Q GMRCQT
 ;
ADDICN(PID,ICN) ;
 ;
 ;  Insert ICN into PID-3 and ICN sub-field into PID-4.
 ;
 N X ;
 S X=$P(PID,"|",4),X=ICN_U_U_U_"ICN"_U_"VETID"_X,$P(PID,"|",3)=ICN,$P(PID,"|",4)=X ;
 Q PID ;
 ;
