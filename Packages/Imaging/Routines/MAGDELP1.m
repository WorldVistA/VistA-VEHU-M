MAGDELP1 ;WIRMFO/RED/GEK  First RPC Callbacks IMGVW [ 18-AUG-2000 14:47:56 ]
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
IMGINFO ; RETURN IMAGE INFO FOR IMAGENO
IMGINF(MAGRY,MAGMESS) ;RETURN IMAGE INFO FOR IMAGENO OF FILE 2005
 N Y
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 E  S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 S MAGXX=$P(MAGMESS,"^",1),MAGDUZ=$P(MAGMESS,"^",2)
 D BOTH^MAGFILEB
 S MAGRY=MAGFILE
 Q
IMGPT(MAGRY,MAGMESS) ;RETURN IMAGE INFO LIST FOR PATIENT
 N Y
 K ^TMP("MAGDELP1",$J)
 S ^TMP("MAGDELP1",$J,"MAGMESS")=MAGMESS
 ; NEW ERROR TRAP
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 E  S X="ERRA^MAGGTERR",@^%ZOSF("TRAP")
 ;
 S MAGDFN=$P(MAGMESS,"^",1),MAGDUZ=$P(MAGMESS,"^",2),MAGGP=$P(MAGMESS,"^",3) S:MAGDUZ="" MAGDUZ=0 S MAGSYS=$P(MAGMESS,"^",4)
 F I=1:1:10 I $E(MAGDFN,1)=" " S MAGDFN=$E(MAGDFN,2,99)
 S MAGDFN=+MAGDFN
 I '$D(^MAG(2005,"AC",MAGDFN)) S MAGRY(0)="1^0" Q
 S MAGT=0,MAGIFN=0,MAGCT=0
 F  S MAGIFN=$O(^MAG(2005,"AC",MAGDFN,MAGIFN)) Q:MAGIFN'>0  D
 . I '$D(^MAG(2005,MAGIFN)) D  Q
 . . S MAGMSG="INVALID 'AC' cross ref. Patient: "_MAGDFN_" Image Internal Number "_MAGIFN Q
 . . ; We should send this to someone. ??? who.
 . I MAGGP="" Q:$P($G(^MAG(2005,MAGIFN,0)),"^",10)  ; CHILD OF GROUP
 . I MAGGP'="" Q:$D(^MAG(2005,MAGIFN,1))  ; GROUP
 . S MAGT=MAGT+1
 . I MAGT>250 Q
 . S MAGCT=MAGCT+1
 . S MAGXX=MAGIFN D BOTH^MAGFILEB S MAGFILE="B2^"_MAGFILE
 . S MAGRY(MAGCT)=MAGFILE
 S MAGRY(0)="1^"_MAGCT
 I MAGT>MAGCT S MAGRY(0)=MAGRY(0)_" of "_MAGT
 D ENTRY^MAGLOG("IMGVW",MAGDUZ,"","IMGPT-MAGDELP1",MAGDFN,MAGT)
 K MAGT,MAGIFN
 Q
IMGPTRE(MAGRY,MAGMESS) ;RETURN IMAGE INFO LIST FOR PATIENT
 N Y
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 E  S X="ERRA^MAGGTERR",@^%ZOSF("TRAP")
 S MAGDFN=$P(MAGMESS,"^",1),MAGDUZ=$P(MAGMESS,"^",2) S:MAGDUZ="" MAGDUZ=0
 S MAGGP=$P(MAGMESS,"^",3),MAGSYS=$P(MAGMESS,"^",4)
 F I=1:1:10 I $E(MAGDFN,1)=" " S MAGDFN=$E(MAGDFN,2,99)
 S MAGDFN=+MAGDFN
 I '$D(^MAG(2005,"APDTPX",MAGDFN)) S MAGRY(0)="1^0" Q
 S MAGCT=0,MAGT=0,MAGI=0,MAGP="",MAGPD=""
 F  S MAGPD=$O(^MAG(2005,"APDTPX",MAGDFN,MAGPD)) Q:MAGPD=""  D
 . S MAGP="" F  S MAGP=$O(^MAG(2005,"APDTPX",MAGDFN,MAGPD,MAGP)) Q:MAGP=""  D
 . . S MAGI="" F  S MAGI=$O(^MAG(2005,"APDTPX",MAGDFN,MAGPD,MAGP,MAGI)) Q:+MAGI<1  D
 . . . I '$D(^MAG(2005,MAGI)) D  Q
 . . . . S MAGMSG="INVALID 'APDTPX' cross ref. Patient: "_MAGDFN_" Image Internal Number "_MAGI Q
 . . . . ; We should send this to someone. ??? who.
 . . . Q:$P($G(^MAG(2005,MAGI,0)),"^",10)  ; CHILD OF GROUP
 . . . S MAGT=MAGT+1
 . . . I MAGT>250 Q
 . . . S MAGCT=MAGCT+1
 . . . I '$D(^MAG(2005,MAGI)) S MAGRY(MAGCT)="B2^^^^INVALID Image Internal Number "_MAGI Q
 . . . S MAGXX=MAGI D BOTH^MAGFILEB S MAGFILE="B2^"_MAGFILE
 . . . S MAGRY(MAGCT)=MAGFILE
 S MAGRY(0)="1^"_MAGCT
 I MAGT>MAGCT S MAGRY(0)=MAGRY(0)_" of "_MAGT
 D ENTRY^MAGLOG("IMGVW",MAGDUZ,"","IMGPTRE-MAGDELP1",MAGDFN,MAGT)
 K MAGT,MAGI
 Q
GRP(MAGRY,MAGMESS) ;RETURN IMAGE LIST FOR GROUP
 N Y
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 E  S X="ERRA^MAGGTERR",@^%ZOSF("TRAP")
 K ^TMP("MAGDELP1","GRP","DATA")
 S ^TMP("MAGDELP1","GRP","DATA")=$G(MAGMESS)
 S MAGOG=$P(MAGMESS,"^",1),MAGDUZ=$P(MAGMESS,"^",2) S:MAGDUZ="" MAGDUZ=0
 S MAGSYS=$P(MAGMESS,"^",4)
 S MAGBIGG=$P(MAGMESS,"^",5)
 F I=1:1:10 I $E(MAGOG,1)=" " S MAGOG=$E(MAGOG,2,99)
 S MAGOG=+MAGOG
 I '$D(^MAG(2005,MAGOG,0)) S MAGRY(0)="" Q
 I $O(^MAG(2005,MAGOG,1,0))="" S MAGRY(0)="0^ERROR: There are NO Images defined for this Group" Q
 I +$P($G(^MAG(2005,MAGOG,1,0)),U,4)>200,MAGBIGG D  Q
 . S MAGRY(0)="0^0^BIGGROUP^"_$P(^MAG(2005,MAGOG,1,0),U,4)
 S MAGT=0,MAGI=0,MAGCT=0,MAGDFN=$P(^MAG(2005,MAGOG,0),"^",7)
 F  S MAGI=$O(^MAG(2005,MAGOG,1,MAGI)) Q:MAGI'>0  D
 . S MAGT=MAGT+1
 . I MAGT>210 Q
 . S MAGLI=MAGI
 . S MAGCT=MAGCT+1
 . S MAGXX=+^MAG(2005,MAGOG,1,MAGI,0)
 . I '$D(^MAG(2005,MAGXX)) S MAGRY(MAGCT)="B2^^^^INVALID Image Internal Number "_MAGXX Q
 . D BOTH^MAGFILEB S MAGFILE="B2^"_MAGFILE
 . S MAGRY(MAGCT)=MAGFILE
 S MAGRY(0)="1^"_MAGCT
 I MAGT>MAGCT S MAGRY(0)=MAGRY(0)_" of "_MAGT_U_MAGCT_":"_MAGT_":"_MAGLI
 D ENTRY^MAGLOG("IMGVW",MAGDUZ,MAGOG,"GRP-MAGDELP1",MAGDFN,MAGT)
 K MAGT,MAGI
 Q
FILEPUT(MAGRY,MAGMESS) ;
 N Y,MAGLOC,MAGLOC2
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 E  S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 S MAGRY="0^STARTED"
 S MAGXX=+$P(MAGMESS,"^",1) D VSTNOCP^MAGFILEB
 S MAGLOC=$P(MAGMESS,"^",2) I '$D(^MAG(2005.2,"B",MAGLOC)) D
 . S MAGLOC2="" I $D(^MAG(2005.2,"AC",MAGLOC)) S MAGLOC2=$O(^MAG(2005.2,"AC",MAGLOC,""))
 . I MAGLOC2="" S MAGLOC="",MAGRY="0^ERROR: CANNOT FIND REMOTE LOCATION IN NETWORK LOCATION FILE" Q
 . S MAGLOC=$P(^MAG(2005.2,MAGLOC2,0),"^",1)
 I ($G(MAGLOC)=""&($G(MAGLOC2)="")) K MAGXX,MAGFILE1 S MAGRY="0^ERROR: CANNOT FIND REMOTE LOCATION" Q
 S X=$$FILECOPY^MAGBAPI($P(MAGFILE2,".",1)_".*",MAGLOC)
 S MAGRY="1A^Queued as "_$G(X)
 K MAGFILE1,MAGFILE2,MAGXX
 Q
