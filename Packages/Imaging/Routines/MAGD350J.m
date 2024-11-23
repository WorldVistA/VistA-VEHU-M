MAGD350J ;WOIFO/EDM/PMK - Imaging RPCs ; Jul 26, 2024@10:41:12
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
 ;
 ; Supported IA #2056 reference $$GET1^DIQ function call
 ; Controlled IA #4110 to read REQUEST/CONSULTATION file (#123)
 ; Controlled IA #3268 to read TIU DOCUMENT file (#8925)
 ;
 ; Copied from MAGDRPC2 and then modified to support TIER-2 lookups
 ;
 Q
 ;
IMAGE(OUT,D0) ; RPC = MAG DICOM P350 GET BASIC IMAGE
 N I,MSG,TARGET,V,VE,VI,X
 K OUT S I=1
 I '$G(D0) S OUT(1)="-1,Invalid IEN ("_$G(D0)_")" Q
 I $D(^MAG(2005.1,D0,0)) S OUT(1)="-3,Image #"_D0_" has been deleted." Q
 I '$D(^MAG(2005,D0,0)) S OUT(1)="-2,No data for """_D0_"""." Q
 ;
 D GETS^DIQ(2005,D0_",","*","REIN","TARGET","MSG")
 S X="" F  S X=$O(TARGET(2005,D0_",",X)) Q:X=""  D
 . S VI=$G(TARGET(2005,D0_",",X,"I"))
 . S VE=$G(TARGET(2005,D0_",",X,"E"))
 . S I=I+1,OUT(I)=X_"^"_VI S:VI'=VE OUT(I)=OUT(I)_"^"_VE
 . Q
 ;
 D FILEFIND^MAGD350K(D0,"FULL",0,0,.X,.V)
 S:X'<0 I=I+1,OUT(I)="TIER-1 Full FileName^"_X
 S:V'<0 I=I+1,OUT(I)="TIER-1 Full Path+FileName^"_V
 ;
 D FILEFIND^MAGD350K(D0,"BIG",0,0,.X,.V)
 S:X'<0 I=I+1,OUT(I)="TIER-1 Big FileName^"_X
 S:V'<0 I=I+1,OUT(I)="TIER-1 Big Path+FileName^"_V
 ;
 D FILEFIND^MAGD350K(D0,"ABSTRACT",0,0,.X,.V)
 S:X'<0 I=I+1,OUT(I)="TIER-1 Abstract FileName^"_X
 S:V'<0 I=I+1,OUT(I)="TIER-1 Abstract Path+FileName^"_V
 ;
 S (V,X)=0 F  S X=$O(^MAG(2005,D0,1,X)) Q:'X  S V=V+1
 S:V I=I+1,OUT(I)="# Images^"_V
 ;
 ; new code for TIER-2 support
 ;
 D FILEFIND^MAGD350K(D0,"FULL TIER-2",0,0,.X,.V)
 S:X'<0 I=I+1,OUT(I)="TIER-2 Full FileName^"_X
 S:V'<0 I=I+1,OUT(I)="TIER-2 Full Path+FileName^"_V
 ;
 D FILEFIND^MAGD350K(D0,"BIG TIER-2",0,0,.X,.V)
 S:X'<0 I=I+1,OUT(I)="TIER-2 Big FileName^"_X
 S:V'<0 I=I+1,OUT(I)="TIER-2 Big Path+FileName^"_V
 ;
 D FILEFIND^MAGD350K(D0,"ABSTRACT TIER-2",0,0,.X,.V)
 S:X'<0 I=I+1,OUT(I)="TIER-2 Abstract FileName^"_X
 S:V'<0 I=I+1,OUT(I)="TIER-2 Abstract Path+FileName^"_V
 ;
 S I=I+1,OUT(I)="ACCESSION NUMBER^"_$$ACNUMB(.OUT) ; get accession number
 ;
 S (V,X)=0 F  S X=$O(^MAG(2005,D0,1,X)) Q:'X  S V=V+1
 S:V I=I+1,OUT(I)="# Images^"_V
 ;
 S OUT(1)=I-1
 Q
 ;
ACNUMB(OUT) ; get accession number
 N ACNUMB,DATA,FIELD,GMRCIEN,GMRCREF,I,TIUIEN,X
 N PARENTDATAFILE,PARENTIMAGEPTR,PARENTROOTD0,PARENTROOTG1
 S I=1 F  S I=$O(OUT(I)) Q:I=""  D
 . S X=OUT(I),FIELD=$P(X,"^",1) S:FIELD'="" DATA(FIELD)=$P(X,"^",2,3)
 . Q
 S PARENTDATAFILE=$G(DATA("PARENT DATA FILE#"))
 S PARENTROOTD0=$G(DATA("PARENT GLOBAL ROOT D0"))
 S PARENTIMAGEPTR=$G(DATA("PARENT DATA FILE IMAGE POINTER"))
 S PARENTROOTG1=$G(DATA("PARENT GLOBAL ROOT D1"))
 ;
 S ACNUMB=""
 ;
 I PARENTDATAFILE="74^RADIOLOGY" D  ; radiololgy
 . S ACNUMB=$$GET1^DIQ(74,PARENTROOTD0,.01) ; radiology day-case#
 . Q
 E  I PARENTDATAFILE="8925^TIU" D  ; tiu
 . S TIUIEN=PARENTROOTD0
 . S GMRCREF=$$GET1^DIQ(8925,TIUIEN,1405,"I")
 . I GMRCREF?1N.N1";GMR(123," D
 . . S GMRCIEN=$P(GMRCREF,";",1)
 . . S ACNUMB=$$GMRCACN^MAGDFCNV(GMRCIEN)
 . . Q
 . Q
 E  I PARENTDATAFILE="2006.5839^DICOM GMRC TEMP LIST" D  ; dicom gmrc temp list
 . S GMRCIEN=PARENTROOTD0
 . S ACNUMB=$$GMRCACN^MAGDFCNV(GMRCIEN) ; P350 PMK 07/25/2024
 . Q
 Q ACNUMB
