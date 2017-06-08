PRSTRT ; HISC/REL/WAA - Make 8B Tape ;7/9/93  13:23
 ;;3.5;PAID;;Jan 26, 1995
 ; TYP="T" for Transmit ALL, TYP="R" for Transmit Payroll Released
 Q
TRAN ; Transmission of ALL records
 S TYP="T" G L0
CORR ; Transmission of Payroll Released records
 S TYP="R"
L0 S U="^" W ! K IOP,%ZIS S %ZIS("A")="Select TAPE Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 U IO D T0 D ^%ZISC S IOP="" D ^%ZIS K %ZIS,IOP G EX
T0 S PP=$P(^PRST(455,0),"^",3) G:PP<1 KIL S X="N",%DT="XT" D ^%DT S NOW=+Y K %DT
 S PYPR=$E(PP,4,5)
 S SN=$P($G(^XMB(1,1,"XUS")),"^",17),SN=$S(+SN>0:$P($G(^DIC(4,SN,99)),"^",1),1:"")
 S XMSUB=^DD("SITE")_" ("_SN_") PAYROLL DATA (PAY PERIOD "_PYPR_")"
 S XMSUB=XMSUB_$J("",80-$L(XMSUB)),XMSUB=$E(XMSUB,1,80) U IO W XMSUB U IO(0)
 D CODES^PRSTUTL S REC=0 I TYP="R" G RETR
 F DFN=0:0 S DFN=$O(^PRST(455,PP,1,DFN)) Q:DFN<1  S C0=^(DFN,0) D CARD
 U IO W "*** END ***"_$J("",69) U IO(0) Q
RETR F DFN=0:0 S DFN=$O(^PRST(455,PP,1,DFN)) Q:DFN<1  S C0=^(DFN,0) D:$P(C0,"^",2)="P" CARD
 U IO W "*** END ***"_$J("",69) U IO(0) Q
CARD S STA=$P(C0,"^",4) Q:STA'?3N
 S SSN=$P(C0,"^",5) Q:SSN'?9N
 S NCODE=$P(C0,"^",6),TL=$P(C0,"^",7) S:$L(NCODE)'=3 NCODE="   " S:TL="" TL="   "
 S LVGP=$P(C0,"^",8) S:LVGP="" LVGP=" "
 S NH=$P(C0,"^",9),NH=$S(NH="":"  ",$L(NH)=1:"0"_NH,1:NH)
 S PYPL=$P(C0,"^",10) S:PYPL="" PYPL=" "
 S DB=$P(C0,"^",11) S:DB="" DB=" "
 S DAYNO=$P(C0,"^",12) I DAYNO'?3N S DAYNO="   "
 S CD=$P(C0,"^",3) I CD'="" S CD=$E("00000"_CD,$L(CD),$L(CD)+5)
 S HDR=" "_STA_SSN_NCODE_DAYNO_"8B"_TL_LVGP_NH_PYPL_DB_PYPR,STR="" G:CD="" C0
 F A=13:1:N1 S CODE=$P(C0,"^",A) I CODE'="" S STR=STR_$P(T0," ",A-12)_CODE
 I $D(^PRST(455,PP,1,DFN,1)) S N=^(1) F A=1:1:N2 S CODE=$P(N,"^",A) I CODE'="" S STR=STR_$P(T1," ",A)_CODE
 S:CD STR=STR_"CD"_CD
C0 I $L(STR)<49 S REC=REC+1 U IO W HDR_STR_$J("",49-$L(STR)) U IO(0) W:REC#100=1 "." Q
 F K=49:-1:1 Q:$E(STR,K,K+1)?2U
 S REC=REC+1 U IO W HDR_$E(STR,1,K-1)_$J("",50-K) U IO(0) W:REC#100=1 "."
 S STR=$E(STR,K,999) G C0
MAIL S U="^" W ! K IOP,%ZIS S %ZIS("A")="Select TAPE Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 S REC=0 U IO R HEAD:60 U IO(0) D M1 D ^%ZISC S IOP="" D ^%ZIS K %ZIS,IOP G EX
M1 K ^TMP($J) U IO F K=1:1:175 R X:60 G:'$T!(X["*** END") M2 S ^TMP($J,K,0)=X,REC=REC+1
 U IO(0) D M3 G M1
M2 U IO(0) I $D(^TMP($J)) D M3 K ^TMP($J)
 Q
M3 S XMY("XXX@Q-TAB.VA.GOV")="" W "."
 S XMSUB=HEAD
 S XMTEXT="^TMP($J,",XMDUZ=.5 D ^XMD Q
EX W !!,REC," Records Output",!
KIL K %DT,%ZIS,A,C0,CD,CODE,DAYNO,DB,DFN,HEAD,HDR,IOP,K,LVGP,N,N1,N2,NCODE,NH,NOW,POP,PP,PYPL,PYPR,REC,SN,SSN,STA,STR,T0,T1,TL,TYP,X,XMDUZ,XMSUB,XMTEXT,XMY,Y Q
