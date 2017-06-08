DGPM5C ;ALB/MIR - MOVEMENT, ENTER/EDIT OF FACILITY MOVEMENT TYPES ; 30 JAN 90
 ;;MAS VERSION 5.0;
 ;
 ;
 K ^DG(405.1) S ^DG(405.1,0)="FACILITY MOVEMENT TYPE^405.1I^^"
 S DGCT=0 W !
 F DGI=42.1,42.3,42.2 W !,"Converting ",$S(DGI=42.1:"ADMISSION",DGI=42.3:"TRANSFER",1:"DISCHARGE")," Types" F DGJ=0:0 S DGJ=$O(^DIC(DGI,DGJ)) Q:'DGJ  D MOVE
 W !!,"Now adding new entries to your file:"
 F DGI=1:1 S DGX=$P($T(TYPES+DGI),";;",2) Q:DGX="QUIT"  I '$D(^DG(405.1,"B",$P(DGX,"^",1))) S DGCT=DGCT+1,^DG(405.1,DGCT,0)=DGX W !,"   ...",$P(DGX,"^",1)," added"
 S DIK="^DG(405.1," D IXALL^DIK
 S DIK="^DG5(1,""ME"",",DA(1)=1 D IXALL^DIK
 D DV ;place default parameters into 405.1
Q K DIK,DGCT,DGI,DGJ,DGPMDEF,DGX,I
 Q
 ;
 ;
MOVE ;move data from *type files to 405.1...store relationship in 405.9
 ; DGI = *type file number
 ; DGJ = IFN of *type file
 ; DGX = 0 node for 405.1
 ;DGCT = IFN of 405.1 and of 405.9 multiple
 ;
 Q:'$D(^DIC(DGI,DGJ,0))  S DGX=^(0)
 S DGCT=DGCT+1 W:'(DGCT#10) "."
 S ^DG(405.1,DGCT,0)=$P(DGX,"^",1)_"^"_$S(DGI=42.1:1,DGI=42.3:2,1:3)_"^"_$P(DGX,"^",7)_"^"_$P(DGX,"^",3)_"^^^"_$P(DGX,"^",8)
 S $P(^DG(405.1,0),"^",3,4)=DGCT_"^"_DGCT
 S ^DG5(1,"ME",DGCT,0)=DGJ_";"_"DIC("_DGI_",^"_DGCT
 S $P(^DG5(1,"ME",0),"^",3,4)=DGCT_"^"_DGCT
 Q
 ;
 ;
 ;
DV ;Place Default values in file 405.1
 S DGHOW="A" D DQ^DGPMDEF
 Q
 ;
 ;
TYPES ;new entries to add to 405.1
 ;;PROVIDER/SPECIALTY CHANGE^6^20^1^N^^PROVIDER/SPEC CHANGE
 ;;CHECK-IN LODGER^4^5^1^N^^CHECK-IN LODGER
 ;;CHECK-IN LODGER (OTHER FACILITY)^4^6^1^N^^CHECK-IN (OTHER)
 ;;CHECK-OUT LODGER^5^7^1^N^^LODGER CHECK-OUT
 ;;FROM UNAUTHORIZED TO AUTHORIZED ABSENCE^2^26^1^N^^FROM UAA TO AA
 ;;DISCHARGE FROM NCHU/DOM WHILE ASIH^3^47^1^N^^FROM NHCU/DOM WHILE
 ;;QUIT
