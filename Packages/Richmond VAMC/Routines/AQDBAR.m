AQDBAR ;CGA/RAF routine to print Codabar and Code 128 barcodes; 20 Apr 06
 ;
 ;==================================================
SET ;Set variables
 ;==================================================
 S (ANS2,ANS1,ANS)=0,IOF=$C(27,91,50,74,27,91,72)
 W IOF
 W !,"Please chose the type of Bar Code you want to print:",!
 W !,"     1.  CODABAR"
 W !,"     2,  CODE 128"
 R !!,"Please pick a barcode type:  ",ANS
 I ANS["^" Q
 S %ZIS("B")="GENEZEBRA$PRT" D ^%ZIS G K:POP
 I ANS=1 D CBAR G AGA
 I ANS=2 D C128 G AGA
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
 R !!,"Please enter data for your barcode: ",ANS1
 R !!,"Please enter the Human Readable text: ",ANS2
 U IO
 W "^XA^MD8^LH0,0",!
 W "^FO315,60^BY1,,,,^BBN,65,N,N,N^FD",ANS1,"^FS",!
 W "^FO300,125^FW^AS^FD",ANS2,"^FS",!
 W "^XZ",!
 D OUT
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
 K ANS,ANS1
 Q
