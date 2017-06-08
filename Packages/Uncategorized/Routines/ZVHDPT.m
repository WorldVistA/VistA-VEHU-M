ZVHDPT ;DALOI/RM - ADD NEW PAITENTS
 ;Nothing to see here, move along.
 W !,"Enter at a label, not at the top"
 Q
ICN(SSN) ;
 ;F I=1:1:12 S SSN=$E("000001000",1,(9-$L(I)))_I 
 I $D(^DPT("SSN",SSN)) S DA=$O(^DPT("SSN",SSN,"")) D
  . ;F I=412741:1:412790 S DA=I D
  . S ICN=$P($G(^DPT(DA,"MPI")),"^") Q:'ICN
  . ;Q:$E($P(^DPT(DA,0),"^"),1,9)'="VBPATIENT"
  . S VBECFDA(2,DA_",",991.01)="100"_$E(ICN,4,99)
  . W !,"Before: ",$P(^DPT(DA,0),"^"),"     ",$P(^DPT(DA,"MPI"),"^")
  . D FILE^DIE(,"VBECFDA","VBERR")
  . I $D(DIERR) W !,"An error occurred filing """,$P(^DPT(DA,0),"^"),""" Please review the entry",!!! ZW VBERR W !!!,"Press any key to continue" R *TA K DIERR
  . W !,"After : ",$P(^DPT(DA,0),"^"),"     ",$P(^DPT(DA,"MPI"),"^")
  . W !!
 Q
TEST ;
 F I=151:1:186 S A=$E("000000000",1,(9-$L(I)))_I W !,A I $D(^DPT("SSN",A)) W " - EXISTS" D
  . S B=0 F  S B=$O(^DPT("SSN",A,B)) Q:'B  W !?15,$P(^DPT(B,0),"^")
 Q
CREATE ;
 F I=1:1:10  S VBDATA=$P($T(LST+I),";;",2) D
  . I $D(^DPT("SSN",$TR($P(VBDATA,"^",2),"-",""))) W !,"SSN ",$P(VBDATA,"^",2)," already exists." Q
  . S VBECFDA(2,"+1,",.01)=$P(VBDATA,"^",1)
  . S VBECFDA(2,"+1,",.02)="M"
  . S VBECFDA(2,"+1,",.03)="4/7/35"
  . S VBECFDA(2,"+1,",.05)="MARRIED"
  . S VBECFDA(2,"+1,",.09)=$P(VBDATA,"^",2)
  . S VBECFDA(2,"+1,",.12105)="N"
  . S VBECFDA(2,"+1,",.14105)="N"
  . S VBECFDA(2,"+1,",.2125)="N"
  . S VBECFDA(2,"+1,",.21925)="N"
  . S VBECFDA(2,"+1,",.2515)="1"
  . S VBECFDA(2,"+1,",.301)="N"
  . S VBECFDA(2,"+1,",.31115)="1"
  . S VBECFDA(2,"+1,",.3192)="Y"
  . S VBECFDA(2,"+1,",.32101)="Y"
  . S VBECFDA(2,"+1,",.32102)="N"
  . S VBECFDA(2,"+1,",.32103)="N"
  . S VBECFDA(2,"+1,",.32201)="N"
  . S VBECFDA(2,"+1,",.322013)="N"
  . S VBECFDA(2,"+1,",.322016)="N"
  . S VBECFDA(2,"+1,",.3221)="N"
  . S VBECFDA(2,"+1,",.3224)="N"
  . S VBECFDA(2,"+1,",.3227)="N"
  . S VBECFDA(2,"+1,",.3285)="N"
  . S VBECFDA(2,"+1,",.32945)="N"
  . S VBECFDA(2,"+1,",.3305)="Y"
  . S VBECFDA(2,"+1,",.3405)="Y"
  . S VBECFDA(2,"+1,",.362)="0"
  . S VBECFDA(2,"+1,",.381)="0"
  . S VBECFDA(2,"+1,",.382)="10/1/05"
  . S VBECFDA(2,"+1,",.525)="N"
  . S VBECFDA(2,"+1,",.5291)="N"
  . S VBECFDA(2,"+1,",391)="NSC VETERAN"
  . S VBECFDA(2,"+1,",401.4)="10/1/05"
  . S VBECFDA(2,"+1,",1010.15)="Y"
  . S VBECFDA(2,"+1,",1901)="Y"
  . S VBECFDA(2,"+1,",994)="N"
  . ;S VBECFDA(2.03,"+2,+1,",.01)=$P(VBDATA,"^",6)
  . D UPDATE^DIE("EU","VBECFDA",,"VBERR")
  . I $D(DIERR) W !,"An error occurred filing """,$P(VBDATA,"^"),""" Please review the entry",!!! ZW VBERR W !!!,"Press any key to continue" R *TA K DIERR
  . W !,"Patient "_$P(VBDATA,"^")_" Created Successfully"
  . D ICN($TR($P(VBDATA,"^",2),"-",""))
  . Q
WF ;Warm Fuzzy
 S WF=$G(WF)+1 S:WF>4 WF=1 W $S(WF=1:"|",WF=2:"/",WF=3:"-",1:"\"),*13 Q
END ;
 Q
UALERT ;;NAME^SSN
 ;;UserAlerts, Nine^666-00-0009
 ;;UserAlerts, Ten^666-00-0010
 ;;UserAlerts, Eleven^666-00-0011
 ;;UserAlerts, Twelve^666-00-0012
 Q
MERGEPAT ;;NAME^SSN
 ;;Merge, One^000-00-1001
 ;;Merge, Two^000-00-1002
 ;;Merge, Three^000-00-1003
 ;;Merge, Four^000-00-1004
 ;;Merge, Five^000-00-1005
 ;;Merge, Six^000-00-1006
 ;;Merge, Seven^000-00-1007
 ;;Merge, Eight^000-00-1008
 ;;Merge, Nine^000-00-1009
 ;;Merge, Ten^000-00-1010
 ;;Merge, Eleven^000-00-1011
 ;;Merge, Twelve^000-00-1012
 Q
LST ;;NAME^SSN      
 ;;BHIEPATIENT,A ONE^000001101
 ;;BHIEPATIENT,B TWO^000007937
 ;;BHIEPATIENT,C THREE^000002651
 ;;BHIEPATIENT,D FOUR^000001058
 ;;BHIEPATIENT,E FIVE^000009260
 ;;BHIEPATIENT,F SIX^000002679
 ;;BHIEPATIENT,G SEVEN^000002389
 ;;BHIEPATIENT,H EIGHT^000005231
 ;;BHIEPATIENT,I NINE^000000473
 ;;BHIEPATIENT,J TEN^000004131
 
 
