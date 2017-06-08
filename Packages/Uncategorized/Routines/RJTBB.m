RJTBB 
 R !,"Octal or Decimal #: ",N Q:N="^"  D DE:N["D",OD:N["O",ERR:N'["D" G RJTBB
 Q
OD S M=1,S="",BB=""
 R !,"Enter Number:  ",OD:30
 F I=$L(OD):-1:1 S S=S+(M*$E(OD,I)),M=M*8
 W !,"The Decimal Number is: ",S S CO=S D CO
 W !,"The Binary Number is: "_BB
 Q
DE S BB="" R !,"Enter Decimal Number:  ",DN:30
 S CO=DN D CO
 W !,"The Binary Number is: "_BB
 Q
CO F ZZ=32768,16384,8192,4096,2048,1024,512,256,128,64,32,16,8,4,2,1 S BB=$S(CO-ZZ>-1:BB_"1",1:BB_"0") B  I CO-ZZ>-1 S CO=CO-ZZ
 Q
ERR W !,"Enter D for Decimal or O for Octal, ""^"" to quit"
 Q
