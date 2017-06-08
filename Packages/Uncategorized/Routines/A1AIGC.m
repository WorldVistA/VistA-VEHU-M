A1AIGC ;BT + NP/ALB-ISC; 11-4-87 @ 9:10AM; checks validity of extracted nodes; NOTE:  ISC USE ONLY!
 ;;Version 1.0
ZA ;1^LOGICAL ERROR;2^POSITIONING IN PROGRESS;4^WRITE LOCKED;32^BOT;64^READY;512^BLOCK LENGTH ERR;1024^EOT;16384^EOF;32768^ERR CONDITION
EN1 ;
 S DTIME=$S($D(DTIME):DTIME,1:300),U="^",(X1,X2,ISM,SITFLG)="",(CNT2,CNT)=0 S IOP=$I D ^%ZIS K ^UTILITY($J) F I=1:1:9 S TP(I)=$P($T(ZA),";",I+1)
 S DIC=4,DIC(0)="AEMQZ",DIC("A")="Select Region 1 sending site: " D ^DIC G:+Y<1 EXIT
 S SN=+Y,SNAME=$P(Y,U,2) W !!,*7 I SN=514 W !!,*7,"Class V site selected",! S ISM=1
LDTAPE ;
 R "Load the tape (<RETURN> continues, '^' quits)",X:DTIME G:$T=0!(X="^") EXIT
TM ;
 W ! R "Enter tape mode -->//CVAL4 ",tm:DTIME G:tm["^"!($T=0) EXIT S:tm="" tm="CVAL4" W !!,"Tape mode is ",tm,".  Correct?" S %=1 D YN^DICN I %'=1 D CLINE G TM
BLKSZ ;
 I 1 R !,"Enter blocksize -->//2048 ",bs:DTIME G:bs["^"!($T=0) EXIT S:bs="" bs=2048 W "  ",bs I +bs=0 D CLINE G BLKSZ
READTP ;
 S TAPEIO=47 O 47:(tm::bs):5 I  U 47 W *10 S %ZA=$ZA U 0 D TAPECHK
 E  W *7,!!,"Error opening tape device..." G ABORT
 U 47 W *5,*10 S %ZA=$ZA D TAPECHK E  G EXIT
 I ISM U 47 R X1:10,X2:10 W *10 S %ZA=$ZA D TAPECHK I  U 0 W !!,X2 U 47 R X1:10,X2:10 W *10 S %ZA=$ZA D TAPECHK E  W !,"ISM read-in " G ABORT
 I ISM W !!,"Ready to load data -- " G CONTIN
 U 47 R X1:10,X2:10 W *10 S %ZA=$ZA D TAPECHK I  U 0 W !!,"Globals were saved on """,X1,""" with heading, """,X2,".""",!!,"Ready to load data -- "
CONTIN ;
 I  W !!,"CONTINUE" S %=1 D YN^DICN G:%'=1 EXIT I 1
 E  W !!,*7,"Read-in invalid...check tape or get new one from site..." G ABORT
 D READIN W:EOT !,"No data present...read-in " G:EOT ABORT S X=2 D RDIN I RDIN W !!,*7,"File descriptor missing...read-in aborted!" G EXIT ;chk for file descriptor
 W !!,"Reading the nodes of the tape!",!
 F I=1:1 D READIN Q:EOT  D CHKND G ABORT:$T=0
 W !!,*7,"Completed successful read of the tape...!"
 I 'SITFLG W !!,*7,"No valid information extracted..." G ABORT
 D ^A1AIEXT W *7 R !!,"Transfer global information" S %=2 D YN^DICN I %=2 G EXIT
 W "   Executing..." F I=0:0 S I=$O(^UTILITY($J,"EQPTLG",I)) Q:I=""  W !,^(I) I '(I#2) S @(^UTILITY($J,"EQPTLG",I)_"="_^UTILITY($J,"EQPTLG",I+1))
 W !!,*7,"Re-cross referencing file...please wait!" S DIK="^DIZ(11200," D IXALL^DIK
 W !!,"Re-counting entries for descriptor node...be patient..." D ^A1AIFD
 G EXIT
CHKND ;
 Q:$P(X1,",",2)?1A!(X2["**END")  S NL=$L(X1,","),NV="N"_NL Q:NL=2
 S EQGBL="^DIZ(11200,"_$P(X1,",",2) D @NV:(NL>0)!(NL<10) I X1=@NV D:'$D(@X1) SETUTIL Q
 I 1 D ERR Q
N3 ;
 S N3=EQGBL_",0)" W !,"  **MAKE MODEL NUMBER" Q
N4 ;
 S N4=EQGBL_",1,0)" W !,"  **SITE # DESCRIPTOR" Q
N5 ;
 S N5=EQGBL_",1,"_SN_",0)" S:X1=@NV SITFLG=1 Q
N6 ;
 S N6=EQGBL_",1,"_SN_",1,0)" W !,"  **PROBLEM DESCRIPTOR NODE" Q
N7 ;
 S N7=EQGBL_",1,"_SN_",1,"_$P(X1,",",6)_",0)" Q
N8 ;
 S N8=EQGBL_",1,"_SN_",1,"_$P(X1,",",6)_",1,0)" Q
N9 ;
 S N9=EQGBL_",1,"_SN_",1,"_$P(X1,",",6)_",1,"_$P(X1,",",8)_",0)" Q
ERR ;
 U 0 W !!,"** Bad Node",!,"  ",X1," = ",$S(X2]"":X2,1:" * Null data *")
 Q
READIN ;
 U 47 R X1:10,X2:10 W *10 S %ZA=$ZA D TAPECHK
 Q
RDIN ;
 S RDIN="" I $L(X1,",")'=X S RDIN=1
 Q
SETUTIL ;
 I NL=7 D ^A1AIDATA I NOGO S NOGO="" D ERR Q
 I 1 S CNT2=CNT2+1,CNT=CNT+2,^UTILITY($J,"EQPTLG",CNT)=X1
 S ^UTILITY($J,"EQPTLG",CNT+1)=""""_X2_""""
 Q
ABORT ;
 U 0 W *7,"Aborted!",!
EXIT ;
 I $D(TAPEIO),TAPEIO=47 U 47 W *5 C 47
 I SITFLG W *7,!,"KILL ^UTILITY?" S %=2 D YN^DICN I %'=2 K ^UTILITY($J,"EQPTLG")
 I 'SITFLG K ^UTILITY($J,"EQPTLG")
 K SITFLG,CNT,CNT2,X,X1,X2,ISM,DIC,SNAME,SN,TP,tm,bs,%ZA,%,RDIN,DIK,EQGBL,N1,N2,N3,N4,N5,N6,N7,N8,N9 Q
CLINE ;
 W $C(13),$J("",79),$C(13) Q
TAPECHK ;
 I %ZA\$P(TP(5),U)#2,X1["**END"!(X2["**END")!(X1["***DONE") S EOT=1 U 0 W !!,*7,"End of global encountered!" Q
 I %ZA\$P(TP(5),U)#2 S EOT="" U 0 Q
 F I=1:1:4,6:1:9 I %ZA\$P(TP(I),U)#2 U 0 W !,*7,"    ",$P(TP(I),U,2)
TAPEQ I 0
 Q
