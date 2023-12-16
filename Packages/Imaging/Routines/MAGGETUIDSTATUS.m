MAGGETUIDSTATUS ;WOIFO/RRM - GET UID STATUS ; Feb 24, 2023@12:26:15
 ;;3.0;IMAGING;**345**;Mar 19, 2002;Build 2
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs.     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; 
 Q  ;No direct call
 ;
STUDYUIDSTAT(STUDYUID) ;Get the STUDY UID status 
 N STUDYIEN,STATUS
 S STATUS=""
 I $D(^MAGV(2005.62,"B",STUDYUID)) D
 . ;get UID status of the latest entry
 . S STUDYIEN=$O(^MAGV(2005.62,"B",STUDYUID,""),-1)
 . S STATUS=$P($G(^MAGV(2005.62,STUDYIEN,5)),U,2)
 Q $G(STATUS)
 ;
GETSERIESUIDSTAT(SERIESUID) ;
 N SERIESIEN,STATUS
 S STATUS=""
 I $D(^MAGV(2005.63,"B",SERIESUID)) D
 . ;get UID status of the latest entry
 . S SERIESIEN=$O(^MAGV(2005.63,"B",SERIESUID,""),-1)
 . S STATUS=$G(^MAGV(2005.63,SERIESIEN,9))
 Q $G(STATUS)
 ;
GETSOPUIDSTAT(SOPUID) ;
 N SOPIEN,STATUS,ISAOF
 S STATUS=""
 I $D(^MAGV(2005.64,"B",SOPUID)) D
 . ;get UID status of the the latest entry
 . S SOPIEN=$O(^MAGV(2005.64,"B",SOPUID,""),-1)
 . S STATUS=$G(^MAGV(2005.64,SOPIEN,11))
 . S ISAOF=$P($G(^MAGV(2005.64,SOPIEN,6)),U,2)
 Q $G(STATUS)
 ;
GETUIDSTAT2005(UID) ;
 N MAGIEN,STATUS
 S STATUS=""
 I $D(^MAG(2005,"P",UID)) D  Q:$G(STATUS)
 . ;get the latest entry
 . S MAGIEN=$O(^MAG(2005,"P",UID,""),-1)
 . S STATUS=$P($G(^MAG(2005,MAGIEN,100)),"^",8)
 I $D(^MAG(2005,"SERIESUID",UID)) D
 . S MAGIEN=$O(^MAG(2005,"SERIESUID",UID,""),-1)
 . S STATUS=$P($G(^MAG(2005,MAGIEN,100)),"^",8)
 Q $G(STATUS)
 ;
