ORWORB ; SLC/DEE,REV,CLA,WAT - RPC FUNCTIONS WHICH RETURN USER ALERT ;Aug 13, 2024@09:39:58
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,116,148,173,190,215,243,296,329,334,410,377,498,405,596,535**;Dec 17, 1997;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ; Reference to ^DPT( in ICR #10035
 ; Reference to ^XTV(8992 in ICR #2689
 ; Reference to ^VA(200,5 in ICR #4329
 ; Reference to ^XUSEC( in ICR #10076
 ; Reference to SET1^RAO7PC4 in ICR #3563
 ; Reference to $$RESOLVE^TIUSRVLO in ICR #2834
 ; Reference to INP^VADPT in ICR #10061
 ; Reference to $$NOW^XLFDT,$$FMADD^XLFDT in ICR #10103
 ; Reference to $$GET^XPAR,EN^XPAR,GETLST^XPAR in ICR #2263
 ; Reference to GETUSER1^XQALDATA,GETUSER2^XQALDATA in ICR #4834
 ; Reference to DELETE^XQALERT,DELETEA^XQALERT,GETACT^XQALERT in ICR #10081
 ; Reference to ALERTDAT^XQALBUTL,AHISTORY^XQALBUTL in ICR #2788
 ; Reference to ALTDATA^PXRMCALT in ICR #7258
 ; Reference to ^TIU(8925 in ICR #2937
 ; Reference to ^GMR(123 in ICR #2586
 ; Reference to ^SRF( in ICR #7436
 ; Reference to ^PSRX( in ICR #6149
 ; Reference to ^PS(52.41 in ICR #6148
 ; Reference to ^LRO(69,D0,1 in ICR #2407
 ; Reference to ^RAO(75.1 in ICR #3074
 ; Reference to ^RADPT(D0,'DT',D1,'P' in ICR #65
 ; Reference to ^LR( in ICR #525
 ; Reference to $$GET1^DIQ in ICR #2056
 ;
 Q
GETLTXT(ORY,ORAID) ;get the long text for an alert
 N ORDATA
 D ALERTDAT^XQALBUTL(ORAID,"ORDATA")
 S ORY(1)=""
 I $D(ORDATA(4,1)) N ORI S ORI=0 F  S ORI=$O(ORDATA(4,ORI)) Q:'ORI  D
 .S ORY(ORI)=ORDATA(4,ORI)
 Q
 ;
URGENLST(ORY) ;return array of the  urgency for the notification
 N ORSRV,ORERROR
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 D GETLST^XPAR(.ORY,"USR^SRV.`"_$G(ORSRV)_"^DIV^SYS^PKG","ORB URGENCY","I",.ORERROR)
 Q
 ;
FASTUSER(ORY,ORDEFFLG) ;return current user's notifications across all patients
 ; ORDEFFLG: setting this to 1 causes the alerts API to exclude deferred alerts for this user
 ;  defaults to 1 if not passed in
 N STRTDATE,STOPDATE,ORTOT,I,ORURG,URG,ORN,SORT,ORN0,URGLIST,REMLIST,REM,NONORLST,NONOR
 N ALRT,ALRTDT,ALRTPT,ALRTMSG,ALRTI,ALRTLOC,ALRTXQA,J,FWDBY,PRE,ALRTDFN,FROMFAST
 K ^TMP("ORB",$J),^TMP("ORBG",$J)
 S STRTDATE="",STOPDATE="",FWDBY="Forwarded by: ",FROMFAST=1
 D GETUSER1^XQALDATA("^TMP(""ORB"",$J)",DUZ,STRTDATE,STOPDATE,$G(ORDEFFLG,1))
 D USERLIST(.ORY,STRTDATE,STOPDATE)
 Q
 ;
PROUSER(ORY,STRTDATE,STOPDATE,MAXRET,PROONLY) ;return current user's processed notifications for a specified date range
 Q:'$$GET^XPAR("SYS","OR RTN PROCESSED ALERTS")
 N FWDBY
 K ^TMP("ORB",$J),^TMP("ORBG",$J)
 S FWDBY="Forwarded by: "
 D GETUSER2^XQALDATA("^TMP(""ORB"",$J)",DUZ,STRTDATE,STOPDATE,MAXRET,PROONLY)
 D USERLIST(.ORY,STRTDATE,STOPDATE)
 Q
USERLIST(ORY,STRTDATE,STOPDATE) ;process for obtaining user's notifications
 N ORTOT,I,ORURG,URG,ORN,SORT,ORN0,URGLIST,REMLIST,REM,NONORLST,NONOR
 N ALRT,ALRTDT,ALRTPT,ALRTMSG,ALRTI,ALRTLOC,ALRTXQA,J,PRE,ALRTDFN,ORRMVD
 S ORTOT=^TMP("ORB",$J)
 D URGLIST^ORQORB(.URGLIST)
 D REMLIST^ORQORB(.REMLIST)
 D REMNONOR^ORQORB(.NONORLST)
 S J=0
 F I=1:1:ORTOT D
 .N ORPROV,ORBIRAD,ORALRTDAT,ORALRTXT
 .S ALRTDFN="",REM=""
 .S ALRT=^TMP("ORB",$J,I)
 .S PRE=$E(ALRT,1,1)
 .S ALRTXQA=$P(ALRT,U,2) Q:ALRTXQA=""  ; XQAID expected
 .D ALERTDAT^XQALBUTL(ALRTXQA,"ORALRTDAT")
 .S ORALRTXT=$G(ORALRTDAT(1.01))
 .S NONOR="" F  S NONOR=$O(NONORLST(NONOR)) Q:NONOR=""  D
 ..I ALRTXQA[NONOR S REM=1  ;allow this type of alert to be Removed
 .S ALRTMSG=$P($P(ALRT,U),PRE_"  ",2)
 .;S ALRTMSG=$P($P(ALRT,U),PRE,2,99),ALRTMSG=$$TRIM^XLFSTR(ALRTMSG,"L")
 .I $E(ALRT,4,8)'="-----" D  ;not forwarded alert info/comment
 ..S ORRMVD=0
 ..S ORURG="n/a"
 ..S ALRTI=$P(ALRT,"  ")
 ..S ALRTPT=""
 ..S ALRTLOC=""
 .. ; *596 ajb
 . . I $E($P(ALRTXQA,";"),1,3)="TIU" D  Q
 . . . N ALRT,NODE,ORIEN,ORREF,ORTIU,X,Y
 . . . S ORPROV="N/A"
 . . . I ORALRTXT="" Q  ; full text of alert data
 . . . S $P(ALRT,U,2)=$P(ORALRTXT,":"),$P(ALRT,U,4)=$S(ALRT[" STAT ":"HIGH",1:"Moderate")
 . . . S X=$P(ALRTXQA,";",3),$P(Y,"/",1)=$E(X,4,5),$P(Y,"/",2)=$E(X,6,7),$P(Y,"/",3)=(1700+$E(X,1,3))
 . . . S X=$E($P(X,".",2)_"0000",1,4),$P(Y,"@",2)=$E(X,1,2)_":"_$E(X,3,4),$P(ALRT,U,5)=Y
 . . . S $P(ALRT,U,6)=$P(ORALRTXT,": ",2),$P(ALRT,U,8)=ALRTXQA,$P(ALRT,U,9)=REM_U
 . . . S J=J+1,^TMP("ORBG",$J,J)=ALRT
 . . . S ORTIU=+$G(ORALRTDAT(2)) D  Q:'ORTIU
 . . . . N ORTIUTXT,ORTIUTXT6
 . . . . I ORTIU Q
 . . . . S ORTIUTXT=$P(ALRTXQA,";"),ORTIUTXT6=$E(ORTIUTXT,1,6)
 . . . . I "^TIUADD^TIUERR^"[ORTIUTXT6 S ORTIU=$E(ORTIUTXT,7,999) Q
 . . . . I ORTIUTXT?3A1.99999999N S ORTIU=$E(ORTIUTXT,4,999)
 . . . S ORIEN=+$P($G(^TIU(8925,ORTIU,12)),U,10) I 'ORIEN D
 . . . . S ORPROV="UNKNOWN"
 . . . . S ORREF=$P($G(^TIU(8925,ORTIU,14)),U,5) Q:ORREF=""
 . . . . I $P(ORREF,";",2)="GMR(123," S ORIEN=$P($G(^GMR(123,+ORREF,0)),U,3) I ORIEN="" S ORPROV="UNKNOWN"
 . . . . I $P(ORREF,";",2)="SRF(" S ORIEN=$P($G(^SRF(+ORREF,0)),U,14) I ORIEN="" S ORPROV="UNKNOWN"
 . . . I +ORIEN>0 S ORPROV=$$GETPRVNM(ORIEN)
 .. ; *596 ajb
 ..I $P(ALRTXQA,",")="OR" D
 ... N NOPROV,P04,ORPOUT
 ... S NOPROV=0
 ...S ORN=$P($P(ALRTXQA,";"),",",3)
 ...S URG=$G(URGLIST(ORN))
 ...S ORURG=$S(URG=1:"HIGH",URG=2:"Moderate",1:"low")
 ...S REM=$G(REMLIST(ORN))
 ...S ORN0=^ORD(100.9,ORN,0)
 ...S ALRTI=$S(ORN=90:"L",$P(ORN0,U,6)="INFODEL":"I",1:"")
 ...S ALRTDFN=$P(ALRTXQA,",",2)
 ...S ALRTLOC=$G(^DPT(+$G(ALRTDFN),.1))
 ...I $G(ORN)=6,$P(ALRT,U)["Your task #" S ALRTMSG=$E($P(ALRT,U),2,999),NOPROV=1,ORPROV="N/A"
 ...I 'NOPROV S ORPROV=$$GETPROV(ORN,ALRTDFN,.ORALRTDAT)
 ...I $$ISSMIEN^ORBSMART(ORN) D
 ....N ORSMBY
 ....D ALTDATA^PXRMCALT(.ORPOUT,ALRTDFN,ALRTXQA)
 ....I $G(ORPOUT("DATA","RADIOLOGY REPORT FOUND"))=0 D DEL^ORB3FUP1(.ORSMBY,ALRTXQA,0) S ORRMVD=1 Q
 ....I $L($G(ORPOUT("DATA",1,"DIAGNOSIS")))>0 S ORBIRAD=$G(ORPOUT("DATA",1,"DIAGNOSIS"))
 ..I ORRMVD Q
 ..S ALRTI=$S(ALRTI="I":"I",ALRTI="L":"L",1:"")
 ..I (ALRT["): ")!($G(ORN)=27&(ALRT[") CV")) D  ;WAT
 ...S ALRTPT=$P(ALRT,": ")
 ...S ALRTPT=$E(ALRTPT,4,$L(ALRTPT))
 ...;S ALRTPT=$P(ALRTPT,PRE,2,99),ALRTPT=$$TRIM^XLFSTR(ALRTPT,"L")
 ...I $G(ORN)=27&(ALRT[") CV") S ALRTMSG=$P($P(ALRT,U),": ",2) ;WAT
 ...E  S ALRTMSG=$P($P(ALRT,U),"): ",2) ;WAT
 ...I $E(ALRTMSG,1,1)="[" D
 ....S:'$L(ALRTLOC) ALRTLOC=$P($P(ALRTMSG,"]"),"[",2)
 ....S ALRTMSG=$P(ALRTMSG,"] ",2)
 ..I '$L($G(ALRTPT)) S ALRTPT="no patient"
 ..S ALRTDT=$P(ALRTXQA,";",3)
 ..S ALRTDT=$P(ALRTDT,".")_"."_$E($P(ALRTDT,".",2)_"0000",1,4)
 ..S ALRTDT=$E(ALRTDT,4,5)_"/"_$E(ALRTDT,6,7)_"/"_($E(ALRTDT,1,3)+1700)_"@"_$E($P(ALRTDT,".",2),1,2)_":"_$E($P(ALRTDT,".",2),3,4)
 ..;if SMART alert, append BIRAD results to ALRTMSG
 ..I $G(ORBIRAD)'="" S ALRTMSG=ALRTMSG_" - RESULTS: "_ORBIRAD
 ..S J=J+1,^TMP("ORBG",$J,J)=ALRTI_U_ALRTPT_U_ALRTLOC_U_ORURG_U_ALRTDT_U
 ..S ^TMP("ORBG",$J,J)=^TMP("ORBG",$J,J)_ALRTMSG_U_U_ALRTXQA_U_$G(REM)_U
 .I ORRMVD Q
 .;if alert forward info/comment:
 .I $E(ALRTMSG,1,5)="-----" D
 ..S ALRTMSG=$P(ALRTMSG,"-----",2)
 ..I $E(ALRTMSG,1,14)=FWDBY D
 ...S J=J+1,^TMP("ORBG",$J,J)=FWDBY_U_$P($P(ALRTMSG,FWDBY,2),"Generated: ")_$P($P(ALRTMSG,FWDBY,2),"Generated: ",2)
 ..E  S ^TMP("ORBG",$J,J)=^TMP("ORBG",$J,J)_U_""""_ALRTMSG_""""
 .I $G(ORPROV)'="" S ^TMP("ORBG",$J,J)=^TMP("ORBG",$J,J)_U_ORPROV ; ajb
 .;if this is for processed alerts, add additional data into pieces 15 through 22
 .I $D(^TMP("ORB",$J,J,"PROCESSED")) D
 ..S $P(^TMP("ORBG",$J,J),U,15)=^TMP("ORB",$J,J,"PROCESSED")
 .;if this is for pending alerts, add "surrogate for" into piece 15
 .I $G(FROMFAST) N DUZIEN,SURRFOR,ORALRTHST D
 ..D AHISTORY^XQALBUTL(ALRTXQA,"ORALRTHST")
 ..S DUZIEN=$O(ORALRTHST(20,"B",DUZ,"")) Q:'DUZIEN
 ..S SURRFOR=+$G(ORALRTHST(20,DUZIEN,3,1,0)) ; get first "surrogate for" and return returns 0 if empty
 ..I SURRFOR S $P(^TMP("ORBG",$J,J),U,15)=$P(^VA(200,SURRFOR,0),U)
 S ^TMP("ORBG",$J)=""
 S ORY=$NA(^TMP("ORBG",$J))
 K ^TMP("ORB",$J)
 Q
 ;
GETDATA(ORY,XQAID,PFLAG) ; return XQADATA for an alert
 N SHOWADD
 S ORY=""
 Q:$G(XQAID)=""!('$D(^XTV(8992,"AXQA",XQAID)))
 I +$G(PFLAG) S XQADATA=$$GETACT2(XQAID) I 1
 E  D GETACT^XQALERT(XQAID)
 S ORY=XQADATA
 I ($E(XQAID,1,3)="TIU"),(+ORY>0) D
 . S SHOWADD=1
 . S ORY=ORY_$$RESOLVE^TIUSRVLO(+ORY)
 K XQAID,XQADATA,XQAOPT,XQAROU
 Q
 ;
GETACT2(ALERTID) ; Returns first XQADATA found, for alerts for other users
 N XQADATA,XDUZ,XQI,XQX,XQZ,DONE
 S XQADATA="",XDUZ="",DONE=0
 F  Q:DONE  S XDUZ=$O(^XTV(8992,"AXQA",ALERTID,XDUZ)) Q:'XDUZ  D
 . S XQI=$O(^XTV(8992,"AXQA",ALERTID,XDUZ,0))
 . Q:XQI'>0
 . S XQX=$G(^XTV(8992,XDUZ,"XQA",XQI,0)) Q:XQX=""
 . S XQZ=$G(^XTV(8992,XDUZ,"XQA",XQI,1))
 . S XQADATA=$S(XQZ'="":XQZ,1:$P(XQX,U,9,99))
 . I XQADATA'="" S DONE=1
 Q XQADATA
 ;
KILUNSNO(Y,ORVP) ; Delete unsigned order alerts if no unsigned orders remaining
 S ORVP=ORVP_";DPT("
 D UNOTIF^ORCSIGN
 Q
 ;
UNFLORD(ORY,DFN,XQAID) ; -- auto-unflag orders?/delete alert
 Q
 ;*334/VMP-DJE Auto unflag has been disabled
 ;Q:'$L(DFN)!('$L(XQAID))
 ;N ORI,ORIFN,ORA,XQAKILL,ORN,ORBY,ORAUTO,ORUNF
 ;S ORN=+$O(^ORD(100.9,"B","FLAGGED ORDERS",0))
 ;;S XQAKILL=$$XQAKILL^ORB3F1(ORN)
 ;D LIST^ORQOR1(.ORBY,DFN,"ALL",12,"","")
 ;S ORAUTO=+$$GET^XPAR("ALL","ORPF AUTO UNFLAG")
 ;S ORI=0 F  S ORI=$O(ORBY(ORI)) Q:ORI'>0  D
 ;. I ORAUTO D  ; unflag
 ;. . ;DJE-VM *329 - use GUI RPC call to make it run the proper code, only run it if the user sees it.
 ;. . ;S ORUNF=+$E($$NOW^XLFDT,1,12)_U_DUZ_"^Auto-Unflagged"
 ;. . ;S ORIFN=$P(ORBY(ORI),U),ORA=+$P(ORIFN,";",2)
 ;. . ;I ORIFN,$D(^OR(100,+ORIFN,0)) S $P(^(8,ORA,3),U)=0,$P(^(3),U,6,8)=ORUNF D MSG^ORCFLAG(ORIFN) ; unflag
 ;. . S ORIFN=+ORBY(ORI)
 ;. . I $D(^OR(100,ORIFN,0)),'$$FLAGRULE^ORWORR1(ORIFN) D UNFLAG^ORWDXA(.ORUNF,$P(ORBY(ORI),U),"Auto-Unflagged")
 ;;DJE-VM *329 - ORWDXA is smarter and deletes the appropriate alert(s)
 ;;I (ORAUTO)!(+$G(ORBY(1))=0) D DELETE^XQALERT
 ;Q
KILEXMED(Y,ORDFN)  ; -- Delete expiring meds notification if no expiring meds remaining
 N ORDG,ORLST,OROI,LIST S ORDG=$$DG^ORQOR1("RX")
 N XQAKILL,ORNIFN,ORVP
 S LIST("INPT")=1
 S LIST("OUTPT")=1
 D AGET^ORWORR(.ORLST,ORDFN,5,ORDG)
 ;selected code copied from EXPIR^ORB3TIM2
 I +(@ORLST@(.1)) D  ;if there are orders
 . K LIST("OUTPT")
 . S OROI=.5
 . N ORSCHFIL,ORBZ
 . S ORSCHFIL=$$TERMLKUP^ORB31(.ORBZ,"ONE TIME MED")
 . F  S OROI=$O(@ORLST@(OROI)) Q:'OROI  D  Q:'$G(LIST("INPT"))
 .. N EXORN S EXORN=+@ORLST@(OROI)
 .. ;skip outpt meds
 .. Q:$$DGRX^ORQOR2(EXORN)="OUTPATIENT MEDICATIONS"
 .. ;skip one time meds
 .. N ONETIME,ORSCH,ORBI S ONETIME=0
 .. I $D(ORBZ),(+$G(ORSCHFIL)=51.1) F ORBI=1:1:ORBZ D
 ... S ORSCH=$P(ORBZ(ORBI),U,2)
 ... I ORSCH=$$VALUE^ORCSAVE2(EXORN,"SCHEDULE") S ONETIME=1 Q
 .. Q:+$G(ONETIME)=1
 .. ;don't delete notification if there are valid inpt orders
 .. K LIST("INPT")
 S OROI=""
 F  S OROI=$O(LIST(OROI)) Q:'$L(OROI)  D
 .S ORNIFN=$O(^ORD(100.9,"B","MEDICATIONS EXPIRING - "_OROI,0)),ORVP=ORDFN_";DPT("
 .Q:'$L($G(ORNIFN))
 .S XQAKILL=$$XQAKILL^ORB3F1(ORNIFN) ; expiring meds notif
 .I $D(XQAID) D DELETE^XQALERT
 .I '$D(XQAID) S XQAID=$P($G(^ORD(100.9,ORNIFN,0)),U,2)_","_+ORVP_","_ORNIFN D DELETEA^XQALERT K XQAID
 Q
KILEXOI(Y,ORDFN,ORNIFN)  ; -- Delete expiring flagged OI notification if no flagged expiring OI remaining
 N ORDG,ORLST S ORDG=$$DG^ORQOR1("ALL")
 D AGET^ORWORR(.ORLST,ORDFN,5,ORDG)
 Q:+(@ORLST@(.1))  ;more left
 N XQAKILL,ORVP
 S ORVP=ORDFN_";DPT("
 S XQAKILL=$$XQAKILL^ORB3F1(ORNIFN) ; flagged expiring OI notifications
 I $D(XQAID) D DELETE^XQALERT
 I '$D(XQAID) S XQAID=$P($G(^ORD(100.9,ORNIFN,0)),U,2)_","_+ORVP_","_ORNIFN D DELETEA^XQALERT K XQAID
 Q
KILUNVOR(Y,ORDFN)  ; -- Delete UNVERIFIED ORDER notification if none remaining within current admission/30 days
 N DFN,ORDG,ORLST,ORBDT,OREDT,ORDDT,VAIN,VAERR,VA200 S ORDG=$$DG^ORQOR1("ALL")
 S OREDT=$$NOW^XLFDT
 S ORDDT=$$FMADD^XLFDT(OREDT,"-90")
 ;get current admission date/time:
 S DFN=ORDFN,VA200="" D INP^VADPT
 S ORBDT=$P($G(VAIN(7)),U)
 S ORBDT=$S('$L($G(ORBDT)):$$FMADD^XLFDT(OREDT,"-30"),1:ORBDT)  ;<= if no admission use past 30 days
 S ORBDT=$S(ORDDT>ORBDT:ORDDT,1:ORBDT)  ;max past days to use is 90 days
 D AGET^ORWORR(.ORLST,ORDFN,9,ORDG,ORBDT,OREDT)
 Q:+(@ORLST@(.1))  ;more left
 N XQAKILL,ORVP,ORNIFN
 S ORNIFN=$O(^ORD(100.9,"B","UNVERIFIED ORDER",0)),ORVP=ORDFN_";DPT("
 S XQAKILL=$$XQAKILL^ORB3F1(ORNIFN)
 I $D(XQAID) D DELETE^XQALERT
 I '$D(XQAID) S XQAID=$P($G(^ORD(100.9,ORNIFN,0)),U,2)_","_+ORVP_","_ORNIFN D DELETEA^XQALERT K XQAID
 Q
KILUNVMD(Y,ORDFN)  ; -- Delete UNVERIFIED MEDS notification if none remaining within current admission/30 days
 N DFN,ORDG,ORLST,ORBDT,OREDT,ORDDT S ORDG=$$DG^ORQOR1("RX")
 S OREDT=$$NOW^XLFDT
 S ORDDT=$$FMADD^XLFDT(OREDT,"-90")
 ;get current admission date/time:
 S DFN=ORDFN,VA200="" D INP^VADPT
 S ORBDT=$P($G(VAIN(7)),U)
 S ORBDT=$S('$L($G(ORBDT)):$$FMADD^XLFDT(OREDT,"-30"),1:ORBDT)  ;<= if no admission use past 30 days
 S ORBDT=$S(ORDDT>ORBDT:ORDDT,1:ORBDT)  ;max past days to use is 90 days
 D AGET^ORWORR(.ORLST,ORDFN,9,ORDG,ORBDT,OREDT)
 Q:+(@ORLST@(.1))  ;more left
 N XQAKILL,ORVP,ORNIFN
 S ORNIFN=$O(^ORD(100.9,"B","UNVERIFIED MEDICATION ORDER",0)),ORVP=ORDFN_";DPT("
 S XQAKILL=$$XQAKILL^ORB3F1(ORNIFN)
 I $D(XQAID) D DELETE^XQALERT
 I '$D(XQAID) S XQAID=$P($G(^ORD(100.9,ORNIFN,0)),U,2)_","_+ORVP_","_ORNIFN D DELETEA^XQALERT K XQAID
 Q
ESORD(ORY,XQAID)   ;order(s) requiring electronic signature follow-up
 K XQAKILL
 N ORPT,ORDG,ORBXQAID,ORY,ORX,ORZ,ORDERS,ORDNUM,ORQUIT,ORBLMDEL
 S ORBXQAID=XQAID,ORDERS=0,ORQUIT=0
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 S ORDG=$$DG^ORQOR1("ALL")
 ;the FLG code for UNSIGNED orders in ORQ1 is '11'
 ;get unsigned orders - if none exist, delete alert then quit:
 D EN^ORQ1(ORPT_";DPT(",ORDG,11,"","","",0,0)
 S ORX="",ORX=$O(^TMP("ORR",$J,ORX)) Q:ORX=""  I +$G(^TMP("ORR",$J,ORX,"TOT"))<1 D DEL^ORB3FUP1(.ORY,ORBXQAID) K ^TMP("ORR",$J) Q
 ;
 ;user does not have ORES key, delete user's alert:
 I '$D(^XUSEC("ORES",DUZ)) S XQAKILL=1 D DEL^ORB3FUP1(.ORY,ORBXQAID) K ^TMP("ORR",$J) Q
 ;
 ;if prov is NOT linked to pt via attending, primary or teams:
 I $$PPLINK^ORQPTQ1(DUZ,ORPT)=0 D
 .S ORX="" F  S ORX=$O(^TMP("ORR",$J,ORX)) Q:ORX=""!(ORDERS=1)  D
 ..S ORZ="" F  S ORZ=$O(^TMP("ORR",$J,ORX,ORZ)) Q:+ORZ=0!(ORDERS=1)  D
 ...S ORDNUM=^TMP("ORR",$J,ORX,ORZ)
 ...;quit if this unsigned order's last action was made by the user
 ...I DUZ=+$$UNSIGNOR^ORQOR2(ORDNUM) S ORDERS=1
 .I ORDERS'=1 D  ;provider has no outstanding unsigned orders for pt
 ..S XQAKILL=1 D DEL^ORB3FUP1(.ORY,ORBXQAID)  ;delete alert for this user
 K ^TMP("ORR",$J)
 Q
 ;
TXTFUP(ROOT,DFN,NOTIF,XQADATA) ; Follow-up for text messages
 ;
 I NOTIF=67 D CHGRAD
 Q
 ;
CHGRAD ;GUI follow-up for Imaging Request Changed (#67)
 S ROOT=$NA(^TMP($J,"RAE4"))
 K @ROOT
 D SET1^RAO7PC4  ;DBIA #3563
 Q
 ;
GETSORT(ORY) ;return notification sort method^direction for user/division/system/pkg
 S ORY=$$GET^XPAR("ALL","ORB SORT METHOD",1,"I")_U_$$GET^XPAR("ALL","ORB SORT DIRECTION",1,"I")
 Q
 ;
SETSORT(ORERR,SORT,DIR) ;set notification sort method^direction for user
 D EN^XPAR(DUZ_";VA(200,","ORB SORT METHOD",1,SORT,.ORERR)
 I $L($G(DIR)) D EN^XPAR(DUZ_";VA(200,","ORB SORT DIRECTION",1,DIR,.ORERR)
 Q
 ;
GETPROV(ORN,ORDFN,ORALRTDAT) ;Find Ordering Provider
 ; ORN = NOTIFICATION IEN
 ; ORDFN = ALERT PATIENT DFN
 ; ORALRTDAT = ALERT DATA IN FILE 8992.1
 S ORN=+ORN
 I ORN=0 Q ""
 I +ORDFN=0 Q ""
 N ORDATA,ORIEN,ORIEN1,ORIENLNG,ORIENS,ORNTMP,ORPRV,ORQUIT,P04
 S ORNTMP=U_ORN_U
 S (ORIEN,ORPRV)=""
 S ORDATA=$G(ORALRTDAT(2)) ;data for processing
 ;Notifications with order number at beginning of data
 I "^3^5^6^8^12^14^24^26^31^33^42^43^44^45^47^48^52^55^57^58^59^60^62^68^72^74^82^"[ORNTMP  S ORIEN=+ORDATA
 ;Notifications with order number as 2nd ";" piece
 I "^73^88^91^"[ORNTMP S ORIEN=+$P(ORDATA,";",2)
 ;Possible Multiple Order Numbers (Lapsed Unsigned Order and Preg/Lact Unsafe Orders)
 I ORN=78!(ORN=79) S ORIENS=$P(ORDATA,";",2) D
 . N ORIEN1,ORIENLNG,ORPROV1,X,P04
 . S P04=0
 . S ORIEN=+ORIENS
 . S ORIENLNG=$L(ORIENS,U)
 . I ORIENLNG=1 Q
 . S ORQUIT=0
 . F X=1:1:$L(ORIENS,U) D  Q:ORIEN=""
 .. S ORIEN1=$P(ORIENS,U,X)
 .. I +P04=0 S P04=$P($G(^OR(100,ORIEN1,0)),U,4) Q
 .. I P04'=$P($G(^OR(100,ORIEN1,0)),U,4) S ORIEN=""
 .. Q
 ;New Orders (format of data varies)
 I ORN=50 S ORIEN=+ORDATA I ORIEN=0 D  I +ORIEN=0 Q "N/A"
 . ;New Orders alerts in GUI may display any number of new orders and not
 . ;specifically just the one associated with this alert. Therefore, we
 . ;will quit at next line and not calculate the provider.
 . Q
 . N ORDATA1,ORDT,ORP2,ORPKG,ORSPCMN,PSIEN
 . S ORP2=$P(ORDATA,"|",2)
 . S ORDATA1=$P(ORP2,"@")
 . S ORPKG=$P(ORP2,"@",2)
 . I ORPKG="PS" D
 .. S PSIEN=ORDATA1
 .. I +PSIEN=PSIEN S ORIEN=$P(^PSRX(PSIEN,"OR1"),U,2) Q
 .. S ORIEN=$$GET1^DIQ(52.41,+PSIEN_",",.01)
 . I $E(ORPKG,1,2)="LR" D
 .. S ORDT=$P(ORDATA1,";",2),ORSPCMN=$P(ORDATA1,";",3)
 .. S ORIEN=$P(^LRO(69,ORDT,1,ORSPCMN,0),U,11)
 . I ORPKG="RA" D
 .. N ORIMG
 .. S ORIMG=ORDATA1
 .. I +ORIMG S ORIEN=$$GET1^DIQ(75.1,+ORIMG_",",7)
 . ;I ORPKG="FH" D
 . ;OR,13,50;4546;2990419.100747
 . ;|D;1635;1;2990419.100737;0;;;C;0;1;;;;@FH
 .;. S TEVNT=$P(ORDATA1,";",1)
 .;. S ADM=$P(ORDATA1,";",2)
 .;. S DT=$P(ORDATA1,";",4)
 .;. F  S DIET=$O(^FH(119.8,"AP",ORDFN,DT,"")) Q:DIET=""  D  Q:ORQUIT
 .;.. ;Need to find a way to link to ORDER
 ;Imaging Notifications with format RADTI~RACNI
 I "^21^22^25^32^51^53^67^69^84^"[ORNTMP D
 . N ORACNI,ORADPT0,ORADTI,ORDATA1,ORDATA2,ORIMG,QUIT
 . S QUIT=0
 . I ORDATA?1.N1"@" S ORIEN=+ORDATA Q
 . I ORDATA["|" D  Q:+ORIEN>0
 .. S ORDATA1=$P(ORDATA,"|",1)
 .. I $P(ORDATA1,"@",2)="OR",+ORDATA1>0 S ORIEN=+ORDATA1 Q
 .. S ORDATA2=$P(ORDATA,"|",2)
 .. I $L(ORDATA2,"~")=3 I +ORDATA2>0 S ORIMG=+$P(ORDATA2,"~",1) Q
 .. S ORADTI=$P(ORDATA,"~",2) S:ORADTI="" QUIT=1 Q
 .. S ORACNI=+$P(ORDATA,"~",3) S:ORACNI=0 QUIT=1
 . I ORDATA'["|" D  Q:QUIT=1
 .. I ORDATA["~" D  Q:QUIT=1
 ... S ORADTI=$P(ORDATA,"~",1) S:ORADTI="" QUIT=1 Q
 ... S ORACNI=$P(ORDATA,"~",2) S:ORACNI="" QUIT=1
 .. I ORDATA'["~" D  Q:QUIT=1
 ... S ORADTI=$P(ORDATA,"/",2) S:ORADTI="" QUIT=1 Q
 ... S ORACNI=$P(ORDATA,"/",3) S:ORACNI="" QUIT=1
 . I +$G(ORIMG)=0,$G(ORADTI)'="",$G(ORACNI)'="" S ORIMG=+$P($G(^RADPT(ORDFN,"DT",ORADTI,"P",ORACNI,0)),U,11) I ORIMG=0 Q
 . I +$G(ORIMG)>0 S ORIEN=$$GET1^DIQ(75.1,ORIMG_",",7)
 ;Consult/Request Notifications that begin with the request (Consult) ien
 I "^23^27^30^63^66^89^"[ORNTMP D
 . I +ORDATA>0 S ORIEN=$P($G(^GMR(123,+ORDATA,0)),U,3)
 ;ORDERER-FLAGGED RESULTS (placed in the notifications with order number in first part of data
 ;I "^33^"[ORNTMP D
 ;. N ORDATA1,ORDATA2
 ;. I ORDATA["|" D  Q:+ORIEN>0
 ;.. S ORDATA1=$P(ORDATA,"|",1)
 ;.. I $P(ORDATA1,"@",2)="OR",+ORDATA1>0 S ORIEN=+ORDATA1 Q
 ;.. Q
 ;.. ;The 2nd vertical bar piece may be of several different order types
 ;.. ;(consult and lab (chemistry) to name a couple). For now we will only
 ;.. ;use the OR data if available.
 ;.. S ORDATA2=$P(ORDATA,"|",2)
 ;.. I +ORDATA2>0 S ORIEN=$P($G(^GMR(123,+ORDATA2,0)),U,3)
 ;Laboratory entries
 I ORN=70!(ORN=71) D
 . N ORLRDFN,ORLRDT,ORLRTYP
 . S ORLRDFN=$G(^DPT(ORDFN,"LR")) Q:+ORLRDFN=0
 . S ORLRTYP=$P(ORDATA,U,1),ORLRDT=$P(ORDATA,U,3)
 . S ORIEN=$P($G(^LR(ORLRDFN,ORLRTYP,ORLRDT,"ORUT",1,0)),U,3)
 ;No data to find linked order
 I "^18^19^20^35^36^41^54^56^61^64^65^75^76^77^80^81^83^85^86^87^90^97^"[ORNTMP Q "N/A"
 ;Documentation states these are "Inactive"
 ;I "^28^37^46^"[ORNTMP Q "TBD"
 Q $$GETPRVNM(ORIEN)
 ;
GETPRVNM(ORIEN) ;
 N ORPRV,P04
 S ORPRV=""
 I +ORIEN=0 Q "UNKNOWN"
 S P04=$P($G(^OR(100,ORIEN,0)),U,4)
 I +P04 S ORPRV=$$GET1^DIQ(200,P04,.01)
 I ORPRV="" S ORPRV="UNKNOWN"
 Q ORPRV
