SDMHPRO1 ;MAF/ALB,JAS - MENTAL HEALTH PROACTIVE HIGH RISK REPORT (BGJ CONT.) ; MAR 29, 2024@14:00
 ;;5.3;Scheduling;**588,877**;Aug 13,1993;Build 14
 ;;Per VHA Directive 6402, this routine should not be modified
DATA ; Set up the data for the patient
 ;       piece 1 = dfn
 ;       piece 2 = Appointment Date and time
 ;       piece 3 = status N(Noshow) or NA (Noshow with auto rebook)
 ;       piece 4 = PID last 4 of SSN
 ;       piece 5 = clinic ien   ^SC(
 ;       piece 6 = stop code ien ^DIC(40.7
 ;
 ;
EN ;PRINT OF THE ^TMP
 N SDXDIV,SDXCLIN,SDXDFN,SDXSTOP,SDXREM,SDXNM,SDCOUNT,SDATE
 S (SDXDFN,SDXREM,SDCOUNT)=0
 K SDPAT
 I $D(^TMP(NAMSPC1,$J)) D TOTAL^SDMHPRO
 S SDXDIV=""
 F  S SDXDIV=$O(^TMP(NAMSPC1,$J,SDXDIV)) Q:SDXDIV']""!(SDUP)  D
 .S SDCOUNT=0
 .I SDTL="CLIN" D  N SDX S SDX=$$SETSTR(" ",X,1,79) D SET1(SDX)
 ..S SDXNM=""
 ..F  S SDXNM=$O(^TMP(NAMSPC1,$J,SDXDIV,SDXNM)) Q:SDXNM']""!(SDUP)  D
 ...S SDATE=0
 ...F  S SDATE=$O(^TMP(NAMSPC1,$J,SDXDIV,SDXNM,SDATE)) Q:'SDATE!(SDUP)  D
 ....S SDXCLIN=""
 ....F  S SDXCLIN=$O(^TMP(NAMSPC1,$J,SDXDIV,SDXNM,SDATE,SDXCLIN)) Q:SDXCLIN']""!(SDUP)   D
 .....S SDXSTOP=0
 .....F  S SDXSTOP=$O(^TMP(NAMSPC1,$J,SDXDIV,SDXNM,SDATE,SDXCLIN,SDXSTOP)) Q:'SDXSTOP!(SDUP)  D
 ......I $D(^TMP(NAMSPC1,$J,SDXDIV,SDXNM,SDATE,SDXCLIN,SDXSTOP)) Q:$D(SDPAT(SDXDIV,$O(^DPT("B",$E(SDXNM,1,30),0))))  D PRT
 .N SDX S SDX=$$SETSTR(" ",X,1,81) D SET1(SDX)
 Q
 ;
 ;
PRT ;Print  report
 N SDX,SDXX
 D COUNT^SDMHPRO
 I '$D(SDXFLG(SDXDIV)) D HEAD^SDMHPRO  S SDXFLG(SDXDIV)=1,SDXFLG(SDXDIV,SDXCLIN)=1
 I $D(SDXFLG(SDXDIV)),'$D(SDXFLG(SDXDIV)) S SDX=$$SETSTR("",X,1,80) D SET1(SDX) D HEAD1^SDMHPRO S SDXFLG(SDXDIV)=1
 N SDXNODE,SDXID,SDXDT,SDXSTAT,SDXSORT1,SDXSORT2,SDXCLIEN,SDX,SDDSS
 S SDXSORT1=$S(SDTL="MEN":SDXREM,SDTL="STOP":SDXSTOP,1:SDXCLIN)
 S SDXSORT2=$S(SDTL="CLIN":SDXSTOP,1:SDXCLIN)
 S SDXNODE=$G(^TMP(NAMSPC1,$J,SDXDIV,SDXNM,SDATE,SDXCLIN,SDXSTOP))
 S SDXDFN=$P(SDXNODE,"^",1) Q:SDXDFN']""
 S SDXID=$E($P(SDXNODE,"^",4),1,5)
 S SDXDT=$P(SDXNODE,"^",2)
 S SDXSTAT=$P(SDXNODE,"^",3)
 S SDXCLIEN=$P(SDXNODE,"^",5)
 S SDDSS=$P($G(^DIC(40.7,+$P(SDXNODE,"^",6),0)),"^",2)
 S SDPAT(SDXDIV,SDXDFN)=""
 I '$D(SDXFLG(SDXDIV)) D HEAD1^SDMHPRO  S SDXFLG(SDXDIV)=1
 S SDXDT=$$FMTE^XLFDT(SDXDT,"5")
 D SET
 S SDXX=$$SETSTR(SDCOUNT,X,1,2)_$$SETSTR($P(^DPT(SDXDFN,0),"^",1),X,3,20)_$$SETSTR(SDXID,X,2,5) I SDCOUNT=$P($G(TOTAL(SDXDIV)),"^",1) S SDCOUNT=0
 D FUT
 Q
 ;
 ;
SETSTR(W,X,Y,Z) ;SET UP THE STRING
 ;W= String
 ;X= Variable to set it into
 ;Y= column to set it into
 ;Z= length of the string
 S X=$$SETSTR^SDUL1(W,X,Y,Z)
 Q X
SET1(X) ;Sets the XMTEXT global
 S SDLN=SDLN+1,^TMP("SDMHP",$J,SDLN,0)=X Q
SET ;
 S X="" S SDLN=SDLN+1,^TMP("SDPRO1",$J,SDLN,0)=X
 Q
 ;
 ;
FUT ; FUTURE SCHEDULED APPTS.
 N SDARRAY,SDCOUNT,SDX,X1,X2,X,SDPRODAY
 S SDPRODAY=$$GET^XPAR("SYS^PKG.SCHEDULING","SDMH PROACTIVE DAYS",1,"Q")
 S SDPRODAY=$S(SDPRODAY]"":SDPRODAY,1:30)
 ;Find Scheduled apointments for SDPRODAY  days using scheduling API
 S X1=DT,X2=SDPRODAY D C^%DTC S SDX=X
 S SDARRAY(1)=DT_";"_SDX
 S SDARRAY("SORT")="P"
 S SDARRAY(3)="NT;R"
 S SDARRAY(4)=SDXDFN
 S SDARRAY("FLDS")="1;2;3;4;10;13"
 S SDCOUNT=$$SDAPI^SDAMA301(.SDARRAY)
 I SDCOUNT>0 D  Q:SDUP
 .;Get info on future scheduled appointments and display it
 . S SDX="",X=""
 . N SDFA,SDFNODE,SDFUTDT
 . S SDFA=0 F  S SDFA=$O(^TMP($J,"SDAMA301",SDXDFN,SDFA)) Q:SDFA=""  D  ;!($P($G(SDFA),".",1))'=$P(SDBEG,".",1)  D
 ..S (SDX,X)=""
 ..S SDFUTDT=$$FMTE^XLFDT(SDFA,"5") S SDFNODE=^TMP($J,"SDAMA301",SDXDFN,SDFA)
 ..N SDCLCD S SDCLCD=$P($P($G(SDFNODE),"^",2),";",1) I SDCLCD]"" S SDCLCD=$P($G(^SC(SDCLCD,0)),"^",15) Q:SDXDIV'=$P($G(^DG(40.8,SDCLCD,0)),"^",1)
 ..I '$D(SDXX) S SDX=$$SETSTR(SDFUTDT,X,32,16)_$$SETSTR($P($P(SDFNODE,"^",2),";",2),X,2,30)
 ..I $D(SDXX) S SDX=SDXX_$$SETSTR(SDFUTDT,X,2,16)_$$SETSTR($P($P(SDFNODE,"^",2),";",2),X,2,30) K SDXX
 ..D SET1(SDX)
 .N SDX S SDX=$$SETSTR(" ",X,1,81) D SET1(SDX)
 .Q
 I SDCOUNT'>0 D
 .S (SDX,X)=""
 .S SDX="     Future Scheduled Appointments: NO APPOINTMENTS SCHEDULED WITHIN "_SDPRODAY_$S(SDPRODAY=1:" DAY",1:" DAYS")
 .S SDX=$$SETSTR(SDX,X,1,80) D SET1(SDX)
 ;.S SDX=$$SETSTR("     Future Scheduled Appointments: NO APPOINTMENTS SCHEDULED WITHIN 30 DAYS",X,1,80) D SET1(SDX)
 K ^TMP($J,"SDAMA301")
 Q
 ;
 ;
PID(DFN) ; Return PID
 ; INPUT  - DFN
 ; OUTPUT - PID or 'UNKNOWN'
 N VA
 D PID^VADPT6
 Q $S(VA("BID")]"":VA("BID"),1:"UNKNOWN")
 ;
