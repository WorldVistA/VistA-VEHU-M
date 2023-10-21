ECX3P188 ;MNTVBB/DMR - NATIONAL CLINIC (#728.441) File Update; May 15, 2023@15:03 ; 7/18/23 1:10pm
 ;;3.0;DSS EXTRACTS;**188**;May 15, 2023;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Post-init routine updating entries in the NATIONAL CLINIC (#728.441)
 ; file for FY24.
 ;
 ; Reference(s) to $$FIND1^DIC supported by ICR# 2051
 ; Reference(s) to FILE^DIE supported by ICR# 2053
 ; Reference(s) to UPDATE^DIE supported by ICR# 2053
 ; Reference(s) to BMES^XPDUTL supported by ICR# 10141
 ; Reference(s) to MES^XPDUTL supported by ICR# 10141
 Q
 ;
POST ;routine entry point
 D BMES^XPDUTL("Update NATIONAL CLINIC (#728.441) file starts.")
 D ADD    ;add new code
 D UPDATE ;change short description of existing clinic codes
 D BMES^XPDUTL("Update complete.")
 D MES^XPDUTL("")
 Q
 ;
ADD ; Add new code
 ;ECXREC is in format: ;;short description^code^^
 ;
 N ECXI,ECXREC,ECXNM,ECXCODE,ECXIEN,ECXERR
 D BMES^XPDUTL(">>> Adding new CHAR4 code(s) to the NATIONAL CLINIC file (#728.441)...")
 ;
 F ECXI=1:1 S ECXREC=$P($T(ADDCLIN+ECXI),";;",2) Q:ECXREC="QUIT"  D
 . S ECXNM=$P(ECXREC,U,1)   ;Name
 . S ECXCODE=$P(ECXREC,U,2) ;Code
 . ; check if new code already exists in file 728.441
 . S ECXIEN=$$FIND1^DIC(728.441,"","X",ECXCODE,"","","ECXERR")
 . ; quit if error
 . I $D(ECXERR) D  Q
 . . D BMES^XPDUTL("       >> ... Unable to add CHAR4 code "_ECXCODE_" - "_ECXNM_" to file.")
 . . D MES^XPDUTL("        >> ... "_$G(ECXERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("        >> ... Please contact support for assistance...")
 . . K ECXERR
 . ; if code already exists, quit
 . I ECXIEN D  Q
 . . D BMES^XPDUTL("    >> CHAR4 code "_ECXCODE_" - "_ECXNM_" already exists.")
 . ; if code does not exist, add new entry
 . ; set field values of new entry
 . K ECXFDA
 . S ECXFDA(728.441,"+1,",.01)=ECXCODE
 . S ECXFDA(728.441,"+1,",1)=ECXNM
 . ; add new entry
 . D UPDATE^DIE("E","ECXFDA","","ECXERR")
 . ; check if error
 . I '$D(ECXERR) D
 . . D BMES^XPDUTL("    >> CHAR4 Code "_ECXCODE_" - "_ECXNM_" added to file.")
 . I $D(ECXERR) D
 . . D BMES^XPDUTL("    >> ... Unable to add CHAR4 code "_ECXCODE_" "_ECXNM_" to file.")
 . . D MES^XPDUTL("    >> ... "_$G(ECXERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("    >> ... Please contact support for assistance.")
 . . ; clean out error array b4 processing next code
 . . K ECXERR
 ;
 D BMES^XPDUTL(">>> Add new CHAR4 code(s) complete.")
 D MES^XPDUTL("")
 Q
 ;
UPDATE ;changing short description of existing entries
 ;ECXREC is in format: ;;code^short description
 ;
 N ECXCODE,ECXDESC,ECXIEN,DIE,DA,DR,ECXI,ECXREC,ECXERR
 ;
 D BMES^XPDUTL(">>> Updating entries in the NATIONAL CLINIC (728.441) file...")
 ;
 F ECXI=1:1 S ECXREC=$P($T(UPDCLIN+ECXI),";;",2) Q:ECXREC="QUIT"  D
  .S ECXCODE=$P(ECXREC,"^"),ECXDESC=$P(ECXREC,"^",2)
  .S ECXIEN=$$FIND1^DIC(728.441,"","X",ECXCODE,"","","ECXERR")
  .I 'ECXIEN D  Q
  ..D BMES^XPDUTL(">>>....Unable to find code: "_ECXCODE_".")
  ..D BMES^XPDUTL("*** Please contact support for assistance. ***")
  .K FDA
  .S FDA(728.441,ECXIEN_",",1)=ECXDESC
  .D FILE^DIE(,"FDA","ECXERR")
  .I '$D(ECXERR) D BMES^XPDUTL(">>>...."_ECXCODE_" - "_$P(ECXREC,U,2)_" updated")
  .I $D(ECXERR) D BMES^XPDUTL(">>>....Unable to update code "_ECXCODE_".") D
  ..D BMES^XPDUTL("*** Please contact support for assistance. ***")
 Q
 ;
ADDCLIN ;Add new code
 ;;Care Coordination Review Team (CCRT)^CCRT^^
 ;;Certified Registered Nurse Anesthetist^CRNA^^
 ;;HPACT Mobile Medical Unit (MMU)^HMMU^^
 ;;Homeless Patient Aligned Care Team (HPACT)^HPAC^^
 ;;Nursing Home to Home RN^NHRN^^
 ;;QUIT
 ;
UPDCLIN ;Contains the NATIONAL CLINIC entry description to be updated
 ;;CDSC^CRH Toxic Exposure Screening (TES)
 ;;CGPC^CRH Interdisciplinary Team Meeting With Patient
 ;;CGTC^CHAR4 COUNCIL
 ;;CGWC^CRH Interdisciplinary Team Meeting Without Patient
 ;;CNSG^E-Consult RN/CRNA
 ;;DEUC^Tele Emergency Care PA
 ;;DMUC^Tele Emergency Care MD
 ;;NASG^NTO Program Genetic Counseling
 ;;NAST^NTO Program Clinical Trials
 ;;NASU^NTO Program Close to Me
 ;;NASW^NTO Breast Gynecologic Oncology SoE (BGSOE)
 ;;NASX^Environmental Toxic Exposure Screening
 ;;NASY^NTO Program Advanced Practice Provider (APP)
 ;;PNUC^Tele Emergency Care NP
 ;;QUIT
