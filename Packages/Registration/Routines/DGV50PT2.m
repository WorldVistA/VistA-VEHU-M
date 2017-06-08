DGV50PT2 ;ALB/RMO - DG POST-INIT FOR VERSION 5.0 CONT. (MAS MISC) ; 2 MAY 90 2:55 pm
 ;;MAS VERSION 5.0;
 ;
EN ;
 D WL,AB,BR,RM,GL,DIV
 Q
 ;
WL ;Ward locations...stuff G&L init date as date inactivated for inactive wards
 S DGFL=0 D DGDATE
 W !!,">>> Setting Out-of-Service Date for inactive wards and"
 W !?4,"wards with beds out of service to " S Y=DGDATE X ^DD("DD") W Y
 W !!?10,"Wards changed:"
 F DGI=0:0 S DGI=$O(^DIC(42,DGI)) Q:'DGI  I $D(^(DGI,0)) S DGX0=^(0),DGBOOS=$P(DGX0,"^",5),DGWOOS=$S('$D(^("I")):0,1:$P(^("I"),U)="I") I DGWOOS!DGBOOS D SET
 I 'DGFL W "  No wards were changed" G WLQ
 W !!?4,"The following responses were stuffed for these entries:"
 W !?10,"REASON:                         OTHER REASONS"
 W !?10,"DISPLAY OOS ON G&L:             YES (for Entire Wards OOS only)"
 ;W !?10,"OOS DISPLAY END DATE:           XXXXXX"
 ;W !?10,"SHOW ON BED STATUS REPORT:      YES"
 ;W !?10,"INCLUDED STAT'S ON BED STATUS:  NO"
 ;W !?10,"BED STATUS DISPLAY END DATE:    XXXXX"
 W !!?4,"If you would like to change the data entered, please use the"
 W !?4,"'Edit Ward Out-of-Service Dates' option on the 'ADT System"
 W !?4,"Definition Menu'."
WLQ K DA,DGDATE,DGFL,DGI,DGNEW,DGX0,DIC,DIE,DLAYGO,DR,X,Y,DGBOOS,DGWOOS Q
 ;
AB ; -- set auth beds
 D DGDATE
 W !!,">>> Setting the Authorized Beds Date for all wards to " S Y=DGDATE X ^DD("DD") W Y
 F DGI=0:0 S DGI=$O(^DIC(42,DGI)) Q:'DGI  I $D(^(DGI,0)) S DGX0=^(0) D SETAUTH
 K DA,DGDATE,DGI,DGX0,DIC,DIE,DLAYGO,DR,X,Y
 Q
 ;
SET ;for wards which are inactive or have beds oos,
 ;set G&L init date as out-of-service date
 S DGNEW=1 S:'$D(^DIC(42,DGI,"OOS",0)) ^(0)="^42.08D^^"
 S DA(1)=DGI,X=DGDATE,DLAYGO=42.08,DIC(0)="L",(DIC,DIE)="^DIC(42,DGI,""OOS""," D ^DIC S DA(1)=DGI,DA=+Y
 S DR=".02////6;.06////"_$S(DGWOOS:1,1:"0;.11////"_DGBOOS) D ^DIE
 S DGFL=1
 W !?20,$E($P(DGX0,U),1,30),"  ",?55,$S(DGWOOS:"-- Entire Ward",1:"-- "_DGBOOS_" Beds")
 ;K DA S DA=DGI,DIE="^DIC(42,",DR="900///@" D ^DIE
 ;Need add'l info for G&L values to be stuffed
 Q
 ;
SETAUTH ;for all wards, set the number of authorized beds in the AUTHORIZED
 ;BEDS DATE multiple as of the date chosen to in init the G&L
 I '$D(^DIC(42,DGI,"AUTH",0)) S ^(0)="^42.09D^^"
 S DA(1)=DGI,X=DGDATE,DLAYGO=42.09,DIC(0)="L",(DIC,DIE)="^DIC(42,DGI,""AUTH""," D ^DIC S DA(1)=DGI,DA=+Y,DR="2////"_+$P(DGX0,"^",6) D ^DIE
 Q
 ;
DGDATE ; -- get gl init date
 S X=+$S($D(^DG(43,1,"GL")):^("GL"),1:0),DGDATE=$S(X<2881001:2881001,1:X)
 Q
 ;
BR ;re-index the aivdt x-ref in billing rates file.
 W !!,">>> Re-indexing ""AIVDT"" Cross-reference on the Billing Rates file (#399.5)..."
 D REDO^DGCRBR
 Q
 ;
RM ;re-index the "R" x-ref in the ward location file
 W !!,">>> Re-indexing ""R"" Cross-reference on the Ward Location file (#42)..."
 F DGI=0:0 S DGI=$O(^DIC(42,DGI)) Q:'DGI  F DGJ=0:0 S DGJ=$O(^DIC(42,DGI,2,DGJ)) Q:'DGJ  W "." S DA(1)=DGI,DA=DGJ,DIK="^DIC(42,"_DA(1)_",2,",DIK(1)=".01^R" D EN^DIK
 K DA,DGI,DGJ,DIK
 Q
 ;
 ;
GL ;stuff G&L parameters with default values
 W !!,">>> Storing default values in G&L fields in the MAS PARAMETERS file..."
 S X=$S($D(^DG(43,1,"G")):^("G"),1:"")
 S:$P(X,"^",2)']"" DR="1000.02////1"
 S:$P(X,"^",3)']"" DR=$S($D(DR):DR_";",1:"")_"1000.03////0"
 S:$P(X,"^",4)']"" DR=$S($D(DR):DR_";",1:"")_"1000.04////0"
 S:$P(X,"^",5)']"" DR=$S($D(DR):DR_";",1:"")_"1000.05////2"
 S:$P(X,"^",6)']"" DR=$S($D(DR):DR_";",1:"")_"1000.06////0"
 S:$P(X,"^",8)']"" DR=$S($D(DR):DR_";",1:"")_"1000.08////0"
 S:$P(X,"^",9)']"" DR=$S($D(DR):DR_";",1:"")_"1000.09////0"
 S DIE="^DG(43,",DA=1 D ^DIE
 K DR,DIE,DA
 Q
 ;
 ;
DIV ;create cross-reference in the med center division file
 F I=0:0 S I=$O(^DG(40.8,I)) Q:I'>0  I $D(^(I,0)) S ZNODE=^(0) S:+$P(ZNODE,"^",7) ^DG(40.8,"AD",$E($P(ZNODE,"^",7),1,30),I)=""
 K I,ZNODE Q
