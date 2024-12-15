MAGVIM12 ;WOIFO/NST/BT/JL - Utilities for RPC calls for DICOM file processing ; May 05, 2023@080:09:32
 ;;3.0;IMAGING;**357**;Mar 19, 2002;Build 29
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; This function returns Service (Radiology, Consult, or Lab) based on Modality and Procedure
 ; If service found, it will be returned as:
 ;   RAD --------- Radiology
 ;   CON --------- Consult/Procedure Request Tracking (CPRS)
 ;   LAB --------- Anatomic Pathology
 ; If no Service found, this function will add an entry 
 ;   with Modalty and Procedure into File #2006.9423
 ;   and return "" if successful otherwise return "-1^"_Error
 ;
GETSRV(MDL,PROC) ;Get SERVICE
 N FILE,SRV,IEN
 S FILE=2006.9423,IEN=""
 S SRV=$$GETS(MDL,PROC)
 I $P(SRV,U,1)="-1" Q IEN  ;return error
 I SRV'="" Q SRV
 ;Does not exist, create it
 S IEN=$$UPDSRV("",MDL,PROC)
 I $P(IEN,U,1)="-1" Q IEN  ;return error
 I IEN Q $$GET1^DIQ(FILE,IEN,1)
 Q "-1^Unable to update file #2006.9423"
 ;
GETS(MDL,PROC) ;Get Service
 N FILE S FILE=2006.9423
 I $G(MDL)="" Q ""     ;no value to lookup, must have PROC or MDL defined
 S MDL=$$UPCASE(MDL),PROC=$G(PROC),PROC=$$UPCASE(PROC)
 S IEN=$O(^MAGV(FILE,"B",MDL_"|"_PROC,""))
 I IEN Q $$GET1^DIQ(FILE,IEN,1)
 S IEN=$O(^MAGV(FILE,"B",MDL,""))
 I IEN Q $$GET1^DIQ(FILE,IEN,1)
 Q ""
 ;
UPDSRV(SRV,MDL,PROC) ;Update service or Add the new entry and return IEN or error
 N FILE,MAGFDA,MAGIEN,MAGXE
 S FILE=2006.9423
 S MAGFDA(FILE,"?+1,",.01)=MDL_$S(PROC'="":"|"_PROC,1:"")
 S MAGFDA(FILE,"?+1,",1)=SRV
 D UPDATE^DIE("S","MAGFDA","MAGIEN","MAGXE")
 I $D(MAGXE("DIERR","E")) Q "-1^"_$G(MAGXE("DIERR",1,"TEXT",1))
 Q MAGIEN(1)
 ;
GTCSRV(IEN) ; Get computed Service in Work Item FIle 2006.941
 N FILE,MTGIDX,PTGIDX
 N SRV,MOD,PROC
 S FILE=2006.941
 S MTGIDX=$O(^MAGV(FILE,"H","Modality",IEN,""))
 I 'MTGIDX Q ""
 S MOD=$P(^MAGV(FILE,IEN,4,MTGIDX,0),U,2)
 S PROC=""
 S PTGIDX=$O(^MAGV(FILE,"H","Procedure",IEN,""))
 I PTGIDX S PROC=$P(^MAGV(FILE,IEN,4,PTGIDX,0),U,2)
 S SRV=$$GETS(MOD,PROC)
 Q SRV
 ; 
UPCASE(X) ;
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
