OCXOZ0M ;SLC/RJS,CLA - Order Check Scan ;NOV 22,2024 at 16:47
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32,221,243**;Dec 17,1997;Build 242
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 ; ***************************************************************
 ; ** Warning: This routine is automatically generated by the   **
 ; ** Rule Compiler (^OCXOCMP) and ANY changes to this routine  **
 ; ** will be lost the next time the rule compiler executes.    **
 ; ***************************************************************
 ;
 Q
 ;
R18R1B ; Send Order Check, Notication messages and/or Execute code for  Rule #18 'STAT RESULTS AVAILABLE'  Relation #1 'STAT LAB RESULT'
 ;  Called from R18R1A+10^OCXOZ0L.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; GETDATA( ---------> GET DATA FROM THE ACTIVE DATA FILE
 ; NEWRULE( ---------> NEW RULE MESSAGE
 ;
 Q:$D(OCXRULE("R18R1B"))
 ;
 N OCXNMSG,OCXCMSG,OCXPORD,OCXFORD,OCXDATA,OCXNUM,OCXDUZ,OCXQUIT,OCXLOGS,OCXLOGD
 S OCXCMSG=""
 S OCXNMSG="STAT lab results: ["_$$GETDATA(DFN,"76^",96)_"]"
 ;
 Q:$G(OCXOERR)
 ;
 ; Send Notification
 ;
 S (OCXDUZ,OCXDATA)="",OCXNUM=0
 I ($G(OCXOSRC)="GENERIC HL7 MESSAGE ARRAY") D
 .S OCXDATA=$G(^TMP("OCXSWAP",$J,"OCXODATA","ORC",2))_"|"_$G(^TMP("OCXSWAP",$J,"OCXODATA","ORC",3))
 .S OCXDATA=$TR(OCXDATA,"^","@"),OCXNUM=+OCXDATA
 I ($G(OCXOSRC)="CPRS ORDER PROTOCOL") D
 .I $P($G(OCXORD),U,3) S OCXDUZ(+$P(OCXORD,U,3))=""
 .S OCXNUM=+$P(OCXORD,U,2)
 S:($G(OCXOSRC)="CPRS ORDER PRESCAN") OCXNUM=+$P(OCXPSD,"|",5)
 S OCXRULE("R18R1B")=""
 I $$NEWRULE(DFN,OCXNUM,18,1,44,OCXNMSG) D  I 1
 .D:($G(OCXTRACE)<5) EN^ORB3(44,DFN,OCXNUM,.OCXDUZ,OCXNMSG,.OCXDATA)
 Q
 ;
R18R2A ; Verify all Event/Elements of  Rule #18 'STAT RESULTS AVAILABLE'  Relation #2 'STAT IMAGING RESULT'
 ;  Called from EL75+5^OCXOZ0G.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; MCE75( ----------->  Verify Event/Element: 'STAT IMAGING RESULT'
 ;
 Q:$G(^OCXS(860.2,18,"INACT"))
 ;
 I $$MCE75 D R18R2B
 Q
 ;
R18R2B ; Send Order Check, Notication messages and/or Execute code for  Rule #18 'STAT RESULTS AVAILABLE'  Relation #2 'STAT IMAGING RESULT'
 ;  Called from R18R2A+10.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; GETDATA( ---------> GET DATA FROM THE ACTIVE DATA FILE
 ; NEWRULE( ---------> NEW RULE MESSAGE
 ;
 Q:$D(OCXRULE("R18R2B"))
 ;
 N OCXNMSG,OCXCMSG,OCXPORD,OCXFORD,OCXDATA,OCXNUM,OCXDUZ,OCXQUIT,OCXLOGS,OCXLOGD
 S OCXCMSG=""
 S OCXNMSG="STAT imaging results: "_$$GETDATA(DFN,"75^",24)
 ;
 Q:$G(OCXOERR)
 ;
 ; Send Notification
 ;
 S (OCXDUZ,OCXDATA)="",OCXNUM=0
 I ($G(OCXOSRC)="GENERIC HL7 MESSAGE ARRAY") D
 .S OCXDATA=$G(^TMP("OCXSWAP",$J,"OCXODATA","ORC",2))_"|"_$G(^TMP("OCXSWAP",$J,"OCXODATA","ORC",3))
 .S OCXDATA=$TR(OCXDATA,"^","@"),OCXNUM=+OCXDATA
 I ($G(OCXOSRC)="CPRS ORDER PROTOCOL") D
 .I $P($G(OCXORD),U,3) S OCXDUZ(+$P(OCXORD,U,3))=""
 .S OCXNUM=+$P(OCXORD,U,2)
 S:($G(OCXOSRC)="CPRS ORDER PRESCAN") OCXNUM=+$P(OCXPSD,"|",5)
 S OCXRULE("R18R2B")=""
 I $$NEWRULE(DFN,OCXNUM,18,2,44,OCXNMSG) D  I 1
 .D:($G(OCXTRACE)<5) EN^ORB3(44,DFN,OCXNUM,.OCXDUZ,OCXNMSG,.OCXDATA)
 Q
 ;
R18R3A ; Verify all Event/Elements of  Rule #18 'STAT RESULTS AVAILABLE'  Relation #3 'STAT CONSULT RESULT'
 ;  Called from EL110+5^OCXOZ0G.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; MCE110( ---------->  Verify Event/Element: 'STAT CONSULT RESULT'
 ;
 Q:$G(^OCXS(860.2,18,"INACT"))
 ;
 I $$MCE110 D R18R3B
 Q
 ;
R18R3B ; Send Order Check, Notication messages and/or Execute code for  Rule #18 'STAT RESULTS AVAILABLE'  Relation #3 'STAT CONSULT RESULT'
 ;  Called from R18R3A+10.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; GETDATA( ---------> GET DATA FROM THE ACTIVE DATA FILE
 ; NEWRULE( ---------> NEW RULE MESSAGE
 ;
 Q:$D(OCXRULE("R18R3B"))
 ;
 N OCXNMSG,OCXCMSG,OCXPORD,OCXFORD,OCXDATA,OCXNUM,OCXDUZ,OCXQUIT,OCXLOGS,OCXLOGD
 S OCXCMSG=""
 S OCXNMSG="STAT consult results: "_$$GETDATA(DFN,"110^",24)
 ;
 Q:$G(OCXOERR)
 ;
 ; Send Notification
 ;
 S (OCXDUZ,OCXDATA)="",OCXNUM=0
 I ($G(OCXOSRC)="GENERIC HL7 MESSAGE ARRAY") D
 .S OCXDATA=$G(^TMP("OCXSWAP",$J,"OCXODATA","ORC",2))_"|"_$G(^TMP("OCXSWAP",$J,"OCXODATA","ORC",3))
 .S OCXDATA=$TR(OCXDATA,"^","@"),OCXNUM=+OCXDATA
 I ($G(OCXOSRC)="CPRS ORDER PROTOCOL") D
 .I $P($G(OCXORD),U,3) S OCXDUZ(+$P(OCXORD,U,3))=""
 .S OCXNUM=+$P(OCXORD,U,2)
 S:($G(OCXOSRC)="CPRS ORDER PRESCAN") OCXNUM=+$P(OCXPSD,"|",5)
 S OCXRULE("R18R3B")=""
 I $$NEWRULE(DFN,OCXNUM,18,3,44,OCXNMSG) D  I 1
 .D:($G(OCXTRACE)<5) EN^ORB3(44,DFN,OCXNUM,.OCXDUZ,OCXNMSG,.OCXDATA)
 Q
 ;
R19R1A ; Verify all Event/Elements of  Rule #19 'PATIENT DISCHARGE'  Relation #1 'DISCHARGE'
 ;  Called from EL56+5^OCXOZ0G.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; MCE56( ----------->  Verify Event/Element: 'PATIENT DISCHARGE'
 ;
 Q:$G(^OCXS(860.2,19,"INACT"))
 ;
 I $$MCE56 D R19R1B^OCXOZ0N
 Q
 ;
CKSUM(STR) ;  Compiler Function: GENERATE STRING CHECKSUM
 ;
 N CKSUM,PTR,ASC S CKSUM=0
 S STR=$TR(STR,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 F PTR=$L(STR):-1:1 S ASC=$A(STR,PTR)-42 I (ASC>0),(ASC<51) S CKSUM=CKSUM*2+ASC
 Q +CKSUM
 ;
GETDATA(DFN,OCXL,OCXDFI) ;     This Local Extrinsic Function returns runtime data
 ;
 N OCXE,VAL,PC S VAL=""
 F PC=1:1:$L(OCXL,U) S OCXE=$P(OCXL,U,PC) I OCXE S VAL=$G(^TMP("OCXCHK",$J,DFN,OCXE,OCXDFI)) Q:$L(VAL)
 Q VAL
 ;
MCE110() ; Verify Event/Element: STAT CONSULT RESULT
 ;
 ;
 N OCXRES
 I $L(OCXDF(37)) S OCXRES(110,37)=OCXDF(37)
 Q:'(OCXDF(37)) 0 I $D(^TMP("OCXCHK",$J,OCXDF(37),110)) Q $G(^TMP("OCXCHK",$J,OCXDF(37),110))
 Q 0
 ;
MCE56() ; Verify Event/Element: PATIENT DISCHARGE
 ;
 ;  OCXDF(37) -> PATIENT IEN data field
 ;
 N OCXRES
 S OCXDF(37)=$G(DFN) I $L(OCXDF(37)) S OCXRES(56,37)=OCXDF(37)
 Q:'(OCXDF(37)) 0 I $D(^TMP("OCXCHK",$J,OCXDF(37),56)) Q $G(^TMP("OCXCHK",$J,OCXDF(37),56))
 Q 0
 ;
MCE75() ; Verify Event/Element: STAT IMAGING RESULT
 ;
 ;
 N OCXRES
 I $L(OCXDF(37)) S OCXRES(75,37)=OCXDF(37)
 Q:'(OCXDF(37)) 0 I $D(^TMP("OCXCHK",$J,OCXDF(37),75)) Q $G(^TMP("OCXCHK",$J,OCXDF(37),75))
 Q 0
 ;
NEWRULE(OCXDFN,OCXORD,OCXRUL,OCXREL,OCXNOTF,OCXMESS) ; Has this rule already been triggered for this order number
 ;
 ;
 Q:'$G(OCXDFN) 0 Q:'$G(OCXRUL) 0
 Q:'$G(OCXREL) 0  Q:'$G(OCXNOTF) 0  Q:'$L($G(OCXMESS)) 0
 S OCXORD=+$G(OCXORD),OCXDFN=+OCXDFN
 ;
 N OCXNDX,OCXDATA,OCXDFI,OCXELE,OCXGR,OCXTIME,OCXCKSUM,OCXTSP,OCXTSPL
 ;
 S OCXTIME=(+$H)
 S OCXCKSUM=$$CKSUM(OCXMESS)
 ;
 S OCXTSP=($H*86400)+$P($H,",",2)
 S OCXTSPL=($G(^OCXD(860.7,"AT",OCXTIME,OCXDFN,OCXRUL,+OCXORD,OCXCKSUM))+$G(OCXTSPI,300))
 ;
 Q:(OCXTSPL>OCXTSP) 0
 ;
 K OCXDATA
 S OCXDATA(OCXDFN,0)=OCXDFN
 S OCXDATA("B",OCXDFN,OCXDFN)=""
 S OCXDATA("AT",OCXTIME,OCXDFN,OCXRUL,+OCXORD,OCXCKSUM)=OCXTSP
 ;
 S OCXGR="^OCXD(860.7"
 D SETAP(OCXGR_")",0,.OCXDATA,OCXDFN)
 ;
 K OCXDATA
 S OCXDATA(OCXRUL,0)=OCXRUL_U_(OCXTIME)_U_(+OCXORD)
 S OCXDATA(OCXRUL,"M")=OCXMESS
 S OCXDATA("B",OCXRUL,OCXRUL)=""
 S OCXGR=OCXGR_","_OCXDFN_",1"
 D SETAP(OCXGR_")","860.71P",.OCXDATA,OCXRUL)
 ;
 K OCXDATA
 S OCXDATA(OCXREL,0)=OCXREL
 S OCXDATA("B",OCXREL,OCXREL)=""
 S OCXGR=OCXGR_","_OCXRUL_",1"
 D SETAP(OCXGR_")","860.712",.OCXDATA,OCXREL)
 ;
 S OCXELE=0 F  S OCXELE=$O(^OCXS(860.2,OCXRUL,"C","C",OCXELE)) Q:'OCXELE  D
 .;
 .N OCXGR1
 .S OCXGR1=OCXGR_","_OCXREL_",1"
 .K OCXDATA
 .S OCXDATA(OCXELE,0)=OCXELE
 .S OCXDATA(OCXELE,"TIME")=OCXTIME
 .S OCXDATA(OCXELE,"LOG")=$G(OCXOLOG)
 .S OCXDATA("B",OCXELE,OCXELE)=""
 .K ^OCXD(860.7,OCXDFN,1,OCXRUL,1,OCXREL,1,OCXELE)
 .D SETAP(OCXGR1_")","860.7122P",.OCXDATA,OCXELE)
 .;
 .S OCXDFI=0 F  S OCXDFI=$O(^TMP("OCXCHK",$J,OCXDFN,OCXELE,OCXDFI)) Q:'OCXDFI  D
 ..N OCXGR2
 ..S OCXGR2=OCXGR1_","_OCXELE_",1"
 ..K OCXDATA
 ..S OCXDATA(OCXDFI,0)=OCXDFI
 ..S OCXDATA(OCXDFI,"VAL")=^TMP("OCXCHK",$J,OCXDFN,OCXELE,OCXDFI)
 ..S OCXDATA("B",OCXDFI,OCXDFI)=""
 ..D SETAP(OCXGR2_")","860.71223P",.OCXDATA,OCXDFI)
 ;
 Q 1
 ;
SETAP(ROOT,DD,DATA,DA) ;  Set Rule Event data
 M @ROOT=DATA
 I +$G(DD) S @ROOT@(0)="^"_($G(DD))_"^"_($P($G(@ROOT@(0)),U,3)+1)_"^"_$G(DA)
 I '$G(DD) S $P(@ROOT@(0),U,3,4)=($P($G(@ROOT@(0)),U,3)+1)_"^"_$G(DA)
 ;
 Q
 ;
 ;
