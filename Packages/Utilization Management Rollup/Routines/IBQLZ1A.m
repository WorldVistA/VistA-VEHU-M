IBQLZ1A ;ALB/CPM - ALTERNATE CONVERSION FOR FILE 356.1 ; 08-NOV-95
 ;;NOT for General Distribution.
 ;
 ;
ACDD ; Alternate conversion for the UM ROLLUP v1.0 installation.
 ;
 ; Update the new field ACUTE CARE DISCHARGE DATE (#1.09) in
 ; the CLAIMS TRACKING (#356) file with values from the
 ; ACUTE CARE DISCHARGE DATE (#1.17) field from the HOSPITAL
 ; REVIEW (#356.1) file.
 ;
 ;
 W !!,"Updating field #1.09 in the CLAIMS TRACKING (#356) file..."
 ;
 S IBTRV=0 F  S IBTRV=$O(^IBT(356.1,IBTRV)) Q:'IBTRV  D
 .;
 .; - find the Acute Care Discharge Date
 .S IBQACDD=$P($G(^IBT(356.1,IBTRV,1)),"^",17)
 .Q:'IBQACDD
 .;
 .; - find the corresponding Claims Tracking entry
 .S IBTRN=$P($G(^IBT(356.1,IBTRV,0)),"^",2)
 .Q:'IBTRN  Q:'$G(^IBT(356,IBTRN,0))
 .;
 .; - update field #1.09 in file #356
 .S DIE="^IBT(356,",DA=IBTRN,DR="1.09////"_IBQACDD D ^DIE
 ;
 ;
 K DA,DR,DIE,IBQACDD,IBTRN,IBTRV
 Q
