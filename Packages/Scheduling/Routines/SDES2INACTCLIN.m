SDES2INACTCLIN ;ALB/TJB,MGD,TJB,TJB - Inactivate Clinic in HOSPITAL LOCATION FILE 44 ;Feb 20, 2025
 ;;5.3;Scheduling;**864,877,890,902**;Aug 13, 1993;Build 1
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ;Reference to $$GETS^DIQ is supported by IA #2056
 ;Reference to $$GETS1^DIQ is supported by IA #2056
 ;
 Q
 ;
SDINACTCLN(SDRETURN,SDCONTEXT,SDPARAM) ;Inactivate Clinic
 ;INPUT -
 ; SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ; SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ;
 ; SDPARAM("CLINIC IEN")=CLINIC IEN     IEN of the clinic in file 44 - Hospital location
 ; SDPARAM("INACTIVATION DATE")=DATE    ISO DATE to inactivate the clinic if empty default to today (DT)
 ;
 ;RETURN PARMETER:
 ; Status
 ;
 N ERRORS,RESULTS,CLINICIEN,INACTDATE
 ; validate context array
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("ClinicInactivate",1)="" D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q
 D VALCLINIEN^SDES2VAL44(.ERRORS,$G(SDPARAM("CLINIC IEN")),1)
 I $D(ERRORS) S ERRORS("ClinicInactivate",1)="" D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q
 D INIT(.SDPARAM,.CLINICIEN,.INACTDATE)
 D VALIDATE(.ERRORS,INACTDATE,CLINICIEN)
 D NOAPPOINTMENTS(CLINICIEN,INACTDATE,.ERRORS)
 I $D(ERRORS) D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q
 ; File the inactivation on HOSPITAL LOCATION
 D BLDCINREC(.RESULTS,CLINICIEN,INACTDATE,.ERRORS)
 ; If the Clinic was inactivated then update the SDEC RESOURCE (409.831) with the inactivation information
 I '$D(ERRORS) D UPDATECLNRES(CLINICIEN,INACTDATE,$G(SDCONTEXT("USER DUZ")),.ERRORS)
 I $D(ERRORS) D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q  ; There was a problem updating 409.831 with the inactivation
 D ENCODE^SDES2JSON(.RESULTS,.SDRETURN)
 Q
 ;
INIT(SDPARAM,CLINICIEN,INACTDATE) ; initialize values needed
 S CLINICIEN=$G(SDPARAM("CLINIC IEN"))
 S INACTDATE=$G(SDPARAM("INACTIVATION DATE"))
 ; If no Inactivation Date then default it to today
 I INACTDATE="" S INACTDATE=$$FMTISO^SDAMUTDT(DT)
 Q
 ;
VALIDATE(ERRORS,INACTIVEDATE,CLINICIEN) ; validate incoming parameters
 N FMDATE
 ; Validate the inactivation date
 S FMDATE=$$ISOTFM^SDAMUTDT(INACTIVEDATE)
 I FMDATE=-1 D ERRLOG^SDES2JSON(.ERRORS,46,"For Clinic Inactivation")
 I FMDATE>0,(FMDATE<DT) D ERRLOG^SDES2JSON(.ERRORS,46,"Clinic Inactivation can't be before today")
 I (FMDATE>$$FMADD^XLFDT(DT,182)) D ERRLOG^SDES2JSON(.ERRORS,46,"Inactivation Date greater than 6 Months in the future")
 Q
 ; Make sure there are no active appointments after the inactivation date
NOAPPOINTMENTS(CLINICIEN,INACTDATE,ERRORS) ;
 N POP,FMDATE,DATEIDX,LASTDATE,I1
 S FMDATE=$$ISOTFM^SDAMUTDT($G(INACTDATE))
 S CLINICIEN=$G(CLINICIEN)
 S POP=0,LASTDATE=9999999,DATEIDX=FMDATE-.0001
 F  S DATEIDX=$O(^SC(CLINICIEN,"S",DATEIDX)) Q:'DATEIDX!(POP)!(FMDATE'<LASTDATE&(LASTDATE))  D
 . S I1=0 F  S I1=$O(^SC(CLINICIEN,"S",DATEIDX,1,I1)) Q:'I1  I $$GET1^DIQ(44.003,I1_","_DATEIDX_","_CLINICIEN_",",310,"I")'="C" S POP=1,FMDATE=DATEIDX Q
 I POP D ERRLOG^SDES2JSON(.ERRORS,521)
 Q
 ;
BLDCINREC(SDCINREC,CLINICIEN,INACTIVEDATE,ERRORS) ;Inactivate Clinic
 ; If the inactivation was filed in FILEMAN, no errors recorded, otherwise populate ERRORS
 N SDERR,SDFDA,SDCLNNAME,FMDATE,REACTDT,SDATE,I
 N CLIN,PROVDUZ,IEN ; These variables linger from the UPDATE^DIE call
 S SDCLNNAME=""
 S REACTDT=$$GET1^DIQ(44,CLINICIEN,2506,"I")
 S FMDATE=$$ISOTFM^SDAMUTDT(INACTIVEDATE)
 S SDCLNNAME=$$GET1^DIQ(44,CLINICIEN,.01)
 S SDFDA(44,CLINICIEN_",",2505)=FMDATE
 I REACTDT'="",REACTDT<=FMDATE D
 . S SDFDA(44,CLINICIEN_",",2506)="@"
 D UPDATE^DIE("","SDFDA","","SDERR")
 I $G(SDERR) D ERRLOG^SDES2JSON(.ERRORS,81) Q
 ; Remove the grid elements
 S SDATE=$S((REACTDT'=""&(REACTDT>FMDATE)):REACTDT,1:9999999) D  Q:$D(ERRORS)
 . F I=FMDATE-.0001:0 S I=$O(^SC(CLINICIEN,"ST",I)) Q:'I!(I>SDATE)  K ^SC(CLINICIEN,"ST",I)
 . F I=FMDATE-.0001:0 S I=$O(^SC(CLINICIEN,"T",I)) Q:'I!(I>SDATE)  K ^SC(CLINICIEN,"T",I)
 . F I=FMDATE-.0001:0 S I=$O(^SC(CLINICIEN,"OST",I)) Q:'I!(I>SDATE)  K ^SC(CLINICIEN,"OST",I)
 . D REMVTX(CLINICIEN,FMDATE)
 S SDCINREC("ClinicInactivate",1)="Clinic is successfully inactivated."
 Q
 ;
REMVTX(SCLIN,SDDATE) ; Remove T0 to T6 patterns
 N SDN,SD,J,J1,I,X,X1,X2,DA,DIE,DR,DOW,SDINDPAT,FDA,ERR,FDAIEN,SDFILE,TNODE
 S TNODE="44.06^44.07^44.08^44.09^44.008^44.009^44.0001"
 F I=0:1:6 S SDFILE(I)=$P(TNODE,U,I+1)
 K SDN S DOW=$$DOW^XLFDT(SDDATE,1),SDN(DOW)=SDDATE,SDINDPAT(DOW)=$G(^SC(SCLIN,"T"_DOW,9999999,1)),X=SDDATE
 F I=1:1:6 S X2=1,X1=X D C^%DTC S DOW=$$DOW^XLFDT(X,1),SDN(DOW)=X,SDINDPAT(DOW)=$G(^SC(SCLIN,"T"_DOW,9999999,1))
 F I=0:1:6 S J=$O(^SC(SCLIN,"T"_I,(SDN(I)-0.0001)))  D  Q:$D(ERRORS)
 . Q:'$D(^SC(SCLIN,"T"_I,0))  ; skip if no Tx node
 . S SD=$O(^SC(SCLIN,"T"_I,J,0))
 . I J>0,SD'=9999999,$$GET1^DIQ(SDFILE(I),J_","_SCLIN_",",1,"I")'="" D  Q:$D(ERRORS)
 . . K FDA,ERR,FDAIEN
 . . D  Q:$D(ERRORS)
 . . . Q:$D(^SC(SCLIN,"T"_I,SDN(I)))
 . . . S FDA(SDFILE(I),"+2,"_SCLIN_",",1)=$$GET1^DIQ(SDFILE(I),J_","_SCLIN_",",1,"I")  ;^SC(SCLIN,"T"_I,J,1)
 . . . S FDA(SDFILE(I),"+2,"_SCLIN_",",.01)=SDN(I)
 . . . S FDAIEN(2)=SDN(I) D UPDATE^DIE("","FDA","FDAIEN","ERR")
 . . . I $D(ERR) D ERRLOG^SDES2JSON(.ERRORS,81,"Issue with saving old pattern for Clinic IEN:"_SCLIN_" DOW: "_I_" Date: "_SDN(I))
 . . K ^SC(SCLIN,"T"_I,J) F J1=J:0 S J1=$O(^SC(SCLIN,"T"_I,J1)) Q:'J1  K ^SC(SCLIN,"T"_I,J1) ;don't remove if already canceled, SD*5.3*726
 . D  Q:$D(ERRORS)  ; File indefinite date with empty pattern
 . . I $$GET1^DIQ(SDFILE(I),"9999999,"_SCLIN_",",.01,"I")=9999999,$$GET1^DIQ(SDFILE(I),"9999999,"_SCLIN_",",1,"I")="" Q  ; Already have an empty indefinite pattern
 . . K FDA,ERR,FDAIEN
 . . S FDA(SDFILE(I),"+2,"_SCLIN_",",1)=""
 . . S FDA(SDFILE(I),"+2,"_SCLIN_",",.01)=9999999
 . . S FDAIEN(2)=9999999 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 . . I $D(ERR) D ERRLOG^SDES2JSON(.ERRORS,81,"Issue with saving empty indefinite pattern for Clinic IEN:"_SCLIN)
 . D:SDINDPAT(I)'=""  ; If we have an indefinite pattern then file it on the inactivation date
 . . Q:$D(^SC(SCLIN,"T"_I,SDN(I)))
 . . K FDA,ERR,FDAIEN
 . . S FDA(SDFILE(I),"+2,"_SCLIN_",",1)=SDINDPAT(I)
 . . S FDA(SDFILE(I),"+2,"_SCLIN_",",.01)=SDN(I)
 . . S FDAIEN(2)=SDN(I)
 . . D UPDATE^DIE("","FDA","FDAIEN","ERR")
 . . I $D(ERR) D ERRLOG^SDES2JSON(.ERRORS,81,"Issue with filing the saved pattern for Clinic IEN:"_SCLIN_" Date: "_SDN(I))
 Q
 ;
UPDATECLNRES(SDCLINICIEN,INACTIVATIONDATE,SDDUZ,ERRORS) ;Update INACTIVATED DATE/TIME and INACTIVATED BY USER in SDEC RESOURCE File #409.831
 N SDRESFDA,SDCLINRES,SDERR,FMDATE,REACTDT
 S SDCLINRES=$$GETRES^SDES2UTIL1(SDCLINICIEN,1)
 Q:SDCLINRES=""  ; no resource associated with clinic
 S FMDATE=$$ISOTFM^SDAMUTDT(INACTIVATIONDATE)
 S REACTDT=$$GET1^DIQ(409.831,SDCLINRES,.025,"I")
 S SDRESFDA(409.831,SDCLINRES_",",.021)=$P(FMDATE,".")
 S SDRESFDA(409.831,SDCLINRES_",",.022)=$S(SDDUZ'="":SDDUZ,1:DUZ)
 I REACTDT'="",REACTDT<=FMDATE D
 . S SDRESFDA(409.831,SDCLINRES_",",.025)="@"
 . S SDRESFDA(409.831,SDCLINRES_",",.026)="@"
 D FILE^DIE("","SDRESFDA","SDERR")
 I $D(SDERR) D ERRLOG^SDES2JSON(.ERRORS,81,"File 409.831 not updated with the inactivation date for Resource IEN="_SDCLINRES)
 Q
