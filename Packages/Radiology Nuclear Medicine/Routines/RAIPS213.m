RAIPS213 ;WOIFO/KLM - Post-init Driver, patch 213 ; Apr 11, 2024@13:41:13
 ;;5.0;Radiology/Nuclear Medicine;**213**;Mar 16, 1998;Build 1
 ;
 ;This patch will add five HCC Liver study procedures to the radiology package
 ;and sync them with CPRS. 
 ;
 Q
 ;
EN ;entry point
 N RAI,RA01,RA6,RA7,RA9,RA11,RA12,RA17,RA20,RA125,RA500,RA731,RADATA,RATXT,RAERR,RASAV,RAY,RAGOOD
 F RAI=1:1 S RADATA=$T(PROCS+RAI) Q:RADATA=""  D
 .S RA01=$P($P(RADATA,";",3),"^"),RA6=$P(RADATA,"^",2),RA7=$P(RADATA,"^",3),RA9=$P(RADATA,"^",4),RA11=$P(RADATA,"^",5)
 .S RA12=$P(RADATA,"^",6),RA17=$P(RADATA,"^",7),RA20=$P(RADATA,"^",8),RA125=$P(RADATA,"^",9),RA500=$P(RADATA,"^",10),RA731=$P(RADATA,"^",11)
 .;Create .01 first
 .S RAGOOD=1
 .N RAFDA,RAR S RAR="RAFDA(71,""?+1,"")" ;FDA root -check for existing entry
 .S @RAR@(.01)=RA01 ;Name
 .K RAERR,RAIENS,RADA
 .D UPDATE^DIE(,"RAFDA","RADA","RAERR") K RAFDA
 .I $D(RAERR(1,"DIERR"))#2 D MES^XPDUTL("An error occured filing data for "_RA01) Q
 .;Update rest of fields
 .Q:'$D(RADA)
 .I $G(RADA(1,0))'="+" D MES^XPDUTL("Error Filing Data - procedure already exists. "_RA01) Q
 .S RASAV=RADA(1),RAIENS=RADA(1)_","
 .S RAY=RASAV_"^"_RA01_"^"_1 ;for OI update
 .S RAR="RAFDA(71,RAIENS)"
 .S:$D(RA6) @RAR@(6)=RA6    ;Procedure Type
 .S:$D(RA7) @RAR@(7)=RA7    ;Staff Review
 .S:$D(RA9) @RAR@(9)=RA9    ;CPT
 .S:$D(RA11) @RAR@(11)=RA11    ;Rad approval
 .S:$D(RA12) @RAR@(12)=RA12    ;Imaging Type
 .S:$D(RA17) @RAR@(17)=RA17    ;Display Edu Desc
 .S:$D(RA20) @RAR@(20)=RA20    ;Contrast Used
 .K RAERR D FILE^DIE("E","RAFDA","RAERR") K RAFDA
 .I $D(RAERR(1,"DIERR"))#2 S RAGOOD=0 D MES^XPDUTL("An error occured filing data for "_RA01)
 .;
CM .;Contrast Media (RA125)
 .I RA20="Yes" D
 ..K RAFDA,RAERR,RAIENS
 ..S RAIENS="+1,"_RASAV_","
 ..S RAFDA(71.0125,RAIENS,.01)=RA125
 ..D UPDATE^DIE("","RAFDA","RAIENS","RAERR")
 ..I $D(RAERR(1,"DIERR"))#2 S RAGOOD=0 D MES^XPDUTL("An error occured filing Contrast Media data for "_RA01) Q
 ..;Update Contrast Activity Log
 ..D FILEAU^RAMAINU1(RASAV,RA125)
 ..Q
 .;
ED .;Educational Description (RA500)
 .K RAFDA,RAERR,RAIENS,^TMP($J,"RA213")
 .S RAIENS=RASAV_","
 .S:$D(RA500) ^TMP($J,"RA213",1,0)=$P(RA500,"|")
 .I $P(RA500,"|",2)]"" S ^TMP($J,"RA213",2,0)=$P(RA500,"|",2)
 .D WP^DIE(71,RAIENS,500,"","^TMP($J,""RA213"")","RAERR")
 .I $D(RAERR(1,"DIERR"))#2 S RAGOOD=0 D MES^XPDUTL("An error occured filing the Educational Description for "_RA01)
 .;
MOD .;Modality (RA731)
 .K RAFDA,RAERR,RAIENS
 .S RAIENS="+1,"_RASAV_","
 .S:$D(RA731) RAFDA(71.0731,RAIENS,.01)=RA731
 .D UPDATE^DIE("","RAFDA","RAIENS","RAERR")
 .I $D(RAERR(1,"DIERR"))#2 S RAGOOD=0 D MES^XPDUTL("An error occured filing the Modality data for "_RA01)
 .;
OI .;Update Orderable Item
 .N RAENALL,RAFILE,RASTAT
 .S RAENALL=0,RAFILE=71,RASTAT=1,RAY=RASAV_"^"_RA01_"^"_1
 .D PROC^RAO7MFN(RAENALL,RAFILE,RASTAT,RAY)
 .;
 .;Feedback to installer
 .I RAGOOD=1 D MES^XPDUTL(RA01_" Procedure successfully created!")
 .I RAGOOD=0 D MES^XPDUTL("There were errors creating procedure "_RA01_". Contact the radiology developers.")
 .Q
 K ^TMP($J,"RA213"),RAFDA,RAERR,RAIENS
 Q
 ; Field #   Name
 ; ----------------------------
 ; .01       NAME
 ;  6        TYPE OF PROCEDURE
 ;  7        STAFF REVIEW REQUIRED
 ;  9        CPT CODE
 ;  11       RAD/NM PHYS APPROVAL REQUIRED
 ;  12       TYPE OF IMAGING
 ;  17       DISPLAY ED DESC WHEN ORDERED
 ;  20       CONTRAST MEDIA USED
 ;  125      CONTRAST MEDIA [71.0125]
 ;  500      EDUCATIONAL DESCRIPTION [71.09]
 ;  731      MODALITY [71.0731]
 ;
PROCS ;Liver Procedures
 ;;MRI LIVER W/WO IV CONTRAST HCC^DETAILED^YES^74183^NO^MAGNETIC RESONANCE IMAGING^YES^Yes^L^For detection and characterization of liver lesions in patients with|cirrhosis, chronic hepatitis B, and/or fibrosis.^MR
 ;;CT LIVER W/ IV CONTRAST 3 PHASE HCC^DETAILED^YES^74160^NO^CT SCAN^YES^Yes^N^For detection and characterization of liver lesions in patients with|cirrhosis, chronic hepatitis B, and/or fibrosis.^CT
 ;;CT LIVER W/WO IV CONTRAST 4 PHASE HCC^DETAILED^YES^74170^NO^CT SCAN^YES^Yes^N^For posttreatment HCC surveillance/detection/characterization.|^CT
 ;;US LIVER HCC SCREENING^DETAILED^YES^76705^NO^ULTRASOUND^YES^^^For HCC screening in patients with cirrhosis, chronic hepatitis B, and/or|fibrosis.^US
 ;;US LIVER W/CONTRAST HCC^DETAILED^YES^76978^NO^ULTRASOUND^YES^Yes^M^For detection and characterization of liver lesions in patients with|cirrhosis, chronic hepatitis B, and/or fibrosis.^US
