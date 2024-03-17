DGNAME ;SFISC/MKO-PATIENT NAME UTILITIES ; 12/10/23 11:20pm
 ;;5.3;Registration;**974,1112**;Aug 13, 1993;Build 1
 ;**974,Story 841921 (mko): New routine for updating Name Components
 Q
 ;
UPDNC(RETURN,FLAG,IEN,NEWNC) ;Remote Procedure DG UPDATE NAME COMPONENTS
 ; FLAG : "G" - "GET" mode, Name and Aliases should be returned, not updated
 ;        Otherwise, the Name Components entry IEN will be updated with values in NEWNC array
 ; IEN : If FLAG["G", IEN is the DFN of the Patient whose name and alias should be returned
 ;       If FLAG'["G", IEN is the IEN of the Name Components entry to update
 ; NEWNC : Array of name components, with subscripts: "FAMILY", "GIVEN", "MIDDLE", and "SUFFIX"
 N DIERR,DIHELP,DIMSG,DIRUT,DTOUT,DUOUT,ERRARR,ERRMSG,FDA,MSG,IENS
 S FLAG=$G(FLAG)
 ;
 ;Get corresponding Name Components entry
 I FLAG["G" D GETNAMES(.RETURN,IEN) Q
 ;
 I '$G(IEN) S RETURN="-1^Name Components IEN not passed." Q
 I $P($G(^VA(20,IEN,0)),U)="" S RETURN="-1^Name Components entry IEN "_IEN_" not found." Q
 ;
 ;Setup FDA array for Name CURVAL
 S IENS=IEN_","
 S:$D(NEWNC("FAMILY"))#2 FDA(20,IENS,1)=NEWNC("FAMILY")
 S:$D(NEWNC("GIVEN"))#2 FDA(20,IENS,2)=NEWNC("GIVEN")
 S:$D(NEWNC("MIDDLE"))#2 FDA(20,IENS,3)=NEWNC("MIDDLE")
 S:$D(NEWNC("SUFFIX"))#2 FDA(20,IENS,5)=NEWNC("SUFFIX")
 S FDA(20,IENS,7)="CL30"
 D FILE^DIE("ET","FDA","MSG")
 ;
 ;If error, return error message(s)
 I $G(DIERR) S RETURN="-1^"_$$BLDERR("MSG") Q
 ;
 S RETURN="1^"_IEN
 Q
 ;
GETNAMES(RETURN,PATIEN) ;Get the Name and Aliases
 N ALSIEN,NCIEN
 K RETURN
 ;
 I '$G(PATIEN) S RETURN="-1^DFN was not passed." Q
 I $P($G(^DPT(PATIEN,0)),U)="" S RETURN="-1^Patient with DFN "_PATIEN_" not found." Q
 ;
 ;Get Name Components for Patient Name
 S NCIEN=$P($G(^DPT(PATIEN,"NAME")),U)
 ;**1112 - VAMPI-22440 (ckn)
 ;If "NAME" node in Patient file #2 OR Entry in NAME COMPONENTS File OR both missing,
 ;regenerate it using Patient file .01 field to avoid any error during update.
 I NCIEN,'$$FNDNCIEN(PATIEN_",") S NCIEN=$$CREATENC(PATIEN)
 I 'NCIEN S NCIEN=$$CREATENC(PATIEN)
 I NCIEN D GETCOMP(.RETURN,NCIEN) Q:$G(RETURN)<0
 ;
 ;Get each Alias
 S ALSIEN=0 F  S ALSIEN=$O(^DPT(PATIEN,.01,ALSIEN)) Q:'ALSIEN  D  Q:$G(RETURN)<0
 . S NCIEN=$P($G(^DPT(PATIEN,.01,ALSIEN,0)),U,3)
 . I NCIEN D GETCOMP(.RETURN,NCIEN)
 Q
 ;
GETCOMP(RETURN,NCIEN) ;Get the Name Components into the RETURN array
 N DIERR,DIHELP,DIMSG,NCIENS,TARG,MSG
 S NCIENS=NCIEN_","
 D GETS^DIQ(20,NCIENS,"1;2;3;5","","TARG","MSG")
 I $G(DIERR) S RETURN="-1^"_$$BLDERR("MSG") Q
 S RETURN($O(RETURN(""),-1)+1)=NCIEN_U_$G(TARG(20,NCIENS,1))_U_$G(TARG(20,NCIENS,2))_U_$G(TARG(20,NCIENS,3))_U_$G(TARG(20,NCIENS,5))
 Q
 ;
BLDERR(MSGROOT) ;Build an error from the error message array
 N ERRARR,ERRMSG,I
 D MSG^DIALOG("AE",.ERRARR,"","",MSGROOT)
 S ERRMSG="",I=0 F  S I=$O(ERRARR(I)) Q:'I  S ERRMSG=ERRMSG_$S(ERRMSG]"":" ",1:"")_$G(ERRARR(I))
 Q ERRMSG
 ;
FNDNCIEN(IENS) ;
 ;**1112 VAMPI-22440 (ckn) - Find Name Component entry using Patient's DFN
 N DIERR,DIHELP,DIMSG,MSG,VAL
 S VAL(1)=2,VAL(2)=.01,VAL(3)=IENS
 Q $$FIND1^DIC(20,"","QX",.VAL,"BB","","MSG")
 ;
CREATENC(IEN) ;
 ;**1112 VAMPI-22440 (ckn) - Generate NAME node and Name Component entry if missing
 N DA,DIK,IENS,NCIEN
 S IENS=IEN_","
 S NCIEN=$$FNDNCIEN(IENS)
 I 'NCIEN D
 .S DIK="^DPT(",DA=IEN,DIK(1)=".01^ANAM01"
 .D EN1^DIK
 E  D
 .N DIERR,DIHELP,DIMSG,FDA,MSG
 .S FDA(2,IEN_",",1.01)=NCIEN
 .D FILE^DIE("","FDA","MSG")
 Q $$FNDNCIEN(IENS)
 ;
