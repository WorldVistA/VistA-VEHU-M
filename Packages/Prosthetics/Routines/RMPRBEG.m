RMPRBEG ;PHX/DWL/HNB-POST-INIT ROUTINE ;10/19/1993
 ;;2.0;PROSTHETICS;;10/19/1993
 W !!,?5,"Beginning Post Init",!!
TMP ;DELETE TEMPLATES FROM FILES 660,665,668
 F X="RMPR CLOTHING","RMPR DIS ENTRY","RMPR RETURN","RMPR SUSPENSE EDIT" S DIC="^DIE(",DIC(0)="MZ",RMPRX=X D ^DIC I +Y>0 S DA=+Y,DIK=DIC D ^DIK W !,?5,"Deleting Input Template '",RMPRX,"'" K Y,DA,DIC
 F X="RMPR PRINT SUPSENSE","RMPR PRINT STK ISU" S DIC="^DIPT(",DIC(0)="MZ",RMPRX=X D ^DIC I +Y>0 S DA=+Y,DIK=DIC D ^DIK W !,?5,"Deleting Print Template '",RMPRX,"'" K Y,DA,DIC
 F X="RMPR PRINT SUSPENSE","RMPR PRINT STK ISU" S DIC="^DIBT(",DIC(0)="MZ",RMPRX=X D ^DIC I +Y>0 S DA=+Y,DIK=DIC D ^DIK W !,?5,"Deleting Sort Template '",RMPRX,"'" K DA,Y,DIC
IND ;SET CLOTHING ALLOWANCE AND RE-INDEX 665
 I '$O(^RMPR(665,0)) G PROT
 W !!,?5,"Converting Clothing Allowance Date"
 F ZT=0:0 S ZT=$O(^RMPR(665,ZT)) Q:ZT'>0  S Y=0 D
 .I $D(^RMPR(665,ZT,0)),$P(^(0),U,8) S RMPRV=^(0) S:'$D(^RMPR(665,ZT,6,0)) ^RMPR(665,ZT,6,0)="^665.02DA^^" D
 ..I '$D(^RMPR(665,ZT,6,"B",+$P(RMPRV,U,8))) S X=$P(RMPRV,U,8),DIC(0)="L",DIC="^RMPR(665,"_ZT_",6," S DA(1)=ZT,DLAYGO=665 K DD,D0,DO D FILE^DICN K DLAYGO
 ..I $D(^RMPR(665,ZT,6,"B",+$P(RMPRV,U,8))) S Y=$O(^RMPR(665,ZT,6,"B",$P(RMPRV,U,8),0))
 .I +Y>0 S $P(^RMPR(665,ZT,6,+Y,0),U,2)=$S($P(RMPRV,U,6)["N":"N","Y":"E",1:"U"),$P(^(0),U,3)=$P(RMPRV,U,7),^(1)=$P(RMPRV,U,9)
 W !!,?5,"Re-indexing Prosthetics Patient File."
 S DIK="^RMPR(665," D IXALL^DIK W $C(7),!,?5,"Done.."
 ;DELETE DATA DICTIONARY FIELDS IN 660 AND KILL D X-REF ON 660
 K ^RMPR(660,"D") S X="S DIK=""^DD(660,"" F DA=3,42,44,69,70,72 I $D(^DD(660,DA,0)) W !,?5,""Removing Field "",DA,"" "",$P(^DD(660,DA,0),U,1),"" From file "",!,?10,$O(^DD(660,0,""NM"",0)) D ^DIK" X X
PROT ;INSTALL RMPR SCH EVENT PROTOCOL
 D ^RMPRONIT
 I $O(^DIC(669.9,0)) G GRP
 S SITE=$S($D(DUZ(2)):+DUZ(2),1:0) G:+SITE START
 I +SITE'>0 G ER1
START G:'$D(^DIC(4,SITE,0)) ER4 S RMPRA=^DIC(4,SITE,0),RMPRB=$S($D(^DIC(4,SITE,1)):^(1),1:" "),SIG="",ST=$P(^DIC(4,SITE,0),U,2)
 S STRT=$P(RMPRB,U,1)
 S CITY=$P(RMPRB,U,3),ZIP=$P(RMPRB,U,4),ART=125,WCHR=100,BRSS=75,BAS=75,PG=90,COP=90,CDP=90,VAMC=$P($P(RMPRA,U,1),",",1)_" VAMC"
 S DIC=200,DIC(0)="AEQMZ",DIC("A")="Please Enter the Prosthetics Service Chief's Name: " D ^DIC I +Y>0 S SIG=$P(Y(0,0),",",2)_" "_$P(Y(0,0),",",1)
 E  S SIG=""
 I SIG="" W $C(7),!!,"Please Contact Prosthetic Service to edit Site Parameter",!,"File and Enter Chief Signature Block. ",!
CON K DIC S X=VAMC,DLAYGO=669.9,DIC(0)="AEQLM",DIC="^DIC(669.9,",DIC("DR")="1////^S X=SITE;2////0;11////99999999" D FILE^DICN K DLAYGO G:Y<0 ER2 S RMPRIEN=+Y
 W $C(7),!!,"The Purchasing Device is the printer that Prosthetics Service will use to print",!,"10-2141 and 10-55 forms.  Enter the Purchasing Device, if known, or",!,"`return` to continue.",!
PRNT S DIC="^%ZIS(1,",DIC(0)="AEQM" D ^DIC G:X["^" ER3
 S PRN=$S(+Y>0:+Y,1:"")
 S DA=RMPRIEN,DIE="^DIC(669.9,",DR="4////^S X=STRT;5////^S X=CITY;6////^S X=ST;7////^S X=ZIP;8////^S X=SIG;9////^S X=PRN;15////^S X=ART;16////^S X=WCHR;17////^S X=BRSS;18////^S X=BAS;19////^S X=PG;20////^S X=COP;21////^S X=CDP" D ^DIE
GRP I $D(^DIC(669.9,1)),'$P(^DIC(669.9,1,0),U,7) W $C(7),!,"The AMIS Grouper has Not Been Set!",!,"YOU MUST CORRECT THIS BEFORE USING THE PROSTHETIC PACKAGE!"
 I $D(^DIC(669.9,1)),$P(^DIC(669.9,1,2),U,2)="" W !,"The Street Address is Not Defined!" S HNB=1
 I $D(^DIC(669.9,1)),$P(^DIC(669.9,1,2),U,6)="" W !,"The Prosthetics Service Chief's Name is Undefined!" S HNB=1
 I $D(^DIC(669.9,1)),+$P(^DIC(669.9,1,2),U,4)'>0 W !,"The State entry is Undefined!" S HNB=1
 I $D(HNB) W $C(7),!!,"Use the option Enter/Edit Site Parameter 'RMPR SITE PARA' to Enter/Edit the",!,"above information.  The Prosthetics Package will not run properly if the",!,"Site Parameter file is incomplete!"
 W !!,"You should review the Prosthetic Site Parameter Information by using the",!,"'RMPR SITE INQ' Site Parameter Inquiry option."
 W $C(7),!!,"If your site is multi-divisional, you may enter an additional Site, or edit an",!,"existing Site by using the Enter/Edit Site Parameter option."
EXIT K RMPRA,ART,RMPRB,BAS,BO,BRSS,CDP,CITY,COP,DA,DIC,DIE,DIR,DR,HNB,I,OUT,PG,PRN,RMPRIEN,SIG,SITE,ST,STRT,VAMC,WCHR,X,Y,ZIP,RMPRV,RMPRX,ZT
 W !!,"All Done With Post Init!" I $D(RMPRST) W !!,?5,"Installation Start Time: ",$P(RMPRST,"@",2) K RMPRST
 D NOW^%DTC S Y=% X ^DD("DD") W !!,?5,"Installation Stop Time: ",$P(Y,"@",2) Q
ER1 W !!!,"YOU MUST ENTER A DEFAULT INSTITUTION IN YOUR KERNEL SITE PARAMETERS FILE." G EXIT
ER2 W !!!,"THERE IS AN ERROR SETTING UP YOUR PROSTHETIC SITE PARAMETER FILE."
 W !,"CHECK TO SEE IF THERE IS SOME REASON WHY WE CAN'T CREATE AN ENTRY IN ^DIC(669.9." G EXIT
ER3 W $C(7),!!,"Enter the Device name if known or `return` to continue." G PRNT
ER4 W $C(7),!!,"Your Primary Site has not been entered into the Institution File" G EXIT
