ZCPU ;Isc-albany.va.gov/pke-virtual terminal ;4/19/86
 ;Use Control N to quit, DSM 3.1
 G EN
 S $ZT="ERR^ZCPU" G EN
INNN ;;;U IN R *X:0 IF  S ER=$ZA\2048#2 U OUT W $C(X) W:'ER ER G IN
IN U IN R *X:0 IF  U OUT W $C(X) G IN
OUT U OUT R *Y:0 IF  I Y'=14 U IN W $C(Y) G OUT
 I Y'=14 G IN
 Q
EN W !,"Send commands to " D ^%ZIS Q:POP  S IN=IO,OUT=IO(0) Q:IO=IO(0)
 S X=0 F Z="IN","OUT" U @Z X ^%ZOSF("EOFF"),^%ZOSF("TYPE-AHEAD"),^%ZOSF("RM") ;^%ZOSF("ZMAXBUF")
 U OUT:(::::8388608)
 ;;;I '$D(ZZZ) S X=0 X ^%ZOSF("PRIORITY")
 ;
 D IN,EX QUIT
 ;
 ;8388608 D SET BIT 23 Pass control characters
EX ;
 S X=80 U OUT X ^%ZOSF("EON"),^%ZOSF("RM")
 U OUT:(:::::8388608)
 W !!,"DO DROP to drop the mini, EN to continue ",! QQQ
DROP U IN X ^%ZIS("C")
 S X=10 X ^%ZOSF("PRIORITY")
 W !,$C(7),"Dropped line to the mini" Q
 Q
LOAD U OUT X ^%ZOSF("EON") R "Download ZCPU1d program ?  with no CR",X:5 X ^%ZOSF("EOFF") Q:X=""  X ^%ZOSF("TEST") I $T U IN W "U $I ZL" U OUT ZP  H 5 Q
 ;
ERR DDDDDDDDDDDDDD
 ;
DO S X(1)="HINQ101  00000000000000NMLINDEMANN,DAVID,WAYNE/HJBX2898"_$C(13)
 S X(2)="HINQ101                CN 50040150HJBX2898"_$C(13)
 S X(3)="HINQ101                CN 50050150HJBX2898"_$C(13)
 S X(3)="HINQ101                SN 55555555HJBX2898"_$C(13)
 Q
XX U IO W X(Z) R Y(Z) S ^ZH($H)=Y(Z)
 Q
YY U IO F Z=1:1 R Y(Z)
ZC ;
 S X="" F Z=1:1:80 S X=X_"A"
 Q
ZCALL ;
 S ST=$P($H,",",2) F Z=1:1:1500 S CHK=0 S CHK=$ZC(LPC,X)
 W !!,$P($H,",",2)-ST,!!
 ;
 S ST=$P($H,",",2) F Z=1:1:1500 S CHK=0 F I=1:1:$L(X) S CHK=CHK+($A(X,I)*I)
 W !!,$P($H,",",2)-ST,!!
 ;
 S ST=$P($H,",",2) F Z=1:1:1500 S CHK=0,C=$ZC(LPC,X),C=$S(C:C*$L(X),1:$L(X))
 W !!,$P($H,",",2)-ST,!!
