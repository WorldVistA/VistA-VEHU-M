PRCHNPO1 ;SF-ISC/RSD/RHD-CONT. OF NEW PO ;4/30/25  10:35
V ;;5.1;IFCAP;**16,79,100,108,191,238**;Oct 20, 2000;Build 6
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;            insure ONLY one PP entry is allowed and only able
 ;            to allow/edit one entry in what is defined as a
 ;            multiple field.  Prompt Pay processing is NO 
 ;            longer part of the order/del order templates,
 ;            but called as new routine PRCHNPOC.
 ;
 ;            FPDS Questions removed PRC*5.1*238
 ;
 ;Integration agreements
 ; ICR #10018      ^DIE        EN+1,E2+2
 ; ICR #10056      ^DIC(5      POP+10,POP+16,POP1+4
 ;
EN I ('$G(PRCHPC)!($G(PRCHPC)=2)),'$G(PRCHPHAM) D
 .S PRCH=0,DIE="^PRC(442,",DR="[PRCHDISCNT]",(D0,DA,DA(1))=PRCHPO D ^DIE    ;PRC*5.1*191 & PRC*5.1*238
 . D PPEDIT^PRCHNPOC      ;PRC*5.1*191
 F I=1:1 S PRCH=$O(^PRC(442,PRCHPO,3,PRCH)) Q:PRCH=""!(PRCH'>0)  S PRCHCN=$S($P(^(PRCH,0),U,5)]"":$P(^(0),U,5),1:".OM"),PRCHAC=$P(^(0),U,1),PRCHACT=$P(^(0),U,4),PRCHP=$P(^(0),U,2) D SET Q:'$D(PRCHPO)
 G ERR^PRCHNPO:'$D(PRCHPO) S $P(^PRC(442,PRCHPO,0),U,14)=$P(^PRC(442,PRCHPO,0),U,14)+I-1,PRCHLCNT=$P(^(0),U,14),Y=$G(^PRC(440,PRCHV,2)),PRCHN("LSA")=$P(Y,U,5),PRCHN("MB")=$S(PRCHDT:$P(Y,U,3),1:$P(Y,U,6))
 S PRCHBO=$S(PRCHDT:1.1,1:1) K PRCHB
 S X="",PRCH="" F I=0:0 S PRCH=$O(PRCH("AM",PRCH)) Q:PRCH=""  S X=X+$P(PRCH("AM",PRCH),U,2)
 ;Comment line below for PRC*5.1*79, new FPDS report for Austin
 ;G:($G(PRCHPC)!$G(PRCHDELV)) EST
 I $G(PRCHPC)=1 G EST ;skip for Simplified PC orders, PRC*5.1*79
 I PRCHDT I (X+PRCHEST>25000&("467B"'[PRCHSC))!("013"[PRCHSC)!(PRCHN("MP")=12)!(PRCHN("MP")=5)!(PRCHN("SFC")=1) G E2
 I $O(^PRC(440,PRCHV,PRCHBO,0)) S PRCHB(0)="^442.16PA^"_$P(^(0),U,3,4) F I=0:0 S I=$O(^PRC(440,PRCHV,PRCHBO,I)) Q:'I  S:$P(^PRCD(420.6,+I,0),"^",5)'="N" PRCHB(I)=I
 I PRCHDT,'$D(PRCHB) D ER3^PRCHNPO6 G ERR^PRCHNPO
 D EN6^PRCHNPO2 G ERR^PRCHNPO:'$D(PRCHPO)
 ;FPDS coding removed via PRC*5.1*238
E2 S DR=""  ;hnc
 S PRCHY=0 I PRCHEST>0,PRCHEC>0 S PRCHY=PRCHEST/PRCHEC,Y=$P(PRCHY,".",2) I $L(Y)>2 S PRCHY=$P(PRCHY,".",1)+$J("."_Y,2,2)
 S PRCH=0 F PRCHI=1:1 S PRCH=$O(PRCH("AM",PRCH)) Q:PRCH=""  D TYPE S PRCHAMT=PRCH("AM",PRCH),PRCHCN=$S(PRCH=".OM":"",1:PRCH),DIE("NO^")="NO" W ?40,"AMOUNT: ",PRCHAMT S PRCHAMT=""""_PRCHAMT_"""" D ^DIE ;
 ;
EST G ERR^PRCHNPO:'$D(PRCHPO) I 'PRCHEST,PRCHESTL S $P(^PRC(442,PRCHPO,0),U,18)=""
 D EN2^PRCHNPO7 I PRCHEST D EST^PRCHNPO6
 I $P($G(^PRC(442,PRCHPO,23)),U,11)="",PRCHSTAT'=22 S (X,Y)=5,DA=PRCHPO D UPD^PRCHSTAT
 I $G(PRCHPC)=2!$G(PRCHDELV) S (D0,DA)=PRCHPO D ^PRCHSF
 I '$G(PRCPROST) S %=1,%B="",%A="     Review "_$S($G(PRCHPC):"Purchase Card",$G(PRCHDELV):"Delivery",1:"Purchase")_" Order " D ^PRCFYN I %=1 S D0=PRCHPO D ^PRCHDP1
 I PRCHSTAT=22 S (D0,DA)=PRCHPO D ^PRCHSF G Q^PRCHNPO4
 G ^PRCHNPO4
 ;
SET G:PRCHAC="Q" PCTQ
 I PRCHAC[":" S PRCHAC=$P(PRCHAC,":",1)_":1:"_$P(PRCHAC,":",2)
 ;
PCT S PRCHAMT=0,Y="F J="_PRCHAC_" S PRCHN=J D PCT1 G:$D(PRCHER) Q" X Y Q:'$D(PRCHPO)
 S PRCHAMT=PRCHAMT*100+.5\1/100,$P(PRCH("AM",PRCHCN),U,2)=$P(PRCH("AM",PRCHCN),U,2)-PRCHAMT
 S $P(^PRC(442,PRCHPO,3,PRCH,0),U,3)=PRCHAMT,$P(^(0),U,6)=I+PRCHLCNT
 Q
 ;
PCT1 I $D(^PRC(442,PRCHPO,2,"B",PRCHN)) S GTFLAG="" D  G:GTFLAG=1 ER^PRCHNPO6 G:GTFLAG=2 ER1^PRCHNPO6
 .S PRCHN=$O(^PRC(442,PRCHPO,2,"B",PRCHN,0)),PRCHD=+$P($G(^PRC(442,PRCHPO,2,PRCHN,2)),U,1) I PRCHD'>0 S GTFLAG=1 Q
 .I $S(PRCHCN=".OM"&($P(^(2),U,2)=""):0,PRCHCN=$P(^(2),U,2):0,1:1) S GTFLAG=2 Q
 .S PRCHDA=0
 .I $E(PRCHP,1)="$" S PRCHDA=$P(PRCHP,"$",2)/PRCHACT
 .E  S PRCHDA=$J(PRCHD*(PRCHP/100),0,2)
 .S PRCHAMT=PRCHAMT+PRCHDA,$P(^PRC(442,PRCHPO,2,PRCHN,2),U,6)=PRCHDA
 Q
 ;
PCTQ S (PRCHAMT,PRCHCN,PRCHX)=0,PRCHACT=PRCHLCNT F K=0:0 S PRCHCN=$O(PRCH("AM",PRCHCN)) Q:PRCHCN=""  S PRCHAC=$E($P(PRCH("AM",PRCHCN),U,3),1,$L($P(PRCH("AM",PRCHCN),U,3))-1) D PCT Q:'$D(PRCHPO)  S PRCHX=PRCHX+PRCHAMT
 Q:'$D(PRCHPO)  S $P(^PRC(442,PRCHPO,3,PRCH,0),U,3)=PRCHX
 Q
 ;
POP ;Set up place of performance for PRC*5.1*79, new FPDS. If station is the
 ;place of perf. for PO, send the state abbrev. and zip code, otherwise
 ;send the vendor's state and zip code. Applies to all Delivery POs.
 ;For Guaranteed Delivery orders, we have to choose the VAMC since users
 ;are not asked for a SHIP TO location - PRC*5.1*100.
 N PRCST,PRCSTL,PRCSZP,PRCPOP,PRCLOC,PRCROOT,PRCVAMC
 I $P(^PRC(442,PRCHPO,25),"^",15)="Y" D
 . I $P(^PRC(442,PRCHPO,0),"^",2)=4 D POP1 Q
 . S PRCLOC=$P(^PRC(442,PRCHPO,1),U,3) ;ship to location
 . S PRCST=$P(^PRC(411,PRC("SITE"),1,PRCLOC,0),"^",6)  ;station's state
 . S PRCSTL=$P(^DIC(5,PRCST,0),"^",2)
 . S PRCSZP=$P(^PRC(411,PRC("SITE"),1,PRCLOC,0),"^",7) ;station's zip
 . S PRCPOP=PRCSTL_PRCSZP,$P(^PRC(442,PRCHPO,25),"^",16)=PRCPOP
 . Q
 I $P(^PRC(442,PRCHPO,25),"^",15)="N" D
 . S PRCST=$P(^PRC(440,PRCHV,0),"^",7) ;vendor's state
 . S PRCSTL=$P(^DIC(5,PRCST,0),"^",2)
 . S PRCSZP=$E($P(^PRC(440,PRCHV,0),"^",8),1,5) ;vendor's zip
 . S PRCPOP=PRCSTL_PRCSZP,$P(^PRC(442,PRCHPO,25),"^",16)=PRCPOP
 Q
 ;
POP1 ;Set up for Guaranteed Delivery orders - users are not asked for a SHIP
 ;TO location during PO creation - PRC*5.1*100.
 S PRCROOT=$G(^PRC(411,PRC("SITE"),0)),PRCVAMC=$G(^(3)) ; local VAMC
 S PRCST=$P(PRCVAMC,"^",4)
 S PRCSTL=$P(^DIC(5,PRCST,0),"^",2) ;station's state
 S PRCSZP=$E($P(PRCVAMC,"^",5),1,5) ;station's zip
 S PRCPOP=PRCSTL_PRCSZP,$P(^PRC(442,PRCHPO,25),"^",16)=PRCPOP
 Q
 ;
TYPE I PRCHI=PRCHEC,PRCHEST'=(PRCHY*PRCHEC) S PRCHY=PRCHY+(PRCHEST-(PRCHY*PRCHEC))
 I PRCHY>0 S PRCH("AM",PRCH)=$P(PRCH("AM",PRCH),U,1)_U_($P(PRCH("AM",PRCH),U,2)+PRCHY)_U_$P(PRCH("AM",PRCH),U,3)
 S PRCHX=$P(PRCH("AM",PRCH),U,3),K=0
 I PRCHX]"" W !?1,"ITEM: " W:PRCHX'[":1:" PRCHX I PRCHX[":1:" F J=0:0 S PRCHX=$P(PRCHX,":1:",1)_":"_$P(PRCHX,":1:",2,99) I PRCHX'[":1:" W PRCHX Q
 S:$P(PRCH("AM",PRCH),U,2)]"" PRCH("AM",PRCH)=$P(PRCH("AM",PRCH),U,2)
 Q
Q I $D(PRCHPO) L -^PRC(442,PRCHPO)
 K PRCH,PRCHAC,PRCHACT,PRCHAM,PRCHAMT,PRCHB,PRCHBO,PRCHCN,PRCHCNT,PRCHD,PRCHDA,PRCHDT,PRCHEC,PRCHER,PRCHES,PRCHEST,PRCHFPDS,PRCHI,PRCHL0,PRCHL1,PRCHL2,PRCHL3,PRCHLCNT,PRCHLI
 K PRCHN,PRCHP,PRCHPO,PRCHSC,PRCHV,PRCHX,PRCHY,DIC,DIE,DR,D0,DA,X,Y
 Q
