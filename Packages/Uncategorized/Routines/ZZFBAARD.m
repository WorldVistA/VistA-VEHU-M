FBAARD ;VOUCHER AUDIT DELETE REJECTS ENTERED IN ERROR;GRR/ALB;01JAN86 ; 12/28/87  13:46 ;
 ;Fee Basis Version 1.13 ; 04/21/89
 S IOP=$S($D(ION):ION,1:$I) D ^%ZIS K IOP
 S Q="",$P(Q,"=",80)="=",UL="",$P(UL,"-",80)="-",CNT=0
 D DT^DICRW
BT K QQ W !! S DIC="^FBAA(161.7,",DIC(0)="AEQMN",DIC("S")="I ^(""ST"")=""V""&($P(^(0),U,17)]"""")" D ^DIC K DIC("S") G Q:X="^"!(X=""),BT:Y<0 S FBN=+Y,B=FBN,FZ=^FBAA(161.7,FBN,0),FBTYPE=$P(FZ,"^",3),FBAAON=$P(FZ,"^",2),FBAARA=0
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ)) W !!,*7,"Sorry, only Supervisor can Release batch!" G Q
 I '$S(FBTYPE="B3":$D(^FBAAC("AH",B)),FBTYPE="B2":$D(^FBAAC("AG",B)),FBTYPE="B5":$D(^FBAA(162.1,"AF",B)),1:0) W !!,*7,"No items rejected in this batch!" G BT
 S DA=FBN,DR="0;ST" W !! D EN^DIQ
 S FBNUM=$P(^FBAA(161.7,B,0),"^",1),FBVD=$P(^(0),"^",12),FBVDUZ=$P(^(0),"^",16)
ASKLL S B=FBN R !!,"Want line items listed? No// ",X:DTIME S:X="" X="N" D VALCK^FBAAUTL1 G:'VAL ASKLL D:"Yy"[X MORE^FBAARJP:FBTYPE="B3",PMORE^FBAARJP:FBTYPE="B5",TMORE^FBAARJP:FBTYPE="B2"
RD0 R !!,"Want to delete rejection codes for the entire Batch? No// ",X:DTIME S:X="" X="N" D VALCK^FBAAUTL1 G:'VAL ^FBAARD0 I "Yy"[$E(X,1) G ^FBAARD1
RD1 R !!,"Want to delete rejection code for any line items? No// ",X:DTIME Q:'$T  S:X="" X="N" D VALCK^FBAAUTL1 G RD1:'VAL,Q:"Yy"'[$E(X,1) D DELT^FBAARD2:FBTYPE="B2",DELM:FBTYPE="B3",DELP^FBAARD2:FBTYPE="B5"
RDD G:FBTYPE="B5" PARM
FIN S $P(FZ,"^",12)=DT,$P(FZ,"^",16)=DUZ,^FBAA(161.7,FBN,0)=FZ,^FBAA(161.7,FBN,"ST")="V",^FBAA(161.7,"AC","V",FBN)="" K ^FBAA(161.7,"AC","T",FBN) D:FBAARA>0 MINOB^FBAAUTL1
 S DIC="^FBAA(161.7,",DA=FBN,DR="0;ST" W !! D EN^DIQ G BT
Q K B,J,K,L,M,X,Y,Z,DIC,ERR,FBN,CNT,Q,UL,VAL Q
GOT S Y(0)=^FBAAC(J,1,K,1,L,1,M,0),$P(Y(0),"^",14)=DT,^FBAAC(J,1,K,1,L,1,M,0)=Y(0)
 Q
PARM F A=0:0 S A=$O(^FBAA(162.1,"AE",FBN,A)) Q:A'>0  F B=0:0 S B=$O(^FBAA(162.1,"AE",FBN,A,B)) Q:B'>0  I $D(^FBAA(162.1,A,"RX",B,0)) S $P(^(0),"^",19)=DT
 G FIN
ERR S ERR=1 W !!,"Invalid entry, must enter a number between 1 and ",QQ,!,"or an '^' to exit!" Q
GET W !! S DIC="^FBAAA(",DIC(0)="AEQM" D ^DIC Q:X="^"!(X="")  G GET:Y<0 S DA=+Y,J=DA Q
DELM D GET Q:X="^"!(X="")  I '$D(^FBAAC("AH",B,J)) W !!,*7,"No payments in this batch for that patient!" G DELM
 S QQ=0 D HED^FBAACCB
 F K=0:0 S K=$O(^FBAAC("AH",B,J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AH",B,J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AH",B,J,K,L,M)) Q:M'>0  D WRITM
RL1 R !!,"Delete Reject flag for all items for this patient? Yes// ",X:DTIME S:X="" X="Y" D VALCK^FBAAUTL1 G RL1:'VAL,LOOP:"Yy"[$E(X,1)
RL S ERR=0 R !!,"Delete reject for which line item: ",X:DTIME Q:X=""!(X="^")  D ERR:X'?1N.N,ERR:X<0!(X>QQ) G:ERR RL S HX=X
 I '$D(QQ(HX)) W !,*7,"You already deleted that one!!" G RL
ASUR W !!,"Are you sure you want to delete reject for item number: ",X," ? No// " R X:DTIME S:X="" X="N" D VALCK^FBAAUTL1 G ASUR:'VAL,RL:"Yy"'[$E(X,1)
 S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2),L=$P(QQ(HX),"^",3),M=$P(QQ(HX),"^",4)
 D STUFF G RDMORE
STUFF S $P(^FBAAC(J,1,K,1,L,1,M,0),"^",8)=$P(^FBAAC(J,1,K,1,L,1,M,"FBREJ"),"^",3),FBAAAP=+$P(^(0),"^",3),FBAARA=FBAARA+FBAAAP,FBIN=$P(^FBAAC(J,1,K,1,L,1,M,0),"^",16)
 S ^FBAAC("AC",B,J,K,L,M)="",^FBAAC("AJ",B,FBIN,J,K,L,M)="" K ^FBAAC("AH",B,J,K,L,M) S $P(FZ,"^",9)=($P(FZ,"^",9)+FBAAAP),$P(FZ,"^",11)=($P(FZ,"^",11)+1)
 K ^FBAAC(J,1,K,1,L,1,M,"FBREJ")
 I '$D(^FBAAC("AH",B)) S $P(FZ,"^",17)=""
 Q
RDMORE R !!,"Item Deleted, want to delete another? Yes// ",X:DTIME S:X="" X="Y" D VALCK^FBAAUTL1 G RDMORE:'VAL,RL:"Yy"[$E(X,1),DELM
WRITM S QQ=QQ+1,QQ(QQ)=J_"^"_K_"^"_L_"^"_M D SET^FBAACCB Q
LOOP F HX=0:0 S HX=$O(QQ(HX)) Q:HX'>0  S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2),L=$P(QQ(HX),"^",3),M=$P(QQ(HX),"^",4) D STUFF
 W !,"...DONE!" G DELM
