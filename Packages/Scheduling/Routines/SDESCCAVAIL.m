SDESCCAVAIL ;ALB/ANU - VISTA SCHEDULING RPCS CANCEL CLINIC AVAILABILITY ; Oct 16, 2021@16:32
 ;;5.3;Scheduling;**800**;Aug 13, 1993;Build 23
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;Global References    Supported by ICR#     Type
 ;-----------------    -----------------     ----------
 ; ^TMP($J             SACC 2.3.2.5.1
 ;
 ;External References
 ;-------------------
 ; ^%DT                10003                 Supported
 ; $$FIND1^DIC          2051                 Supported
 ; $$GET1^DIQ           2056                 Supported
 ;
 Q  ;No Direct Call
 ;
CANCLAVAIL(SDCLNJSON,SDCLNIEN,SDESCANDATE,SDESSTRTIM,SDESENDTIM,SDCANREM) ;Called from RPC: SDES CANCEL CLINIC AVAILABILITY
 ; This RPC cancels Clinic availability within a given timeframe for a given clinic.
 ; Input:
 ;   SDCLNSREC   [required] -  Successs or Error message
 ;   SDCLNIEN    [required] -  The Internal Entry Number (IEN) from the HOSPITAL LOCATION File #44
 ;   SDESCANDATE [required] -  The Cancel Date in FM format
 ;   SDESSTRTIM  [required] -  Starting Time in FM format
 ;   SDESENDTIM  [required] -  Ending Time in FM format
 ;   SDCANREM    [required] -  Cancellation Remarks
 ;
 N ERRPOP,ERR,ERRMSG,SDECI,SC,SD,SL,SI,STARTDAY,SDTIME,FR,ST,SDHTO,TO,SDDFR
 N A,DA,DFN,DH,I,FR,NOAP,P,SDCNT,SDDATA0,X,Y,%,SDCLNSREC
 D INIT
 D VALIDATE
 I ERRPOP D BLDJSON Q
 D CANCLNAVA
 S SDCLNSREC("Success")="Clinic Availability is successfully cancelled."
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
 S %=$P(SL,U,6),SI=$S(%="":4,%<3:4,%:%,1:4)
 S %=$P($G(SL),U,3) ;Hour clinic display begins from file 44
 I %="" S %=8
 S STARTDAY=$S($L(%):%,1:8)
 D NOW^%DTC
 S SDTIME=%
 D TC(SDESSTRTIM)
 I Y=-1 S SDCLNSREC("Error",1)="Start time is Invalid" S ERRPOP=1 Q
 S FR=Y,ST=%
 D TC(SDESENDTIM)
 I Y=-1 S SDCLNSREC("Error",1)="End time is Invalid" S ERRPOP=1 Q
 S SDHTO=X,TO=Y,SDDFR=TO-FR
 S NOAP=1
 I SD="" S SDCLNSREC("Error",1)="Cancel Date is Invalid" S ERRPOP=1 Q
 ;
 ; Clinic does not meet on that day
 I '$F(^SC(SC,"ST",SD,1),"[") S SDCLNSREC("Error",1)="CLINIC DOES NOT MEET ON THAT DAY" S ERRPOP=1 Q
 ;
 ; Loss of workload credit
 I $$COED^SDC4(SC,FR,TO,1) S SDCLNSREC("Error",1)="Not Allowed to cancel availability as atleast one appointment has been checked out" S ERRPOP=1 Q
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
 S I=^SC(SC,"ST",SD,1),I=I_$J("",%-$L(I)),Y=""
 I $G(SDDFR)<100,$L(I)<77 S I=I_"    " ;SD*5.3*758 - pad 4 empty spaces needed for blocks < 60 minutes
 F X=0:2:% D
 .S DH=$E(I,X+SI+SI)
 .S P=$S(X<ST:DH_$E(I,X+1+SI+SI),X=%:$S(Y="[":Y,1:DH)_$E(I,X+1+SI+SI),1:$S(Y="["&(X=ST):"]",1:"X")_"X"),Y=$S(DH="]":"",DH="[":DH,1:Y),I=$E(I,1,X-1+SI+SI)_P_$E(I,X+2+SI+SI,999)
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
 ; SD*724 - Replace 'I' with 'SDI'
 F SDI=0:0 S SDI=$O(^SC(SC,"S",FR,1,SDI)) Q:SDI'>0  D
 .I '$D(^SC(SC,"S",FR,1,SDI,0)) I $D(^("C")) S J=FR,J2=SDI D DELETE^SDC1 K J,J2 Q  ;SD*5.3*545 delete corrupt node
 .I '+$G(^SC(SC,"S",FR,1,SDI,0)) S J=FR,J2=SDI D DELETE^SDC1 K J,J2 Q  ;SD*5.3*545 if DFN is missing delete record
 .Q:$P(^SC(SC,"S",FR,1,SDI,0),"^",9)="C"  ;SD*5.3*758 - Quit processing if appointment already canceled.
 .S DFN=+^SC(SC,"S",FR,1,SDI,0),SDCNHDL=$$HANDLE^SDAMEVT(1)
 .D BEFORE^SDAMEVT(.SDATA,DFN,FR,SC,SDI,SDCNHDL)
 .S $P(^SC(SC,"S",FR,1,SDI,0),"^",9)="C"
 .S:$D(^DPT(DFN,"S",FR,0)) NODE=^(0)  ;added SD/523
 .Q:$P(NODE,U,1)'=SC                  ;added SD/523
 .S ^DPT("ASDCN",SC,FR,DFN)=""
 .S SDSC=SC,SDTTM=FR,SDPL=SDI,TDH=DH,TMPD=SDCANREM D CANCEL^SDCNSLT S DH=TDH ;SD/478
 .I $D(^DPT(DFN,"S",FR,0)),$P(^(0),"^",2)'["C" S $P(^(0),"^",2)="C",$P(^(0),"^",12)=DUZ,$P(^(0),"^",14)=SDTIME,DH=DH+1,TDH=DH,DIE="^DPT(DFN,"_"""S"""_",",DR="17///^S X=SDCANREM",DA=FR D ^DIE S DH=TDH D MORE
 .D SDEC^SDCNP0(DFN,FR,SC,"C","",$G(SDCANREM),SDTIME,DUZ)   ;alb/sat 627
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
 D ^%DT
 I Y<0!(X["?") Q
 S X=$E($P(Y_"0000",".",2),1,4),%=$E(X,3,4),%=X\100-STARTDAY*SI+(%*SI\60)*2
 I %<0!(%>72) S Y=-1
 Q
