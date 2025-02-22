DGYPGLI2 ;ALB/LM - TREATING SPECIALTY INPATIENT SET ;3/10/93
 ;;5.2;REGISTRATION;**27**;JUL 29,1992
 ;
 Q
START ;
 D PTLWD,PTLTS,PTCTS
 ;
END K AA,ASIH,PASS,UA,MVT,PT,SV,SV1,TREAT,WARD Q
 ;
 ;
PTLWD Q:'PTLWD  ; Patient Listing by Wards
 S ^TMP($J,"PTLWD",DIV)=$S($D(^TMP($J,"PTLWD",DIV)):^TMP($J,"PTLWD",DIV),1:0)
 S $P(^TMP($J,"PTLWD",DIV),"^",1)=$P(^TMP($J,"PTLWD",DIV),"^",1)+1
 S $P(^TMP($J,"PTLWD",DIV),"^",2)=$P(^TMP($J,"PTLWD",DIV),"^",2)+PASS
 S $P(^TMP($J,"PTLWD",DIV),"^",3)=$P(^TMP($J,"PTLWD",DIV),"^",3)+AA
 S $P(^TMP($J,"PTLWD",DIV),"^",4)=$P(^TMP($J,"PTLWD",DIV),"^",4)+UA
 S $P(^TMP($J,"PTLWD",DIV),"^",5)=$P(^TMP($J,"PTLWD",DIV),"^",5)+ASIH
 S ^TMP($J,"PTLWD",DIV,WARD,+DGW)=$S($D(^TMP($J,"PTLWD",DIV,WARD,+DGW)):^TMP($J,"PTLWD",DIV,WARD,+DGW),1:0)
 S $P(^TMP($J,"PTLWD",DIV,WARD,+DGW),"^",1)=$P(^TMP($J,"PTLWD",DIV,WARD,+DGW),"^",1)+1
 S $P(^TMP($J,"PTLWD",DIV,WARD,+DGW),"^",2)=$P(^TMP($J,"PTLWD",DIV,WARD,+DGW),"^",2)+PASS
 S $P(^TMP($J,"PTLWD",DIV,WARD,+DGW),"^",3)=$P(^TMP($J,"PTLWD",DIV,WARD,+DGW),"^",3)+AA
 S $P(^TMP($J,"PTLWD",DIV,WARD,+DGW),"^",4)=$P(^TMP($J,"PTLWD",DIV,WARD,+DGW),"^",4)+UA
 S $P(^TMP($J,"PTLWD",DIV,WARD,+DGW),"^",5)=$P(^TMP($J,"PTLWD",DIV,WARD,+DGW),"^",5)+ASIH
 S ^TMP($J,"PTLWD",DIV,WARD,+DGW,PT,DFN)=TREAT_"^"_ADMDT_"^"_$S(SV'=0:SV,1:"")_"^"_MVT
 Q
 ;
PTLTS Q:'PTLTS  ; Patient Listing by Treating Specialty
 S ^TMP($J,"PTLTS",DIV)=$S($D(^TMP($J,"PTLTS",DIV)):^TMP($J,"PTLTS",DIV),1:0)
 S $P(^TMP($J,"PTLTS",DIV),"^",1)=$P(^TMP($J,"PTLTS",DIV),"^",1)+1
 S $P(^TMP($J,"PTLTS",DIV),"^",2)=$P(^TMP($J,"PTLTS",DIV),"^",2)+PASS
 S $P(^TMP($J,"PTLTS",DIV),"^",3)=$P(^TMP($J,"PTLTS",DIV),"^",3)+AA
 S $P(^TMP($J,"PTLTS",DIV),"^",4)=$P(^TMP($J,"PTLTS",DIV),"^",4)+UA
 S $P(^TMP($J,"PTLTS",DIV),"^",5)=$P(^TMP($J,"PTLTS",DIV),"^",5)+ASIH
 S ^TMP($J,"PTLTS",DIV,TREAT,DGTS)=$S($D(^TMP($J,"PTLTS",DIV,TREAT,DGTS)):^TMP($J,"PTLTS",DIV,TREAT,DGTS),1:0)
 S $P(^TMP($J,"PTLTS",DIV,TREAT,DGTS),"^",1)=$P(^TMP($J,"PTLTS",DIV,TREAT,DGTS),"^",1)+1
 S $P(^TMP($J,"PTLTS",DIV,TREAT,DGTS),"^",2)=$P(^TMP($J,"PTLTS",DIV,TREAT,DGTS),"^",2)+PASS
 S $P(^TMP($J,"PTLTS",DIV,TREAT,DGTS),"^",3)=$P(^TMP($J,"PTLTS",DIV,TREAT,DGTS),"^",3)+AA
 S $P(^TMP($J,"PTLTS",DIV,TREAT,DGTS),"^",4)=$P(^TMP($J,"PTLTS",DIV,TREAT,DGTS),"^",4)+UA
 S $P(^TMP($J,"PTLTS",DIV,TREAT,DGTS),"^",5)=$P(^TMP($J,"PTLTS",DIV,TREAT,DGTS),"^",5)+ASIH
 S ^TMP($J,"PTLTS",DIV,TREAT,DGTS,PT,DFN)=WARD_"^"_ADMDT_"^"_$S(SV'=0:SV,1:"")_"^"_MVT
 Q
 ;
PTCTS Q:'PTCTS  ; Patient Counts by Treating Specialty
 S ^TMP($J,"PTCTS",DIV)=$S($D(^TMP($J,"PTCTS",DIV)):^TMP($J,"PTCTS",DIV),1:0)
 S $P(^TMP($J,"PTCTS",DIV),"^",1)=$P(^TMP($J,"PTCTS",DIV),"^",1)+1
 S $P(^TMP($J,"PTCTS",DIV),"^",2)=$P(^TMP($J,"PTCTS",DIV),"^",2)+PASS
 S $P(^TMP($J,"PTCTS",DIV),"^",3)=$P(^TMP($J,"PTCTS",DIV),"^",3)+AA
 S $P(^TMP($J,"PTCTS",DIV),"^",4)=$P(^TMP($J,"PTCTS",DIV),"^",4)+UA
 S $P(^TMP($J,"PTCTS",DIV),"^",5)=$P(^TMP($J,"PTCTS",DIV),"^",5)+ASIH
 S ^TMP($J,"PTCTS",DIV,TREAT,DGTS,SV)=$S($D(^TMP($J,"PTCTS",DIV,TREAT,DGTS,SV)):^TMP($J,"PTCTS",DIV,TREAT,DGTS,SV),1:0)
 S $P(^TMP($J,"PTCTS",DIV,TREAT,DGTS,SV),"^",1)=$P(^TMP($J,"PTCTS",DIV,TREAT,DGTS,SV),"^",1)+1
 S $P(^TMP($J,"PTCTS",DIV,TREAT,DGTS,SV),"^",2)=$P(^TMP($J,"PTCTS",DIV,TREAT,DGTS,SV),"^",2)+PASS
 S $P(^TMP($J,"PTCTS",DIV,TREAT,DGTS,SV),"^",3)=$P(^TMP($J,"PTCTS",DIV,TREAT,DGTS,SV),"^",3)+AA
 S $P(^TMP($J,"PTCTS",DIV,TREAT,DGTS,SV),"^",4)=$P(^TMP($J,"PTCTS",DIV,TREAT,DGTS,SV),"^",4)+UA
 S $P(^TMP($J,"PTCTS",DIV,TREAT,DGTS,SV),"^",5)=$P(^TMP($J,"PTCTS",DIV,TREAT,DGTS,SV),"^",5)+ASIH
 Q
