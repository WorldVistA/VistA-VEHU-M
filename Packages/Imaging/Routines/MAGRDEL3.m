MAGRDEL3 ;WIRMFO/RED/GEK DELPHI API CALLS [ 18-AUG-2000 14:47:56 ]
 ;;2.5T11;MAG;;18-Aug-2000
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a Class II medical device.  As such, it may not be changed    |
 ;; | in any way.  Modifications to this software may result in an  |
 ;; | adulterated medical device under 21CFR820, the use of which   |
 ;; | is considered to be a violation of US Federal Statutes.       |
 ;; +---------------------------------------------------------------+
 ;;
GETWRITE(ZY,MAGIN) ; GET WRITE LOCATION AT A (REMOTE) SITE 
 ; Returns: (NETWORK LOC PTR)^(NETWORK LOC .01 NAME)^(PHYSICAL REF)
 N MAGRET,MAGREFNM,MAGDRIVE
 S X="ERR^MAGRDEL3",@^%ZOSF("TRAP")
 S MAGRET=$G(^MAG(2006.1,"ARITE")) I MAGRET="" S ZY="0^No write location in site parameters file." Q
 S MAGREFNM=$P(^MAG(2005.2,MAGRET,0),"^",1),MAGDRIVE=$P(^(0),"^",2)
 S ZY=MAGRET_"^"_MAGREFNM_"^"_MAGDRIVE
 Q
DUZLU(ZY,MAGIN) ;GET DUZ FOR PERSON
 S X="ERR^MAGRDEL3",@^%ZOSF("TRAP")
 S ZY="0^ERROR"
 I $D(^VA(200,"B",MAGIN)) S ZY=$O(^VA(200,"B",MAGIN,"")) Q
 S ZY="0^Not in New Person File.  See IRM."
 Q
CONLU(ZY,MAGIN) ;GET IMAGES FOR A CONSULT FROM FILE 2005.15
 S X="ERRA^MAGRDEL3",@^%ZOSF("TRAP")
 ;S ZY(0)="0^ERROR GETTING CONSULT IMAGES"
 S MAGIEN=+$P(MAGIN,"^",1),MAGCT=0,MAGT=0
 F I=1:1 S MAGCT=$O(^MAG(2005.15,MAGIEN,2,MAGCT)) Q:+MAGCT<1  D
 . S MAGT=MAGT+1,MAGXX=^MAG(2005.15,MAGIEN,2,MAGCT,0) D BOTH^MAGFILEB S MAGFILE="B2^"_MAGFILE
 . S ZY(MAGT)=MAGFILE
 ;S ZY(0)="1^"_MAGT
 K MAGT,MAGIEN,MAGCT,MAGXX,MAGFILE Q
ABSJB(ZY,MAGIN) ; SET ABSTRACT AND/OR JUKEBOX QUEUES
 S X="ERR^MAGRDEL3",@^%ZOSF("TRAP")
 S ^TMP("MAGRDEL3",$J,"MAGIN")=MAGIN
 S ZY="0^ERROR: Setting Queue for Abstract or JukeBox copy"
 S MAGIENAB=+$P(MAGIN,"^",1),MAGIENJB=$P(MAGIN,"^",2)
 I +MAGIENAB>0 S X=$$ABSTRACT^MAGBAPI(MAGIENAB)
 I MAGIENJB'="" S X=$$JUKEBOX^MAGBAPI(MAGIENJB)
 S ZY="1^SUCCESSFUL" Q
ERR ;
 S ZY="0^ERROR "_$$EC^%ZOSV
 D @^%ZOSF("ERRTN")
 Q
ERRA ;
 S ZY(0)="0^ERROR "_$$EC^%ZOSV
 D @^%ZOSF("ERRTN")
 Q
