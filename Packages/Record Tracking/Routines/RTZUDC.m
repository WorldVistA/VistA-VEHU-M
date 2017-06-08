RTZUDC ;PKE/Isc-albany  download format,test intermec barcode printer
 ;;v1.261
 ;D ST to open device
 ;D EN to download format F3 for RT standard record labels
 ;D EN2 to download a longer format into F3
 ;  Formats may also be defined and tested by connecting a terminal
 ;  to the Printer.
ST ;set variables for download and open device
 S STX=$C(2),ETX=$C(3),ESC=$C(27),ETB=$C(23),CAN=$C(24),CR=$C(13)
 S RS=$C(30),NUL=$C(0)
 D ^%ZIS
 Q
EN ; general format download for up to 6 lines of text and barcode
 ; this is enough for RT standard record labels,  mas, rad
 ; when this is run successfully printer may respond with '18'
 ; Free Text at end of FORM FEED prints on 1st line of label 2xheight
 ; Interface to the printer depends on paramters in the device file
 ; and terminal type.
 ;
 U IO W STX,ESC,"P",ETX D RD
 W STX,"E3;F3;" D RD
 W "H0;o00,380;f1;c0;d0,50;h2;w2;"
 W "H1;o25,380;f1;c0;d0,50;h1;w1;"
 W "H2;o40,380;f1;c0;d0,50;h1;w1;"
 W "H3;o55,380;f1;c0;d0,50;h1;w1;"
 W "H4;o70,380;f1;c0;d0,50;h1;w1;"
 W "H5;o85,380;f1;c0;d0,50;h1;w1;"
 W "H6;o100,380;f1;c0;d0,50;h1;w1;"
 W "B99;o115,310;f1;c0,0;h50;w1;r0;i1;d1,50;p@;"
 W ETX D RD
 Q
EN2 ; this loads format for up to 15 lines of text + barcode
 U IO W STX,ESC,"P",ETX D RD
 W STX,"E3;F3;" D RD
 W "H0;o0,380;f1;c0;d0,50;h1;w1;"
 W "H1;o20,380;f1;c0;d0,50;h1;w1;"
 W "H2;o40,380;f1;c0;d0,50;h1;w1;"
 W "H3;o60,380;f1;c0;d0,50;h1;w1;"
 W "H4;o80,380;f1;c0;d0,50;h1;w1;"
 W "H5;o100,380;f1;c0;d0,50;h1;w1;"
 W "H6;o120,380;f1;c0;d0,50;h1;w1;"
 W ETX D RD
 ;Q
1 U IO
 W STX,"F3;" D RD
 W "H7;o130,380;f1;c0;d0,50;h1;w1;"
 W "H8;o140,380;f1;c0;d0,50;h1;w1;"
 W "H9;o150,380;f1;c0;d0,50;h1;w1;"
 W "H10;o160,380;f1;c0;d0,50;h1;w1;"
 W "H11;o170,380;f1;c0;d0,50;h1;w1;"
 W "H12;o180,380;f1;c0;d0,50;h1;w1;"
 W ETX D RD
 ;Q
2 U IO
 W STX,"F3;" D RD
 W "H13;o190,380;f1;c0;d0,50;h1;w1;"
 W "H14;o200,380;f1;c0;d0,50;h1;w1;"
 W "H15;o210,380;f1;c0;d0,50;h1;w1;"
 W "H16;o220,380;f1;c0;d0,50;h1;w1;"
 W "B99;o220,380;f1;c0,0;h50;w1;r0;i1;d1,50;pAA;"
 W ETX D RD
 Q
 ; test print
RR U IO W STX,"R",ETX D RD
 W STX,ESC,"E3",CAN H 1
 W "WAREHO6",CR
 W "PART36E",CR
 W "LO1246",CR
 W "RIGSUPP",CR
 W "WAREHO000000000LLLLLLLLLLLLL",CR
 W "WAREHO000000000LLLLLLLLLLLLL",CR
 W "WAREHO000000000LLLLLLLLLLLLL",CR
 W "A6934XX2",CR H 1
 W RS,1
 W ETB,ETX D RD
 Q
RD ;flush
 U 0 W ! U IO F I=1:1:4 U IO R *X:1 U 0 W X,"  " U IO
 Q
 ;
XXXX ;look like RT PROGRAM
 F I=1:1:50 S RTV(I)=$C(I+50)
 S IOF="*2,""R"",*3,*2,*27,""E3"",*24,""   Test  VAMC"""
 S RTON="*27,""F99"",*0"
 S RTOFF="*30,""1"",*23,*3"
TT U IO W @IOF F N=1,2,3,4,5 X ^DIC(194.4,1,"E",N,0)
 W @RTON,"12345",CR,@RTOFF D RD
 Q
XT S IOF=$P(^%ZIS(2,128,1),"^",2)
 S RTON=^("BAR1")
 S RTOFF=^("BAR0")
