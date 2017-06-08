PRSTKQ ; HISC/CLS/WAA - Quick Entry of Timecard ;8/4/93  08:53
 ;;3.5;PAID;;Jan 26, 1995
 W !,"Enter '^' to bypass this employee." W:LP=1 " Enter '^^' to stop T&L editing."
RD R !!,"Enter code string: ",CODE:DTIME S:'$T CODE="^^" I CODE["?" W !!,"Enter a 8B code string from the Time and Attendance Report (ex. AN080AL080)" G RD
 I CODE["^^",LP=1 S LP=0 G UNL
 I CODE["^" G UNL
 L +^PRST(455,PP,1,DFN)
 D:$P(^PRST(455,PP,1,DFN,0),"^",2)="T" ^PRSTAUD
 I $P(^PRST(455,PP,1,DFN,0),"^",3)'="" S ^PRST(455,PP,1,DFN,0)=$P(^PRST(455,PP,1,DFN,0),"^",1,12),$P(^(0),"^",2,3)="^" K ^(1)
INIT S CPTR=1,NUM="",SCD="" K CD G:CODE="" ST
CODEL S CHARCODE=$E(CODE,CPTR,CPTR+1) I CHARCODE="CD" S CPTR=CPTR+8 G CODEL:$L(CODE)'<CPTR,ST
 I CHARCODE'?2U G ERR1
 S CIEN=$O(^DD(455.02,"B",CHARCODE,"")) G:CIEN="" ERR1 S Y0=^DD(455.02,CIEN,0)
 S LEN=+$P(Y0,"X)>",2),NUM=$E(CODE,CPTR+2,CPTR+LEN+1)
 S X=NUM X $P(Y0,"^",5) G:'$D(X) ERR2
 I $D(CD(CHARCODE)) G DUP
 S CD(CHARCODE)=$P(Y0,"^",4)_"^"_NUM,CPTR=CPTR+LEN+2 G:$L(CODE)'<CPTR CODEL
ST S S(0)=^PRST(455,PP,1,DFN,0),S(1)=""
 S CODE="" F I=0:0 S CODE=$O(CD(CODE)) Q:CODE=""  S $P(S(+CD(CODE)),"^",+$P(CD(CODE),";",2))=$P(CD(CODE),"^",2),SCD=SCD+$P(CD(CODE),"^",2)
 S:SCD SCD=SCD#1000000 S $P(S(0),"^",2)=FLG,$P(S(0),"^",3)=SCD
 S C0=S(0),C1=S(1) D CHK I %=1 D UNL G RD
 S ^PRST(455,PP,1,DFN,0)=S(0) S:S(1)'="" ^PRST(455,PP,1,DFN,1)=S(1)
UPD S NOW=$P($H,",",2)\60,NOW=NOW\60*100+(NOW#60)+1/10000+$P(DT,".",1)
 S $P(^PRST(455,PP,1,DFN,2),"^",1,2)=DUZ_"^"_NOW
UNL ;
 L -^PRST(455,PP,1,DFN) Q
CHK ; Edit check record
 W ! K ER S HDR=0 D TK^PRSTED1 S %=0 Q:'CNT
C1 W *7,!!,"Do you wish to edit this RECORD" S %=1 D YN^DICN
 I %=-1 S %=2 Q
 I %<1 W !!,"Answer YES to edit the 8B data; answer NO to ignore the error and continue." G C1
 Q
ERR1 W *7,!,CHARCODE," is not a valid field name." D UNL G RD
ERR2 W *7,!,NUM," is not a valid value for the ",CHARCODE," field." D UNL G RD
DUP W *7,!,CHARCODE," has been entered more than once!" D UNL G RD
