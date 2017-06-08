PRC4OFF2 ;WASH-ISC@Altoona,PA/RGY-Forward IRS offsets to Austin (cont) ;5/3/93  8:45 AM
 ;;4.0;IFCAP;;9/23/93
PRCAOFF2 ;WASH-ISC@Altoona,PA/RGY-Forward IRS offsets to Austin (cont) ;5/3/93  8:45 AM
V ;;3.7;AR;**7,12,17,20**;09/04/92
 F PRCADEB=0:0 S PRCADEB=$O(^PRCA(430,"C",PRCADEB)) Q:'PRCADEB  S PRCADEBT=0 K ^TMP($J,"PRCAOFF1","BILL") D @$S($E(DT,4,7)>1121&($E(DT,4,7)<1206):"M",1:"U")
 Q
M S PRCALDD="" F PRCABN=0:0 S PRCABN=$O(^PRCA(430,"C",PRCADEB,PRCABN)) Q:'PRCABN  D:$D(^PRCA(430,PRCABN,0)) CHKM I $O(^PRCA(430,"C",PRCADEB,PRCABN))="" D CM
 Q
U F PRCABN=0:0 S PRCABN=$O(^PRCA(430,"C",PRCADEB,PRCABN)) Q:'PRCABN  D:$D(^PRCA(430,PRCABN,0)) CHKU I $O(^PRCA(430,"C",PRCADEB,PRCABN))="" D CU
 Q
CHKM ;Check for valid IRS OFFSET MASTER bill
 I $P(^PRC(412,PRCADEB,0),"^")'["DPT" Q
 I ",1,2,18,22,23,"'[(","_$P(^PRCA(430,PRCABN,0),"^",2)_",") Q
 I $D(^PRCA(430,PRCABN,1)),^(1)>0 Q
 I $D(^PRCA(430,PRCABN,4)),^(4)>0 Q
 Q:$S('$D(^PRCA(430,PRCABN,6)):1,$E($P(^(6),"^",14),1,3)'=$E(DT,1,3):1,$P(^(0),"^",8)'=16:1,1:0)  S X2=$P(^(6),"^",14),X1=DT D ^%DTC Q:X<60
 S PRCALDD=$P(^PRCA(430,PRCABN,0),"^",10),PRCA0=$G(^PRCA(430,PRCABN,0))
 S Y=^PRCA(430,PRCABN,7),PRCATOT=0 F X=1:1:5 S PRCATOT=PRCATOT+$P(Y,"^",X)
 S PRCADEBT=PRCADEBT+PRCATOT,X=DT_"^"_$P(Y,"^")_"^"_$P(Y,"^",2)_"^"_($P(Y,"^",3)+$P(Y,"^",4)+$P(Y,"^",5))_"^"_$P(^PRCA(430,PRCABN,6),"^",19)_"^"_PRCATOT,^TMP($J,"PRCAOFF1","BILL",PRCABN)=X
 Q
CM ;Create IRS OFFSET MASTER code sheet
 G CMQ:PRCADEBT<25 S PRCHAUTO=1,PRCFA("TTF")=999,PRCFASYS="IRS" D TT^PRCFAC,NEWCS^PRCFAC I '$D(DA) H 15 G CM
 S DFN=+^PRC(412,PRCADEB,0) D DEM^VADPT
 S PRCAN01=$TR($P(VADM(1),",",1),"'`-_/\.()=, ")
 S ^PRCF(423,DA,1005)="04^81^"_$E($P($P(PRCAN01,"^"),","),1,4)_"^"_$P(VADM(2),"^",1)_"^^^  ^^"_$S($E(DT,2,3)=99:"00",$L(+$E(DT,2,3))=1:0_($E(DT,2,3)+1),1:$E(DT,2,3)+1)_"^^0^"_$E($P(VADM(1),","),1,20)
 S ^PRCF(423,DA,1005)=^PRCF(423,DA,1005)_"^"_$E($P(VADM(1),",",2),1,15)_"^"_(PRCADEBT+9.35)_"^  ^000^"_$E("000000000",1,9-$L(PRCADEB))_PRCADEB_"^"_PRCALDD_"^ ^ ",$P(^(0),"^",2)=PRC("SITE"),$P(^(1),"^",16)="$",$P(^(300),"^",12)="   "
 D XMIT
 K DFN,VADM,VAERR
CMQ Q
CHKU ;Check for valid IRS OFFSET update bill
 I $S('$D(^PRCA(430,PRCABN,6)):1,$E(DT,1,3)-1'=$E($P(^(6),"^",15),1,3):1,1:0) Q
 S Y=$S($P(^PRCA(430,PRCABN,0),"^",8)'=$O(^PRCA(430.3,"AC",102,0)):"0^0^0^0^0",1:^PRCA(430,PRCABN,7)),X=$P(^PRCA(430,PRCABN,6),"^",15,20),PRCATOT=$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)-$P(Y,"^")-$P(Y,"^",2)-$P(Y,"^",3)-$P(Y,"^",4)-$P(Y,"^",5)
 I PRCATOT>0 S $P(X,"^",2)=$P(Y,"^"),$P(X,"^",3)=$P(Y,"^",2),$P(X,"^",4)=$P(Y,"^",3)+$P(Y,"^",4)+$P(Y,"^",5),^TMP($J,"PRCAOFF1","BILL",PRCABN)=X,PRCADEBT=PRCADEBT+PRCATOT
 Q
CU ;Create IRS OFFSET UPDATE code sheet
 G CUQ:PRCADEBT'>0 S PRCHAUTO=1,PRCFA("TTF")=999.01,PRCFASYS="IRS" D TT^PRCFAC,NEWCS^PRCFAC I '$D(DA) H 15 G CU
 S DFN=+^PRC(412,PRCADEB,0) D DEM^VADPT
 S PRCAN01=$TR($P(VADM(1),",",1),"'`-_/\.()=, ")
 S ^PRCF(423,DA,1005)="04^81^"_$E($P($P(PRCAN01,"^"),","),1,4)_"^"_$P(VADM(2),"^",1)_"^0^^  ^00^"_$E(DT,2,3)_"^^^^^"_PRCADEBT,$P(^(0),"^",2)=PRC("SITE"),$P(^(1),"^",16)="$" D XMIT
 K DFN,VADM,VAERR
CUQ Q
ERR ;Setup mailman message of rejected code sheets
 S ^TMP($J,"PRCAOFF1",1)="IRS OFFSET rejected code sheets"
 S DFN=+^PRC(412,PRCADEB,0) D DEM^VADPT
 S PRCAG=PRCAG+1,^TMP($J,"PRCAOFF1",1,PRCAG)="Code sheet for debtor #"_PRCADEB_" ("_VADM(1)_") could not be processed!"
 S PRCAG=PRCAG+1,^TMP($J,"PRCAOFF1",1,PRCAG)=^PRCF(423,DA,"CODE",1,0)
 S DIK="^PRCF(423," D ^DIK
 K DFN,VADM,VAERR
 Q
XMIT ;Give record to code sheet package
 D ^PRCFACX1 S X=0 F Y=0:0 S Y=$O(^PRCF(423,DA,"CODE",Y)) Q:'Y  S X=X+$L(^(Y,0))
 I X'=$P(^PRCF(423,DA,"TRANS"),"^",15) D ERR G XMITQ
 D ENCODE^PRCFES1(DA,DUZ,.X) I X<1 D ERR G XMITQ
 S DR=".3///^S X=""N"";.5///^S X=DT;.6///^S X=""IRS"";.8///^S X=3",DIE="^PRCF(423," D ^DIE K PERS
 F X=0:0 S X=$O(^TMP($J,"PRCAOFF1","BILL",X)) Q:'X  S $P(^PRCA(430,X,6),"^",15,20)=^(X)
XMITQ Q
