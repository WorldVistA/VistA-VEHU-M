NLTIPRE ;DALISC/FHS - PRE-INIT FOR NLT INITS
 ;;5.254;NATIONAL LABORATORY TESTS;;SEP 21, 1995
EN1 ;
 Q:'$D(DIFQ)
 N DIC,DIE,DA,DR,Y,X,DIK
 S DIC=64,DIC(0)="NM",X="88592.0000",U="^" D ^DIC I Y<1 K DIC D
 . S DIE="^LAM(",DA=1476,DR=".01///^S X=""Screen Cyto Tech. Interp. Sp. St. Cell Prod."";1///^S X=""88592.0000"";6///^S X=""SLIDE"";13///^S X=""Cytology"""
 . D ^DIE
 . W !!?5,"Added -- Screen Cyto Tech. Interp. Sp. St. Cell Prod. [88592.0000]",!
 . W !!,"This WKLD code is not included in the Init Routine Set.",!
END ;
 K DA,DIK
 S $P(^LAM(0),U,3)=1881,DIK="^DD(64,",DA(1)=64,DA=14 D ^DIK
 W !!,"Pre Init completed -- Starting init process ",!!
 Q
