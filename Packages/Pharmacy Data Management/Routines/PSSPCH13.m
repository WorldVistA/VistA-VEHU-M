PSSPCH13 ;BIR/WRT-PATCH ROUTINE ; 07/06/98 10:24
 ;;1.0;PHARMACY DATA MANAGEMENT;**13**;9/30/97
 S DIK="^DD(50,",DA=23,DA(1)=50 D ^DIK
 S DIK="^DD(50,",DA=24,DA(1)=50 D ^DIK
 ;
DEL ;Delete bogus field from "ID" node.
 I '$D(^DD(50,534016)) K ^DD(50,0,"ID",534016)
 Q
