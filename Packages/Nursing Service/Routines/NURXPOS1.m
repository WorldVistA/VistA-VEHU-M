NURXPOS1 ;HISC/YLHSU-ROUTINE TO REMOVE FIELD ^DD(210,19.82) ;12/20/94
 ;;2.5;NURSING FIXES;**20,21,22,29**;DEC 20, 1994
EN1 ;DELETE THE NAME OF EVALUATOR FIELD (19.82) IN THE NURS STAFF FILE (210)
 W !!,"Deleting the * NAME OF EVALUATOR (19.82) field from NURS STAFF file..."
 S DIK="^DD(210,",DA(1)=210,DA=19.82 D ^DIK W "."
 Q
