PRSTAUD ; HISC/WAA - Generate Audit Record ;5/8/92  09:55
 ;;3.5;PAID;;Jan 26, 1995
A1 S PE=0,C0=$G(^PRST(455,PP,1,DFN,0)) Q:C0=""  S C1=$G(^(1)),C2=$G(^(2)) G ADD
AD ;Entry point for Add/Edit an 8B Record
 S PE=1
ADD D CODES^PRSTUTL
 S STA=$P(C0,"^",4) I STA'?3N S STA=$E(STA_"   ",1,3)
 S SSN=$P(C0,"^",5) I SSN'?9N S SSN=$E(SSN_"         ",1,9)
 S NCODE=$P(C0,"^",6),TL=$P(C0,"^",7) S:$L(NCODE)'=3 NCODE="   " S:TL="" TL="   "
 S LVGP=$P(C0,"^",8) S:LVGP="" LVGP=" "
 S NH=$P(C0,"^",9),NH=$S(NH="":"  ",$L(NH)=1:"0"_NH,1:NH)
 S PYPL=$P(C0,"^",10) S:PYPL="" PYPL=" "
 S DB=$P(C0,"^",11) S:DB="" DB=" "
 S DAYNO=$P(C0,"^",12) I DAYNO'?3N S DAYNO="   "
 S CD=$P(C0,"^",3) I CD'="" S CD=$E("00000"_CD,$L(CD),$L(CD)+5)
 S HDR=SSN_NCODE_DAYNO_"8B"_TL_LVGP_NH_PYPL_DB_$E(PP,4,5),STR="" G:CD="" C0
 F A=13:1:N1 S ACODE=$P(C0,"^",A) I ACODE'="" S STR=STR_$P(T0," ",A-12)_ACODE
 I $D(^PRST(455,PP,1,DFN,1)) S N=^(1) F A=1:1:N2 S ACODE=$P(N,"^",A) I ACODE'="" S STR=STR_$P(T1," ",A)_ACODE
 S STR=STR_"CD"_CD
C0 S HDR=HDR_STR
START ;THIS IS THE START OF THE AUDIT ADD
 S X="T",%DT="X" D ^%DT S DT=+Y
 S %=$P($H,",",2)\60,%=%\60*100+(%#60)+1/10000+$P(DT,".",1)
 S STATUS=$P(C0,"^",2),NNOW=%
 I STATUS="T",'PE S CLERK=$P(C2,"^"),DATE=$P(C2,"^",2)
 E  S CLERK=$P(C2,"^",3),DATE=$P(C2,"^",4)
 S:'$D(^PRST(455,PP,"A",0)) ^(0)="^455.05PA^^"
 I '$D(^PRST(455,PP,"A",DFN,0)) S ^(0)=DFN,$P(^PRST(455,PP,"A",0),"^",3)=DFN,$P(^(0),"^",4)=$P(^(0),"^",4)+1
 S:'$D(^PRST(455,PP,"A",DFN,1,0)) ^(0)="^455.06DA^^"
 S X=NNOW,DIC="^PRST(455,"_PP_",""A"","_DFN_",1,",DA(2)=PP,DA(1)=DFN,DIC(0)="L"
 S DLAYGO=455 K DD,DO D FILE^DICN S D1=+Y
 I PE S CLERK=DUZ,DATE=NNOW
 S ^PRST(455,PP,"A",DFN,1,D1,0)=NNOW_"^"_CLERK_"^"_DATE_"^"_STATUS_"^"_HDR
 S ^PRST(455,PP,"A","B",DFN,D1)=""
KIL K %,A,ACODE,C0,C1,C2,CD,CLERK,D1,DA,DATE,DAYNO,DB,DIC,DLAYGO,HDR,LVGP,NCODE,N,NH,NNOW,PYPL,SSN,STATUS,STR Q
