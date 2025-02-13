SD53111P ;ALB/ABR - SD*5.3*111 POST-INSTALL; 4/2/97
 ;;5.3;Scheduling;**111**;Aug 13, 1993
 ;
EN ; This routine will delete the DD and data for files 
 ; 409.71, 409.72, 409.81, 409.82, 409.3, and 40.6
 ;
 ;
 D BMES^XPDUTL("The data, data dictionary, and associated templates will be deleted"),MES^XPDUTL("for the following files:")
 D MES^XPDUTL("  409.71 - AMBULATORY PROCEDURE"),MES^XPDUTL("  409.72 - AMBULATORY PROCEDURE TIME SENSITIVE")
 D MES^XPDUTL("  409.3 - AMBULATORY PROCEDURE GROUPS"),MES^XPDUTL("  409.81 - RAM GROUP"),MES^XPDUTL("  409.82 - RAM REIMBURSEMENT")
 D MES^XPDUTL("  40.6 - AMBULATORY SURGERY PROCEDURE")
 ;
 D DELDD
 D BMES^XPDUTL(">>> FILE DELETIONS COMPLETE.")
 Q
 ;
DELDD ;  file deletions
 N DIU
 S DIU="^SD(409.71,",DIU(0)="DT" D EN^DIU2 K DIU
 D BMES^XPDUTL("File #409.71, AMBULATORY PROCEDURE, has been deleted")
 S DIU="^SD(409.72,",DIU(0)="DT" D EN^DIU2 K DIU
 D MES^XPDUTL("File #409.71, AMBULATORY PROCEDURE TIME SENSITIVE, has been deleted")
 S DIU="^SD(409.3,",DIU(0)="DT" D EN^DIU2 K DIU
 D MES^XPDUTL("File #409.3, AMBULATORY PROCEDURE GROUPS, has been deleted")
 S DIU="^SD(409.81,",DIU(0)="DT" D EN^DIU2 K DIU
 D MES^XPDUTL("File #409.81, RAM GROUP has been deleted")
 S DIU="^SD(409.82,",DIU(0)="DT" D EN^DIU2 K DIU
 D MES^XPDUTL("File #409.81, RAM REIMBURSEMENT has been deleted")
 S DIU="^DIC(40.6,",DIU(0)="DT" D EN^DIU2 K DIU
 D MES^XPDUTL("File #40.6, AMBULATORY SURGERY PROCEDURE has been deleted")
 Q
 ;
