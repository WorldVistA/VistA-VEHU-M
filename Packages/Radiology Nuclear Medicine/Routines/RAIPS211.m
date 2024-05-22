RAIPS211 ;WOIFO/KLM - Post-init Driver, patch 211 ; Feb 23, 2024@11:23
 ;;5.0;Radiology/Nuclear Medicine;**211**;Mar 16, 1998;Build 1
 ;
EN ;entry point
 ;fall though
BIRADR ;Update the BI-RAD R Code for FDA (Add display text, update name)
 N RAIENS,RADX,RAFDA,RAERR,RATXT S RADX=1107
 S RAIENS=RADX_","
 S RAFDA(78.3,RAIENS,100)="Post-Procedure Mammogram for Marker Placement"
 K RAERR D FILE^DIE("E","RAFDA","RAERR")
 I $D(RAERR("DIERR")) S RATXT(1)="Error updating BIRAD code "_RADX
 I $G(RATXT(1))="" S RATXT(1)=RADX_" Display text updated"
 D BMES^XPDUTL(.RATXT)
 ;Update .01
 S $P(^RA(78.3,RADX,0),U)="BI-RADS CATEGORY R"
 ;Take care of "B" x-ref
 K ^RA(78.3,"B","BI-RADS R",RADX)
 S DIK="^RA(78.3,",DA=RADX D IX^DIK
 K DA,DIK,RATXT
 S RATXT(1)=RADX_" Code name updated"
 D BMES^XPDUTL(.RATXT)
 ;fall through
NOSHOW ;update NO SHOW reason for cancel/hold reason 
 N RA01,RAIEN,RAIENS,RAFDA,RASCR,RATXT S RA01="PATIENT NO SHOWED"
 S RASCR="I $P(^(0),U,5)=""Y""" ;Nat'l flag
 S RAIEN=$$FIND1^DIC(75.2,,"X",.RA01,,.RASCR)
 I RAIEN>0 S RAIENS=RAIEN_"," D
 .K RAERR S RAFDA(75.2,RAIENS,2)=9 ;general request (cancel and hold)
 .D FILE^DIE(,"RAFDA","RAERR")
 .I $D(RAERR("DIERR")) S RATXT(1)="Error updating Reason "_RA01
 .I $G(RATXT(1))="" S RATXT(1)=RA01_" Updated"
 .D BMES^XPDUTL(.RATXT)
 I RAIEN<1 D
 .S RATXT(1)="Error updating Reason "_RA01
 .D BMES^XPDUTL(.RATXT)
 Q
