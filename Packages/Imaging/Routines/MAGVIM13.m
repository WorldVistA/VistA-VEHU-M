MAGVIM13 ;WOIFO/BT/JL - Utilities for RPC calls for DICOM file processing ; May 05, 2023@080:09:32
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
 ;+++++ UPDATE IMAGE SERVICE MAPPING #2006.9423
 ; RPC: MAGV UPDATE WORK ITEM SERVICE
 ;
 ; .MAGRY        Reference to a local variable where the results are returned.
 ;
 ; MDL           MODALITY of image WORK ITEM (DICOM)
 ; PROC          PROCEDURE of image WORK ITEM (DICOM)
 ; NEWSRV        NEW SERVICE where File 2006.941 and 2006.9423
 ;
 ; This RPC Updates or Adds Service in both 
 ;               File 2006.941 (for IEN: WIEN) - Service is inside TAGS 
 ;           and File 2006.9423 (SERVICE (Field #1) )
 ;
 ; Return Values
 ; =============
 ; If MAGRY 1st '^'-piece is 0, then OKay. Otherwise, the output 
 ;             is as follows:
 ;
 ; MAGRY     Description
 ;                ^01: 0 or -1
 ;                ^02: -1 Error message if any
 ;   
UPDSRV(OUT,PRVSRV,MDL,PROC,NEWSRV) ;
 N FILE,SRV,IEN,MPIEN,TAGIDX,ERR
 N MAGFDA,MAGXE,MAGIEN,SHORT
 ;---- update Service in Work Item Service File #2006.9423 --------------
 S FILE=2006.9423
 I $G(MDL)="" S OUT="-1"_U_"Modality must not be empty" Q
 I $G(NEWSRV)="" S OUT="-1"_U_"New Service must not be empty" Q
 S MDL=$$UPCASE(MDL)
 S PROC=$$UPCASE($G(PROC))
 S SHORT=""
 I NEWSRV="Radiology" S SHORT="RAD"
 I NEWSRV="Lab" S SHORT="LAB"
 I NEWSRV="Consult" S SHORT="CON"
 I SHORT="" S OUT="-1"_U_"Invalid Service" Q
 S SRV=""
 S MPIEN=$O(^MAGV(FILE,"B",MDL_"|"_PROC,""))
 I MPIEN S SRV=$$GET1^DIQ(FILE,MPIEN,1)
 I 'MPIEN D
 . S MPIEN=$O(^MAGV(FILE,"B",MDL,""))
 . I MPIEN S SRV=$$GET1^DIQ(FILE,MPIEN,1)
 I SRV'=SHORT D
 . S MPIEN=$$UPDSRV^MAGVIM12(SHORT,MDL,PROC)
 I $P(MPIEN,U,1)="-1" S OUT=MPIEN Q  ;return error
 S OUT=0
 Q
 ;
UPCASE(X) ;
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
