SDBUL ;ALB/CAW ; Send a bulletin when someone deletes clinic day(s) ;11/18/94 [ 11/22/94  10:14 AM ]
 ;;5.3;Scheduling;**T1**;Aug 13, 1993
 ;
EN(CLINIC,DATE) ;
 N DO,SDBUL,SDLN,SDY,SDNOW,X,XMDUZ,XMSUB,XMTEXT,SDLN
 S (SDY,SDNOW)=DATE
 D BUL
EN1 S SDY=$O(^SC(CLINIC,"S",SDY)) G:'SDY ENQ I $P(SDY,".")'=SDNOW D INC G EN1
 I $O(^SC(CLINIC,"S",SDNOW)) S SDY=SDNOW D LOOP G EN1
ENQ I SDLN>3 D ^XMD
 Q
 ;
LOOP F  S SDY=$O(^SC(CLINIC,"S",SDY)) Q:'SDY!($P(SDY,".")>(SDNOW+.9))  S SDX=0 D
 .F  S SDX=$O(^SC(CLINIC,"S",SDY,1,SDX)) Q:'SDX  D
 ..S APPT=$G(^SC(CLINIC,"S",SDY,1,SDX,0)) Q:'APPT
 ..S CANC=$P(APPT,U,9) Q:CANC="C"
 ..S CLIN=$P(^SC(CLINIC,0),U)
 ..S PAT=$P($G(^DPT(+APPT,0)),U)
 ..S Y=SDY X ^DD("DD") S APPT=Y
 ..D SET("              Patient: "_PAT)
 ..D SET("Appointment Date/Time: "_APPT)
 ..D SET("")
 Q
 ;
INC ;
 S X1=SDNOW,X2=7 D C^%DTC S (SDY,SDNOW)=X
 Q
 ;
BUL ;
 ;
 N SDATE
 D XMY^SDUTL2(+$P($G(^DG(43,1,"SCLR")),U,17),0,0) G BULQ:'$D(XMY)
 S XMSUB="Clinic Day Deleted",XMTEXT="SDBUL("
 D SET("The following day(s) had appointment(s) when the clinic day(s)")
 D SET("were deleted.  The appointment(s) had not been cancelled:")
 N Y S Y=DT D DD^%DT S SDATE=Y
 D SET("By: "_$P($G(^VA(200,DUZ,0)),U)_"     On: "_SDATE)
BULQ Q
 ;
SET(X)  ; -- set text into array
 S SDLN=$G(SDLN)+1,SDBUL(SDLN,0)=X Q
