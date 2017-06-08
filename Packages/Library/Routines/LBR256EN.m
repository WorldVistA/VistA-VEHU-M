LBR256EN ;SSI/KMB-ENVIRONMENT CHECK FOR LBR*2.5*6 ;[ 09/08/98  4:03 PM ]
 ;;2.5;Library;**6**;Mar 11, 1996
 ;;
 ;; This is the environment check routine for LBR*2.5*6.
 ;; It checks for the Library version 2.5 installation.
 ;;
 ;; 
ST ; confirm DUZ(0) is set to '@'
 I '$G(DUZ)!($G(DUZ(0))'["@") D  Q
 . D BMES^XPDUTL("USER 'DUZ' VARIABLES **NOT** CORRECTLY DEFINED.")
 . D MES^XPDUTL("CONFIRM THAT DUZ(0)='@'.  THEN D ^XUP.")
 . D MES^XPDUTL("  ")
 . S XPDQUIT=2
 ;
PFILE ; get IENs for all LBR* Package File entries
 N LBRPACK
 D FIND^DIC(9.4,"","1","","LBR","*","C","","","LBRPACK")
 ;
LBRS ; loop through FIND global LBRPACK
 ; get Package File IEN's for all LBR* entries
 N LBRND,LBR25OK,LBRPDA,LBRVER
 S (LBRND,LBR25OK)=0
 F  Q:LBR25OK  S LBRND=$O(LBRPACK("DILIST",2,LBRND)) Q:LBRND=""  D
 . ; get IEN for package file entry
 . S LBRPDA=LBRPACK("DILIST",2,LBRND)
 . ; create list of VERSION entries for each package file entry
 . D FIND^DIC(9.49,","_LBRPDA_",","","Q","2.5V1","","B","","","LBRVER")
 . ; check if 2.5V1 entry in version multiple if not go to next one
 . I $P($G(LBRVER("DILIST",0)),U)'>0 Q
 . ; if 2.5V1 multiple found, set OK flag
 . S LBR25OK=1
 ;
 ; version 2.5 install check
 I 'LBR25OK D  Q
 . D BMES^XPDUTL("Version 2.5 is required for patch LBR*2.5*6 installation.")
 . S XPDQUIT=2
 ;
EXIT ; environment successfull
 D BMES^XPDUTL("     >> Environment check complete and okay.")
 D MES^XPDUTL(" ")
 Q
