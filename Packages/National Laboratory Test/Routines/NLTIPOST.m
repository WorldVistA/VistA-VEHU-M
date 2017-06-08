NLTIPOST ;DALISC/FHS - POST INIT FOR NLT"
 ;;5.254;NATIONAL LABORATORY TESTS;;SEP 21, 1995
EN ;
 Q:'$D(DIFQ)
 S LRVR=$P($T(+2),";",3,99)
 S ^XTMP("NLT","SPELL")="Spelling errors for "_LRVR
 S $P(^LAM(0),U,3)=99999
 K DIE,DIC F X="FROZEN SECTION H & E",X="WK-FROZEN SECTION H & E" S DIC=60,DIC(0)="ZXM" D ^DIC
 I Y>1,$P(Y(0),U,4)'="SP" D
 . W !,"Changing Subscript for LAB TEST { ",X," } from WKL to SP",!
 . S DA=+Y,DIE="^LAB(60,",DR="4///^S X=""SP""" D ^DIE
SPCK ;
 W !!?5,"Correcting spelling errors ",!,"X* = Duplicate entry",!
 K CK F I=1:1 S LN=$T(SPELL+I) Q:'$P(LN,";;",2)  S CK(I)=LN
 S I=0 F  S I=$O(CK(I)) Q:I<1  W $P(CK(I),";",3),?10,$P(CK(I),";",4),!
 K DIC S DIC=64,DIC(0)="XNZM"
 S II=0 F  S II=$O(CK(II)) Q:II<1  D
 . S X=$P(CK(II),";",3)_".0000",NM=$P(CK(II),";",4) D ^DIC
 . I Y<1 W !,"*** Unable to find WKLD Code [ ",X," ] in your file #64 ****",!! Q
 . ;W !,Y  W:Y>1 !,Y(0)
 . S LNX=$P(Y,U,2) I LNX'=NM S CK=1 D FILE
 W !!?15,"Spelling updates completed.",!
 S ^LAM("VR")=LRVR F I=64.2,64.21,64.22,64.3 S ^LAB(I,"VR")=LRVR
 Q
SPELL ;
 ;;81276;Phenolphthalein;
 ;;81518;X*Amiodarone;
 ;;85121;Sickle Cell;
 ;;85123;Siderocyte;
 ;;85059;Activated Clotting Time;
 ;;85061;Acanthocyte;
 ;;81012;Angiotensin Converting Enzyme;
 ;;87328;Microfilarial Ag;
 ;;STOP
FILE ;
 W !?5,"Correcting Spelling of entry ",+Y," from ",LNX," to ",NM
 S DA=+Y,RT(64,DA_",",.01)=NM
 D FILE^DIE("","RT",^XTMP("NLT","SPELL"))
 Q
