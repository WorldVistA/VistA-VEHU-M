FHPATM ; GLRISC/REL - Patient Movements ;1/25/91  15:58 ;
 ;;4.6;;
 S DAT=0 D HDR
P1 S %DT="AEXT",%DT("A")="START with DATE@TIME: " W ! D ^%DT G:Y<1 KIL S DAT=Y
 I DAT>NOW W "  [ Date cannot be in Future ]" G P1
 S X1=DT,X2=-5 D C^%DTC I DAT<X W "  [ DATE MORE THAN 5 DAYS IN PAST ]" G P1
P2 W ! K IOP S %IS="MQ",%IS("A")="Select LIST Printer: " D ^%ZIS K %IS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="F0^FHPATM",FHLST="DAT^DT" D EN2^FH G KIL
 U IO D F0 U IO(0) X ^%ZIS("C") K %IS,IOP G KIL
F0 D HDR W !!?5,"Name",?27,"SSN",?35,"Date/Time",?49,"FROM Ward-Bed",?67,"TO Ward-Bed"
 W !!?26,"--- A D M I S S I O N S ---",! S NOD="ATT1" D FND
 W !!?26,"--- D I S C H A R G E S ---",! S NOD="ATT3" D FND
 W !!?27,"--- T R A N S F E R S ---",! S NOD="ATT2" D FND W ! Q
HDR S H1="" I DAT S DTP=DAT D DTP^FH S H1=DTP_" to "
 W @IOF,!!?23,"P A T I E N T   M O V E M E N T S"
 D NOW^%DTC S (DTP,NOW)=%,DT=NOW\1 D DTP^FH S H1=H1_DTP W !!?(80-$L(H1)\2),H1 Q
FND S NX=DAT-.0000005
F1 S NX=$O(^DGPM(NOD,NX)) Q:NX<1!(NX'<NOW)
 F DA=0:0 S DA=$O(^DGPM(NOD,NX,DA)) Q:DA=""  S X1=$S($D(^DGPM(DA,0)):^(0),1:"") D PRT
 G F1
PRT S DFN=+$P(X1,"^",3),ADM=$P(X1,"^",14),XT=$P(X1,"^",18) Q:ADM<1  D P0
 Q
P0 Q:'$D(^DPT(DFN,0))  S Y(0)=^(0) I NOD="ATT1",XT=40 Q
 I NOD="ATT3",XT=41!(XT=42)!(XT=46) Q
 W !,$E($P(Y(0),"^",1),1,24),?26,$E($P(Y(0),"^",9),6,9)
 W ?32,$J(+$E(NX,6,7),2),"-",$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(NX,4,5))
 I NX#1 S I2=+$E(NX_"0",9,10) W $J($S(I2>12:I2-12,1:I2),3),":",$E(NX_"000",11,12),$S(I2>11:"pm",1:"am")
 D GET W ?48,FW,?65,TW Q
GET S (FW,FR)="" I NOD="ATT3" S (TW,TR)="" D LST G G1
 S TW=$P(X1,"^",6),TR=$P(X1,"^",7) I NOD="ATT1" G G1
 S FW=TW,FR=TR
 I "^1^2^3^25^26^43^45^"[("^"_XT_"^") S TW=$S(XT=2!(XT=26):"AUTH LEAVE",XT=3!(XT=25):"UA LEAVE",XT=1:"ON PASS",XT=43!(XT=45):"ASIH OTHER",1:TW),TR=""
 I "^22^23^24^25^26^44^"[("^"_XT_"^") S FW=$S(XT=24!(XT=25):"AUTH LEAVE",XT=22!(XT=26):"UA LEAVE",XT=23:"PASS",XT=44:"ASIH OTHER",1:FW),FR=""
 I "^4^13^14^45^"[("^"_XT_"^") D LST
G1 S:FW FW=$P(^DIC(42,FW,0),"^",1) S:TW TW=$P(^DIC(42,TW,0),"^",1)
 S:FR FR=$P(^DG(405.4,FR,0),"^",1) S:TR TR=$P(^DG(405.4,TR,0),"^",1)
 S FW=$E(FW,1,14-$L(FR))_" "_FR,TW=$E(TW,1,14-$L(TR))_" "_TR Q
LST S TRN=9999999.9999995-NX
 F TRN=TRN:0 S TRN=$O(^DGPM("APID",DFN,TRN)) Q:TRN=""  F T0=0:0 S T0=$O(^DGPM("APMV",DFN,ADM,TRN,T0)) Q:T0=""  I T0'=DA S X=$S($D(^DGPM(T0,0)):^(0),1:""),FW=$P(X,"^",6),FR=$P(X,"^",7) G:FW L1
L1 S:"^43^45^"[("^"_$P(X,"^",18)_"^") FR="",FW="ASIH OTHER" Q
KIL K %,%H,%I,%T,%DT,%IS,ADM,DA,DAT,DFN,DTP,FW,FR,H1,I2,NOD,NOW,NX,POP,T0,TRN,TW,TR,X,X1,X2,XT,Y Q
