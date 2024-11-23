MAGD350I ;WOIFO/PMK - Fix problem with JPEG DCM files; Sep 25, 2024@11:14:40
 ;;3.0;IMAGING;**350**;Mar 19, 2002;Build 4
 ;; Per VHA Directive 2004-038, this routine should not be modified.
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
 ; Private IA #4389 to read the INSTALL file (#9.7)
 ;;
 ;;
 ; These RPC fix a problem caused by MAG*3.0*226 which changed
 ; the way that Clinical Capture DICOM images were stored so that
 ; instead of storing them as DICOM objects, they were stored as
 ; raw JPEG images with a DCM extension.
 ; 
 ; No other RPCs are to be included in this routine.
 Q
 ;
 ; FIND JPEG IMAGES THAT HAVE *.DCM EXTENSIONS
ENTRY(OUT,MAXCOUNT,MAGIEN) ; RPC = MAG DICOM P350 MAKE LIST
 N ASSOCSITEID,COUNT,IMAGESAVEDT,INST,INSTALLDATE
 N PREVIOUSMAGIEN,RETURN,SITE,SITEID,SITELIST,TYPECONSULT
 K OUT
 S SITEID=$G(DUZ(2)) ; P350 PMK 07/26/2024
 I 'SITEID S SITEID=$$KSP^XUPARAM("INST") ; pointer to INSTITUTION file (#4)
 ;
 ; build SITELIST - P350 PMK 07/29/2024
 S SITE=$O(^MAG(2006.1,"B",SITEID,""))
 S SITELIST(SITEID)=""
 S INST=0 F  S INST=$O(^MAG(2006.1,SITE,"INSTS",INST)) Q:'INST  D
 . S ASSOCSITEID=$G(^MAG(2006.1,SITE,"INSTS",INST,0))
 . S SITELIST(ASSOCSITEID)=""
 . Q
 ;
 I '$G(MAXCOUNT) S MAXCOUNT=1000
 S COUNT=0
 S TYPECONSULT=$O(^MAG(2005.83,"B","CONSULT",""))
 ;
 I '$G(MAGIEN) D  ; get MAGIEN value automatically
 . S MAGIEN=$G(^MAG(2006.59935,0,"LAST MAGIEN"),0)
 . I MAGIEN=0 D  ; find first image after MAG*3.0*226 install
 . . N NEXTDATE
 . . S INSTALLDATE=$$FINDDATE()
 . . S MAGIEN=$O(^MAG(2005,"AD",INSTALLDATE,""))
 . . I MAGIEN="" D
 . . . S NEXTDATE=$O(^MAG(2005,"AD",INSTALLDATE))
 . . . S MAGIEN=$O(^MAG(2005,"AD",NEXTDATE,""))
 . . . Q
 . . Q
 . Q
 ;
 F  S MAGIEN=$O(^MAG(2005,MAGIEN)) Q:'MAGIEN  D  Q:COUNT>=MAXCOUNT
 . S COUNT=COUNT+1
 . S PREVIOUSMAGIEN=MAGIEN
 . S RETURN=$$CHECK(MAGIEN,.IMAGESAVEDT,.SITELIST)
 . I RETURN="" D
 . . N FIXDT,STATUS
 . . S STATUS="UNKNOWN"
 . . S FIXDT=""
 . . D SAVE(MAGIEN,IMAGESAVEDT,STATUS,FIXDT)
 . . Q
 . Q
 S OUT(1)=4
 S OUT(2)=COUNT
 S OUT(3)=$P($G(^MAG(2006.59935,0)),"^",4)
 S OUT(4)=MAGIEN
 S OUT(5)=$G(PREVIOUSMAGIEN)
 S OUT(6)=$G(IMAGESAVEDT)
 Q
 ;
CHECK(MAGIEN,IMAGESAVEDT,SITELIST) ; check ^MAG(2005) for a *.DCM extension but wrong file type
 N ACQSITE,CAPTUREAPP,EXTENSION,FILENAME,NODE0,NODE2,NODE40,SERIESUID,SOPUID,TYPEINDEX
 S ACQSITE=$$GET1^DIQ(2005,MAGIEN,.05,"I")
 I ACQSITE,'$D(SITELIST(ACQSITE)) Q "-8,Acquistion Site is different"
 S NODE0=$G(^MAG(2005,MAGIEN,0)) I NODE0="" Q "-1,NODE0 is null"
 S NODE2=$G(^MAG(2005,MAGIEN,2)) I NODE2="" Q "-2,NODE2 is null"
 S NODE40=$G(^MAG(2005,MAGIEN,40)) I NODE40="" Q "-3,NODE40 is null"
 S SOPUID=$G(^MAG(2005,MAGIEN,"PACS")) ; PACS UID (SOP Instance UID)
 I SOPUID="" Q "-4,No SOP Instance UID (""PACS"")" ; can't do DICOM
 S SERIESUID=$G(^MAG(2005,MAGIEN,"SERIESUID")) ; SERIES UID
 I SERIESUID="" Q "-5,No Series Instance UID" ; can't do DICOM
 S IMAGESAVEDT=$P(NODE2,"^",1) ;  ; DATE/TIME IMAGE SAVED
 S CAPTUREAPP=$P(NODE2,"^",12) ; CAPTURE APPLICATION
 ; S TYPEINDEX=$P(NODE40,"^",3) ; TYPE INDEX -- removed P350 PMK 09/25/2024
 ; I TYPEINDEX'=TYPECONSULT Q "1,Type Index is not Consult" -- removed P350 PMK 09/25/2024
 S FILENAME=$P(NODE0,"^",2) ; FILEREF
 S EXTENSION=$P(FILENAME,".",2) ; EXTENSION
 I EXTENSION'="DCM" Q "-6,Not *.DCM file"
 I CAPTUREAPP'="C" Q "-7,Not acquired by Capture Client"
 Q ""
 ;
FINDDATE() ; find the install date for MAG*3.0*226
 ; Start date based on P226 install - P226 introduced the DICOM conversion issue
 N A,INSTALLDATE
 ; shouldn't use FIND1^DIC because it fails if the patch was installed multiple times
 D FIND^DIC(9.7,"","17I;@","B","MAG*3.0*226","","","","","A") ; ICR #4389
 S INSTALLDATE=$G(A("DILIST","ID",1,17))
 S INSTALLDATE=INSTALLDATE\1 ; remove the time
 Q INSTALLDATE
 ;
SAVE(MAGIEN,IMAGESAVEDT,STATUS,FIXDT) ; SAVE/UPDATE
 N AUDITIEN,D0,X
 S AUDITIEN=MAGIEN ; IMAGE AUDIT file IEN is same as IMAGE file IEN
 ; 
 S D0=$O(^MAG(2006.59935,"B",MAGIEN,""))
 I D0 Q  ; only new entries - no duplicate entries
 ;
 S X=$G(^MAG(2006.59935,0))
 S $P(X,"^",1,2)="CLEANUP OF JPEG IMAGES STORED AS DICOM IMAGES^2006.59935"
 S D0=$O(^MAG(2006.59935," "),-1)+1 ; Next number
 S $P(X,"^",3)=D0
 S $P(X,"^",4)=$P(X,"^",4)+1 ; Total count
 S ^MAG(2006.59935,0)=X
 S ^MAG(2006.59935,D0,0)=MAGIEN_"^"_IMAGESAVEDT_"^"_STATUS_"^"_FIXDT_"^^"_AUDITIEN_"^^^"
 S ^MAG(2006.599350,"B",MAGIEN,D0)=""
 S ^MAG(2006.599350,"C",STATUS,D0)=""
 S ^MAG(2006.59935,0,"LAST MAGIEN")=MAGIEN
 Q
 ;
KILL ; remove the global
  K ^MAG(2006.59935)
  Q
  ;
GETNEXT(OUT) ; RPC = MAG DICOM P350 GET NEXT TO FIX
 N IEN
 K OUT
 S IEN=$O(^MAG(2006.59935,"C","UNKNOWN",""))
 I IEN D
 . S OUT=$G(^MAG(2006.59935,IEN,0))
 . Q
 E  S OUT=""
 Q
 ;
FIXONE(OUT,MAGIEN,NEWSTATUS,ERRORMSG,SOPUID) ; RPC = MAG DICOM P350 FIX ONE IMAGE
 N D0,FIXDT,OLDSTATUS,REASONIEN,X
 S REASONIEN=$O(^MAG(2005.88,"B","Corrected DICOM image generate",""))
 S SOPUID=$G(SOPUID)
 K OUT
 S ERRORMSG=$G(ERRORMSG)
 S D0=$O(^MAG(2006.59935,"B",MAGIEN,""))
 I D0'="" D
 . S X=$G(^MAG(2006.59935,D0,0)) Q:X=""
 . S OLDSTATUS=$P(X,"^",3)
 . K ^MAG(2006.59935,"C",OLDSTATUS,D0)
 . S ^MAG(2006.59935,"C",NEWSTATUS,D0)=""
 . S FIXDT=$$NOW^XLFDT()
 . S $P(^MAG(2006.59935,D0,0),"^",3,5)=NEWSTATUS_"^"_FIXDT_"^"_ERRORMSG
 . I SOPUID'="" S $P(^MAG(2006.59935,D0,0),"^",7)=SOPUID
 . S OUT=0
 . ; set STATUS REASON field 113.3 in IMAGE file (#2005)
 . I NEWSTATUS="SUCCESS",REASONIEN D
 . . N MAGERR,MAGIENS
 . . S MAGFDA(2005,MAGIEN_",",113.3)=REASONIEN  ; STATUS REASON (-> 2005.8)
 . . D UPDATE^DIE("","MAGFDA","MAGIENS","MAGERR")
 . . I $D(MAGERR) S OUT="1,Could not update IMAGE file (#2005) with STATUS REASON (#113.3)"
 . . Q
 . Q
 E  S OUT="-1,Entry #"_MAGIEN_" not found in file 2006.59935"
 Q
 ;
FIXFAIL(OUT) ; RPC = MAG DICOM P350 FIX FAIL IMAGES
 N COUNT,D0,LOWESTIEN,MAGIEN,RESULT,X
 S COUNT=0,LOWESTIEN=999999999999999999
 S D0="" F  S D0=$O(^MAG(2006.59935,"C","FAIL",D0)) Q:D0=""  D
 . S X=$G(^MAG(2006.59935,D0,0)) Q:X=""
 . S MAGIEN=$P(X,"^",1)
 . I $O(^MAG(2006.59935,"B",MAGIEN,""))="" Q
 . D FIXONE(.RESULT,MAGIEN,"UNKNOWN","1,Fixed for Reprocessing")
 . I RESULT'=0 Q
 . S COUNT=COUNT+1
 . I MAGIEN<LOWESTIEN D
 . . S LOWESTIEN=MAGIEN
 . . S ^MAG(2006.59935,0,"LAST MAGIEN")=LOWESTIEN-1
 . . Q
 . Q
 S OUT=COUNT
 Q
 ;
UPDATE(OUT) ; RPC = MAG DICOM P350 UPDATE FIELDS
 N D0,MAGIEN,NEWIMAGEIEN,REASON,REASONIEN,SOPUID,X
 N DOCDATE,IPROCIDX,ISPECIDX,NEWGROUPIEN,SAVEDBY,SHORTDESC
 N COMPLETED,ERROR1,ERROR2,NOTPROCESSED,UPDATED
 S (COMPLETED,UPDATED,NOTPROCESSED,ERROR1,ERROR2)=0
 S REASON="Corrected DICOM image generated by Patch MAG*3.0*350"
 S REASONIEN=$O(^MAG(2005.88,"B",$E(REASON,1,30),""))
 S (D0,ERROR)=0 F  S D0=$O(^MAG(2006.59935,"C","SUCCESS",D0)) Q:D0=""  D
 . S X=$G(^MAG(2006.59935,D0,0)) I X="" S ERROR1=ERROR1+1 Q
 . I $P(X,"^",9)'="" S COMPLETED=COMPLETED+1 Q  ; already updated
 . S MAGIEN=$P(X,"^",6),SOPUID=$P(X,"^",7)
 . I SOPUID="" S ERROR2=ERROR2+1 Q
 . S NEWIMAGEIEN=$O(^MAG(2005,"P",SOPUID,""))
 . I NEWIMAGEIEN="" S NOTPROCESSED=NOTPROCESSED+1 Q
 . S $P(^MAG(2006.59935,D0,0),"^",8)=NEWIMAGEIEN
 . S UPDATED=UPDATED+1
 . S NEWGROUPIEN=$$GET1^DIQ(2005,NEWIMAGEIEN,14,"I")
 . ; get old values from original image in AUDIT file
 . N ORIGIN,PACKAGEINDEX,PROCEDURE,TYPEINDEX
 . S ORIGIN=$$GET1^DIQ(2005.1,MAGIEN,45,"I")
 . S PACKAGEINDEX=$$GET1^DIQ(2005.1,MAGIEN,40,"I")
 . S PROCEDURE=$$GET1^DIQ(2005.1,MAGIEN,6,"I")
 . S SHORTDESC=$$GET1^DIQ(2005.1,MAGIEN,10,"I")
 . S TYPEINDEX=$$GET1^DIQ(2005.1,MAGIEN,42,"I")
 . S DOCDATE=$$GET1^DIQ(2005.1,MAGIEN,110,"I")
 . S SAVEDBY=$$GET1^DIQ(2005.1,MAGIEN,8,"I")
 . S ISPECIDX=$$GET1^DIQ(2005.1,MAGIEN,44,"I")
 . S IPROCIDX=$$GET1^DIQ(2005.1,MAGIEN,43,"I")
 . ;
 . S ERROR=$$DBUPDATE(NEWIMAGEIEN) Q:ERROR  ; update the new image
 . S ERROR=$$DBUPDATE(NEWGROUPIEN) Q:ERROR  ; update the new group
 . ;
 . S $P(^MAG(2006.59935,D0,0),"^",9)=$$NOW^XLFDT ; record update time
 . Q
 I ERROR Q
 S OUT=COMPLETED_"^"_UPDATED_"^"_NOTPROCESSED_"^"_ERROR1_"^"_ERROR2
 Q
 ;
DBUPDATE(IEN) ; update IMAGE file, either group or image entry
 N IENS,MAGERR,MAGFDA
 S IENS=IEN_","
 ; store old values into new entry in IMAGE file
 S MAGFDA(2005,IENS,45)=ORIGIN        ; ORIGIN
 S MAGFDA(2005,IENS,40)=PACKAGEINDEX  ; PACKAGE INDEX
 S MAGFDA(2005,IENS,6)=PROCEDURE      ; PROCEDURE
 S MAGFDA(2005,IENS,10)=SHORTDESC     ; SHORT DESCRIPTION
 S MAGFDA(2005,IENS,42)=TYPEINDEX     ; TYPE INDEX (->2005.83)
 S MAGFDA(2005,IENS,113.3)=REASONIEN  ; STATUS REASON (-> 2005.8)
 S MAGFDA(2005,IENS,110)=DOCDATE      ; DOCUMENT DATE
 S MAGFDA(2005,IENS,8)=SAVEDBY        ; IMAGE SAVE BY (->200)
 S MAGFDA(2005,IENS,44)=ISPECIDX      ; SPEC/SUBSPEC INDEX (-> 2005.84)
 S MAGFDA(2005,IENS,43)=IPROCIDX      ; PROC/EVENT INDEX (-> 2005.85)
 ;
 D UPDATE^DIE("","MAGFDA","NEWIENS","MAGERR")
 I $D(MAGERR)  D  Q -1
 . D DBERROR("-1,Could not update IMAGE file (#2005) for new MAGIEN = "_IEN,.MAGERR)
 . Q
 K ^MAG(2005,IEN,99) ; remove AUDIT nodes
 Q 0
 ;
DBERROR(CODE,MAGERR) ; generate error message
 N I,J,X
 K OUT
 S X=" DB Error:"
 S I="" F  S I=$O(MAGERR("DIERR",I)) Q:'I  D
 . S J="" F J=$O(MAGERR("DIERR",I,"TEXT",J)) D
 . . S X=X_" "_MAGERR("DIERR",I,"TEXT",J)
 . . Q
 . Q
 S OUT=CODE_","_X
