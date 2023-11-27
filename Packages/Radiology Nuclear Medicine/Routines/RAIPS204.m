RAIPS204 ;WOIFO/KLM - Post-init Driver, patch 204 ; Aug 31, 2023@13:34:20
 ;;5.0;Radiology/Nuclear Medicine;**204**;Mar 16, 1998;Build 2
 ;
 ;Post-Init will add LIRADS, PIRADS and TIRADS to file 78.3.  Filing errors are stored in ^XTMP
 ;It will also make updates to LUNGRADS and PR codes. 
 ;
 Q:'$D(^XTMP("RA*5.0*204 DIAGNOSTIC CODES FILE UPDATE BACKUP OF 78.3",78.3))  ;data not backed up
 N RACHX1 S RACHX1=$$NEWCP^XPDUTL("POST1","LIPITI^RAIPS204")
 N RACHX2 S RACHX2=$$NEWCP^XPDUTL("POST2","LUNG^RAIPS204")
 N RACHX3 S RACHX3=$$NEWCP^XPDUTL("POST3","PR^RAIPS204")
 Q
LIPITI ; Adding LI-RADS, PI-RADS & TI-RADS to Diagnosis Code File 78.3
 N RAFDA,RADNUM,RAI,RADX,RA001,RA01,RA2,RA3,RA4,RAMSG
 N RADIERR S RADIERR="RA*5.0*204 ERRORS FILING/UPDATING DATA - JOB #"_$J
 I '$D(^XTMP(RADIERR,0)) D
 .N X,Y S X=DT,Y=180
 .S ^XTMP(RADIERR,0)=$$FMADD^XLFDT(X,Y,0,0,0)_U_$G(DT)_U_"Errors filing/updating data - post init RA204"
 .Q
 F RAI=1:1 S RADX=$T(CODES+RAI) Q:RADX=" ;;"  D
 .S RA001=$P($P(RADX,";",3),"^"),RA01=$P($P(RADX,";",3),"^",2),RA2=$P($P(RADX,";",3),"^",3),RA3=$P($P(RADX,";",3),"^",4),RA4=$P($P(RADX,";",3),"^",5)
 .Q:RA001=""
 .S RAFDA(78.3,"+1,",.01)=RA01 ; DIAG CODE
 .S RAFDA(78.3,"+1,",2)=RA2   ; DIAG DESC
 .S RAFDA(78.3,"+1,",3)=RA3   ; PRINT ON ABN REPORT
 .S RAFDA(78.3,"+1,",4)=RA4   ; GENERATE ALERT
 .S RADNUM(1)=RA001
 .D UPDATE^DIE("","RAFDA","RADNUM","RAMSG")
 .;Capture any "DIERR" messages - they will tell us if an IEN already existed.  They shouldn't but you never know.
 .I $D(RAMSG("DIERR")) D
 ..S ^XTMP(RADIERR,"DIERR",RA001)=RAMSG("DIERR",1,"TEXT",1)
 ..Q
 .K RAMSG
 .Q
 I $D(^XTMP(RADIERR,"DIERR")) D MES^XPDUTL("There were errors filing data. Contact the radiology developement team.")
 Q
 ;
LUNG ;update LUNGRADS
 N RAFDA,RADNUM,RAI,RADX,RA001,RA01,RA3,RAERR,RATXT,RASAVE,RAE
 N RADIERR S RADIERR="RA*5.0*204 ERRORS FILING/UPDATING DATA - JOB #"_$J
 I '$D(^XTMP(RADIERR,0)) D
 .N X,Y S X=DT,Y=180
 .S ^XTMP(RADIERR,0)=$$FMADD^XLFDT(X,Y,0,0,0)_U_$G(DT)_U_"Errors fileing/updating data - post init RA204"
 .Q
 F RAI=1:1 S RADX=$T(LUNGRADS+RAI) Q:RADX=""  D
 .S RAE=0
 .S RA001=$P($P(RADX,";",3),"^"),RA01=$P($P(RADX,";",3),"^",2),RA3=$P($P(RADX,";",3),"^",4)
 .S RAIENS=RA001_","
 .I $G(RA01)]"" D  ;.01 field is uneditable - will hard set it.
 ..S RASAVE=$P(^RA(78.3,RA001,0),U)
 ..Q:RA01=RASAVE  ;Already a match - no update needed
 ..I $P(RA01,":")'=$P(RASAVE,":") D  Q
 ...S RATXT(1)="Error updating LUNGRAD code "_RA001 D BMES^XPDUTL(.RATXT)
 ...S ^XTMP(RADIERR,"DIERR",RA001)="Code doesn't match",RAE=1
 ...Q
 ..S $P(^RA(78.3,RA001,0),U)=RA01
 ..;Set/kill "B" x-ref (no other x-refs to worry about)
 ..S ^RA(78.3,"B",$E(RA01,1,30),RA001)="" ;XREF has 30c limit
 ..K ^RA(78.3,"B",$E(RASAVE,1,30),RA001)
 ..S RATXT(1)=RA001_" Updated" D BMES^XPDUTL(.RATXT)
 ..K RATXT
 ..Q
 .I $G(RA3)]"" D 
 ..S RAFDA(78.3,RAIENS,3)=RA3   ; PRINT ON ABN REPORT
 ..K RAERR D FILE^DIE("E","RAFDA","RAERR")
 ..I $D(RAERR("DIERR")) S RATXT(1)="Error updating LUNRAD code "_RA001
 ..I $G(RATXT(1))="" S RATXT(1)=RA001_" Updated"
 ..D BMES^XPDUTL(.RATXT)
 ..K RAERR,RATXT
 ..Q
 .Q
 I $G(RAE)=1 D MES^XPDUTL("There were errors updating data. Contact the radiology developement team.")
 Q
PR ;Inactivate Peer Review (PR) codes
 N RAFDA,RAI,RAIENS,RAERR,RATXT
 F RAI=1250,1251,1252,1253,1254,1255,1256  D
 .I $E($P(^RA(78.3,RAI,0),U),1,2)'="PR" D  Q
 ..S RATXT(1)="Code "_RAI_" does not appear to be a 'PR' code"
 ..D BMES^XPDUTL(.RATXT)
 .S RAIENS=RAI_","
 .;check if they're already inactive
 .I $P(^RA(78.3,RAI,0),U,5)="Y" D  Q
 ..K RATXT S RATXT(1)=RAI_" is already inactive."
 ..D BMES^XPDUTL(.RATXT)
 .E  S RAFDA(78.3,RAIENS,5)="Y" ;Inactive
 .D FILE^DIE("E","RAFDA","RAERR")
 .K RATXT
 .I $D(RAERR("DIERR")) S RATXT(1)="Error inactivating PR code "_RAI
 .I $G(RATXT(1))="" S RATXT(1)=RAI_" Inactivated"
 .D BMES^XPDUTL(.RATXT)
 .K RAERR,RATXT
 .Q
 Q
CODES ; NUMBER^CODE^DESC^PRINT^ALERT
 ;;1400^LI-RADS NC^Noncategorizable due to image omission or degradation^Y^y
 ;;1410^LI-RADS NO OBS^No observations^Y^n
 ;;1411^LI-RADS 1^Definitely benign^Y^n
 ;;1412^LI-RADS 2^Probably benign^Y^n
 ;;1413^LI-RADS 3^Intermediate probability of malignancy^Y^y
 ;;1414^LI-RADS 4^Probably HCC^Y^y
 ;;1415^LI-RADS 5^Definitely HCC^Y^y
 ;;1416^LI-RADS TIV^Tumor in vein (TIV)^Y^y
 ;;1417^LI-RADS M^Probably or definitely malignant, not necessarily HCC^Y^y
 ;;1421^LI-RADS TR NONEVALUABLE^Treated, response not evaluable due image omission or degradation^Y^y
 ;;1422^LI-RADS TR NONVIABLE^Treated, probably or definitely not viable^Y^y
 ;;1423^LI-RADS TR EQUIVOCAL^Treated, equivocally viable^Y^y
 ;;1424^LI-RADS TR VIABLE^Treated, probably or definitely viable^Y^y
 ;;1450^US LI-RADS 1A^No/Benign Observation(s) -- no/minimal visualization limitations^Y^n
 ;;1451^US LI-RADS 1B^No/Benign Observation(s) -- moderate visualization limitations^Y^y
 ;;1452^US LI-RADS 1C^No/Benign Observation(s) -- severe visualization limitations^Y^y
 ;;1453^US LI-RADS 2A^Observation(s) <10mm (not benign) -- no/minimal visualization limitations^Y^y
 ;;1454^US LI-RADS 2B^Observation(s) <10mm (not benign) -- moderate visualization limitations^Y^y
 ;;1455^US LI-RADS 2C^Observation(s) <10mm (not benign) -- severe visualization limitations^Y^y
 ;;1456^US LI-RADS 3A^Observation(s) >= 10mm (not benign) -- no/minimal visualization limitations^Y^y
 ;;1457^US LI-RADS 3B^Observation(s) >= 10mm (not benign) -- moderate visualization limitations^Y^y
 ;;1458^US LI-RADS 3C^Observation(s) >= 10mm (not benign) -- severe visualization limitations^Y^y
 ;;1500^PI-RADS NC^Noncategorizable due to image omission or degradation^Y^y
 ;;1511^PI-RADS 1^Very low (clinically significant cancer highly unlikely to be present)^Y^n
 ;;1512^PI-RADS 2^Low (clinically significant cancer is unlikely to be present)^Y^n
 ;;1513^PI-RADS 3^Intermediate (the presence of clinically significant cancer is equivocal)^Y^y
 ;;1514^PI-RADS 4^High (clinically significant cancer is likely to be present)^Y^y
 ;;1515^PI-RADS 5^Very high (clinically significant cancer highly likely to be present)^Y^y
 ;;1600^TI-RADS NC^Noncategorizable due to image omission or degradation^Y^y
 ;;1611^TI-RADS 1^Benign -- No FNA or follow-up^Y^n
 ;;1612^TI-RADS 2^Not suspicious -- No FNA or follow-up^Y^n
 ;;1613^TI-RADS 3^Mildly suspicious -- FNA if >= 2.5 cm, follow-up if >= 1.5 cm^Y^y
 ;;1614^TI-RADS 4^Moderately suspicious -- FNA if >= 1.5 cm, follow-up if >= 1 cm^Y^y
 ;;1615^TI-RADS 5^Highly suspicious -- FNA if >= 1 cm, follow-up if >= 0.5 cm^Y^y
 ;;
LUNGRADS ;Updates. Remove the word "NODULE". Update 'print on report' field
 ;;1211^^^Y^
 ;;1212^LUNGRADS 2: BENIGN APPEARANCE OR BEHAVIOR^^Y^
 ;;1213^LUNGRADS 3: PROBABLY BENIGN^^Y^
 ;;1214^LUNGRADS 4A: SUSPICIOUS^^^
 ;;1215^LUNGRADS 4B: SUSPICIOUS^^^
 ;;1216^LUNGRADS 4X: SUSPICIOUS WITH ADDITIONAL FEATURES^^^
 ;;1218^^^Y^
