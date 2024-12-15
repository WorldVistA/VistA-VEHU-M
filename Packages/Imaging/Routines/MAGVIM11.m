MAGVIM11 ;WOIFO/BT - Utilities for RPC calls for DICOM file processing ; Nov 05, 2023@13:02:32
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
 Q
STATSEP() ; Status and result separator ie. -3``No record IEN
 Q "`"
 ; RPC: MAGV GET WORK ITEM SOURCES
GETSRCS(OUT) ; Returns all work items' sources
 N SSEP,FILE,PROC,I
 D GETFLTR(.OUT,"Source")
 Q
 ; RPC: MAGV GET WORK ITEM PROCEDURES
GETPROCS(OUT) ; Returns all work items' procedures
 N SSEP,FILE,PROC,I
 D GETFLTR(.OUT,"Procedure")
 Q
 ; RPC: MAGV GET WORK ITEM MODALITIES
GETMDLS(OUT) ; Returns all work items' modalities
 N SSEP,FILE,PROC,I
 D GETFLTR(.OUT,"Modality")
 Q
GETFLTR(OUT,TAG) ;
 N SSEP,FILE,VAL,I
 S VAL="",I=0,SSEP=$$STATSEP,FILE=2006.941
 F I=1:1:9999 S VAL=$O(^MAGV(FILE,"HH",TAG,VAL)) Q:VAL=""  S OUT(I+1)=VAL
 S OUT(1)=0_SSEP_I
 Q
