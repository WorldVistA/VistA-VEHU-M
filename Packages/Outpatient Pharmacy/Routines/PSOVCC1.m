PSOVCC1 ;ORLFO/WLC - PSO VCC RPC CALLS ; Mar 20, 2023@12:57:56
 ;;7.0;OUTPATIENT PHARMACY;**707**;DEC 1997;Build 18
 ;
 ; External calls:
 ;
 ; Description       ICR     Notes
 ; -----------       ------  -------
 ; Reference to ENCODE^XLFJSON in #6682
 ; Reference to GET^DDE in #7008
 ; Reference to FMTHL7^XLFDT, HTFM^XLFDT in #10103
 ; 
 ; 
RFIL(PSOVO,PSOVIEN) ; retrieve ENTITY data for Refill Log (#52.1)
 ; inside a PRESCRIPTION (#52) file entry.
 ;
 ; INPUT:
 ;     PSOVIEN = External # of Prescription
 ; OUTPUT:
 ;     PSOVO(0) - Return value:
 ;            1 = Success, array of values returned in JSON format.
 ;           -1^error message for failure
 ;     PSOVO(1) = Array of values from REFILLS Log
 ;
 N CT,DDEY,ERR,PIEN
 I $G(PSOVIEN)']"" D NORXNER("-1^ Prescription Number is Required") Q
 I '$$RXVAL^PSOUTCRM(PSOVIEN) D NORXNER("-2^ Prescription Number is not recognized") Q
 S PIEN=$O(^TMP($J,"PSOV",-1))
 K PSOVO,ERR D GET^DDE("PSO REFILL LOG",PIEN,,0,,"PSOVO","ERR")
 I $D(ERR) D NORXNER("-1^Error in Retrieval") Q
 I $L(PSOVO(1),"}")<3 D NORXNER("0^No data - there are no REFILL LOG entries for this prescription") Q
 D TIDY^PSOVCC0
 Q
 ;----------
 ; 
ACT(PSOVO,PSOVIEN) ; Activity Log from PRESCRIPTION (#52) file.
 ;
 ;     INPUT:
 ;          PSOVIEN - External # OF PRESCRIPTION (#52) file entry.
 ;     OUTPUT:
 ;          PSOVO(0) - Return value
 ;           1 = Success
 ;          -1^Error message for failure
 ;          PSOVO(1) = Array of values from ACTIVITY Log
 ;
 N CT,DDEY,ERR,JSONER,OC,OD,PIEN,RETVAR,V
 I $G(PSOVIEN)']"" D NORXNER("-1^ Prescription Number is Required") Q
 I '$$RXVAL^PSOUTCRM(PSOVIEN) D NORXNER("-2^ Prescription Number is not recognized") Q
 S PIEN=$O(^TMP($J,"PSOV",-1))
 D GET^DDE("PSO ACTIVITY LOG",PIEN,,0,,"PSOVO","ERR")
 I $L(PSOVO(1),"}")<3 D NORXNER("0^No data - there are no ACTIVITY LOG entries for this prescription") Q
 D TIDY^PSOVCC0
 Q
 ;
 ; ----------
CMOP(PSOVO,PSOVIEN)  ; List CMOP Log
 ;
 ;     INPUT:
 ;          PSOVIEN - External # OF PRESCRIPTION (#52) file entry.
 ;     OUTPUT:
 ;          PSOVO(0) - Return Value: 
 ;            1 for success
 ;           -1^error message for failure
 ;          PSOVO(1) = Array of values from CMOP Log
 ;
 N CT,DDEY,ERR,OC,OD,PIEN,RETVAR,V
 I $G(PSOVIEN)']"" D NORXNER("-1^ Prescription Number is Required") Q
 I '$$RXVAL^PSOUTCRM(PSOVIEN) D NORXNER("-2^ Prescription Number is not recognized") Q
 S PIEN=$O(^TMP($J,"PSOV",-1))
 D GET^DDE("PSO CMOP M",PIEN,,0,,"PSOVO","ERR")
 I $D(ERR) D NORXNER("-1^Error in Retrieval") Q
 I $L(PSOVO(1),"}")<3 D NORXNER("0^No data - there are no CMOP entries for this prescription") Q
 D TIDY^PSOVCC0
 Q
 ;
 ; -------
 ;
PART(PSOVO,PSOVIEN)  ; Partial log
 ;
 ; INPUT:
 ;   PSOVIEN - External # of PRESCRIPTION (#52) file entry.
 ; OUTPUT:
 ;          PSOVO(0) - Return Value: 
 ;            1 for success
 ;           -1^error message for failure
 ;          PSOVO(1) - Array of values from PARTIALS Log
 ;
 N CT,DDEY,ERR,PIEN,RETVAR,V
 I $G(PSOVIEN)']"" D NORXNER("-1^ Prescription Number is Required") Q
 I '$$RXVAL^PSOUTCRM(PSOVIEN) D NORXNER("-2^ Prescription Number is not recognized") Q
 S PIEN=$O(^TMP($J,"PSOV",-1))
 D GET^DDE("PSO PARTIALS LOG",PIEN,,0,,"PSOVO","ERR")
 I $D(ERR) D NORXNER("-1^Error in Retrieval") Q
 I $L(PSOVO(1),"}")<3 D NORXNER("0^No data - there are no PARTIAL entries for this prescription") Q
 D TIDY^PSOVCC0
 Q
 ;
 ; -------
 ;
COPAY(PSOVO,PSOVIEN) ; COPAY transaction log
 ;
 ; INPUT:
 ;   PSOVIEN - External # of PRESCRIPTION (#52) file.
 ; OUTPUT:
 ;          PSOVO(0) - Return Value:
 ;            1 for success
 ;           -1^error message for failure
 ;          PSOVO(1) - Array of values from COPAY Log
 ;
 N CT,DDEY,ERR,PIEN,RETVAR,V
 S PSOVO(0)=0,PIEN=0
 I $G(PSOVIEN)']"" D NORXNER("-1^ Prescription Number is Required") Q
 I '$$RXVAL^PSOUTCRM(PSOVIEN) D NORXNER("-2^ Prescription Number is not recognized") Q
 S PIEN=$O(^TMP($J,"PSOV",-1))
 D GET^DDE("PSO COPAY LOG",PIEN,,0,,"PSOVO","ERR")
 I $D(ERR) D NORXNER("-1^Error in Retrieval") Q
 I $L(PSOVO(1),"}")<3 D NORXNER("0^No data - there are no COPAY entries for this prescription") Q
 D TIDY^PSOVCC0
 Q
  ;
 ; -------
 ;
LABEL(PSOVO,PSOVIEN)  ; Labels Log
 ;
 ; INPUT:
 ;   PSOVIEN - External # of PRESCRIPTION (#52) file.
 ; OUTPUT:
 ;          PSOVO(0) - Return Value:
 ;            1 for success
 ;           -1^error message for failure
 ;          PSOVO(1) - Array of values from LABELS Log
 ;
 N CT,DDEY,ERR,PIEN
 I $G(PSOVIEN)']"" D NORXNER("-1^ Prescription Number is Required") Q
 I '$$RXVAL^PSOUTCRM(PSOVIEN) D NORXNER("-2^ Prescription Number is not recognized") Q
 S PIEN=$O(^TMP($J,"PSOV",-1))
 D GET^DDE("PSO LABEL LOG",PIEN,,0,,"PSOVO","ERR")
 I $D(ERR) D NORXNER("-1^Error in Retrieval") Q
 I $L(PSOVO(1),"}")<3 D NORXNER("0^No data - there are no LABEL entries for this prescription") Q
 D TIDY^PSOVCC0
 Q
 ;
 ; -------
 ;
NORXNER(ERROR) ; handle messages for input parameter issue or no data
 ;
 N ZXC,DDEY
 S DDEY="PSOVO"
 S ECMER=ERROR
 D MERGE(0)
 K PSOVO(0)
 K PSOVO(1)
 D ENCODE^XLFJSON("ECM",.DDEY)
 S ZXC=@(DDEY_"(1)")
 S ZXC=$$SWAP^PSOUTCRM(ZXC,"\/","/")
 S @DDEY=ZXC
 K ECM,ECMER
 Q
 ;
MERGE(CT) ; merge into output array as json
 ;
 M ECM("data","items")=ECMER
 S ECM("data","updated")=$$FMTHL7^XLFDT($$HTFM^XLFDT($H))
 S ECM("data","total items")=CT
 Q
 ;
