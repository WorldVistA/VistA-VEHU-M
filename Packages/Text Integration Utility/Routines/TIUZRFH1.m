TIUZRFH1 ;RENO/HM - DIETETIC OBJECTS FOR TIU [1/6/99 12:50pm]
 ;
 Q  ; NO TOP LEVEL ENTRY
 ;
BMI(DFN) ;
 S HT=$$HEIGHT^TIULO(DFN)
 S WT=$$WEIGHT^TIULO(DFN)
 ;
 ; Code from NEXT^FHASM3
 ;
 S A2=HT*HT*.0254*.0254
 Q:A2=0 "BMI not available without height"
 ;
 Q:WT=0 "BMI not avaliable without weight"
 ;
 S X=WT/2.2/A2
 S X=$J(X,0,1)
 Q X
