ENLOG1 ;(WASH ISC)/CTB/CLH/DH-Read Tape from Austin DPC ;10-28-91
 ;;;;
 ;CLASS 3 SOFTWARE - Not officially supported by the ISC's
 W !!,"Routine to load LOG1 NX tape (ASCII) from Austin DPC into",!,"a temporary MUMPS global (^ENZ).",!
 D ^%ZIS Q:POP
PSTTRP S ENMT=IO,ENMT(0)=IO(0),ENEOT=0,^ENZ("LOG1",0)="LOG1"
 X ^%ZOSF("MAGTAPE")
 U ENMT F ENCNT=1:1 D RD,SET Q:ENEOT
 G EXIT
 ;
RD S X(ENCNT)="" F I=1:1:100 R X:1 S:'$T ENEOT=1 Q:ENEOT  S X(ENCNT)=X(ENCNT)_X I I>4,$E(X(ENCNT),(I-4),I)="  EOF" S ENEOT=1
 Q
SET S ^ENZ("LOG1",ENCNT)=X(ENCNT)
 I '(ENCNT#200) U IO(0) W "." U ENMT
 K X(ENCNT)
 Q
EXIT K ENMT,ENEOT,ENCNT,X,I
 X ^%ZIS("C")
 W !,"Done."
 Q
 ;ENLOG1
