RJPTFARN ;RJ WILM DE -PTF ARCHIVE TO FILE; MAY 6 86
 ;;4.0
 S:'$D(DUZ(0)) DUZ(0)="" I DUZ(0)'="@" W !!,*7,"You must be a programmer to run this option." Q
 I '$D(^PTFAR(460401,0)) W !,*7,"You do not have the PTF ARCHIVE File installed.  Try Later!" Q
 W !,"You should be using a 16K Partition and "
 S X="T" D ^%DT S DT=+Y W !,"You should be using a Printer to run the PTF Archive Program.",! S %DT="APE",%DT("A")="Archive PTF Records Transmitted to Austin with a Discharge Date before Date: " D ^%DT G:Y=-1 X S Z=Y
 K %DT S X1=DT,X2=Z D ^%DTC W !,"That is ",X," days in the past.  Are you sure: NO// " R A:300 S A=$S(A["y":"Y",A'["Y":"",1:"Y") G:A="" X
 W !,"Locking Globals ^DGPT, ^DGP, ^DPT, ^PTFAR." F I="^DGPT","^DGP","^DPT","^PTFAR" L @I:1 I '$T W !,"Unable to lock ",I," global.  Try Later!" G X
 S PTFAR=$P(^PTFAR(460401,0),"^",3)+1 W !,"Hold On." S A=$P(^DGPT(0),"^",3) F I=1:1:A I $D(^DGPT(I,0)),$D(^DGPT(I,70)) S X2=$P(^(70),"^",1),X1=Z D ^%DTC I X>0 D A
 W !,"Reindexing Files." S DIC="^DGP(45.84,X)",DIC1="^DGP(45.84,0)" D R W "." S DIC="^DGPT(X)",DIC1="^DGPT(0)" D R W "." S DIC="^PTFAR(460401,X)",DIC1="^PTFAR(460401,0)" D R W ".  Done."
X L  K %DT,A,D,DA,DFN,E,I,J,K,M,PTFAP,PTFAR,PTFARE,PTFC,PTFCC,PTFCOB,PTFD,PTFDB,PTFDXLS,PTFI1,PTFI2,PTFI3,PTFI4,PTFI5,PTFI6,PTFI7,PTFI8,PTFI9,PTFI10,PTFLB,PTFN,PTFOP1,PTFOP2,PTFOP3,PTFOP4,PTFOP5
 K %X,%Y,C,DIC,DIC1,L,PTFP,PTFP1,PTFP2,PTFP3,PTFP4,PTFP5,PTFPD,PTFR,PTFSOA,PTFSS,X,Y,Z Q
A I '$D(^DGP(45.84,I,0)) W !,"PTF Record ",I," Not Coded.  ...NOT ARCHIVED!" Q
 I $P(^(0),"^",4)="" W !,"PTF Record ",I," Not Transmitted.  ...NOT ARCHIVED!" Q
 S %X="^DGPT(I,",%Y="^PTFAR(460401,PTFAR," D %XY^%RCR W "  ",I
 S D=^DGPT(I,0),DFN=$P(D,"^",1),PTFP=$S(DFN="":"",$D(^DPT(DFN,0)):$P(^(0),"^",1),1:"")
 S D=^DGPT(I,101),DFN=$P(D,"^",1),PTFSOA=$S(DFN="":"",$D(^DIC(45.1,DFN,0)):$P(^(0),"^",1)_"_"_$P(^(0),"^",2),1:""),DFN=$P(D,"^",4),PTFCOB=$S(DFN="":"",$D(^DIC(45.82,DFN,0)):$P(^(0),"^",1)_"_"_$P(^(0),"^",2),1:"")
 I $D(^DGPT(I,"S",0)) S PTFN=0 F M=1:1 S PTFN=$N(^DGPT(I,"S",PTFN)) Q:PTFN'?.N  S D=^DGPT(I,"S",PTFN,0) D OP
 F K=1:1:5 S @("PTFP"_K)=""
 I $D(^DGPT(I,"401P")) S D=^("401P") F K=1:1:5 S DFN=$P(D,"^",K),@("PTFP"_K)=$S(DFN="":"",$D(^ICD0(DFN,0)):$P(^(0),"^",1)_"_"_$P(^(0),"^",4),1:"")
 I $D(^DGPT(I,"M",0)) S PTFN=0 F M=1:1 S PTFN=$N(^DGPT(I,"M",PTFN)) Q:PTFN'?.N  S D=^DGPT(I,"M",PTFN,0) D M
 S D=^DGPT(I,70),DFN=$P(D,"^",2),PTFDB=$S(DFN="":"",$D(^DIC(42.4,DFN,0)):$P(^(0),"^",1),1:""),DFN=$P(D,"^",6),PTFPD=$S(DFN="":"",$D(^DIC(45.6,DFN,0)):$P(^(0),"^",1),1:"")
 S DFN=$P(D,"^",10),PTFDXLS=$S(DFN="":"",$D(^ICD9(DFN,0)):$P(^(0),"^",1)_"_"_$P(^(0),"^",3),1:""),DFN=$P(D,"^",11),PTFD=$S(DFN="":"",$D(^ICD9(DFN,0)):$P(^(0),"^",1)_"_"_$P(^(0),"^",3),1:"")
 I $D(^DGPT(I,1,0)) S PTFN=0 F M=1:1 S PTFN=$N(^DGPT(I,1,PTFN)) Q:PTFN'?.N  S D=^DGPT(I,1,PTFN,0) D CC
 S (PTFAP,PTFARE)="" G:'$D(^DGPT(I,460)) A1 S DFN=$P(^(460),"^",5) I DFN'="",$D(^DIC(6,DFN,0)) S DFN=$P(^(0),"^",1),PTFAP=$S(DFN="":"",$D(^DIC(16,DFN,0)):$P(^(0),"^",1),1:"")
 S DFN=$P(^DGPT(I,460),"^",6) I DFN'="",$D(^DIC(6,DFN,0)) S DFN=$P(^(0),"^",1),PTFARE=$S(DFN="":"",$D(^DIC(16,DFN,0)):$P(^(0),"^",1),1:"")
A1 S ^PTFAR(460401,PTFAR,"AR")=PTFP_"^"_PTFSOA_"^"_PTFCOB_"^"_PTFP1_"^"_PTFP2,^PTFAR(460401,PTFAR,"AR3")=PTFP3_"^"_PTFP4_"^"_PTFP5,^PTFAR(460401,PTFAR,"AR1")=PTFDB_"^"_PTFPD_"^"_PTFDXLS_"^"_PTFD_"^"_PTFAP_"^"_PTFARE
 S D=^DGP(45.84,I,0),DFN=$P(D,"^",3),PTFC=$S(DFN="":"",$D(^DIC(3,DFN,0)):$P(^(0),"^",1),1:""),DFN=$P(D,"^",5),PTFR=$S(DFN="":"",$D(^DIC(3,DFN,0)):$P(^(0),"^",1),1:""),^PTFAR(460401,PTFAR,"AR4")=$P(D,"^",2)_"^"_PTFC_"^"_$P(D,"^",4)_"^"_PTFR
 S ^PTFAR(460401,"B",$P(^PTFAR(460401,PTFAR,0),"^",1),PTFAR)="" D ^RJPTFARK S PTFAR=PTFAR+1 Q
OP S DFN=$P(D,"^",3),PTFSS=$S(DFN="":"",$D(^DIC(45.3,DFN,0)):$P(^(0),"^",1)_"_"_$P(^(0),"^",2),1:"")
 F K=1:1:5 S DFN=$P(D,"^",K+7),@("PTFOP"_K)=$S(DFN="":"",$D(^ICD0(DFN,0)):$P(^(0),"^",1)_"_"_$P(^(0),"^",4),1:"")
 S ^PTFAR(460401,PTFAR,"S",PTFN,"AR")=PTFSS_"^"_PTFOP1_"^"_PTFOP2_"^"_PTFOP3,^PTFAR(460401,PTFAR,"S",PTFN,"AR1")=PTFOP4_"^"_PTFOP5 Q
M S DFN=$P(D,"^",2),PTFLB=$S(DFN="":"",$D(^DIC(42.4,DFN,0)):$P(^(0),"^",1),1:"")
 F K=1:1:5 S DFN=$P(D,"^",K+4),@("PTFI"_K)=$S(DFN="":"",$D(^ICD9(DFN,0)):$P(^(0),"^",1)_"_"_$P(^(0),"^",3),1:"")
 F K=6:1:10 S DFN=$P(D,"^",K+5),@("PTFI"_K)=$S(DFN="":"",$D(^ICD9(DFN,0)):$P(^(0),"^",1)_"_"_$P(^(0),"^",3),1:"")
 S ^PTFAR(460401,PTFAR,"M",PTFN,"AR")=PTFLB_"^"_PTFI1_"^"_PTFI2_"^"_PTFI3_"^"_PTFI4_"^"_PTFI5,^PTFAR(460401,PTFAR,"M",PTFN,"AR1")=PTFI6_"^"_PTFI7_"^"_PTFI8_"^"_PTFI9_"^"_PTFI10 Q
CC S DFN=$P(D,"^",1),PTFCC=$S(DFN="":"",$D(^DIC(3,DFN,0)):$P(^(0),"^",1),1:""),^PTFAR(460401,PTFAR,1,PTFN,"AR")=PTFCC Q
R ;Reindex File
 S C=0,L=0,X=0 F M=1:1 S Y=X,X=$O(@DIC) Q:X'?.N!(X="")
 S Z=@DIC1,$P(Z,"^",3,4)=Y_"^"_(M-1),@DIC1=Z Q
