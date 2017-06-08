PSGWEDI1 ;BHAM ISC/GRK,CML-Enter/Edit of AOU Inventory Values - CONTINUED ; 26 Jul 94 / 2:18 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;**2**;4 JAN 94
EN1 ; ENTRY POINT FROM PSGWEDI
 S DIC("W")="W $P(^(0),""^"",8)"
 I $L(PSGWDRG)>1 S X=$E(PSGWDRG,2,$L(X)),DIC(0)="QEM"
 E  S DIC(0)="QEAM"
 S PSGTN="",PSGNT=0 F I=0:0 S I=$O(^PSI(58.19,PSGWIDA,1,PSGWDA,1,I)) Q:I'>0  S PSGTN=PSGTN_I_",",PSGNT=PSGNT+1
 S DIC("S")="S ND=$O(^(""I"",0)) I $S('$G(ND):1,ND>DT:1,1:0) F I=1:1:PSGNT I $S($D(^PSI(58.1,PSGWDA,1,Y,2,$P(PSGTN,"","",I))):1,$D(^PSI(58.16,$P(PSGTN,"","",I),0)):$P(^(0),""^"")=""ALL"",1:0)"
 S DIC="^PSI(58.1,PSGWDA,1," D ^DIC S DA=+Y K DIC Q:Y<0  D ALIGN Q
 ;
 ;
ALIGN ;Align on this item
 Q:'$D(^PSI(58.1,PSGWDA,1,+Y,0))  S K=^(0) D LOC S PSGTYP=""
TYP S PSGTYP=$O(^PSI(58.19,"AINV",PSGWIDA,PSGWDA,PSG1,PSG2,PSG3,PSGTYP)) Q:PSGTYP=""
 I $D(^PSI(58.19,"AINV",PSGWIDA,PSGWDA,PSG1,PSG2,PSG3,PSGTYP,PSGDR)) S PSGDR=$E(PSGDR,1,$L(PSGDR)-1)_$E(" ",$E(PSGDR,$L(PSGDR))'=" ") Q
 E  G TYP
LOC ;Build item address
 S K1=$P(K,"^",8) F I=1:1:3 S @("PSG"_I)=$S($P(K1,",",I)]"":$P(K1,",",I),1:" ")
 S PSGDR=$S($D(^PSDRUG(+K,0))#2:$P(^(0),"^",1),1:+K)
 Q
EN3 ;ENTRY POINT FROM PSGWEDI
 S (A,^(1,PSGWIDA,0))=PSGWIDA_"^"_$P(^PSI(58.1,PSGWDA,1,PSGDDA,0),"^",2)
 I '$D(^PSI(58.1,PSGWDA,1,PSGDDA,1,0)) S ^(0)="^58.12P^"_PSGWIDA_"^1"
 E  S ^(0)=$P(^PSI(58.1,PSGWDA,1,PSGDDA,1,0),"^",1,2)_"^"_$S($P(^(0),"^",3)<PSGWIDA:PSGWIDA,1:$P(^(0),"^",3))_"^"_($P(^(0),"^",4)+1)
 Q
