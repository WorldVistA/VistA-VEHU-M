PSLSET ;XAK,MJK/ALBANY ; 19DEC1985 3:44 PM ;4/22/88  5:03 PM
 ;5.0
 W !,"OUTPATIENT PHARMACY - VERSION ",$P($T(PSLSET+1),";",2,99)
 S PSCNT=0 F I=0:0 S I=$N(^DIC(59,I)) Q:I'>0  S:$D(^(I,0)) PSCNT=PSCNT+1,Y=I
 G DIV1:PSCNT W !,*7,"SITE PARAMETERS MUST BE SPECIFIED FOR AT LEAST ONE SITE."
 W !,"THIS IS USUALLY DONE BY THE PACKAGE CO-ORDINATOR.",!,"DO YOU WISH TO CONTINUE: Y//" R X I X["?" W !!,"Enter Y to edit site parameters or N to exit.",! G PSLSET
 G LEAVE:"Y"'[$E(X,1)
 W ! D 1^PSO G PSLSET
DIV1 G:PSCNT=1 DIV3 S IOP=$I,%IS="N" D ^%ZIS S DEV=$S('POP:+IOS,1:0) I DEV<1 W !?10,*7,"Notify system manager that your device is not logged into the 'DEVICE' file",! G LEAVE ;AC/SFISC
 I $D(^DIC(59,"AB",DEV)) S Y=$N(^(DEV,0)) G DIV3
DIV2 I PSCNT>1 W ! S DIC("A")="DIVISION: ",DIC=59,DIC(0)="AEMQ" D ^DIC K DIC("A") I +Y<0 W !!,*7,"A 'DIVISION' must be selected!",!,"Do you wish to try again? YES// " R ANS G:ANS["N" LEAVE G DIV2
DIV3 S PSITE=+Y W:PSCNT>1 !!?10,"You are logged on under the ",$P(^DIC(59,PSITE,0),"^",1)," division." S %PSITE=$S($D(^DIC(59,PSITE,1)):^(1),1:""),DTIME=$S($D(^(4)):+^(4),1:0) S:'DTIME DTIME=99999
 S %PSITE7=$S($D(^DIC(59,PSITE,7)):^(7),1:"")
 I $P(%PSITE,"^",23)="",($D(^DIC(59,PSITE,1))#2) S (%PSITE,^(1))=$P((^(1)_"^^^^^^^^^^^^^^^^^^^^^^^^^"),"^",1,22)_"^45^"_$P(^(1),"^",24,999)
 X ^PSF("CUTDATE")
 S %PSDIV=$S(($P(%PSITE,"^",15))&('$P(%PSITE,"^",16)):0,1:1)
 I $P(%PSITE,"^",11),$D(DUZ),$D(^DIC(3,+DUZ,0)) S PSCLC=$S($P(^(0),"^",2)]"":$P(^(0),"^",2),1:$E($P(^(0),"^",1),1,5))
 I $P(%PSITE,"^",12) W ! S %IS="MN",%IS("A")="PRINTER 'PROFILE' DEVICE: ",%IS("B")="" D ^%ZIS K %IS G EXIT:IO="",Q:POP S:IO'=IO(0) %RXIOP=ION
 W ! S %IS="MN",%IS("A")="PRINTER 'LABEL'   DEVICE: ",%IS("B")="" D ^%ZIS K %IS G EXIT:IO="",Q:POP S:IO'=IO(0) %RXIO=ION D CURRENT^%ZIS G:IO=IO(0) DONE
LASK W !,"OK TO ASSUME LABEL ALIGNMENT IS CORRECT ? YES//" R X Q:"Y^"[$E(X,1)  I X["?" W !!,"Enter Y if labels are aligned, N if they need to be aligned.",! G LASK
P2 O IO::1 I '$T W !?5,"PRINTER IS BUSY.  OK TO ASSUME ALIGNMENT IS CORRECT?  YES//" R X Q:"Y"[$E(X,1)  G PSLSET
 D P2^PSLBL C IO
DONE ;common exit
 Q
LEAVE S XQUIT="" G DONE
Q W !?10,*7,"DEFAULT PRINTER FOR LABELS MUST BE ENTERED." G PSLSET
 ;
EXIT S IOP=$I D ^%ZIS K IOP G DONE
 ;*** NOTE ***
 ;PATCHES HAVE BEEN INSERTED INTO THIS ROUTINE IN ORDER TO RUN WITH KERNEL V6.
 ;INSERTED BY AC/SF 10-31-88.  UNVERIFIED PATCHES.
 ;Line> PSLSET+8
 ;replace> S DEV...I DEV
 ;with> S IOP=$I,%IS="N" D ^%ZIS S DEV=$S('POP:+IOS,1:0) I DEV
