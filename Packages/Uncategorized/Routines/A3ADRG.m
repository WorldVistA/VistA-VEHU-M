A3ADRG ; B'HAM - C. LARSEN ;FISCAL YEAR DRG DATA (FY86-89)
 W !!,"This routine will perform the following functions:",!!,"1. It will stuff the National Weights and Trims for Fiscal Year 1986 into",!?3,"the 'FISCAL YEAR WEIGHTS&TRIMS' subfield of the DRG file for FY86.  It"
 W !?3,"will leave any existing local data intact for that fiscal year.",!!,"2. It will stuff the newly distributed National Weights and Trims from the"
 W !?3,"'RAM UPDATES FOR FY89' booklet into the Fiscal Year subfield for years",!?3,"1987, 1988, and 1989.  It will leave any existing Local Low and High",!?3,"Trim values intact."
 W !!,"The fields being set in the FISCAL YEAR WEIGHTS&TRIMS subfield are:",!!,"1. WEIGHT (field #2)",!,"2. LOW TRIM (field #3)",!,"3. HIGH TRIM (field #4)",!,"4. AVERAGE LENGTH OF STAY (field #4.5)" S U="^"
 F I=0:0 W !!,"Do you wish to continue" S %=2 D YN^DICN Q:%  W !,"Enter 'Y' or 'N'"
 G:%'=1 QUIT
START ;
 I '$D(^TEMPICD) W !!,"*** THE TEMPORARY GLOBAL '^TEMPICD' HAS NOT BEEN LOADED YET ***",!!,"*** INSTALL GLOBAL AND RETRY ***",! G QUIT
 W !! S DRG="",NUM=0 F FY=86,87,88,89 S ^ICD("AFY",FY)=""
 F I=0:0 S DRG=$O(^ICD("B",DRG)) Q:DRG=""  S NUM=$O(^ICD("B",DRG,0)) Q:NUM'>0  S (FLG86,FLG87)=0 D:$D(^TEMPICD(DRG,"FY86")) SET1 D:$D(^TEMPICD(DRG,"FY87")) SET2 D ZERO
 W !!,"*** DONE ***"
QUIT K CNT,DRG,FLG86,FLG87,FY,I,J,LOC,LOCWT,LOC86,NUM,% Q
SET1 ;
 S LOC86=$S($D(^ICD(NUM,"FY",86,0)):$P(^(0),"^",6,8),1:"^^"),LOCWT=$S($D(^ICD(NUM,"FY",86,0)):$P(^(0),"^",10),1:""),^ICD(NUM,"FY",86,0)=^TEMPICD(DRG,"FY86"),$P(^(0),"^",6,8)=LOC86,$P(^(0),"^",10)=LOCWT,FLG86=1 W "."
 Q
SET2 ;
 F FY=87,88,89 S LOC(FY)=$S($D(^ICD(NUM,"FY",FY,0)):$P(^(0),"^",6,7),1:"^"),^ICD(NUM,"FY",FY,0)=FY_^TEMPICD(DRG,"FY87"),$P(^(0),"^",6,7)=LOC(FY)
 S FLG87=1 W "." Q
ZERO ;
 I '$D(^TEMPICD(DRG)) F FY=86,87,88,89 S ^ICD(NUM,"FY",FY,0)=FY_"^0^0^0^^0^0^^0"
 I  G CHK
 I 'FLG86 S ^ICD(NUM,"FY",86,0)="86^0^0^0^^0^0^^0"
 I 'FLG87 F FY=87,88,89 S ^ICD(NUM,"FY",FY,0)=FY_"^0^0^0^^0^0^^0"
CHK ;
 I '$D(^ICD(NUM,"FY",0)) S ^ICD(NUM,"FY",0)="^80.22^^"
 S CNT=0 F J=0:0 S J=$O(^ICD(NUM,"FY",J)) Q:'J  S CNT=CNT+1
 S $P(^ICD(NUM,"FY",0),"^",3,4)=89_"^"_CNT
 Q
