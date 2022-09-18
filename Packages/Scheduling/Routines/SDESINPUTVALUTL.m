SDESINPUTVALUTL  ;ALB/RRM - VISTA SCHEDULING INPUT VALIDATION UTILITY; Jun 10, 2022@15:02
 ;;5.3;Scheduling;**819**;Aug 13, 1993;Build 5
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;External References
 ;-------------------
 ; Reference to $$GETS^DIQ     is supported by IA #2056
 ; Reference to GETS^DIQ       is supported by IA #2056
 ; Reference to $$FIND1^DIC    is supported by IA #2051
 ; Reference to ENCODE^XLFJSON is supported by IA #6682
 ;
 Q  ;No Direct Call
 ;
VALIDATEMODALITY(SDAPTREQ,MODALITY) ;Retrieve the Modality set of codes
 ; Input : MODALITY - The internal/external set of code value
 ; Output: None
 ;
 N SDERR,I,SDMODSOC,YY,RESULT,ERROR,FOUND
 S (ERROR,FOUND)=0
 S SDMODSOC=$$GET1^DID(409.85,6,,"SET OF CODES",,"SDERR")
 I $D(SDERR) S ERROR=1 D ERRLOG^SDESJSON(.SDAPTREQ,224) Q ERROR
 ;check if the modality set of code passed in are valid
 F I=1:1:$L(SDMODSOC,":") D
 . S YY=$P($P(SDMODSOC,";",I),":")
 . I YY=MODALITY S MODALITY=YY,FOUND=1
 I $G(MODALITY)'="",'FOUND S ERROR=1 D ERRLOG^SDESJSON(.SDAPTREQ,224)
 Q ERROR
 ;
