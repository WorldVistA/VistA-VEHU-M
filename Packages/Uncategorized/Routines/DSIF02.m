DSIF02 ;DSS/RED - PRE INSTALL P2 ;12/02/2011
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**2**;Dec 2, 2011;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; ICR's
 ;   2051  FIND^DIC
 ;   2053  FILE^DIE
 ;
 Q
PRE ;pre-install  DSIF*3.2*2
 ;reset the RPC's: DSIF INP EDIT ROC, DSIF BATCH EDIT
 ;There are input parameters that need to be deleted cleanly
 ;Then in the patch 2 install we recreate this pre-existing RPC
 ;
 N MSG,DSDA,DSFDA,DSIFRPC S MSG="" F DSIFRPC="DSIF INP EDIT ROC","DSIF BATCH EDIT" D
 . D MES^XPDUTL("<<< Deleting the RPC: "_DSIFRPC_", it is rebuilt during the install >>>")
 . S DSDA=$$FIND1^DIC(8994,,,DSIFRPC)
 . Q:'DSDA
 . S DSFDA(8994,DSDA_",",".01")="@" D FILE^DIE(,"DSFDA","MSG")
 . I $G(MSG)'=""  D MES^XPDUTL("<<< The pre-install encountered an error! >>>") Q
 . D MES^XPDUTL("<<< The RPC: "_DSIFRPC_" deleted properly, will be rebuilt in the install >>>")
 Q
 ;
