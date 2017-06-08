LRLABEL6 ;SLC/FHS - BAR CODE LABELS FOR THE INTERMEC PRINTER
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;This routine is similar to automated instrument
 ;*R are use to read the printer's response, not a user's input.
 ;Designed on a 8646 thermal transfer printer
 ;Charater set=USA,Batch=disable,self test=disable
 ;Baud=9600,parity=even,label stock=regular,control mode=computer
 ;Protocol Command=User interface,format Rotation=breech,right margin=diable
 ;bar width=10 mil  LABEL SIZE= 1X3 IN. Part No 049114
 ;top dip sw=all 5 off  :mid dip sw=1 on 2-7 off
 ;bottom dip sw 1-2 off,3-4 on,5 off,6 on,7-8 off
EN ;
 I PNM="TEST, LABEL" D TEST^LRLABAR Q
P Q:N<1  S:'$D(LRAN) LRAN=100 S LRURG=$S($D(LRURG0):$P(^LAB(62.05,LRURG0,0),U),1:"ROUTINE")
 S LRTXT="" F TS=0:0 S TS=$O(LRTS(TS)) Q:TS=""  S LRTXT=LRTXT_LRTS(TS)_"," I $L(LRTXT)>30 S LRTXT=$E(LRTXT,1,30)_" ***" Q
 D PRT
 Q:$S('$D(LRBAR):1,'$D(LRAA):1,'$D(LRBAR(LRAA)):1,1:0)  ;QUIT IF NO BAR CODE
BAR D ENQ W *2,"R",*3 D ENQ
 W *2,*27,"E3",*24,$E(PNM,1,30)_"  "_$P(SSN,"-",3),!,$E(LRINFW,1,20),!,LRTXT,!,LRACC_$S($D(LRURG):"  <"_LRURG_">  ",1:"  ")_"LOC:"_LRLLOC,!,$E(LRACC,1,2),!,$E("00000",$L(LRAN),5)_LRAN,*30,1,*23,*3 D ENQ
 Q
PRT D ENQ W *2,"R",*3 D ENQ
 W *2,*27,"E2",*24,$E(PNM,1,30)_"  "_$P(SSN,"-",3),!,$E(LRINFW,1,20)_"  ORD:"_$S($D(LRCE):LRCE,1:""),!,LRTXT,!,LRACC_$S($D(LRURG):"  <"_LRURG_">  ",1:"  ")_"LOC:"_LRLLOC,!,LRTOP_"  "_LRPREF,*30,1,*23,*3 D ENQ
 Q
ENQ ;
 W *5 R *X:1 Q:X=-1!(X=18)!(X=81)!(X=31)!(X=25)!(X=68)
 F  R *X:1 Q:X=-1
 Q
