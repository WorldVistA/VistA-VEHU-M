RAIPS206 ;WOIFO/KLM - Post-init Driver, patch 206 ; Sep 26, 2023@09:50:23
 ;;5.0;Radiology/Nuclear Medicine;**206**;Mar 16, 1998;Build 8
 ;
 ;Supported IA #1571 ^LEX(757.01
 ;
BIRADS ;updates to BIRADS
 ;Add New codes
 N RAFDA,RADNUM,RAI,RADX,RA001,RA01,RA2,RA3,RA4,RAMSG
 F RAI=1:1 S RADX=$T(CODES+RAI) Q:RADX=""  D
 .S RA001=$P($P(RADX,";",3),"^"),RA01=$P($P(RADX,";",3),"^",2),RA2=$P($P(RADX,";",3),"^",3),RA3=$P($P(RADX,";",3),"^",4),RA4=$P($P(RADX,";",3),"^",5)
 .Q:RA001=""
 .S RAFDA(78.3,"+1,",.01)=RA01 ; DIAG CODE
 .S RAFDA(78.3,"+1,",2)=RA2   ; DIAG DESC
 .S RAFDA(78.3,"+1,",3)=RA3   ; PRINT ON ABN REPORT
 .S RAFDA(78.3,"+1,",4)=RA4   ; GENERATE ALERT
 .S:RA001=1110 RAFDA(78.3,"+1,",100)="Incomplete: Need prior mammograms for comparison" ;DISPLAY TEXT
 .S RADNUM(1)=RA001
 .D UPDATE^DIE("","RAFDA","RADNUM","RAMSG")
 .;Capture any "DIERR" messages - they will tell us if an IEN already existed.  They shouldn't but you never know.
 .I $D(RAMSG("DIERR")) D
 ..S RATXT(1)="Error filing BI-RADS code "_RA001 D BMES^XPDUTL(.RATXT)
 ..Q
 .Q
 ;
ABN ;Set "Print on Abnormal Report" field for 1101 and 1102
 N RAIENS,RADX F RADX=1101,1102 D
 .S RAIENS=RADX_","
 .S RAFDA(78.3,RAIENS,3)="Y"   ; PRINT ON ABN REPORT
 .K RAERR D FILE^DIE("E","RAFDA","RAERR")
 .I $D(RAERR("DIERR")) S RATXT(1)="Error updating BIRAD code "_RADX
 .I $G(RATXT(1))="" S RATXT(1)=RADX_" Updated"
 .D BMES^XPDUTL(.RATXT)
 .K RAERR,RATXT
 .Q
 ;
EXP ;Expression field update (data type changed from 757.01 pointer to free text).
 N RADX,RAEXP
 F RADX=1100:1:1106 D
 .S RAEXP=$P(^RA(78.3,RADX,0),U,6) Q:$G(RAEXP)=""!($G(RAEXP)'?2N)
 .S $P(^RA(78.3,RADX,1),U)=$$GET1^DIQ(757.01,RAEXP,.01)
 .Q
 Q
CODES ; NUMBER^CODE^DESC^PRINT^ALERT
 ;;1107^BI-RADS R^Post-Procedure Mammogram for Marker Placement^Y^n
 ;;1110^BI-RADS CATEGORY 0^Incomplete: Need Prior Mammograms for Comparison^Y^y
