DGV52PT2 ;ALB/MTC - DG POST INIT FOR MAS 5.2 CONT ; 4/3/92
 ;;5.2;REGISTRATION;;JUL 29,1992
 ;
EN ;
 D DDCLN,HNY,PTYPE
 Q
 ;
DDCLN ;delete *'d fields in various files
 ;
 W !!,">>> Removing fields from various MAS files..."
 S DIK="^DD(43,",DA(1)=43 F DA=59,60 I $D(^DD(43,DA,0)) W !,"   ...Deleting ",$P(^(0),"^",1)," field from MAS PARAMETERS file" D ^DIK
 S DIK="^DD(42,",DA(1)=42 F DA=.04,.05,.055,.06,.08,301,305,501,900,1401:1:1404 I $D(^DD(42,DA,0)) W !,"   ...Deleting ",$P(^(0),"^",1)," field from WARD LOCATION file" D ^DIK
 I $D(^DD(42.04)) W !,"   ...Deleting *NURSING multiple from WARD LOCATION file" S DIU=42.04,DIU(0)="S" D EN^DIU2
 ;I $D(^DD(81.066)) W !,"   ...Deleting *BLOOD COMPONENT REQUEST multiple from CPT file" S DIU=81.066,DIU(0)="S" D EN^DIU2
 ;S DIK="^DD(42.702,",DA(1)=42.702 F DA=19,20 I $D(^DD(42.702,DA,0)) W !,"   ...Deleting ",$P(^(0),"^",1)," field from DIVISION multiple of the",!?6,"AMIS 345&346 file" D ^DIK
 ;S DIK="^DD(42.61,",DA(1)=42.61 F DA=14:1:16 I $D(^DD(42.61,DA,0)) W !,"   ...Deleting ",$P(^(0),"^",1)," field from DIVISION multiple of the",!?6,"AMIS 334-341 file" D ^DIK
 ;
 ;data clean-up
 ;
 W !!,">>> Removing data for above listed fields.  Please be patient..."
 W !,"   Now removing data from the WARD LOCATION file"
 K ^DIC(42,"DA") ;remove cross-reference
 F IFN=0:0 S IFN=$O(^DIC(42,IFN)) Q:'IFN  D WARDCLN I '(IFN#20) W "."
 W !,"   Removing data from MAS PARAMETERS file..." I $D(^DG(43,1,"GLS")) S $P(^("GLS"),"^",9,10)="^"
 K DA,DIK,DIU,IFN,X
 Q
 ;
WARDCLN ;clean-up data for removed fields
 I $D(^DIC(42,IFN,0)) S X=^(0),$P(X,"^",4,6)="^^",$P(X,"^",8)="",$P(X,"^",13)="",^(0)=X
 I $D(^DIC(42,IFN,"AQ")) K ^("AQ")
 I $D(^DIC(42,IFN,"AQC")) K ^("AQC")
 I $D(^DIC(42,IFN,"BRANCH")) K ^("BRANCH")
 I $D(^DIC(42,IFN,"DA")) K ^("DA")
 I $D(^DIC(42,IFN,"I")) K ^("I")
 I $D(^DIC(42,IFN,"SUB")) K ^("SUB")
 Q
 ;
 ;
HNY ;honeywell and AMIS 331 clean-up
 ;
 W !!,">>> Now removing honeywell and AMIS 331 files..."
 S DIU(0)="DT" F DGFILE=42.9,43.2,43.21 S DIU=DGFILE,X=$O(^DD(DIU,0,"NM",0)) I X]"" W !,"   Removing ",X," file (#",DIU,")..." D EN^DIU2
 K DA,DIK,DIU,DGFILE,IFN,X
 Q
 ;
 ;
PTYPE ;Update patient type file with new changes
 ;
 W !!,">>> Now updating PATIENT TYPE file..."
 F I=1:1 S X=$P($T(PT+I),";;",2) Q:X="QUIT"  S TYPE($P(X,"^",1))=$P(X,"^",2)
 F IFN=0:0 S IFN=$O(^DG(391,IFN)) Q:'IFN  I $D(^DG(391,IFN,0)),($P(^(0),"^",5)']"") S DGNAME=$P(^(0),"^",1) D VET I $P(^DG(391,IFN,0),"^",5) S $P(^("S"),"^",8)=1
 K DGNAME,I,IFN,TYPE,X
 Q
 ;
VET ;update the VETERAN? field with given value
 ;
 K X I $D(^DG(391,IFN,"S")) S X=^("S"),$P(^("S"),"^",9)=$P(X,"^",7) ;screen 7 moved to screen 9
 I $D(X) S $P(^DG(391,IFN,"S"),"^",10,11)=$P(X,"^",9,10) ;screens 9 and 10 moved to 10 and 11
 K X I $D(^DG(391,IFN,"E")) S X=^("E"),$P(^("E"),"^",74)=$P(X,"^",83) ;and screen 8 moved to screen 7
 I $D(X) S $P(^DG(391,IFN,"E10"),"^",1,2)=$P(X,"^",91,92) ; and screen 9 moved to screen 10
 I DGNAME]"",$D(TYPE(DGNAME)) S $P(^DG(391,IFN,0),"^",5)=TYPE(DGNAME) Q
 S $P(^DG(391,IFN,0),"^",5)=1 ;if not on list, set VETERAN? to yes
 Q
 ;
PT ;patient types for update
 ;;SC VETERAN^1
 ;;ALLIED VETERAN^0
 ;;MILITARY RETIREE^0
 ;;ACTIVE DUTY^0
 ;;COLLATERAL^0
 ;;EMPLOYEE^0
 ;;NSC VETERAN^1
 ;;NON-VETERAN (OTHER)^0
 ;;QUIT
 ;
 ;
MVTYP ;update files 405.1 and 405.2 to disallow FROM AA TO UA transfer from
 ;following TO AA<96 (pass) transfer
 ;
 W !!,">>> Removing TO AUTHORIZED ABSENCE <96 HRS from the CAN ONLY FOLLOW MOVEMENT(S)",!?3,"multiple for FROM AUTH TO UNAUTH ABSENCE in file 405.1..."
 F DGX=0:0 S DGX=$O(^DG(405.1,"AM",1,DGX)) Q:'DGX  S DG1(DGX)=""
 F DGX=0:0 S DGX=$O(^DG(405.1,"AM",25,DGX)) Q:'DGX  F DGY=0:0 S DGY=$O(DG1(DGY)) Q:'DGY  I $D(^DG(405.1,DGX,"F",DGY)) S DA(1)=DGX,DA=DGY,DIK="^DG(405.1,"_DGX_",""F""," D ^DIK
 W !!,">>> Now making same change in file 405.2..."
 S DA(1)=25,DA=1,DIK="^DG(405.2,25,""F""," D ^DIK
 K DA,DG1,DGX,DGY,DIK
 Q
 ;
