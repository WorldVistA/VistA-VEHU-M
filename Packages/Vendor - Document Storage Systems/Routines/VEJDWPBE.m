VEJDWPBE ;wpb/swo routine modified for dental GUI;7.19.98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;3.0;CONSULT/REQUEST TRACKING;**1,4**;DEC 27, 1997
 ;USING LIST MANAGER.
 ;GMRCSLM1 SLC/DCM - Gather data dn format ^TMP global for consult tracking Silent call for use by List Manager and GUI;4/30/98
 G AD
SVC(NODE) ;Check for a valid service
 K GMRCDEAV
 I '$D(^GMR(123,NODE,0)) Q 0
 I '+$P(^GMR(123,NODE,0),"^",5) Q 0
 I '$D(^TMP("GMRCS",$J,$P(^GMR(123,NODE,0),"^",5))) Q 0
 Q 1
AD ;Main entry point. Loop through AD x-ref in file 123; Find consults that have been released to requested service
 ;;DFN and GMRCSSNM must be defined when this entry point is called
 ;;DFN=Internal File Number of Patient in ^DPT
 ;;GMRCSSNM=Service Name of a Hospital Service from file ^GMR(123.5
 ;;If GMRCSSNM is not defined or is null, then no records will be found.
 ;;GMRCOER must be passed so that proper formatting for GUI or List Manager can be performed.  GMRCOER is passed as 0 for List Manager, 1 for GUI.
 ;;GMRCDT1 and GMRCDT2 are passed in as start and stop dates for the lookup. If GMRCDT1="" or GMRCDT1="ALL", then all dates are searched.
 ;;  ***********************************************************
 K ^TMP("GMRCR",$J,"CS"),GMRCNUL
 I $D(GMRCSSS) S (GMRCDG,GMRCSS)=GMRCSSS,GMRCSSNM=($P($G(^GMR(123.5,+GMRCSS,0)),"^",1)) D SERV1^GMRCASV K GMRCSSS ;reset after forward
 S TAB="",$P(TAB," ",30)="",BLK=0,LNCT=1 S:'$D(GMRCOER) GMRCOER=0
 S GMRCD=0 F  S GMRCD=$O(^GMR(123,"AD",DFN,GMRCD)) Q:'GMRCD  S GMRCDA=0 F  S GMRCDA=$O(^GMR(123,"AD",DFN,GMRCD,GMRCDA)) Q:'GMRCDA  I $$SVC(GMRCDA) D SET
 D END Q
SET ;;Format entries into a word processing 'TMP("GMRCR",$J,"CS",' global that List Manager can display
 ;;GMRCOER is a variable that signals that data is being formatted for the OE/RR GUI; this data is formatted differently than the data for List Manager.
 ;;GMRCOER=0 : Data is List Manager formatted.
 ;;GMRCOER=1 : Data is OE/RR GUI formatted.
 S:'$D(TAB) TAB="",$P(TAB," ",30)=""
 S GMRCIFN=GMRCDA I '$L(GMRCIFN),$D(XQADATA) S (GMRCDA,GMRCIFN)=+XQADATA
 S GMRCSEX=$S($P(^DPT(DFN,0),"^",2)="M":"MALE",1:"FEMALE")
 I '$D(^GMR(123,GMRCIFN)) S GMRCQUT=1 Q
 S PROC="",GMRC(0)=^GMR(123,GMRCIFN,0)
 I $D(GMRCSTCK),GMRCSTCK'="" N STATUS D  Q:'STATUS
 . N I
 . F I=1:1 S STATUS=$P(GMRCSTCK,",",I) Q:STATUS=$P(GMRC(0),"^",12)  Q:'STATUS
 . Q
 I $D(GMRCVP),GMRCVP'=$P(GMRC(0),"^",8) Q
 S (GMRCFMDT,X)=$P(GMRC(0),"^",7) I GMRCDT1'="ALL",$P(X,".",1)<GMRCDT1!($P(X,".",1)>GMRCDT2) Q
 S BLK=BLK+1,^TMP("GMRCR",$J,"CS","AD",BLK,LNCT,GMRCDA)=""
 D REGDTM^GMRCU S CDT=$P(X," ")
 S PROC=$P(GMRC(0),"^",8) I PROC'="" S PROC="^"_$P(PROC,";",2)_$P(PROC,";")_",0)" S:$D(PROC) PROC=$P(@PROC,"^",2)
 S:PROC="" PROC="Consult"
 S:$L($P(GMRC(0),"^",5)) TOD=$S($P(^GMR(123.5,$P(GMRC(0),"^",5),0),"^",2)=9:1,1:0)
 I '$D(TOD) S TOD=0
 S TO=$P(GMRC(0),"^",5),TO=$S(+TO:$P($G(^GMR(123.5,TO,0)),"^",1),1:""),TO=$S(TOD:"<",1:"")_TO,TO=$S(GMRCOER:TO,1:$E(TO,1,40))_$S(TOD:">",1:"") I '$L(TO) S TO="Unknown"
 S STS=$P(GMRC(0),"^",12) I +STS,$D(^ORD(100.01,+STS,0)) S:'+GMRCOER STS=$P(^ORD(100.01,+STS,.1),"^",1) I +GMRCOER S STS=$S(GMRCOER=1:$P(^ORD(100.01,+STS,0),"^",1),1:$P(^ORD(100.01,+STS,.1),"^",1))
 I $S(STS="":1,'$D(^ORD(100.01,+$P(GMRC(0),"^",12),0)):1,1:0) S STS=99,$P(GMRC(0),"^",12)=STS,STS=$S(GMRCOER=1:$P(^ORD(100.01,5,0),"^",1),1:$P(^ORD(100.01,+STS,.1),"^",1))
 I 'GMRCOER S ^TMP("GMRCR",$J,"CS",LNCT,0)=$J(BLK,3)_$E(TAB,1,10)_CDT_"  "_$E(STS,1,16)_$S(STS?1A:"  ",STS?2A:" ",1:"  ")_$S($P(GMRC(0),"^",19)="Y":"*",1:" ")_TO_$E(TAB,1,26-$L(TO))_" "_PROC,LNCT=LNCT+1 Q
 I GMRCOER S ^TMP("GMRCR",$J,"CS",LNCT,0)=GMRCDA_"^"_GMRCFMDT_"^"_STS_"^"_TO_"^"_PROC_"^"_$S($P(GMRC(0),"^",19)="Y":"*",1:""),LNCT=LNCT+1 K STSOER Q
 Q
END I LNCT<2 S (BLK,LNCT)=1,GMRCNUL=1,GMRCNPM="< PATIENT DOES NOT HAVE ANY CONSULTS/REQUESTS "_$S($D(GMRCPRNM):"FOR "_GMRCPRNM,1:"")_" ON FILE. >",GMRCNPM=$E(TAB,1,(80-$L(GMRCNPM))\80)_GMRCNPM,^TMP("GMRCR",$J,"CS",LNCT,0)=GMRCNPM D
 .I GMRCDT1'="ALL",$D(GMRCDT1)&($D(GMRCDT2)) S LNCT=LNCT+1,^TMP("GMRCR",$J,"CS",LNCT,0)="Between Dates: "_$$FMTE^XLFDT(GMRCDT1)_" and "_$$FMTE^XLFDT(GMRCDT2)
 .I $D(GMRCSTCK),$L(GMRCSTCK) S LNCT=LNCT+1,^TMP("GMRCR",$J,"CS",LNCT,0)="With Status: " S STS="" F I=1:1 S STS=$P(GMRCSTCK,",",I) Q:STS=""  S ^TMP("GMRCR",$J,"CS",LNCT,0)=^(0)_$P($G(^ORD(100.01,+STS,0)),"^",1)_" "
 .Q
 E  S (BLK,LNCT)=LNCT-1,^TMP("GMRCR",$J,"CS",0)="^^^"_LNCT
 I $D(GMRCALFL) S (BLK,LNCT)=1
 K TO,TOD,END,FLG,GMRC(0),GMRCD,GMRCDG,GMRCIFN,GMRCFNDT,GMRCNPM,GMRCWARD,I,PROC,STS,URG
 Q
OER(DFN,GMRCDG,GMRCDT1,GMRCDT2,GMRCSTCK,GMRCOER) ;;GUI interface for CPRS
 ;;DFN=Patient internal file number
 ;;GMRCDG:  Internal file number of consult service (from file ^GMR(123.5,)
 ;;GMRCDT1:  Beginning date for lookup
 ;;GMRCDT2:  Ending date for lookup
 ;;GMRCSTCK: IEN from OER Status File [^OER(100.01)] to screen results
 ;;     so that only consults with a desired status are displayed
 ;;     Can be sent as a set of statuses: i.e., 6,5,2
 ;;      (GMRCSTCK=GMRC STATUS CHECK)
 ;;GMRCOER=0 if request is from CONSULTS; GMRCOER=1 if request is for CPRS List Manager, 2 if for CPRS GUI
 I GMRCDT1="" S GMRCDT1="ALL"
 I GMRCDG="" S GMRCDG=$O(^GMR(123.5,"B","ALL SERVICES",0))
 S:'$D(GMRCOER) GMRCOER=1
 D SERV1^VEJDWPBF,AD
 K ^TMP("GMRCS",$J),^TMP("GMRCSLIST",$J)
 Q
