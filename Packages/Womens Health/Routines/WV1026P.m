WV1026P ;ISP/AGP - PATCH 26 INSTALLATION TASKS;Feb 01, 2021@15:37
 ;;1.0;WOMEN'S HEALTH;**26**;Sep 30, 1998;Build 624
 Q
 ;
BLDARRAY(ARRAY) ;
 S ARRAY("BR 0 BIOPSY ALREADY OBTAIN")="BREAST BIOPSY ALREADY OBTAIN"
 S ARRAY("BR BIRAD 0 CONSULT")="BREAST CONSULT"
 S ARRAY("BR 0 CURRENTLY UNDER TREATMENT")="BREAST CURRENTLY UNDER TREATMENT"
 S ARRAY("BR BIRAD 1, need Mammogram")="BREAST NEED MAMMOGRAM"
 S ARRAY("BR BIRAD 1, need MRI")="BREAST NEED MRI"
 S ARRAY("BR BIRAD 1, need Ultrasound")="BREAST NEED ULTRASOUND"
 S ARRAY("BR BIRAD 0 OBTAIN PRIOR FILMS")="BREAST OBTAIN PRIOR FILMS"
 S ARRAY("BR 0 REFER FOR BIOPSY")="BREAST REFER FOR BIOPSY"
 S ARRAY("BR 0 REFER TO ONCOLOGIST")="BREAST REFER TO ONCOLOGIST"
 S ARRAY("BR 0 REFER TO SURGEON")="BREAST REFER TO SURGEON"
 ;S ARRAY("BR BIRAD 1, next MAM AGE AT START AGE")="BR BIRAD 1, next MAM AT START AGE"
 ;S ARRAY("BR BIRAD 2, next MAM AGE AT START AGE")="BR BIRAD 2, next MAM AT START AGE"
 S ARRAY("BR BIRAD 1, next MAM AGE 1Y")="BREAST next MAM 1Y"
 S ARRAY("BR BIRAD 1, next MAM AGE 2Y")="BREAST next MAM 2Y"
 S ARRAY("BR BIRAD 1, next MAM AT START AGE")="BREAST next MAM AT START AGE"
 Q
GETLIST(ARRAY,WHAT) ;
 N LINE
 I WHAT="PURPOSE" D  Q
 .F LINE=1:1 Q:$L($T(PURLIST+LINE))<3  D
 ..N TEXT
 ..S TEXT=$P($T(PURLIST+LINE),";;",2)
 ..S ARRAY(TEXT)=""
 Q
 ;
PATDATES ;
 N ARRAY,ACTNODE,IEN,NAME,NODE,NOTE,PATS,PROC,WVFUDATE,WVFDA,WVERR,WVIEN
 D BMES^XPDUTL("Update Women's Health Patient record that need Next Breast Treatment Date")
 D BMES^XPDUTL("  Find Procedure to review")
 S IEN=$O(^WV(790.51,"B","Mammogram, Screening",""))
 I IEN>0 S ARRAY(IEN)=""
 S IEN=$O(^WV(790.51,"B","BREAST TOMOSYNTHESIS SCREENING",""))
 I IEN>0 S ARRAY(IEN)=""
 I '$D(ARRAY) Q
 ;find patients that need to be reviewed
 D BMES^XPDUTL("  Find Patients to review")
 S NOTE="" F  S NOTE=$O(^WV(790.1,"NOTE",NOTE)) Q:NOTE=""  D
 .S WVIEN=0 F  S WVIEN=$O(^WV(790.1,"NOTE",NOTE,WVIEN)) Q:WVIEN'>0  D
 ..S NODE=$G(^WV(790.1,WVIEN,0))
 ..S IEN=0
 ..F  S IEN=$O(^WV(790.1,WVIEN,10,IEN)) Q:IEN'>0  D
 ...S ACTNODE=$G(^WV(790.1,WVIEN,10,IEN,0))
 ...I $P(ACTNODE,U,5)="Y" Q
 ...I $P(ACTNODE,U)'="Return to Age Based Screening" Q
 ...S PATS(+$P(NODE,U,2))=""
 ;loop through patients for review
 D BMES^XPDUTL("  Review Patients record")
 S IEN=0 F  S IEN=$O(PATS(IEN)) Q:IEN'>0  D
 .I '$$UNDERAGE(IEN) Q
 .S NODE=$G(^WV(790,IEN,0))
 .S PROC=$P(NODE,U,18) I +PROC=0 Q
 .I '$D(ARRAY(PROC)) Q
 .I +$P(NODE,U,19)>0 Q
 .S NAME=$$GET1^DIQ(2,IEN,.01)
 .I NAME="" Q
 .S WVFUDATE=""
 .D TERMEVAL^WVRPCGF2(IEN,.WVFUDATE)
 .I WVFUDATE="" Q
 .D BMES^XPDUTL("   Updating patient "_NAME)
 .S WVFDA(790,IEN_",",.19)=WVFUDATE
 .D FILE^DIE("","WVFDA","WVERR")
 .I $D(WVERR) D
 ..D BMES^XPDUTL("   Error updating record")
 ..D AWRITE^PXRMUTIL("WVERR")
 Q
 ;
PRE ;
 N WVMSG
 S WVMSG(1)="  Removing the data dictionary for the "
 S WVMSG(2)="    WV PREGNANCY/LACTATION STATUS CONFLICT EVENTS file (#790.9)..."
 D BMES^XPDUTL(.WVMSG)
 N DIU
 S DIU=790.9,DIU(0)=""
 D EN^DIU2
 D MES^XPDUTL("    DONE")
 Q
POST ;
 D RENAME,PATDATES,REINDEX,CLEAR
 Q
 ;
RENAME ;
 N ARRAY,NAME,NEWNAME
 D BLDARRAY(.ARRAY)
 S NAME="" F  S NAME=$O(ARRAY(NAME)) Q:NAME=""  D
 .S NEWNAME=ARRAY(NAME)
 .D RENAME^PXRMUTIL(790.404,NAME,NEWNAME)
 Q
 ;
UNDERAGE(DFN) ;
 N AGE,DOB
 I +$P($G(^DPT(DFN,.35)),U,1)>0 Q 0
 S DOB=$P(^DPT(DFN,0),U,3)
 S AGE=(DT-DOB)\10000
 I AGE>44 Q 0
 Q 1
 ;
SENDPUR(ANAME) ;
 N ARRAY
 D GETLIST(.ARRAY,"PURPOSE")
 I $D(ARRAY(ANAME)) Q 1
 Q 0
 ;
REINDEX ; Rebuild the APREG index in the WV PATIENT file (#790)
 D BMES^XPDUTL("  Rebuilding the APREG index...")
 N WVDFN
 S WVDFN=0 F  S WVDFN=$O(^WV(790,WVDFN)) Q:'+WVDFN  D
 .N WVINDEX
 .K ^WV(790,WVDFN,4,"APREG")
 .D PREGS^WVUTL11(WVDFN,.WVINDEX)
 D MES^XPDUTL("    DONE")
 Q
 ; 
CLEAR ; Clear the Cover Sheet data cache for all patients
 D BMES^XPDUTL("  Clearing the CPRS Cover Sheet data cache...")
 N WVSUB
 S WVSUB="WV_CCS;" F  S WVSUB=$O(^XTMP(WVSUB)) Q:$E(WVSUB,1,7)'="WV_CCS;"  D
 .K ^XTMP(WVSUB)
 D MES^XPDUTL("    DONE")
 Q
 ;
PURLIST ;
 ;;BI-RAD 0 DENSE RESULT
 ;;BI-RAD 0 RESULT
 ;;BI-RAD 1 DENSE RESULT
 ;;BI-RAD 1 RESULT
 ;;BI-RAD 2 DENSE RESULT
 ;;BI-RAD 2 RESULT
 ;;BI-RAD 3 DENSE RESULT
 ;;BI-RAD 3 RESULT
 ;;BI-RAD 4 DENSE RESULT
 ;;BI-RAD 4 RESULT
 ;;BI-RAD 5 DENSE RESULT
 ;;BI-RAD 5 RESULT
 ;;BI-RAD 6 DENSE RESULT
 ;;BI-RAD 6 RESULT
 ;;BREAST ABNORMAL DENSE RESULT
 ;;BREAST ABNORMAL RESULT
 ;;BREAST NORMAL DENSE RESULT
 ;;BREAST NORMAL RESULT
 ;;BREAST UNSATISFACTORY DENSE RESULT
 ;;BREAST UNSATISFACTORY RESULT
 ;;BREAST NEED MAMMOGRAM
 ;;BREAST NEED MRI
 ;;BREAST NEED ULTRASOUND
 ;;BREAST next MAM AT START AGE
 Q
 ;
