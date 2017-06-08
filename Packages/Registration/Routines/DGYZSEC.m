DGYZSEC ;ALB/RMO - Check Security Log for Invalid Pointers ; 16 AUG 91 9:00 am
 ;;MAS VERSION 5.0;;**11**;
EN S DGSD=7089598.9999,DGCT=0 ;inverse date of 4/1/91 (when distributed)
 F DGDT=0:0 S DGDT=$O(^DGSL(38.1,"AD",DGDT)) Q:'DGDT!(DGDT>DGSD)  F DFN=0:0 S DFN=$O(^DGSL(38.1,"AD",DGDT,DFN)) Q:'DFN  I $D(^DGSL(38.1,DFN,"D",DGDT,0)),'$P(^(0),"^",3) S X=$P(^(0),"^",3) I X]"" D SET
 K DFN,DGCT,DGDT,DGSD,X,Y Q
 ;
SET S Y=+$O(^DIC(19,"B",X,0)),DGCT=DGCT+1
 S $P(^DGSL(38.1,DFN,"D",DGDT,0),"^",3)=$S($D(^DIC(19,Y,0)):Y,1:"")
 W:'(DGCT#100) "."
 Q
