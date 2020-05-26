PRC5129 ;(WOIFO)/SU-Extract IFCAP user counts ; 04/09/2001  03:30 PM
V ;;5.1;IFCAP;**29,212**;Oct 20, 2000;Build 5
 ;Per VA Directive 6402, this routine should not be modified.
 ;
POST ;
 ;
 ;Patch PRC*5.1*212 is converting this to a national option
 ;
 NEW PRCI,PRCJ,PRCK,PRCIE,PRCFCP,PRCDONE,PRCSTA,PRCESTA,PRCIVP,PRCLOA,PRCLC,PRCFDT,PRCMGR,XMSUB,XMTEXT,XMY
 NEW DIFROM
 S U="^",DT=$$DT^XLFDT
 K ^TMP("PRC5129")
FCP ;
 ;     Control Point
 S PRCI=0 F  S PRCI=$O(^PRC(420,"C",PRCI)) Q:'PRCI  D
 . S PRCSTA=0 F  S PRCSTA=$O(^PRC(420,"C",PRCI,PRCSTA)) Q:'PRCSTA  D
 .. S PRCFCP=0,PRCK=4,PRCDONE=0
 .. F  S PRCFCP=$O(^PRC(420,"C",PRCI,PRCSTA,PRCFCP)) Q:'PRCFCP!PRCDONE  D
 ... ;  skip Inactive Fund
 ... I $P(^PRC(420,PRCSTA,1,PRCFCP,0),"^",19) Q
 ... ;  get control point Level Of Access
 ... S PRCLOA=$P($G(^PRC(420,PRCSTA,1,PRCFCP,1,PRCI,0)),"^",2)
 ... I PRCLOA>3!'PRCLOA Q
 ... I PRCK>PRCLOA S PRCK=PRCLOA   ; PRCK only keep the highest level of access
 ... I PRCLOA=1 S PRCDONE=1   ; Stop here if find official level
 .. I PRCK'=4 D SETP(PRCK)
 ;
INV ;
 ;      Inventory
 ;
 ;   sort user by station # through "AD",DUZ x-ref
 S PRCI=0 F  S PRCI=$O(^PRCP(445,"AD",PRCI)) Q:'PRCI  D
 . S PRCIVP=0 K PRCMGR              ;get inv pointer
 . F  S PRCIVP=$O(^PRCP(445,"AD",PRCI,PRCIVP)) Q:'PRCIVP  D
 .. S PRCJ=$P($G(^PRCP(445,PRCIVP,0)),"^",3) Q:PRCJ=""        ; get Inv type PRC*5.1*212 ADD $G
 .. S PRCSTA=+$G(^PRCP(445,PRCIVP,0)) Q:PRCSTA=""             ; get station number PRC*5.1*212 ADD $G
 .. S ^TMP("PRC5129",$J,"INV",PRCSTA,PRCI,PRCJ)=""
 ;
 S PRCSTA=0 F  S PRCSTA=$O(^TMP("PRC5129",$J,"INV",PRCSTA)) Q:'PRCSTA  D
 . S PRCI=0 F  S PRCI=$O(^TMP("PRC5129",$J,"INV",PRCSTA,PRCI)) Q:'PRCI  D
 .. S PRCJ="" F  S PRCJ=$O(^TMP("PRC5129",$J,"INV",PRCSTA,PRCI,PRCJ)) Q:PRCJ=""  D
 ... I PRCJ="W" D                                  ; Warehouse
 .... D SETP(7)                                 ;   user
 .... I $D(^XUSEC("PRCPW MGRKEY",PRCI)) D SETP(4)  ;   manager
 ... I PRCJ="P" D                                  ; Primary
 .... D SETP(8)                                 ;   user
 .... I $D(^XUSEC("PRCP MGRKEY",PRCI)) D SETP(5)   ;   manager
 ... I PRCJ="S" D                                  ; Secondary
 .... D SETP(9)                                 ;   user
 .... I $D(^XUSEC("PRCP2 MGRKEY",PRCI)) D SETP(6)  ;   manager
 ;
PRCH ;
 ;    purchasing
 ;
 ;  get IFCAP primary station number   (assume only one primary)
 S PRCSTA=+$O(^PRC(411,"AC","Y",0))
 ;
 ;  get default station for Engineering (piece 17, ^XTV(8989.3,1,"XUS"))
 S PRCESTA=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 ;
 S PRCI=0 F  S PRCI=$O(^VA(200,PRCI)) Q:'PRCI  D
 . ;  Purchasing
 . S PRCJ=+$G(^VA(200,PRCI,400))
 . I PRCJ,PRCJ<5 D
 .. I PRCJ=1 D SETP(13)           ; Warehouse Employee
 .. I PRCJ=2 D SETP(10)           ; PPM Accountable Officer
 .. I PRCJ=3 D SETP(11)           ; Purchasing Agent
 .. I PRCJ=4 D SETP(12)           ; Supply Manager
 . ;   Engineering
 . ;                Logic copied from ENZACC2 by Scott Baumann
 . S PRCK=0 I $$ACCESS^XQCHK(PRCI,"ENINVNEW")>0 D SETE(1) S PRCK=1
 . I 'PRCK,$$ACCESS^XQCHK(PRCI,"ENINVINV")>0 D SETE(2) S PRCK=1
 . I $$ACCESS^XQCHK(PRCI,"ENSPROOM")>0 D SETE(4) S PRCK=1
 . I $$ACCESS^XQCHK(PRCI,"ENWONEW")>0 D SETE(3) S $E(PRCK,2)=1
 . I '$E(PRCK,2),$$ACCESS^XQCHK(PRCI,"ENWOCLOSE")>0 D SETE(3) S $E(PRCK,2)=1
 . I +PRCK D SETE(5)
 .  ; if none of the first 5 case is true or
 .  ; case SETE(3) is not true but other case is true
 . I ($E(PRCK,2)'=1&+PRCK)!'PRCK I $$ACCESS^XQCHK(PRCI,"ENWONEW-WARD")>0 D SETE(6)
 . ; count Accounting Staff 1 time only per station
 . I $D(^XUSEC("PRCFA SUPERVISOR",PRCI)) D SETP(15) Q
 . I $D(^XUSEC("PRCFA TRANSMIT",PRCI)) D SETP(15) Q
 . I $D(^XUSEC("PRCFA VENDOR EDIT",PRCI)) D SETP(15) Q
 . I $D(^XUSEC("PRCFA PURGE CODE SHEETS",PRCI)) D SETP(15) Q
 ;
 ;
BUDGET ;
 S PRCSTA=0 F  S PRCSTA=$O(^PRC(420,PRCSTA)) Q:'PRCSTA  D
 . S PRCI=0 F  S PRCI=$O(^PRC(420,PRCSTA,2,PRCI)) Q:'PRCI  D SETP(14)
 ;
ACNT ;
 ;   Accounting
 S PRCSTA=0 F  S PRCSTA=$O(^PRC(411,"AE",1,PRCSTA)) Q:'PRCSTA!(PRCSTA>999)  D
 . S PRCI=0 F  S PRCI=$O(^PRC(411,PRCSTA,6,PRCI)) Q:'PRCI  D SETP(15)
 ;
PCARD ;
 ;   Purchase Card
 S PRCJ=0 F  S PRCJ=$O(^PRC(440.5,PRCJ)) Q:'PRCJ  S PRCK=$G(^(PRCJ,0)) D 
 . S PRCSTA=$P($G(^PRC(440.5,PRCJ,2)),"^",3) Q:'PRCSTA
 . I $P(^PRC(440.5,PRCJ,2),"^",2)="Y" Q    ; if Inactive flag set to 'Y'
 . S PRCI=$P(PRCK,"^",8) I PRCI D SETP(16)       ; Purchase card holder
 . S PRCI=$P(PRCK,"^",9) I PRCI D SETP(18)       ; P card approving officer
 . S PRCI=$P(PRCK,"^",10) I PRCI D SETP(19)      ; Alt. P card approving officer
 . ;   Get surrogate user which is not the card holder
 . S PRCI=0 F  S PRCI=$O(^PRC(440.5,PRCJ,1,PRCI)) Q:'PRCI  D:$P(PRCK,"^",8)'=PRCI SETP(17)
 ;
 D RPT
EXIT ;
 K ^TMP("PRC5129")
 Q
 ;
RPT ;
 ;   Generate report from ^TMP("PRC5129")
 ;     1. count from ^TMP
 F PRCIE="I","E" D
 . S PRCSTA=0 F  S PRCSTA=$O(^TMP("PRC5129",$J,PRCIE,PRCSTA)) Q:'PRCSTA  D
 .. K PRCFDT S (PRCFDT,PRCI)=0
 .. F  S PRCI=$O(^TMP("PRC5129",$J,PRCIE,PRCSTA,PRCI)) Q:'PRCI  S PRCJ=$G(^(PRCI)) D
 ... F PRCK=1:1:$S(PRCIE="I":19,1:6) I $P(PRCJ,"^",PRCK) S PRCFDT(PRCK)=$G(PRCFDT(PRCK))+1
 ... S:PRCIE="I" PRCFDT=PRCFDT+1
 .. F PRCK=1:1:$S(PRCIE="I":19,1:6) D
 ... S $P(^TMP("PRC5129",$J,PRCIE,PRCSTA),"^",PRCK)=$G(PRCFDT(PRCK))
 .. I PRCIE="I" S $P(^TMP("PRC5129",$J,"I",PRCSTA),"^",20)=PRCFDT
 ;     2. format report using local array
 K PRCFDT S PRCLC=1,PRCFDT(PRCLC)="$REPORT"
 F PRCIE="I","E" D
 . S PRCSTA=0 F  S PRCSTA=$O(^TMP("PRC5129",$J,PRCIE,PRCSTA)) Q:'PRCSTA  S PRCI=$G(^(PRCSTA)) D
 .. I PRCLC>1 F PRCJ=1:1:3 S PRCLC=PRCLC+1,PRCFDT(PRCLC)=""
 .. S PRCLC=PRCLC+1,PRCFDT(PRCLC)="   "_$S(PRCIE="I":"IFCAP",1:"ENGINEERING")_" USERS BY ROLE"
 .. S PRCLC=PRCLC+1,PRCFDT(PRCLC)="   STATION #: "_PRCSTA
 .. S PRCLC=PRCLC+1,PRCFDT(PRCLC)="       Role"_$J("Count",38)
 .. F PRCK=1:1:$S(PRCIE="I":19,1:4) D 
 ... S:PRCIE="I" PRCJ=$P($T(FORMAT+PRCK),";;",2)
 ... S:PRCIE="E" PRCJ=$P($T(ENGFMT+PRCK),";;",2)
 ... S PRCLC=PRCLC+1,PRCFDT(PRCLC)="       "_PRCJ_$J(+$P(PRCI,"^",PRCK),42-$L(PRCJ))
 .. S PRCLC=PRCLC+1,PRCJ="Total Unique "_$S(PRCIE="I":"IFCAP",1:"ENGINEERING")_" Users"
 .. S PRCFDT(PRCLC)="   "_PRCJ_$J(+$P(PRCI,"^",$S(PRCIE="I":20,1:5)),46-$L(PRCJ))
 .. I PRCIE="E" D
 ... S PRCLC=PRCLC+1,PRCJ="Electronic Work Order Requesters"
 ... S PRCFDT(PRCLC)="   "_PRCJ_$J(+$P(PRCI,"^",6),46-$L(PRCJ))
 ;
 ;   $DATA
 ;    IFCAP data
 S PRCLC=PRCLC+1,PRCFDT(PRCLC)="$DATA(IFCAP)"
 S PRCSTA=0 F  S PRCSTA=$O(^TMP("PRC5129",$J,"I",PRCSTA)) Q:'PRCSTA  S PRCJ=^(PRCSTA) D
 . S PRCK="" F PRCI=1:1:19 S PRCK=PRCK_+$P(PRCJ,"^",PRCI)_","
 . S PRCLC=PRCLC+1,PRCFDT(PRCLC)="Station"_PRCSTA_","_PRCK_+$P(PRCJ,"^",20)
 ;    Engineering data
 S PRCLC=PRCLC+1,PRCFDT(PRCLC)="$DATA(ENGINEERING)"
 S PRCSTA=$O(^TMP("PRC5129",$J,"E",0)) I PRCSTA  S PRCJ=^(PRCSTA) D
 . S PRCK="" F PRCI=1:1:5 S PRCK=PRCK_+$P(PRCJ,"^",PRCI)_","
 . S PRCLC=PRCLC+1,PRCFDT(PRCLC)="Station"_PRCSTA_","_PRCK_+$P(PRCJ,"^",6)
 S PRCLC=PRCLC+1,PRCFDT(PRCLC)="$END"
 ;
MAIL ;
 ;   get mail group member
 ;PRC*5.1*212 CHECK IF PROD ACCOUNT
 I $$PROD^XUPROD() D
 . F PRCI=1:1 S PRCJ=$T(MAILGRP+PRCI),PRCJ=$P(PRCJ,";;",2) Q:PRCJ=""  S XMY(PRCJ)=""
 ;   mail to user who install patch 29
 I $G(DUZ),$D(^VA(200,DUZ)) S XMY(DUZ)=""
 S PRCSTA=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",.01)
 I PRCSTA="" S PRCSTA="UNKNOWN"
 S XMSUB="Extract IFCAP Users by Role ("_PRCSTA_")"
 S XMTEXT="PRCFDT("
 D ^XMD
 Q
MAILGRP ;
 ;;G.coreFLS VistA Stats@FORUM.DOMAIN.EXT
 ;;
 Q
FORMAT ;
 ;;FCP Official
 ;;FCP Clerk
 ;;FCP Requestor
 ;;Warehouse Inv Manager
 ;;Primary Inv Manager
 ;;Secondary Inv Manager
 ;;Warehouse Inv User
 ;;Primary Inv User
 ;;Secondary Inv User
 ;;PPM Accountable Officer
 ;;Purchasing Agent
 ;;Supply Manager
 ;;Warehouse Employee
 ;;Budget Releasing Official
 ;;Accounting Staff
 ;;Purchase Card Holder
 ;;Purchase Card Surrogate
 ;;Purchase Card Approving Official
 ;;Alt PC Approving Official
 ;;
ENGFMT ;
 ;;Asset Update
 ;;Asset View Only
 ;;Engr. Work Order
 ;;Update Location
 ;;
SETP(PRCPC) ;
 ; set value into ^TMP,    STA -- station number,    I -- DUZ
 ;   If termination date is smaller than today's date
 I $P($G(^VA(200,PRCI,0)),"^",11),DT>$P(^(0),"^",11) Q
 I '$P($G(^TMP("PRC5129",$J,"I",PRCSTA,PRCI)),"^",PRCPC) S $P(^(PRCI),"^",PRCPC)=1
 Q
 ;
SETE(PRCPC) ;
 ; set value into ^TMP,    PRCESTA -- engineer station number,    I -- DUZ
 ;   If termination date is smaller than today's date
 I $P($G(^VA(200,PRCI,0)),"^",11),DT>$P(^(0),"^",11) Q
 I '$P($G(^TMP("PRC5129",$J,"E",PRCESTA,PRCI)),"^",PRCPC) S $P(^(PRCI),"^",PRCPC)=1
 Q
