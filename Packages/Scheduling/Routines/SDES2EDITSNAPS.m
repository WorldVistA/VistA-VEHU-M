SDES2EDITSNAPS ;ALB/BLB - EDIT SPECIAL NEEDS PREFS; OCT 28, 2023@6:10pm
 ;;5.3;Scheduling;**864,877**;Aug 13, 1993;Build 14
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
EDITNEEDSPREFS(JSON,SDCONTEXT,NEEDSPREFS) ;
 N ERRORS,RETURN,VALRETURN
 ;
 D VALFILEIEN^SDES2VALUTIL(.VALRETURN,.ERRORS,2,$G(NEEDSPREFS("PATIENT DFN")),1,,1,2)
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("SpecialNeedsAndPreferences",1)="" M RETURN=ERRORS D BUILDJSON^SDES2JSON(.JSON,.RETURN) Q
 ;
 S NEEDSPREFS("IEN")=0,NEEDSPREFS("IEN")=$O(^SDEC(409.845,"B",NEEDSPREFS("PATIENT DFN"),NEEDSPREFS("IEN")))
 I '$G(NEEDSPREFS("IEN")) D ERRLOG^SDESJSON(.ERRORS,436)
 I $D(ERRORS) S ERRORS("SpecialNeedsAndPreferences",1)="" M RETURN=ERRORS D BUILDJSON^SDES2JSON(.JSON,.RETURN) Q
 ;
 D VALIDATENEEDPREF(.ERRORS,.NEEDSPREFS)
 I $D(ERRORS) S ERRORS("SpecialNeedsAndPreferences",1)="" M RETURN=ERRORS D BUILDJSON^SDES2JSON(.JSON,.RETURN) Q
 ;
 D BUILD(.NEEDSPREFS)
 S RETURN("SpecialNeedsAndPreferences")=1 D BUILDJSON^SDES2JSON(.JSON,.RETURN) Q
 Q
 ;
BUILD(NEEDSPREFS) ;
 N PATIENTFDA,PREFERENCE,PATIENTFDAERR,NEEDSPREFSFDAERR,RETURNIEN,COUNT,IENS,PREFNAME,NOPREF,INTERNALPREF,EDITREMARK,REMARKIEN
 ;
 ; delete any preference that is passed in
 ; if remarks subscript is null, delete
 ; if remarks are defined, they will be the new remarks
 ;
 ; edit preferences
 S COUNT=0,NOPREF=0
 F  S COUNT=$O(NEEDSPREFS("SPECIAL NEEDS AND PREFERENCES",COUNT)) Q:'COUNT  D
 .S PREFERENCE=$G(NEEDSPREFS("SPECIAL NEEDS AND PREFERENCES",COUNT))
 .N NEEDSPREFSFDA,REMARK,SUBIEN
 .;
 .S INTERNALPREF=$$SOCEXT2INT^SDESUTIL(409.8451,.01,PREFERENCE)
 .S SUBIEN=0,SUBIEN=$O(^SDEC(409.845,NEEDSPREFS("IEN"),1,"B",INTERNALPREF,SUBIEN))
 .S IENS=SUBIEN_","_$G(NEEDSPREFS("IEN"))_","
 .;
 .I $L($G(NEEDSPREFS("SPECIAL NEEDS AND PREFERENCES",COUNT))) D
 ..S NEEDSPREFSFDA(409.8451,IENS,.01)="@"
 ..D FILE^DIE(,"NEEDSPREFSFDA","NEEDSPREFSFDAERR") K NEEDSPREFSFDA
 ;
 ; edit preference remarks
 S PREFERENCE="",COUNT=0
 F  S PREFERENCE=$O(NEEDSPREFS("SPECIAL NEEDS AND PREFERENCES",PREFERENCE)) Q:PREFERENCE=""  D
 .I $L($$SOCEXT2INT^SDESUTIL(409.8451,.01,PREFERENCE)) D
 ..N EDITREMARK
 ..S COUNT=COUNT+1
 ..S SUBIEN=0,SUBIEN=$O(^SDEC(409.845,$G(NEEDSPREFS("IEN")),1,"B",$$SOCEXT2INT^SDESUTIL(409.8451,.01,PREFERENCE),SUBIEN))
 ..S EDITREMARK(COUNT)=$G(NEEDSPREFS("SPECIAL NEEDS AND PREFERENCES",PREFERENCE,"REMARK"))
 ..D WP^DIE(409.8451,SUBIEN_","_NEEDSPREFS("IEN")_",",6,"","EDITREMARK") Q
 Q
 ;
VALIDATENEEDPREF(ERRORS,NEEDSPREFS) ;
 N COUNT,PREFERENCE,NOPREF,INTERNALPREF
 S COUNT=0,NOPREF=0,INTERNALPREF=""
 F  S COUNT=$O(NEEDSPREFS("SPECIAL NEEDS AND PREFERENCES",COUNT)) Q:'COUNT!(NOPREF=1)  D
 .S PREFERENCE=$G(NEEDSPREFS("SPECIAL NEEDS AND PREFERENCES",COUNT))
 .D VALSETOFCODES^SDES2CREATESNAPS(.ERRORS,PREFERENCE,409.8451,.01,"Invalid special need or preference") I $D(ERRORS) S NOPREF=1 Q
 .S INTERNALPREF=$$SOCEXT2INT^SDESUTIL(409.8451,.01,PREFERENCE)
 .I '$D(^SDEC(409.845,NEEDSPREFS("IEN"),1,"B",INTERNALPREF)) D ERRLOG^SDESJSON(.ERRORS,437) S NOPREF=1 Q
 Q
 ;
