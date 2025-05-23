PSOERRX1 ;BIRM/MFR - All Rxs eRx Queue - Supporting APIs ;08/28/22
 ;;7.0;OUTPATIENT PHARMACY;**700,769**;DEC 1997;Build 26
 ;
HDR ; - Builds the Header section
 N LINE1,LINE2,LINE3,ARR
 ;
 S LINE1="LOOK BACK DAYS: "_IOINHI_$S($G(REDTFLTR):"N/A",1:PSOLKBKD)_IOINORM
 S $E(LINE1,40)="CS/NON-CS: "_IOINHI_$S(PSOCSERX="CS":"CS ONLY",PSOCSERX="Non-CS":"NON-CS ONLY",1:"BOTH")
 S:PSOCSERX'="Non-CS" LINE1=LINE1_" ("_$S(PSOCSSCH=1:"II",PSOCSSCH=2:"III-V",1:"II-V")_")"
 S LINE1=LINE1_IOINORM
 D INSTR^VALM1("MAX. QUEUE SIZE: "_IOINHI_$J(PSOMAXQS,4)_IOINORM,60,2)
 ;
 S LINE2="ERX STATUS: "_IOINHI
 I PSOSTFLT="A" S LINE2=LINE2_"ALL"
 I PSOSTFLT="N" S LINE2=LINE2_"NEW"
 I PSOSTFLT="I" S LINE2=LINE2_"IN PROGRESS"
 I PSOSTFLT="W" S LINE2=LINE2_"WAIT"
 I PSOSTFLT="H" S LINE2=LINE2_$S(PSOHDSTS="ALL":"HOLD (ALL)",1:"HOLD ("_PSOHDSTS_")")
 I PSOSTFLT="C" S LINE2=LINE2_$S(PSOCCRST="ALL":"CCR (ALL)",1:"CCR ("_PSOCCRST_")")
 S LINE2=LINE2_IOINORM
 S LINE3=""
 I $D(PATFLTR)!$G(DOBFLTR)!$G(REDTFLTR)!$D(PRVFLTR)!$G(STSFLTR)!($G(DRGFLTR)'="")!$G(MATFLTR)!($G(MSTPFLTR)'="") D
 . N FILTER S FILTER=""
 . I $G(REDTFLTR) S FILTER=FILTER_"|"_$$FMTE^XLFDT(+REDTFLTR,"2Z")_"-"_$$FMTE^XLFDT($P(REDTFLTR,"^",2),"2Z")
 . I $G(MATFLTR) S FILTER=FILTER_"|MATCH("_$$MATCHLBL^PSOERPC2(MATFLTR)_")"
 . I $G(DRGFLTR)'="" S FILTER=FILTER_"|DRUG('"_DRGFLTR_"')"
 . I $G(DOBFLTR) S FILTER=FILTER_"|DOB("_$$FMTE^XLFDT(DOBFLTR,"2Z")_")"
 . I $G(STSFLTR) S FILTER=FILTER_"|STATUS("_$$GET1^DIQ(52.45,STSFLTR,.01)_")"
 . I $G(MSTPFLTR)'="" S FILTER=FILTER_"|TYPE("_$G(MTARR(MSTPFLTR))_")"
 . I $D(PRVFLTR) S FILTER=FILTER_"|PROVIDER("_$$EPRVFLST^PSOERUT(60)_")"
 . I $D(PATFLTR) S FILTER=FILTER_"|PATIENT("_$$EPATFLST^PSOERUT(60)_")"
 . S $E(FILTER,1)="" I $L(FILTER)>63 S FILTER=$E(FILTER,1,60)_"..."
 . S LINE2="FILTERED BY: "_IOINHI_FILTER_IOINORM
 K VALMHDR S VALMHDR(1)=LINE1,VALMHDR(2)=LINE2 ;S:LINE3'="" VALMHDR(3)=LINE3 S VALMHDR(4)=IOINORM
 D SETHDR()
 Q
 ;
SETHDR() ; - Displays the Header Line
 N HDR,SRTORD,SRTPOS
 S HDR="#",$E(HDR,5)="PATIENT",$E(HDR,26)="DOB",$E(HDR,35)="DRUG"
 S $E(HDR,57)="PROVIDER",$E(HDR,69)="STA",$E(HDR,73)="REC.DATE"
 D INSTR^VALM1(IORVON_HDR_IOINORM,1,4)
 S SRTORD=$S(PSORDER="A":"^",1:"v")
 S SRTPOS=$S(PSOSRTBY="PA":12,PSOSRTBY="DOB":29,PSOSRTBY="DR":39,PSOSRTBY="PR":65,PSOSRTBY="STA":72,1:80)
 D INSTR^VALM1(IOINHI_IORVON_SRTORD_IOINORM,SRTPOS,4)
 Q
 ;
SETSORT(FIELD) ; Sets the data sorted by the FIELD specified
 ;Input: FIELD - Sort By Field
 N ERXCNT,PATNAME,DOB,MSGDT,ERXIEN,CSGROUP,ERXSTS,STS,STSIEN,EXSTSAR,MSGTYPE,PATMTCH,PROMTCH,DRUMTCH,Z,X
 N ERXPAT,ERXPRV,INST,BEGDATE,ENDDATE,INST,STSLST,RELMSGID,RELMRD
 K ^TMP("PSOERRXS",$J),^TMP("PSOERINC",$J)
 ;
 S ERXCNT=0
 S BEGDATE=$$FMADD^XLFDT(DT,-PSOLKBKD)-.1,ENDDATE=DT+.99
 ; - Setting Begin/End Date if a Date Range is selected
 I $G(REDTFLTR) D
 . S BEGDATE=$P(REDTFLTR,"^",1)-.1,ENDDATE=$P(REDTFLTR,"^",2)+.99
 ;
 ; - Filter By eRx Patient is set
 I $D(PATFLTR) D  Q
 . S ERXPAT="" F  S ERXPAT=$O(PATFLTR(ERXPAT)) Q:'ERXPAT  D  I ERXCNT'<PSOMAXQS Q
 . . I $G(DOBFLTR),'$D(^PS(52.46,"DOB",DOBFLTR,ERXPAT)) Q
 . . S MSGDT=BEGDATE
 . . F  S MSGDT=$O(^PS(52.49,"PAT2",ERXPAT,MSGDT)) Q:'MSGDT!(MSGDT>ENDDATE)  D  I ERXCNT'<PSOMAXQS Q
 . . . S ERXIEN=0 F  S ERXIEN=$O(^PS(52.49,"PAT2",ERXPAT,MSGDT,ERXIEN)) Q:'ERXIEN  D  I ERXCNT'<PSOMAXQS Q
 . . . . D SETITEM(FIELD,ERXIEN,.ERXCNT)
 . . . . D RELMSG(ERXIEN,.ERXCNT)
 ;
 ; - Filter By eRx Patient DOB is set
 I $G(DOBFLTR)'="" D  Q
 . S ERXPAT=0 F  S ERXPAT=$O(^PS(52.46,"DOB",DOBFLTR,ERXPAT)) Q:'ERXPAT  D  I ERXCNT'<PSOMAXQS Q
 . . I $D(PATFLTR),'$D(PATFLTR(ERXPAT)) Q
 . . S MSGDT=BEGDATE
 . . F  S MSGDT=$O(^PS(52.49,"PAT2",ERXPAT,MSGDT)) Q:'MSGDT!(MSGDT>ENDDATE)  D  I ERXCNT'<PSOMAXQS Q
 . . . S ERXIEN=0 F  S ERXIEN=$O(^PS(52.49,"PAT2",ERXPAT,MSGDT,ERXIEN)) Q:'ERXIEN  D  I ERXCNT'<PSOMAXQS Q
 . . . . D SETITEM(FIELD,ERXIEN,.ERXCNT)
 . . . . D RELMSG(ERXIEN,.ERXCNT)
 ;
 ; - Filter By eRx Status is set
 I $G(PSOSTFLT)'="A"!$G(STSFLTR) D  Q
 . I $G(STSFLTR) S STSLST(STSFLTR)=""
 . E  D LOADSTS^PSOERPC1(.STSLST)
 . I '$G(MBMSITE) D
 . . S ERXSTS=0 F  S ERXSTS=$O(STSLST(ERXSTS)) Q:'ERXSTS  D  I ERXCNT'<PSOMAXQS Q
 . . . S MSGDT=BEGDATE
 . . . F  S MSGDT=$O(^PS(52.49,"E",+$G(PSNPINST),ERXSTS,MSGDT)) Q:'MSGDT!(MSGDT>ENDDATE)  D  I ERXCNT'<PSOMAXQS Q
 . . . . S ERXIEN=0 F  S ERXIEN=$O(^PS(52.49,"E",+$G(PSNPINST),ERXSTS,MSGDT,ERXIEN)) Q:'ERXIEN  D  I ERXCNT'<PSOMAXQS Q
 . . . . . D SETITEM(FIELD,ERXIEN,.ERXCNT)
 . . . . . D RELMSG(ERXIEN,.ERXCNT)
 . E  D
 . . S MSGDT=BEGDATE
 . . F  S MSGDT=$O(^PS(52.49,"AMSGDTSTS",MSGDT)) Q:'MSGDT!(MSGDT>ENDDATE)  D  I ERXCNT'<PSOMAXQS Q
 . . . S ERXSTS=0 F  S ERXSTS=$O(STSLST(ERXSTS)) Q:'ERXSTS  D  I ERXCNT'<PSOMAXQS Q
 . . . . S ERXIEN=0 F  S ERXIEN=$O(^PS(52.49,"AMSGDTSTS",MSGDT,ERXSTS,ERXIEN)) Q:'ERXIEN  D  I ERXCNT'<PSOMAXQS Q
 . . . . . D SETITEM(FIELD,ERXIEN,.ERXCNT)
 . . . . . D RELMSG(ERXIEN,.ERXCNT)
 ;
 ; - Filter By  Message Type is set
 I $G(MSTPFLTR)'="" D  Q
 . S INST=0 F  S INST=$O(^PS(52.49,"MTYPE",INST)) Q:'INST  D  I ERXCNT'<PSOMAXQS Q
 . . I '$G(MBMSITE),PSNPINST'=INST Q
 . . S MSGDT=BEGDATE F  S MSGDT=$O(^PS(52.49,"MTYPE",INST,MSGDT)) Q:'MSGDT!(MSGDT>ENDDATE)  D  I ERXCNT'<PSOMAXQS Q
 . . . S ERXIEN=0 F  S ERXIEN=$O(^PS(52.49,"MTYPE",INST,MSGDT,MSTPFLTR,ERXIEN)) Q:'ERXIEN  D  I ERXCNT'<PSOMAXQS Q
 . . . . D SETITEM(FIELD,ERXIEN,.ERXCNT)
 . . . . D RELMSG(ERXIEN,.ERXCNT)
 ;
 ; - No Filters (Catch All)
 S MSGDT=BEGDATE
 F  S MSGDT=$O(^PS(52.49,"AMSGDTSTS",MSGDT)) Q:'MSGDT!(MSGDT>ENDDATE)  D  I ERXCNT'<PSOMAXQS Q
 . S ERXSTS=0 F  S ERXSTS=$O(^PS(52.49,"AMSGDTSTS",MSGDT,ERXSTS)) Q:'ERXSTS  D  I ERXCNT'<PSOMAXQS Q
 . . I '$$ELIGSTS^PSOERPC1("RX",$P($G(^PS(52.45,ERXSTS,0)),"^")) Q
 . . S ERXIEN=0 F  S ERXIEN=$O(^PS(52.49,"AMSGDTSTS",MSGDT,ERXSTS,ERXIEN)) Q:'ERXIEN  D  I ERXCNT'<PSOMAXQS Q
 . . . D SETITEM(FIELD,ERXIEN,.ERXCNT)
 . . . D RELMSG(ERXIEN,.ERXCNT)
 ;
 K ^TMP("PSOERINC",$J)
 Q
 ;
RELMSG(ERXIEN,ERXCNT) ; IncludeS any related Message
 ;Input: ERXIEN - Pointer to the ERX HOLDING QUEUE (#52.49) file
 ;       ERXCNT - eRx Counter - Number of Items on the List (Passed in by Reference)
 N RELMSGID,RELMRD
 S RELMSGID=0 F  S RELMSGID=$O(^PS(52.49,ERXIEN,201,"B",RELMSGID)) Q:'RELMSGID  D
 . I $D(^TMP("PSOERINC",$J,RELMSGID)) Q
 . S RELMRD=$P($G(^PS(52.49,RELMSGID,0)),"^",3) I RELMRD<BEGDATE!(RELMRD>ENDDATE) Q
 . D SETITEM(FIELD,RELMSGID,.ERXCNT)
 . S ^TMP("PSOERINC",$J,RELMSGID)=""
 Q
 ;
SETITEM(FIELD,ERXIEN,COUNTER) ; Adds an eRx Record to the Sorted List
 ; Input: FIELD   - Sort By field
 ;        ERXIEN  - eRx IEN - Pointer to #52.49
 ;        COUNTER - eRx Counter - Number of Items on the List (Passed in by Reference)
 N ERXSTAT,MTYPE,RESTYPE,PATIEN,ERXQFLG,REQIEN,DELTA,PATNM,NEWRX,EDRUG,VDRGIEN,MSGDT,STATIEN
 N EXDS,EXPRIEN,VPATIEN,EXPRNM,ERXDT,ERXEDT,DOB,CSPREFIX,CSERX,PROVIDER,EPATIEN,EPROVIEN
 N ERXNODE0,ERXNODE1,ERXNODE2,ERXNODE3,EPTNODE0,EPTNODE1,EPTNODE2
 ; Related Institution Filter (Non-MbM sites only)
 I '$G(MBMSITE),$G(PSNPINST)'=+$G(^PS(52.49,ERXIEN,24)) Q
 S ERXNODE0=$G(^PS(52.49,ERXIEN,0)),ERXNODE1=$G(^PS(52.49,ERXIEN,1))
 S ERXNODE2=$G(^PS(52.49,ERXIEN,2)),ERXNODE3=$G(^PS(52.49,ERXIEN,3))
 S MSGDT=$P(ERXNODE0,"^",3)
 S EPATIEN=$P(ERXNODE0,"^",4) I 'EPATIEN S EPATIEN=$$GETPAT^PSOERXU5(ERXIEN)
 S EPROVIEN=+ERXNODE2 I 'EPROVIEN S EPROVIEN=$$GETPROV^PSOERXU5(ERXIEN)
 ; eRx Provider Filter
 I $D(PRVFLTR),'$D(PRVFLTR(EPROVIEN)) Q
 S VPATIEN=$P(ERXNODE0,"^",5),MTYPE=$P(ERXNODE0,"^",8)
 S STATIEN=+$G(^PS(52.49,ERXIEN,1)),ERXSTAT=$P(^PS(52.45,STATIEN,0),"^")
 S RESTYPE=$P($G(^PS(52.49,ERXIEN,52)),"^",1)
 S CSERX=+$G(^PS(52.49,ERXIEN,95))
 S VPRVIEN=$P($G(^PS(52.49,ERXIEN,2)),"^",3)
 S VDRGIEN=$P($G(^PS(52.49,ERXIEN,3)),"^",2)
 ; Setting Drug Name (if Blank)
 S EDRUG=$P(ERXNODE3,"^",1)
 I EDRUG="" S EDRUG=$$GETDRUG^PSOERXU5(ERXIEN) I EDRUG="" S EDRUG=$S(MTYPE="IE":"<<INBOUND ERROR>>",1:"N/A")
 ; Applying Filters
 ; Message Type Filter
 I $G(MSTPFLTR)'="",MTYPE'=MSTPFLTR Q
 ; Match Status Filter
 I $G(MATFLTR)=1,VPATIEN Q
 I $G(MATFLTR)=2,VPRVIEN!'VPATIEN Q
 I $G(MATFLTR)=3,VDRGIEN!'VPATIEN!'VPRVIEN Q
 I $G(MATFLTR)=4,'VPATIEN!'VPRVIEN!'VDRGIEN Q
 ; Main Filter Eligibility by Status
 I '$$ELIGSTS^PSOERPC1("RX",ERXSTAT,MTYPE) Q
 I '$G(STSFLTR),$G(MSTPFLTR)="",MTYPE="CR",ERXSTAT="CRE" Q
 ; eRx Patient Filter
 I $D(PATFLTR),'$D(PATFLTR(+EPATIEN)) Q
 ; eRx Patient DOB Filter
 I $G(DOBFLTR),$$GET1^DIQ(52.46,+EPATIEN,.08,"I")'=DOBFLTR Q
 ; eRx Provider Filter
 I $D(PRVFLTR),'$D(PRVFLTR(+EPROVIEN)) Q
 ; eRx Status Filter
 I $G(STSFLTR),STSFLTR'=+ERXNODE1 Q
 ; eRx Drug Name Filter
 I $G(DRGFLTR)'="",$$UP^XLFSTR(EDRUG)'[$$UP^XLFSTR(DRGFLTR) Q
 ; Controlled Substance Filter
 I $G(PSOCSERX)="CS",'CSERX Q
 I $G(PSOCSERX)="Non-CS",CSERX Q
 I '$$CSFILTER^PSOERXUT(ERXIEN) Q
 ; If the eRx is a new refill request and the status is refill request new, check for a response.
 ; If no response was received within 14 days, change to RRE (refill request expired).
 I MTYPE="RR",ERXSTAT="RRN" D CHKEXP^PSOERX(ERXIEN,MTYPE)
 ; ChangeRequest messages will be checked for expiration status, 
 ; but will not be displayed in the holding queue list view.
 I MTYPE="CR",ERXSTAT="CRN" D CHKEXP^PSOERX(ERXIEN,MTYPE)
 I 'EPATIEN S EPATIEN=$$GETPAT^PSOERXU5(ERXIEN)
 ; If this is not a search, is a refill response, and is a response type of 'approved',
 ; do not show in the holding queue.
 I '$$FILTERED^PSOERPC1("RX"),MTYPE="RE",RESTYPE="A" Q
 ; Do not display refill response with 'approved with changes' status in the holding queue.
 I '$$FILTERED^PSOERPC1("RX"),MTYPE="RE","RXP,RXC,RXA,RRP,"[ERXSTAT Q
 S ERXQFLG=0
 I MTYPE="RE",RESTYPE="AWC" D  Q:ERXQFLG
 . S REQIEN=$$GETREQ^PSOERXU2(ERXIEN) I 'REQIEN Q
 . D RRDELTA^PSOERXU2(.DELTA,REQIEN,ERXIEN)
 . I $D(DELTA(52.49,"EXTERNAL PROVIDER")) Q
 . S ERXQFLG=1
 S EPTNODE0=$G(^PS(52.46,EPATIEN,0)),EPTNODE1=$G(^PS(52.46,EPATIEN,1)),EPTNODE2=$G(^PS(52.46,EPATIEN,2))
 S PATNAME=$P(EPTNODE0,"^") I PATNAME="" S PATNAME=$$PATNAME^PSOERUT(ERXIEN)
 S DOB=$P(EPTNODE1,"^",4)
 ;
 S PROVIDER=+$G(^PS(52.49,ERXIEN,2)),PROVIDER=$P($G(^PS(52.48,PROVIDER,0)),"^")
 I PROVIDER="" S PROVIDER=$$GET1^DIQ(52.48,+$$GETPROV^PSOERXU5(ERXIEN),.01) S:PROVIDER="" PROVIDER="N/A"
 S CSGROUP=$S('PSOCSGRP:"ALL",CSERX:"CS",1:"NON-CS")
 I MTYPE="CR",(ERXSTAT="CRE") Q
 S Z="",$P(Z,"^")=PATNAME,$P(Z,"^",2)=$$FMTE^XLFDT(DOB,"2Z"),$P(Z,"^",3)=EDRUG,$P(Z,"^",4)=PROVIDER
 S $P(Z,"^",5)=ERXSTAT,$P(Z,"^",6)=$$FMTE^XLFDT(MSGDT\1,"2Z")
 S SORT=MSGDT_ERXIEN_" "
 I FIELD="PA" S SORT=PATNAME_" "_ERXIEN
 I FIELD="DOB" S SORT=DOB_" "_ERXIEN
 I FIELD="DR" S SORT=$$UP^XLFSTR(EDRUG)_" "_ERXIEN
 I FIELD="PR" S SORT=PROVIDER_" "_ERXIEN
 I FIELD="RE" S SORT=MSGDT_" "_ERXIEN
 I FIELD="STA" S SORT=ERXSTAT_" "_ERXIEN
 S ^TMP("PSOERRXS",$J,CSGROUP,SORT)=Z
 S ^TMP("PSOERRXS",$J,CSGROUP,SORT,"ERXIEN")=ERXIEN_"^"_$S($G(LOCKPATS(+EPATIEN)):1,1:0)
 S ^TMP("PSOERINC",$J,ERXIEN)=""
 S COUNTER=$G(COUNTER)+1
 Q
 ;
VPRVFLTR ; - VistA Provider Filter
 N DIR,PRV,XX,RANGE,COMSEG,I,J,VPRV,EPRV,DIRUT,DIROUT,QUIT
REP1 ; - Repeat VistA Provider Prompt
 S DIR(0)="F^3:30",DIR("A")="VISTA PROVIDER NAME"
 W ! D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 I $$CHKPRV2^PSOERX1A(Y)
 D FIND^DIC(200,"","@;.01;.114;.115;53.2;IX","",X,,"B","I $$CHKPRV2^PSOERX1A(Y)","","PRVLST")
 I '$D(PRVLST("DILIST",2)) W !,"No VistA Provider found",$C(7) K PRVLST G REP1
 ;
 D PRVLHDR
 S (QUIT,CNT)=0 K DIRUT,DTOUT
 S PRV="" F  S PRV=$O(PRVLST("DILIST","ID",PRV)) Q:'PRV  D  I QUIT Q
 . W !,PRV,".",?4,$E(PRVLST("DILIST","ID",PRV,.01),1,30),?35,PRVLST("DILIST","ID",PRV,53.2)
 . I PRVLST("DILIST","ID",PRV,.114)'="" D
 . . W ?47,$E(PRVLST("DILIST","ID",PRV,.114),1,20),"-",$$STATEABB^PSOERUT(200,PRVLST("DILIST",2,PRV))
 . W ?71,$$FMTE^XLFDT($$LASTREDT^PSOERUT("AVPRV",PRVLST("DILIST",2,PRV)),"2Z")
 . S CNT=CNT+1
 . I CNT>18,$O(PRVLST("DILIST","ID",PRV)),$Y>(IOSL-4) D
 . . K DIR S DIR(0)="E" D ^DIR I $D(DIRUT)!$D(DIROUT) S QUIT=1 Q
 . . W @IOF D PRVLHDR
 ;
 K DIR S DIR("A")="SELECT (1-"_+$G(PRVLST("DILIST",0))_"): "
 S DIR(0)="LA^1:"_+$G(PRVLST("DILIST",0)) W ! D ^DIR I $D(DIRUT)!$D(DIROUT) G REP1
 S RANGE=X
 ;
 K VPRVFLTR,PRVFLTR
 F I=1:1:$L(RANGE,",") D
 . S COMSEG=$P(RANGE,",",I)
 . F J=+COMSEG:1:$S(COMSEG["-":$P(COMSEG,"-",2),1:+COMSEG) D
 . . S VPRV=+$G(PRVLST("DILIST",2,J)) I 'VPRV Q
 . . S VPRVFLTR(VPRV)=""
 . . S EPRV=0 F  S EPRV=$O(^PS(52.49,"AVPRV",VPRV,EPRV)) Q:'EPRV  D
 . . . S PRVFLTR(EPRV)=""
 ;
 I '$D(PRVFLTR) W !!,"There are no eRx Providers associated with the VistA Provider(s) selected.",$C(7) K VPRVFLTR G REP1
 Q
 ;
PRVLHDR ; - Prints the Provider List Header
 N XX W !?73,"LAST",!,"#",?4,"VISTA PROVIDER NAME",?35,"DEA",?47,"CITY",?71,"REC.DATE"
 S $P(XX,"-",80)="" W !,XX
 Q
