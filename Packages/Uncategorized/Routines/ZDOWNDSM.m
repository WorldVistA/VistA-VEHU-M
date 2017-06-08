DOWNSIZE ; Routine to size RA81 as an RA60
 ;;5.01;
 W !,"This routine will change the size of an RA81 to 500 maps (200 megs).",!
ASK C 63 W !,"What is the unit number of the RA81 ? " R UNIT:$S($D(DTIME):DTIME,1:60),!
 I UNIT=""!(UNIT="^") Q
 I UNIT'?1N!(UNIT>7) W "...please enter a one-digit number 0-7.",! G ASK
 S DT=40+UNIT*4+$V($V(44)+224)
 I $V(DT)#256'=15 W "...that unit is not an RA81.",! G ASK
 O 63:(2:1:1:"Z"):0 I '$T W "... VIEW buffer not available.",! G ASK
 V 16777216:"DU"_UNIT
 I $V(812,0)=500 W "...DU",UNIT," is already 500 maps.",! G ASK
 S BB=$V(512,0)#256 F I=1:1:BB D
 .S BB(I)=$V(3*(I-1)+3+512,0)#256*256+($V(3*(I-1)+2+512,0)#256)*256+($V(3*(I-1)+1+512,0)#256)
 I BB S %A=0 U 63:(2:1),0 F I=1:1:BB I BB(I)<200000 D  I %A G ASK
 .V BB(I)\400*400+399:"DU"_UNIT ; Read map block
 .I $V(BB(I)#400*2,0) S %A=1 W "Bad block at ",BB(I)," is in use. Can't downsize.",!
 U 63:(1:1),0
 W "DU",UNIT," now has ",$V(812,0)," maps, and no bad blocks are in use."
 W !,"OK to proceed with down-sizing to 500 maps ? "
 R YN:$S($D(DTIME):DTIME,1:60) S:'$T X=U Q:X=U  I YN'="Y",YN'="y" W !,"No change done.",! G ASK
 V 812:0:500,916:0:500
 V -16777216:"DU"_UNIT
 W !,"DU",UNIT," has been re-sized.",! G ASK
