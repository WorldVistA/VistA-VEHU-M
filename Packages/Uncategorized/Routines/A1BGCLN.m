A1BGCLN ;ALB/MIR - CLEAN-UP SERVER, MAILGROUP, AND TEMPLATE ; 25 NOV 92
 ;; Version 1.0 ; PATIENT ADDRESS COLLECTION ;; 20-NOV-92
 ;
 ;
 ;  This routine will remove the A1BG-PAC-SERVER server option
 ;  and the A1BG PAC NOTIFICATION mail group.  It will also
 ;  instruct the site to delete the A1BG* routines.
 ;
 ;  ***NOTE***
 ;  This should only be run once a confirmation message has been
 ;  received from the Albany ISC indicating that data has been
 ;  received from your server!
 ;
 W !!,">>>This routine will remove the A1BG server, mailgroup, and input template",!?4,"from your system."
 S DA=$O(^DIC(19,"B","A1BG-PAC-SERVER",0)) I $G(^DIC(19,+DA,0))]"" W !!,">>>Removing the A1BG-PAC-SERVER option..." S DIK="^DIC(19," D ^DIK
 ;
 S DA=$O(^XMB(3.8,"B","A1BG PAC NOTIFICATION",0)) I $G(^XMB(3.8,+DA,0))]"" W !!,">>>Removing the A1BG PAC NOTIFICATION mail group..." S DIK="^XMB(3.8," D ^DIK
 ;
 W !!,"ALL DONE!  You should now delete all A1BG* routines from your system."
 ;
 K DA,DIK,X,Y
 Q
