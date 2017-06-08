PRCHIDS ;WISC/AKS - fixing vendor file ;
 ;;5.0;IFCAP;**98**;4/21/95
 QUIT
EN ;deleting extra ID nodes and deleting field 5.4
 ;
 N OK,DIK,DA
 I '$D(^DD(440,0,"ID",5)) D  Q:$D(OK)
 . I '$D(^DD(440,0,"ID",5.4)) D
 .. I '$D(^DD(440,0,"ID","Z.001")) D
 ... I '$D(^DD(440,5.4,0)) S OK=1 W !,"Your vendor file checked out ok.",!,"No action necessary!!!"
 I $D(^DD(440,5.4,0)) D
 . S DIK="^DD(440,",DA=5.4,DA(1)=440 D ^DIK K DIK,DA
 . W "Please verify FEDERAL SOURCE data in your VENDOR file."
 I $D(^DD(440,0,"ID",5.4)) K ^DD(440,0,"ID",5.4)
 I $D(^DD(440,0,"ID",5)) K ^DD(440,0,"ID",5)
 I $D(^DD(440,0,"ID","Z.001")) K ^DD(440,0,"ID","Z.001")
 QUIT
