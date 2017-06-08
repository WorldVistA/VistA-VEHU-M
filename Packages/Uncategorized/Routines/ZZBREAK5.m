ZZBREAK5        ;
 S X=1,Y=2,Z=3
 W !,"---- TIME IS ----"
 D ^%T
 F I=1:1:10 S X=Y*I-(Z*3)+5 W !,X
 Q
  
  
  
  
  
