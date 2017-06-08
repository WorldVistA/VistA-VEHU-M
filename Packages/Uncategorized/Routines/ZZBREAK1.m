ZZBREAK1        ;
 S X=1,Y=2 B "S" S Z=3
 W !,"---- TIME IS ----"
 D ^%T
 F I=1:1:10 S J(I)=I_"THIS"
 Q
  
