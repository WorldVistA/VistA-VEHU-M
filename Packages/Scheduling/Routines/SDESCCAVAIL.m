SDESCCAVAIL ;ALB/KML,MGD - VISTA SCHEDULING RPCS CANCEL CLINIC AVAILABILITY ; July 5, 2022
 ;;5.3;Scheduling;**800,805,809,813,819,820**;Aug 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to ^TMP($J Supported by SACC 2.3.2.5.1
 ; Reference to ^%DT in ICR #10003
 ; Reference to $$FIND1^DIC in ICR #2051
 ; Reference to $$GET1^DIQ in ICR #2056
 ;
 Q  ;No Direct Call
 ;
CANCLAVAIL(SDCLNJSON,SDCLNIEN,SDESCANDATE,SDESSTRTIM,SDESENDTIM,SDCANREM,SDEAS) ;Called from RPC: SDES CANCEL CLINIC AVAILABILITY
 ; This RPC cancels Clinic availability within a given timeframe for a given clinic.
 ; Input:
 ;   SDCLNSREC   [required] - Success or Error message
 ;   SDCLNIEN    [required] - The Internal Entry Number (IEN) from the HOSPITAL LOCATION File #44
 ;   SDESCANDATE [required] - The Cancel Date in ISO8601 format (CCYY-MM-DD)
 ;   SDESSTRTIM  [required] - Starting Time in military 24 format (HHMM)
 ;   SDESENDTIM  [required] - Ending Time in military 24 format (HHMM)
 ;   SDCANREM    [required] - Cancellation Remarks
 ;   SDEAS       [optional] - Enterprise Appointment Scheduling (EAS) Tracking Number associated to an appointment.
 ;
 N ERRPOP,ERR,ERRMSG,SDECI,SC,SD,SL,SI,STARTDAY,SDTIME,FR,ST,SDHTO,TO,SDDFR
 N A,DA,DFN,DH,I,FR,NOAP,P,SDCNT,SDDATA0,X,Y,SDXX,SDCLNSREC
 D INIT
 D VALIDATE
 I ERRPOP S SDCLNSREC("Success",1)="" D BLDJSON Q
 D CHECKCLINIC
 I ERRPOP D BLDJSON Q
 D CANCLNAVA
 S SDCLNSREC("Success",1)="Clinic Availability is successfully cancelled."
 D BLDJSON
 Q
 ;
INIT ; initialize values needed
 S SDECI=0
 S SDECI=$G(SDECI,0),ERR=""
 S ERRPOP=0,ERRMSG=""
 S SC=SDCLNIEN
 S SD=SDESCANDATE
 Q
 ;
VALIDATE ; validate incoming parameters
 I SDCLNIEN="" D ERRLOG^SDESJSON(.SDCLNSREC,18) S ERRPOP=1 Q
 I '$D(^SC(SDCLNIEN,0)) D ERRLOG^SDESJSON(.SDCLNSREC,19) S ERRPOP=1 Q
 ;
 S SL=^SC(SDCLNIEN,"SL")
 S I=SDCANREM
 S SDXX=$P(SL,U,6),SI=$S(SDXX="":4,SDXX<3:4,SDXX:SDXX,1:4)
 S SDXX=$P($G(SL),U,3) ;Hour clinic display begins from file 44
 I SDXX="" S SDXX=8
 S STARTDAY=$S($L(SDXX):SDXX,1:8)
 D NOW^%DTC
 S SDTIME=SDXX
 D TC(SDESSTRTIM)
 I Y=-1 D ERRLOG^SDESJSON(.SDCLNSREC,161) S ERRPOP=1
 S FR=Y,ST=SDXX
 D TC(SDESENDTIM)
 I Y=-1 D ERRLOG^SDESJSON(.SDCLNSREC,162) S ERRPOP=1
 S SDHTO=X,TO=Y,SDDFR=TO-FR
 S NOAP=1
 S SD=$$ISOTFM^SDAMUTDT(SD)  ;VSE-2396
 I SD=-1 D ERRLOG^SDESJSON(.SDCLNSREC,163) S ERRPOP=1
 I SD="" D ERRLOG^SDESJSON(.SDCLNSREC,164) S ERRPOP=1
 ;
 ;validate EAS
 S SDEAS=$G(SDEAS,"")
 I $L(SDEAS) S SDEAS=$$EASVALIDATE^SDESUTIL(SDEAS)
 I SDEAS=-1 D ERRLOG^SDESJSON(.SDCLNSREC,142) S ERRPOP=1
 Q
CHECKCLINIC ;
 ; Clinic does not meet on that day
 I '$F($G(^SC(SC,"ST",SD,1)),"[") S SDCLNSREC("Error",1)="Clinic does not meet on that day" S ERRPOP=1 Q
 ;
 ; Loss of workload credit
 I $$COED^SDC4(SC,FR,TO,1) S SDCLNSREC("Error",1)="Not Allowed to cancel availability as at least one appointment has been checked out" S ERRPOP=1 Q
 ;
 ; Clinic is inactive
 K SDRE,SDIN,SDRE1 I $D(^SC(SC,"I")) S SDIN=+^("I"),SDRE=+$P(^("I"),"^",2),Y=SDRE D:Y DTS^SDUTL S SDRE1=$S(SDRE:" to "_Y,1:"")
 I $S('$D(SDIN):0,SDIN'>0!(SDIN>SD):0,SDRE'>SD&(SDRE):0,1:1) D
 .S SDCLNSREC("Error",1)="Clinic is inactive "_$S('SDRE:"as of ",1:"from ") S Y=SDIN D DTS^SDUTL S SDCLNSREC=SDCLNSREC_Y_SDRE1
 .S ERRPOP=1
 ;
 Q
 ;
BLDJSON ;
 D ENCODE^SDESJSON(.SDCLNSREC,.SDCLNJSON,.ERR)
 K SDCLNSREC
 Q
 ;
CANCLNAVA ;
 N SDATA,SDCNHDL ; for evt dvr
 I '$D(^SC(SC,"SDCAN",0)) S ^SC(SC,"SDCAN",0)="^44.05D^"_FR_"^1" G SKIP
 S A=^SC(SC,"SDCAN",0),SDCNT=$P(A,"^",4),^SC(SC,"SDCAN",0)=$P(A,"^",1,2)_"^"_FR_"^"_(SDCNT+1)
SKIP ;
 S ^SC(SC,"SDCAN",FR,0)=FR_"^"_SDHTO
 S NOAP=$S($O(^SC(SC,"S",(FR-.0001)))'>0:1,$O(^SC(SC,"S",(FR-.0001)))>TO:1,1:0)
 I 'NOAP S NOAP=$S($O(^SC(SC,"S",+$O(^SC(SC,"S",(FR-.0001))),0))="MES":1,1:0)
 S ^SC(SC,"S",FR,0)=FR
 S ^SC(SC,"S",FR,"MES")="CANCELLED UNTIL "_X_$S(I?.P:"",1:" ("_I_")")
 S ^SC(SC,"ST",SD,"CAN")=^SC(SC,"ST",SD,1)
 S I=^SC(SC,"ST",SD,1),I=I_$J("",SDXX-$L(I)),Y=""
 I $G(SDDFR)<100,$L(I)<77 S I=I_"    " ;SD*5.3*758 - pad 4 empty spaces needed for blocks < 60 minutes
 F X=0:2:SDXX D
 .S DH=$E(I,X+SI+SI)
 .S P=$S(X<ST:DH_$E(I,X+1+SI+SI),X=SDXX:$S(Y="[":Y,1:DH)_$E(I,X+1+SI+SI),1:$S(Y="["&(X=ST):"]",1:"X")_"X"),Y=$S(DH="]":"",DH="[":DH,1:Y),I=$E(I,1,X-1+SI+SI)_P_$E(I,X+2+SI+SI,999)
 S:'$F(I,"[") I5=$F(I,"X"),I=$E(I,1,(I5-2))_"["_$E(I,I5,999)
 K I5
 S DH=0,^SC(SC,"ST",SD,1)=I,FR=FR-.0001
 G C
 Q
 ;
C ;Cancel any appointments that are within the time blocked out.
 S FR=$O(^SC(SC,"S",FR))
 I FR<1!(FR'<TO) K SDX Q
 N TDH,TMPD,DIE,DR,NODE,SDI
 F SDI=0:0 S SDI=$O(^SC(SC,"S",FR,1,SDI)) Q:SDI'>0  D
 .I '$D(^SC(SC,"S",FR,1,SDI,0)) I $D(^("C")) S J=FR,J2=SDI D DELETE^SDC1 K J,J2 Q  ;SD*5.3*545 delete corrupt node
 .I '+$G(^SC(SC,"S",FR,1,SDI,0)) S J=FR,J2=SDI D DELETE^SDC1 K J,J2 Q  ;SD*5.3*545 if DFN is missing delete record
 .Q:$P(^SC(SC,"S",FR,1,SDI,0),"^",9)="C"  ;SD*5.3*758 - Quit processing if appointment already canceled.
 .S DFN=+^SC(SC,"S",FR,1,SDI,0),SDCNHDL=$$HANDLE^SDAMEVT(1)
 .D BEFORE^SDAMEVT(.SDATA,DFN,FR,SC,SDI,SDCNHDL)
 .S $P(^SC(SC,"S",FR,1,SDI,0),"^",9)="C"
 .S:$D(^DPT(DFN,"S",FR,0)) NODE=^(0)
 .Q:$P(NODE,U,1)'=SC
 .S ^DPT("ASDCN",SC,FR,DFN)=""
 .S SDSC=SC,SDTTM=FR,SDPL=SDI,TDH=DH,TMPD=SDCANREM D CANCEL^SDCNSLT S DH=TDH ;SD/478
 .I $D(^DPT(DFN,"S",FR,0)),$P(^(0),"^",2)'["C" S $P(^(0),"^",2)="C",$P(^(0),"^",12)=DUZ,$P(^(0),"^",14)=SDTIME,DH=DH+1,TDH=DH,DIE="^DPT(DFN,"_"""S"""_",",DR="17///^S X=SDCANREM",DA=FR D ^DIE S DH=TDH D MORE
 .D SDEC^SDCNP0(DFN,FR,SC,"C","",$G(SDCANREM),SDTIME,DUZ)
 G C
 Q
 ;
MORE ;
 I $D(^SC("ARAD",SC,FR,DFN)) S ^(DFN)="N"
 N SDV1
 S SDIV=$S($P(^SC(SC,0),"^",15)]"":$P(^(0),"^",15),1:" 1"),SDV1=$S(SDIV:SDIV,1:+$O(^DG(40.8,0))) I $D(^DPT("ASDPSD","C",SDIV,SC,FR,DFN)) K ^(DFN)
 ; SD*724 - set SDPL with value from SDI
 S SDH=DH,SDTTM=FR,SDSC=SC,SDPL=SDI,SDRT="D" D RT^SDUTL
 S DH=SDH K SDH D CK1,EVT
 K SD1,SDIV,SDPL,SDRT,SDSC,SDTTM,SDX Q
CK1 ;
 S SDX=0 F SD1=FR\1:0 S SD1=$O(^DPT(DFN,"S",SD1)) Q:'SD1!((SD1\1)'=(FR\1))  I $P(^(SD1,0),"^",2)'["C",$P(^(0),"^",2)'["N" S SDX=1 Q
 Q:SDX  F SD1=2,4 I $D(^SC("AAS",SD1,FR\1,DFN)) S SDX=1 Q
 Q:SDX  IF $D(^SCE(+$$EXAE^SDOE(DFN,FR\1,FR\1),0)) S SDX=1
 Q:SDX  K ^DPT("ASDPSD","B",SDIV,FR\1,DFN) Q
 ;
EVT ; -- separate tag if need to NEW vars
 ; -- cancel event
 N FR,I,SDTIME,DH,SC
 D CANCEL^SDAMEVT(.SDATA,DFN,SDTTM,SDSC,SDPL,0,SDCNHDL) K SDATA,SDCNHDL
 Q
 ;
TC(TIME) ;
 N %DT
 I $L(TIME)=3 S TIME="0"_TIME
 S X=TIME_"0000",X=$E(X,1,4)
 S X=$$FMTE^XLFDT(SD)_"@"_X,%DT="TE"
 W !
 D ^%DT
 I Y<0!(X["?") Q
 S X=$E($P(Y_"0000",".",2),1,4),SDXX=$E(X,3,4),SDXX=X\100-STARTDAY*SI+(SDXX*SI\60)*2
 I SDXX<0!(SDXX>72) S Y=-1
 Q
