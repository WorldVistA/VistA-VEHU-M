%ZZAP ; ;1/31/97  12:16 ;
 ;;1.9;
 ;
 I $D(DTIME)=0 D ^XUP
 D INTRO   ; Introduction to the program
NMSP D GETNMSP ; Prompt for the namespace
 I ZZNMSP["^"!(%=-1) G END
 I ABC'=1 G END ; ABC holds the value of the variable %
 I STARTNO["^" G END
 I ENDNO["^" G END
BULL D DELBULL ; Delete bulletins
 I %=-1 G END
OPTS D DELOPTS ; Delete options
 I %=-1 G END
PTRS D DGLPTRS ; Delete pointers
HELP D DELHELP ; Delete help frames
 I %=-1 G END
HPTR D DGLHPTR ; Delete help frame pointers
LTMP D DELTEMP ; Delete List Templates
 I %=-1 G END
PROT D DELPROT ; Delete protocols
 I %=-1 G END
FUNC D DELFUNC ; Delete functions
 I %=-1 G END
KEYS D DELKEYS ; Delete security keys
 I %=-1 G END
PKG D DELPKG  ; Delete package name
 I %=-1 G END
RTNS D DELRTN  ; Delete routines
 I %=-1 G END
BUILD D DELBLD  ; Delete package entry in KIDS BUILD file - ^XPD(9.6
 I %=-1 G END
INSTALL W !,"If this was a KIDS install you will need to delete the package entry in",!,"the KIDS INSTALL file - ^XPD(9.7",!
 D END
 Q
 ; CHANGE THIS INTRO MESSAGE TO INCLUDE PROTOCOLS
INTRO W !,?15,"WELCOME TO ZZAP!! This is version 1.9 dated 1/31/97.",!
 W !,?10,"This program allows you to remove the following elements for a"
 w !,?5,"package:  DDs, options, templates, list manager templates, help frames,"
 w !,?5,"bulletins, protocols, security keys, functions, routines, entries in the"
 w !,?5,"package file, and clean up dangling pointers in the option and help frame"
 w !,?5,"files.  You may leave the data if you wish."
 w !!,?5,"It does NOT remove orders in OE/RR and does NOT account for any changes"
 w !,?5,"made to foreign structures."
 Q
GETNMSP ;
 S (ZZNMSP,ZX)="" R !!,"Enter namespace of package: ",ZZNMSP:DTIME Q:ZZNMSP["^"
 ; % values    -1 = ^   0 = <RET> or ?   1 = YES   2 = NO
 I ZZNMSP="" S %=2 R !!,"Do you want to continue without entering a package name" D YN^DICN Q:%=-1  G:%=2 GETNMSP
 S %=2 R !!,"Do you want to delete DDs, templates, and/or data" D YN^DICN S ABC=% Q:%'=1
 ; the value of % in the previous line needs to be put into another variable because the DIU2 routine in NMSPLOOP also uses % as a variable and messes up its value
 R !!,"Enter starting file number:  ",STARTNO:DTIME Q:STARTNO["^"
 R !!,"Enter ending file number:  ",ENDNO:DTIME Q:ENDNO["^"
 R !!,"Do you want to keep data:  ",ZZDATA:DTIME I ZZDATA["N" S DIU(0)="DET" G NMSPLOOP
 S DIU(0)="ET"
NMSPLOOP F ZI=STARTNO-.000000001:0 S ZI=$O(^DIC(ZI)) Q:ZI>ENDNO  S DIU=^DIC(ZI,0,"GL") W !,DIU D EN^DIU2
 Q
DELBULL ;
 S %=1 R !!,"Do you want to delete bulletins" D YN^DICN Q:%'=1
 W !!,"Deleting bulletins...",!
 S DIK="^XMB(3.6," F ZI=0:0 S ZI=$O(^XMB(3.6,ZI)) Q:ZI'?.N  S ZNODE=^XMB(3.6,ZI,0) I $E(($P(ZNODE,"^",1)),1,$L(ZZNMSP))[ZZNMSP S DA=ZI W !,$P(ZNODE,"^",1) D ^DIK
 W !!,"Bulletins deleted." Q
DELOPTS ;
 S %=1 R !!,"Do you want to delete options" D YN^DICN Q:%'=1
 W !!,"Deleting options...",!
 S DIK="^DIC(19,",ZI="" F ZI=0:0 S ZI=$O(^DIC(19,ZI)) Q:ZI'?.N!(ZI="")  I $D(^DIC(19,ZI,0)) S ZNODE=^DIC(19,ZI,0) I $E(($P(ZNODE,"^",1)),1,$L(ZZNMSP))[ZZNMSP S DA=ZI W !,$P(ZNODE,"^",1) D ^DIK
 W !!,"Options deleted." Q
DGLPTRS ;
 S %=1 D ENASK^XQ3 Q
DELHELP ;
 S %=1 R !!,"Do you want to delete HELP FRAMES" D YN^DICN Q:%'=1
 W !!,"Deleting HELP FRAMES...",!
 S DIK="^DIC(9.2,",ZI="" F ZI=0:0 S ZI=$O(^DIC(9.2,ZI)) Q:ZI'?.N!(ZI="")  I $D(^DIC(9.2,ZI,0)) S ZNODE=^DIC(9.2,ZI,0) I $E(($P(ZNODE,"^",1)),1,$L(ZZNMSP))[ZZNMSP S DA=ZI W !,$P(ZNODE,"^",1) D ^DIK
 W !!,"HELP FRAMES deleted." Q
DGLHPTR ;
 S %=0 D ENASK^XQ3 Q
DELTEMP ;
 S %=1 R !!,"Do you want to delete LIST MANAGER TEMPLATES" D YN^DICN Q:%'=1
 W !!,"Deleting LIST MANAGER TEMPLATES...",!
 S DIK="^SD(409.61,",ZI="" F ZI=0:0 S ZI=$O(^SD(409.61,ZI)) Q:ZI'?.N!(ZI="")  I $D(^SD(409.61,ZI,0)) S ZNODE=^SD(409.61,ZI,0) I $E(($P(ZNODE,"^",1)),1,$L(ZZNMSP))[ZZNMSP S DA=ZI W !,$P(ZNODE,"^",1) D ^DIK
 W !!,"LIST MANAGER TEMPLATES deleted." Q
DELPROT ;
 S %=1 R !!,"Do you want to delete protocols" D YN^DICN Q:%'=1
 W !!,"Deleting protocols...",!
 S DIK="^ORD(101,",ZI="" F ZI=0:0 S ZI=$O(^ORD(101,ZI)) Q:ZI'?.N!(ZI="")  I $D(^ORD(101,ZI,0)) S ZNODE=^ORD(101,ZI,0) I $E(($P(ZNODE,"^",1)),1,$L(ZZNMSP))[ZZNMSP S DA=ZI W !,$P(ZNODE,"^",1) D ^DIK
 W !!,"Protocols deleted." Q
DELFUNC ;
 S %=1 R !!,"Do you want to delete functions" D YN^DICN Q:%'=1
 W !!,"Deleting functions...",!
 S DIK="^DD(""FUNC"",",ZI="" F ZI=0:0 S ZI=$O(^DD("FUNC",ZI)) Q:ZI<0!(ZI'?.N)  S ZNODE=^DD("FUNC",ZI,0) I $E(($P(ZNODE,"^",1)),1,$L(ZZNMSP))[ZZNMSP S DA=ZI W !,$P(ZNODE,"^",1) D ^DIK
 W !!,"Functions deleted." Q
DELKEYS ;
 S %=1 R !!,"Do you want to delete security keys" D YN^DICN Q:%'=1
 W !!,"Deleting security keys...",!
 S DIK="^DIC(19.1,",ZI="" F ZI=0:0 S ZI=$O(^DIC(19.1,ZI)) Q:ZI'?.N  S ZNODE=^DIC(19.1,ZI,0) I $E(($P(ZNODE,"^",1)),1,$L(ZZNMSP))[ZZNMSP S DA=ZI W !,$P(ZNODE,"^",1) D ^DIK
 W !!,"Security keys deleted." Q
DELPKG ;
 W $C(7),!!,"Do NOT delete any package that has orders placed through OE/RR.",!,"If you delete the package entry and leave the data you will have",!,"broken pointers."
 S %=1 R !!,"Do you want to delete PACKAGE file entries" D YN^DICN Q:%'=1
 S DIC="^DIC(9.4,",DIC(0)="MQEA" D ^DIC Q:X=""
 W !!,"To delete the package, type '@', then press <RETURN>.",!
 S DIE=DIC,DA=+Y,DR=".01//@" D ^DIE G PKG
DELRTN ;
 I ^%ZOSF("OS")["VAX" D ^%RPURGE
 I ^%ZOSF("OS")["MSM" D ^%RDEL
 Q
DELBLD ;
 S %=1 R !!,"Do you want to delete KIDS BUILD file entries" D YN^DICN Q:%'=1
 S DIC="^XPD(9.6,",DIC(0)="MQEA" D ^DIC Q:X=""
 W !!,"To delete the package, type '@', then press <RETURN>.",!
 S DIE=DIC,DA=+Y,DR=".01//@" D ^DIE G BUILD
END ;
 K ZI,ZNODE,ZZNMSP,DIU,DIU(0),STARTNO,ENDNO,ZZDATA,DIK,ZX Q
