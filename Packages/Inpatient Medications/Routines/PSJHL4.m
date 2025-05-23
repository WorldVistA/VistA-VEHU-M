PSJHL4 ;BIR/RLW-DECODE HL7 /MESSSAGE FROM OE/RR ;16 Mar 99 / 4:55 PM
 ;;5.0;INPATIENT MEDICATIONS;**1,12,27,34,40,42,55,47,50,56,58,98,85,105,107,110,111,154,134,197,226,279,419,399,426**;16 DEC 97;Build 4
 ; Reference to $$EN^PSOHLNEW is supported by DBIA# 2188.
 ; Reference to ^PS(50.7 is supported by DBIA 2180.
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PS(59.7 supported by DBIA 2181.
 ; Reference to ^ORHLESC is supported by DBIA 4922.
 ;
EN(PSJMSG) ; Start
 K ^TMP("PSJNVO",$J)
 N ADCNT,SOLCNT,OCCNT
 N ACKDATE,ADDITIVE,ADMINSTR,APPL,COMMENT,PSJHLDFN,DISPENSE,DOSE,DURATION,II,INSTR,J,JJ,JJJ,K,LOGIN,NEWORDER,NURSEACK,OBXFL,OCNARR,OCPROV,OCRSN,ORDER,PRIORITY,PSITEM,ORDCON,PROCOM,PSJORDER,PSREASON
 N LOC,PROVIDER,PSPR,PSOC,PTR,QQ,REQST,ROUTE,RXON,RXORDER,SCHEDULE,SEGMENT,SOLUTION,STPDT,STRENGTH,TEXT,CLERK,INFRT,IVTYP,SCHTYP,PREON,NOO,ROC,FREQ,CLASS,PSJHLMTN,UNIT,UNITS,QFLG,VOLUME,TVOLUME,PSGP
 N PSJASTP,FLDATE,FLCMNT,PSJFLAG,PSJYN,PRNTON,APPT,IVLIMIT,IVCAT,INTRMT,PSJINDI
 S (ADCNT,SOLCNT,OCCNT,II,TVOLUME)="",(OBXFL,QFLG)=0,PSJHLMTN="ORR" F  S II=$O(PSJMSG(II)) Q:'II  D DECODE Q:QFLG  D @FIELD(0) Q:$G(CLASS)="O"  Q:QFLG
 I ($G(CLASS)'="I")!(QFLG) G END
 I ($G(PSOC)="NW")!($G(PSOC)="XO") N DIK,DA S DIK="^PS(53.1,",DA=NEWORDER D EN1^DIK L -^PS(53.1,NEWORDER)
 I ($G(PSOC)="NW")!($G(PSOC)="XO") D EN1^PSJHL2(PSJHLDFN,$S(PSOC="NW":"OK",1:"XR"),NEWORDER_"P")
END ;
 K ^TMP("PSJNVO",$J)
 I (",S,A,")[(","_$G(PRIORITY)_",")!($G(SCHEDULE)="NOW")!($G(SCHEDULE)["STAT") D
 . I $G(PRIORITY)="ZD",$G(PSGORD) D NOTIFY(PSGORD_$S(PSGORD["V":"V",PSGORD["U":"U",1:""),PSJHLDFN,$G(PRIORITY),$G(SCHEDULE))
 . I $G(NEWORDER) D NOTIFY(NEWORDER_"P",PSJHLDFN,$G(PRIORITY),$G(SCHEDULE))
 I $G(NEWORDER),$G(^PS(53.1,+NEWORDER,"DSS")) D NOCLDEF^PSJBCMA6(PSJHLDFN,+NEWORDER_"P")
 Q
DECODE ; Parse into fields 
 K FIELD
 N PSJCTR1 S PSJCTR1=""
 S SEGMENT=$G(PSJMSG(II))
 I $D(PSJMSG(II,1)),$P(SEGMENT,"|",1)="ORC" F  S PSJCTR1=$O(PSJMSG(II,PSJCTR1)) Q:PSJCTR1=""  D
 . S SEGMENT=SEGMENT_PSJMSG(II,PSJCTR1)  ;Handle CPRS "overflow" ORC nodes
 I $D(PSJMSG(II,1)),$P(SEGMENT,"|",1)="OBX" S PSJCTR1="" F  S PSJCTR1=$O(PSJMSG(II,PSJCTR1)) Q:PSJCTR1=""  D
 . S SEGMENT=SEGMENT_PSJMSG(II,PSJCTR1)  ;Handle CPRS "overflow" OBX nodes
 S J=0
 F  Q:$G(SEGMENT)=""  D
 .I SEGMENT["|" S FIELD(J)=$P(SEGMENT,"|"),SEGMENT=$E(SEGMENT,$L(FIELD(J))+2,$L(SEGMENT)),J=J+1 Q
 .I SEGMENT'["|" S FIELD(J)=SEGMENT,SEGMENT="" Q
 K PSJCTR1
 Q
NOTIFY(ORDER,PSJHLDFN,PRIO,PSJSCHED) ; Send msg
 N NTFYREAS,WARD,MGROUP,NTFSTAT,DRUG,DRIEN,PNAME,ORDATE,DO,PSG,XMY,VADPT,LASTFOUR,PSJSOK,CLINIC
 Q:($G(PRIO)=""&($G(PSJSCHED)=""))
 S DFN=PSJHLDFN D DEM^VADPT S LASTFOUR=$P($P(VADM(2),"^",2),"-",3)
 S NTFYREAS=$S((",S,A,")[(","_PRIO_","):1,($G(PSJSCHED)="NOW"):2,($G(PSJSCHED)="STAT"):3,1:0) Q:'NTFYREAS
 S PSJSOK=1
 I ORDER["P" D PND
 I ORDER["U" D UD
 I ORDER["V" D IV
 Q:PSJSOK=1
 D XMD^PSJHL4A
 Q
PND ; Pending
 N WARD,WDPARM,MGRP
 Q:'$D(^PS(53.1,+ORDER,0))
 S CLINIC=$P($G(^PS(53.1,+ORDER,"DSS")),"^",1)
 S WARD=$G(^DPT(PSJHLDFN,.1)) I WARD]"" D
 .N DIC,X,Y S DIC="^DIC(42,",DIC(0)="BOXZ",X=WARD D ^DIC S WARD=+Y Q:WARD=0
 .S WARD=$O(^PS(59.6,"B",WARD,0)) Q:+WARD=0
 .Q:$$SNDTSTW^PSJHL4A(PRIO,PSJSCHED,WARD)
 .S WDPARM=$G(^PS(59.6,+WARD,0)),MGRP=$P(WDPARM,"^",30) Q:+MGRP=0
 .S MGRP=$$GET1^DIQ(3.8,MGRP,.01) I MGRP]"" S XMY("G."_MGRP_"@"_$G(^XMB("NETNAME")))="",PSJSOK=0
 S:'$$SNDTSTP^PSJHL4A(PRIO,PSJSCHED) MGROUP="G.PSJ STAT NOW PENDING ORDER@"_$G(^XMB("NETNAME")),XMY(MGROUP)="",PSJSOK=0
 S NTFSTAT="PENDING"
 N NDP2,ND0 S NDP2=$G(^PS(53.1,+ORDER,.2)),ND0=$G(^PS(53.1,+ORDER,0))
 S DRIEN=+$P(NDP2,"^"),DO=$P(NDP2,"^",2),RTE=$P(ND0,"^",3),ORDATE=$P(ND0,"^",14)
 S SCHED=$P($G(^PS(53.1,+ORDER,2)),"^")
 Q
UD ; UD
 N WARD,WDPARM,MGRP
 Q:'$D(^PS(55,PSJHLDFN,5,+ORDER,0))
 S CLINIC=$P($G(^PS(55,PSJHLDFN,5,+ORDER,8)),"^",1)
 S WARD=$P($G(^PS(55,PSJHLDFN,5,+ORDER,0)),"^",23) I +WARD D
 .S WARD=$O(^PS(59.6,"B",WARD,0)) Q:+WARD=0
 .Q:$$SNDTSTW^PSJHL4A(PRIO,PSJSCHED,WARD)
 .S WDPARM=$G(^PS(59.6,+WARD,0)),MGRP=$P(WDPARM,"^",30) Q:+MGRP=0
 .S MGRP=$$GET1^DIQ(3.8,MGRP,.01) I MGRP]"" S XMY("G."_MGRP_"@"_$G(^XMB("NETNAME")))="",PSJSOK=0
 S:'$$SNDTSTA^PSJHL4A(PRIO,PSJSCHED) MGROUP="G.PSJ STAT NOW ACTIVE ORDER@"_$G(^XMB("NETNAME")),XMY(MGROUP)="",PSJSOK=0
 S NTFSTAT="ACTIVE"
 N ND2,ND0 S ND0=$G(^PS(55,PSJHLDFN,5,+ORDER,0)),ND2=$G(^PS(55,PSJHLDFN,5,+ORDER,2)),NDP2=$G(^PS(55,PSJHLDFN,5,+ORDER,.2))
 S DRIEN=+$P(NDP2,"^"),DO=$P(NDP2,"^",2),RTE=$P(ND0,"^",3),ORDATE=$P(ND0,"^",14)
 S SCHED=$P(ND2,"^")
 Q
IV ; IV
 N WARD,WDPARM,MGRP
 Q:'$D(^PS(55,PSJHLDFN,"IV",+ORDER,0))
 S CLINIC=$P($G(^PS(55,PSJHLDFN,"IV",+ORDER,"DSS")),"^",1)
 S WARD=$P($G(^PS(55,PSJHLDFN,"IV",+ORDER,0)),"^",22) I +WARD D
 .S WARD=$O(^PS(59.6,"B",WARD,0)) Q:+WARD=0
 .Q:$$SNDTSTW^PSJHL4A(PRIO,PSJSCHED,WARD)
 .S WDPARM=$G(^PS(59.6,+WARD,0)),MGRP=$P(WDPARM,"^",30) Q:+MGRP=0
 .S MGRP=$$GET1^DIQ(3.8,MGRP,.01) I MGRP]"" S XMY("G."_MGRP_"@"_$G(^XMB("NETNAME")))="",PSJSOK=0
 S:'$$SNDTSTA^PSJHL4A(PRIO,PSJSCHED) MGROUP="G.PSJ STAT NOW ACTIVE ORDER@"_$G(^XMB("NETNAME")),XMY(MGROUP)="",PSJSOK=0
 S NTFSTAT="ACTIVE"
 N ND2,NDP2,ND0 S ND0=$G(^PS(55,PSJHLDFN,"IV",+ORDER,0)),ND2=$G(^PS(55,PSJHLDFN,"IV",+ORDER,2))
 S NDP2=$G(^PS(55,PSJHLDFN,"IV",+ORDER,.2))
 S DRIEN=$P(NDP2,"^"),DO=$P(NDP2,"^",2),RTE=$P(NDP2,"^",3)
 S ORDATE=$P(ND2,"^"),SCHED=$P(ND0,"^",9)
 Q
MSH ; Header
 S PSOC=FIELD(8)
 Q
PID ; ID
 S PSJHLDFN=$$UNESC^ORHLESC(FIELD(3))
 Q
PV1 ; Visit
 N A
 S CLASS=FIELD(2),LOC=$P(FIELD(3),"^"),APPT="" I $G(FIELD(44))]"" S APPT=+$$HL7TFM^XLFDT(FIELD(44))
 I "IO"'[CLASS S PSREASON="Invalid patient class" Q
 N QQ K PSJNVA S QQ=II F  S QQ=$O(PSJMSG(QQ)) Q:'QQ  D  Q:$G(PSJNVA)
 .S X=$G(PSJMSG(QQ))
 .I $P(X,"|")="ZRN" S PSJNVA=1,CLASS="O" D EN^PSOHLNEW(.PSJMSG)
 I $G(PSJNVA) K PSJNVA Q
 I CLASS="O" N QQ S QQ=II F  S QQ=$O(PSJMSG(QQ)) Q:'QQ  I $P(PSJMSG(QQ),"|")="OBR" D  Q:$P(PSJMSG(QQ),"|")="OBR"
 .S RXON=$P(PSJMSG(QQ),"|",4) I RXON]"" S RXON=$P(RXON,"^") I "ABNPUV"[$E(RXON,$L(RXON)) S CLASS="I"
 I CLASS="O" N QQ S QQ=II F  S QQ=$O(PSJMSG(QQ)) Q:'QQ  I $P(PSJMSG(QQ),"|")="ORC" D  Q:$P(PSJMSG(QQ),"|")="ORC"
 .S RXON=$P(PSJMSG(QQ),"|",4) I RXON]"" S RXON=$P(RXON,"^") I "ABNPUV"[$E(RXON,$L(RXON)) S CLASS="I"
 I CLASS="O" N CHK,QQ S QQ=II F  S QQ=$O(PSJMSG(QQ)) Q:'QQ  I $P(PSJMSG(QQ),"|")="RXO" D  Q:$P(PSJMSG(QQ),"|")="RXO"
 .S CHK=$P(PSJMSG(QQ),"|",2),CHK=$S($P(CHK,"^",5)="IV":"IV",1:$P(CHK,"^",4))
 .I CHK="IV" S CLASS="I" Q
 .I 'CHK S PSREASON="Missing or Invalid Orderable Item",CLASS="I" Q
 .I $P($G(^PS(50.7,CHK,0)),"^",3)=1 S CLASS="I" Q
 D:CLASS="O" EN^PSOHLNEW(.PSJMSG)
 Q
ORC ; Order
 S TMPAT=""
 S PSOC=FIELD(1)
 S ORDER=FIELD(2)
 I $G(PSREASON)]"" D ERROR^PSJHL9 Q
 S PSJORDER=$P(FIELD(2),"^"),RXON=$P(FIELD(3),"^"),RXORDER=$S((RXON["N")!(RXON["P"):"^PS(53.1,"_+RXON_",",RXON["V":"^PS(55,"_PSJHLDFN_",""IV"","_+RXON_",",1:"^PS(55,"_PSJHLDFN_",5,"_+RXON_",")
 ;
 ; Resetting Nurse Verification Fields to sync-up CPRS & BCMA (Skips DC'd and Expired orders)
 I PSOC'="DC",PSOC'="SS",$G(PSJHLDFN),$G(RXON),RXON["V"!(RXON["U") D
 . N PSJORSTS
 . S PSJORSTS=$S(RXON["V":$$GET1^DIQ(55.01,+RXON_","_PSJHLDFN,100,"I"),1:$$GET1^DIQ(55.06,+RXON_","_PSJHLDFN,28,"I"))
 . I PSJORSTS="E"!(PSJORSTS="D") Q
 . D DELNV^PSJUTL3(PSJHLDFN,RXON)
 ;
 I PSOC="NA" D ASSIGN^PSJHL5 Q
 S CLERK=+$G(FIELD(10))
 S PROVIDER=+$G(FIELD(12)) D:PSOC="NW"
 .I PROVIDER=0 S PSREASON="Invalid Provider" D ERROR^PSJHL9 Q 
 .I PROVIDER>0 S PSPR=$G(^VA(200,+PROVIDER,"PS")) I '$D(PSPR)!'(PSPR)!$S($P(PSPR,"^",4)="":0,1:$P(PSPR,"^",4)'>DT) S PSREASON="Invalid Provider" D ERROR^PSJHL9 Q
 S UNITS=$P(FIELD(7),"^"),INSTR=$$UNESC^ORHLESC($P(FIELD(7),"^",8))
 S:UNITS["&" DOSE=$P(UNITS,"&"),UNIT=$P(UNITS,"&",2),UNITS=$P(UNITS,"&",3) S:UNITS]"" UNITS=$$UNESC^ORHLESC(UNITS) S:$G(DOSE)]"" DOSE=$$UNESC^ORHLESC(DOSE)
 S SCHEDULE=$P(FIELD(7),"^",2),PRIORITY=$P(FIELD(7),"^",6) S:SCHEDULE["PRN" SCHTYP="P"
 I SCHEDULE["&" S ADMINS=$P(SCHEDULE,"&",2),SCHEDULE=$P(SCHEDULE,"&") S ADMINS=$TR(ADMINS," ","") S ADMINS=$S(ADMINS:ADMINS,1:"")
 S SCHEDULE=$$UNESC^ORHLESC(SCHEDULE)
 I SCHEDULE["@" S TMPAT=$$TMPAT^PSJHL4A(SCHEDULE)
 I $G(TMPAT) S $P(SCHEDULE,"@",2)=TMPAT,ADMINS=TMPAT
 S DURATION=$P(FIELD(7),"^",3),REQST=$P(FIELD(7),"^",4) S:REQST'="" REQST=+$E(+$$HL7TFM^XLFDT(REQST),1,12) S REQST=$$DATE2^PSJUTL2(REQST)
 S PRIORITY=$S($G(PRIORITY)]"":PRIORITY,1:"R")
 I $E(SCHEDULE,1)=" " S:$TR(SCHEDULE," ")="PRN" SCHEDULE="PRN" I '(SCHEDULE="PRN")  S PSREASON="Invalid Schedule" D ERROR^PSJHL9 Q
 S SCHTYP=$P(FIELD(7),"^",7)
 I $G(SCHTYP)="D" S SCHTYP="C"  ;Makes CPRS Day of Week consistent in behavior with backdoor order of Day of Week
 S PRNTON=$P(FIELD(8),"^")
 S NURSEACK=$G(FIELD(11))
 S LOGIN=$G(FIELD(15)) S:LOGIN'="" LOGIN=+$E(+$$HL7TFM^XLFDT(FIELD(15)),1,12) S LOGIN=$$DATE2^PSJUTL2(LOGIN)
 S:$G(NURSEACK)]"" ACKDATE=LOGIN
 S ORDCON=$P($G(FIELD(16)),U) I ORDCON="A" S PSJASTP=$G(FIELD(9)) S:$G(PSJASTP)'="" PSJASTP=+$E(+$$HL7TFM^XLFDT(PSJASTP),1,12) S PSJASTP=$$DATE2^PSJUTL2(PSJASTP)
 I (PSOC="CA")!(PSOC="DC") D CANCEL^PSJHL6 Q
 I PSOC="HD" D HOLD^PSJHL6 Q
 I PSOC="RL" D UNHOLD^PSJHL6 Q
 I PSOC="ZV" D NURSEACK^PSJHL5 Q
 I PSOC="SS" D STATUS^PSJHL5 Q
 ;Commented line below since ^PSJHL8 doesn't exist.
 ;I PSOC="Z@" N X S X="PSJHL8" X ^%ZOSF("TEST") I  D PURGE^PSJHL8 Q
 I PSOC="DE" S QFLG=1 Q
 Q
OBR ; Flagging from CPRS.
 S ORDER=FIELD(2)
 S PSJORDER=$P(FIELD(2),"^"),RXON=$P(FIELD(3),"^"),RXORDER=$S((RXON["N")!(RXON["P"):"^PS(53.1,"_+RXON_",",RXON["V":"^PS(55,"_PSJHLDFN_",""IV"","_+RXON_",",1:"^PS(55,"_PSJHLDFN_",5,"_+RXON_",")
 S PSJFLAG=FIELD(4)
 S FLDATE=$G(FIELD(7)) S:FLDATE'="" FLDATE=+$E(+$$HL7TFM^XLFDT(FIELD(7)),1,12) S FLDATE=$$DATE2^PSJUTL2(FLDATE)
 S CLERK=+$G(FIELD(16))
 S PSJYN=$G(FIELD(24))
 S FLCMNT=$$UNESC^ORHLESC($G(FIELD(13)))
 I PSOC="ORU" D FLAG^PSJHL5
 Q
RXC ; IV 
 D RXC^PSJHL4A
 Q
RXO ; OP
 D RXO^PSJHL4A
 Q
RXR ; Route
 S ROUTE=$P(FIELD(1),"^",4)
 Q
OBX ; Obs.
 D OBX^PSJHL4A
 Q
NTE ; Note
 D NTE^PSJHL4A
 Q
ZRX ; Custom
 D ZRX^PSJHL4A
 Q
ZSC ;Service Connected - Not Used
 Q
ZRN ;Non-VA Med (Herbal/OTC)
 S CLASS="O" D EN^PSOHLNEW(.PSJMSG)
 Q
DG1 ;Billing Awareness - Not used
 Q
