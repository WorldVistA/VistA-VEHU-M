PRSTPRE1 ; HISC/CLS/WAA - Payroll Edit (cont) ;8/4/93  08:40
 ;;3.5;PAID;;Jan 26, 1995
LOOP S NN="" F KK=0:0 S NN=$O(^PRST(455,"ATL",TL,NN)) Q:NN=""  F DFN=0:0 S DFN=$O(^PRST(455,"ATL",TL,NN,DFN)) Q:DFN<1  D L1 G:'LP L0
L0 D TCLS^PRSTKE G TLUN^PRSTPRE
L1 Q:'$D(^PRST(455,PP,1,DFN,0))  Q:$P(^(0),"^",2)'="T"
 D LP Q
LP S CDIS=2 I +$G(^PRST(455,PP,1,DFN,2))=DUZ Q:LP=1  D ^PRSTDIS W *7,!!,"You cannot verify data which you have entered!" H 2 Q
 D ^PRSTDIS,CHK I %=1 L +^PRST(455,PP,1,DFN) G RD
 W !,"Enter '^' to bypass this employee." W:LP=1 " Enter '^^' to stop T&L editing."
LP1 R !!,"Enter CD value: ",X:DTIME S:'$T X="^^" Q:X="^"  I X="^^" S LP=0 Q
 I X'?.N W *7,!,"Enter RETURN if no entries made; otherwise enter CD value",!,"from T&A RECORD. Leading 0's may be omitted." G LP1
 L +^PRST(455,PP,1,DFN) S CODE=$P(^PRST(455,PP,1,DFN,0),"^",3),STAT=$P(^(0),"^",2)
 I X="",CODE'="" W *7,"Data exists! Do not enter a null CD value." D UNL G LP1
 I +CODE=+X W " .. ok" S:STAT="T" $P(^PRST(455,PP,1,DFN,0),"^",2)="P" G UPD
 W *7,!!,"CD does NOT Match! -- Re-Enter Code String Correctly including CD field!"
RD R !!,"Enter code string: ",CODE:DTIME I '$T S LP=0 G UNL
 I CODE["?" W !!,"Enter a 8B transaction code string from the Time and Attendance Report (ex. ""AN080AL080"")" G RD
 I CODE="" S ^(0)=$P(^PRST(455,PP,1,DFN,0),"^",1,12),$P(^(0),"^",3)="" K ^(1) G CLS
 S CPTR=1,NUM="",OCD="",SCD="" K CD
CODEL S CHARCODE=$E(CODE,CPTR,CPTR+1) I CHARCODE="CD" S SCD=+$E(CODE,CPTR+2,CPTR+7),CPTR=CPTR+8 G CODEL:$L(CODE)'<CPTR,ST
 G:CHARCODE'?2U ERR1
 S CIEN=$O(^DD(455.02,"B",CHARCODE,"")) G:CIEN="" ERR1 S Y0=^DD(455.02,CIEN,0)
 S LEN=+$P(Y0,"X)>",2),NUM=$E(CODE,CPTR+2,CPTR+LEN+1),X=NUM X $P(Y0,"^",5) G:'$D(X) ERR2
 G:$D(CD(CHARCODE)) DUP S CD(CHARCODE)=$P(Y0,"^",4)_"^"_NUM,CPTR=CPTR+LEN+2 G:$L(CODE)'<CPTR CODEL
ST S S(0)=$P(^PRST(455,PP,1,DFN,0),"^",1,12),S(1)="",$P(S(0),"^",3)=""
 S CODE="" F I=0:0 S CODE=$O(CD(CODE)) Q:CODE=""  S $P(S(+CD(CODE)),"^",+$P(CD(CODE),";",2))=$P(CD(CODE),"^",2),OCD=OCD+$P(CD(CODE),"^",2)
 S:OCD OCD=OCD#1000000 I SCD="",OCD'="" W *7,!!,"CD value must be included in code string!" G RD
 I OCD'=SCD W *7,!!,"Calculated CD does not match Entered CD" G RD
 S $P(S(0),"^",3)=OCD D:"PX"[$P(S(0),"^",2) ^PRSTAUD S ^PRST(455,PP,1,DFN,0)=S(0) S:S(1)'="" ^PRST(455,PP,1,DFN,1)=S(1) K:S(1)="" ^(1)
CLS D CHK I %=1 G RD
 I $P(^PRST(455,PP,1,DFN,0),"^",2)="X" S $P(^(0),"^",2)="H",^PRST(455,"AH",PP,DFN)=""
 E  S $P(^PRST(455,PP,1,DFN,0),"^",2)=FLG
UPD S NOW=$P($H,",",2)\60,NOW=NOW\60*100+(NOW#60)+1/10000+$P(DT,".",1)
 S $P(^PRST(455,PP,1,DFN,2),"^",3,4)=DUZ_"^"_NOW
UNL ; Unlock
 L -^PRST(455,PP,1,DFN) Q
CHK W ! K ER S HDR=0 D ^PRSTED1 S %=0 Q:'CNT
C1 W *7,!!,"Do you wish to edit this RECORD" S %=1 D YN^DICN
 I %=-1 S %=2 Q
 I %<1 W !!,"Answer YES to edit the 8B data; answer NO to ignore the error and continue." G C1
 Q
ERR1 W *7,!,CHARCODE," is not a valid field name." G RD
ERR2 W *7,!,NUM," is not a valid value for the ",CHARCODE," field." G RD
DUP W *7,!,CHARCODE," has been entered more than once!" G RD
EX K %,%H,%W,%Y,%Y1,C0,C1,CD,CDIS,CFLG,CIEN,CHARCODE,CNT,CODE,CPTR,D0,DFN,DI,DIC,DISYS,FFLG,FLG,HDR,I,K,KK,LAB,LEN,LP,LVG,MX,N1,N2,NEW,NFLG,NN,NOR,NOW,NUM,OCD,OTL,PAY,PE,PP,S,SCD,SN,STA,STAT,T0,T1,TL,TLIEN,TLMETH,X,Y,Y0,Z Q
