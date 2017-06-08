PRSTKE ; HISC/CLS/WAA - Timekeeper Edit ;8/4/93  08:48
 ;;3.5;PAID;;Jan 26, 1995
 S FLG="T",PP=$P(^PRST(455,0),"^",3) G:PP<1 EX
 W !!,"8B Transactions for Pay Period ",+$E(PP,4,5),", ",1700+$E(PP,1,3),!!
 S X="T",%DT="X" D ^%DT S DT=+Y K %DT D CODES^PRSTUTL
TLUN D PICK^PRSTUTL G:TLIEN<1 EX S TL=$P(^PRST(455.5,TLIEN,0),"^",1) S X=$P(^PRST(455.5,TLIEN,0),"^",3) I X="T" S LP=2 G NME
 I X="P" W *7,!!,"This T&L has been Closed by Payroll" G EX
QST W !!,"Would you like to edit the 8B RECORDs in alphabetical order" S %=1 D YN^DICN I % S LP=% G EX:LP=-1&(OTL=1),TLUN:LP=-1,NME:LP=2,LOOP
 W !!,"Answer YES if you want all RECORDs brought up for which no data"
 W !,"has been entered." G QST
 ;
LOOP S NN="",FFLG="TPXH",NFLG=$F(FFLG,FLG)
L0 S NN=$O(^PRST(455,"ATL",TL,NN))
 I NN="" G LLOUT
 S DFN=""
L1 S DFN=$O(^PRST(455,"ATL",TL,NN,DFN)) G:DFN<1 L0
 I '$D(^PRST(455,PP,1,DFN,0)) G L1
 I $F(FFLG,$P(^PRST(455,PP,1,DFN,0),"^",2))'<NFLG G L1
 S CDIS=2 D ^PRSTDIS,LP:TLMETH,^PRSTKQ:'TLMETH
 I LP'=1 G LLOUT
 G L1
LLOUT D TCLS G EX:OTL,TLUN
 ;
NME K DIC S DIC("A")="Select EMPLOYEE: ",DIC("S")="I $P(^(0),""^"",7)=TL",DIC(0)="AEQM",DIC="^PRST(455,PP,1," W ! D ^DIC S DFN=+Y K DIC
 I DFN=-1 D:$P(^PRST(455.5,TLIEN,0),"^",3)="" TCLS G EX:OTL=1,TLUN
 I "T"'[$P(^PRST(455,PP,1,DFN,0),"^",2) W *7,!!,"This Employee has already been closed by Payroll." G NME
 S CDIS=2 D ^PRSTDIS,LP:TLMETH,^PRSTKQ:'TLMETH G NME
LP W !,"Enter '^' to bypass this employee." W:LP=1 " Enter '^^' to stop T&L editing.",!
 L +^PRST(455,PP,1,DFN) S C(0)=^PRST(455,PP,1,DFN,0),C(1)=$G(^(1)),S(0)=C(0),S(1)=C(1)
LP1 K DIC S DIC="^DD(455.02,",DIC(0)="AMEQ",DIC("S")="I Y>11,Y<200",DIC("A")="Enter Code: " D ^DIC K DIC S CIEN=+Y S:$D(DTOUT) X="^^"
 I X["^" S:X="^^" LP=0 G STR
 I CIEN=-1 S $P(S(0),"^",2)=FLG G STR
 S Y0=^DD(455.02,CIEN,0),CODE=$P(Y0,"^",1),ND=+$P(Y0,"^",4),PC=$P($P(Y0,"^",4),";",2)
 S NUM=$P(S(ND),"^",PC)
LP2 W ?40,"Enter code value: " W:NUM'="" NUM,"// " R X:DTIME I '$T S LP=0 G STR
 G:"^"[X LP1 I X["?" W !!,*7,?40,^DD(455.02,CIEN,3),! G LP2
 I X="@" S $P(S(ND),"^",PC)="",$P(S(0),"^",3)=$P(S(0),"^",3)-NUM G LP3
 X $P(Y0,"^",5) I '$D(X) W !!,*7,?40,^DD(455.02,CIEN,3),! G LP2
 I X'="" S $P(S(ND),"^",PC)=X,$P(S(0),"^",3)=$P(S(0),"^",3)-NUM+X#1000000
 G LP1
LP3 S X=$L(S(ND)) I $E(S(ND),X)="^" S S(ND)=$E(S(ND),1,X-1) G LP3
 G LP1
STR I C(0)=S(0),C(1)=S(1) G UNL
 I $P(S(0),"^",13,99)="",S(1)="" S $P(S(0),"^",3)=""
 D:$P(^PRST(455,PP,1,DFN,0),"^",2)=FLG ^PRSTAUD
 S C0=S(0),C1=S(1) D CHK^PRSTKQ G:%=1 LP1
 I $P(C(0),"^",2)="X" S $P(S(0),"^",2)="H",^PRST(455,"AH",PP,DFN)=""
 E  S $P(S(0),"^",2)=FLG
 S ^PRST(455,PP,1,DFN,0)=S(0) S:S(1)'="" ^(1)=S(1) K:S(1)="" ^(1)
 S NOW=$P($H,",",2)\60,NOW=NOW\60*100+(NOW#60)+1/10000+$P(DT,".",1)
 S $P(^PRST(455,PP,1,DFN,2),"^",1,2)=DUZ_"^"_NOW
UNL ;
 L -^PRST(455,PP,1,DFN) Q
TCLS ; Check to see if T&L is completely processed
 W !!,"Checking if T&L is completely processed ... "
 S NN="",FFLG="TPXH",NFLG=$F(FFLG,FLG),NEW=0,CFLG=0
TC1 S NN=$O(^PRST(455,"ATL",TL,NN))
 I NN="" G TC3
 S DFN=""
TC2 S DFN=$O(^PRST(455,"ATL",TL,NN,DFN)) G:DFN="" TC1
 I '$D(^PRST(455,PP,1,DFN,0)) G TC2
 S NEW=$F(FFLG,$P(^PRST(455,PP,1,DFN,0),"^",2))
 I $E(FFLG,NEW-1)="H" S NEW=3
 I NEW<NFLG S NFLG=NEW W "." G TC2
 I NEW>CFLG S CFLG=NEW W "." G TC2
 G TC2
TC3 I NFLG<$F(FFLG,FLG) S $P(^PRST(455.5,TLIEN,0),"^",3)=$E(FFLG,NFLG-1) W $S(NFLG=1:"Unprocessed",NFLG=2:"Unverified",NFLG=3:"Untransmitted",1:"")," records remain.",! Q
 I CFLG'=NFLG S $P(^PRST(455.5,TLIEN,0),"^",3)=$E(FFLG,NFLG-1) W "T&L is now closed out." Q
 I CFLG=NFLG S $P(^PRST(455.5,TLIEN,0),"^",3)=FLG W "T&L is now closed out." Q
 Q
EX K D,%,%DT,%W,%Y,C,S,CD,CDIS,CIEN,CODE,DIC,FLG,DFN,KK,LP,ND,N1,N2,NEW
 K Y,NFLG,NN,FFLG,DISYS,PE,SN,STA,Y,Z,NOW,OTL,PC,PP,T0,T1,TL,TLIEN,TLMETH,X,Y,Y0
 K Z,DTOUT,CFLG,CHARCODE,CPTR,I,LEN,NUM,SCD Q
