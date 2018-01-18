AQDBAR1 ;CGA/RAF routine to print Codabar and Code 128 barcodes; 20 Apr 06
 ;
 ;
EN D DEV  ; G OUT
 F STU="00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30" D
 .F NUM=1:1:20 S (ANS1,ANS2)=STU_"000"_$S($L(NUM)=1:"0"_NUM,1:NUM) D CBAR
 D OUT   
 Q
 ;==================================================
SET ;Set variables
 ;==================================================
 S (ANS2,ANS1,ANS)=0
 W @IOF
 W !,"Please chose the type of Bar Code you want to print:",!
 W !,"     1.  CODABAR"
 W !,"     2,  CODE 128"
 R !!,"Please pick a barcode type:  ",ANS
 I ANS["^" Q
DEV S %ZIS("B")="GENEZEBRA$PRT" D ^%ZIS G K:POP
 ;I ANS=1 D CBAR ;G AGA
 ;I ANS=2 D C128 ;G AGA
 Q
 ;=================================================
AGA ;Print another label
 ;=================================================
 R !!,"Would you like to print another label? ",ANS2
 G:(ANS2["Y")!(ANS2["y") SET
 Q
 ;==================================================
CBAR ;Codabar print
 ;==================================================
 ;R !!,"Please enter data for your barcode: ",ANS1
 ;R !!,"Please enter the Human Readable text: ",ANS2
XTMP ;I $D(^XTMP("VBECS")) S NUM=0 F  S NUM=$O(^XTMP("VBECS",NUM)) Q:'NUM  D
 ;.S NODE=^XTMP("VBECS",NUM),ANS1=$P(NODE,U),ANS2=$P(NODE,U,2) D
 U IO
 W "^XA^MD8^LH0,0",!
 W "^FO315,60^BY1,,,,^BBN,65,N,N,N^FD",ANS1,"^FS",!
 W "^FO300,125^FW^AS^FD",ANS2,"^FS",!
 W "^XZ",!
 ;D OUT
 Q
 ;==================================================
C128 ;Code 128 print
 ;==================================================
 R !!,"Please enter data for your barcode: ",ANS1
 R !!,"Please enter the Human Readable text: ",ANS2
 U IO
 W "^XA^MD8^LH0,0",!
 W "^FO300,60^BY1,,,,^BCN,65,N,N,N^FD",ANS1,"^FS",!
 W "^FO300,125^FW^AS^FD",ANS2,"^FS",!
 W "^XZ",!
 D OUT
 Q
OUT D ^%ZISC
 K ANS,ANS1,ANS2
 Q
