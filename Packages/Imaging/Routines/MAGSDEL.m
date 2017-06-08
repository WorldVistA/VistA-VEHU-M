MAGSDEL ;WISC/SRR/RED/SAF-Deletion of Images and Pointers [ 18-AUG-2000 14:47:56 ]
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
SILENT(RY,MAGO,DUZ,DF) ; Entry point for silent call
 ;RY=Return string
 ;MAGO=Image entry number to be deleted (not a group!)
 ;DUZ=Who is doing the deleting
 ;DF=Delete file flag - 1=delete the image file
 ;                    - 0=don't delete the image file
 S RY="0^Delete Failed"
 S MAGSUPER=1,MAGBIKIL=1 K MAGDWN,MAGI,MAGVERB,MAGERR
 S MAGI=MAGO,MAGIFN=MAGO S:'$D(MAGSYS) MAGSYS=^%ZOSF("VOL")
 S U="^"
 I '$D(^MAG(2005,MAGI,0)) S RY="-1^Image entry doesn't exist in image file" G EXIT
 G DELPAR
SUPERV ; Entry point for menu SUPERVISOR option
 S MAGSUPER=1
 S MAGSRV=+$G(^VA(200,DUZ,5)),MAGVERB=1 ;get service/section pointer
 K MAGDWN,MAGI,MAGERR
 G PAT
ENTRY ;I 'MAGSRV D  G EXIT
 ;. W !!,?10,"YOU ARE NOT REGISTERED IN A SERVICE - NO ACCESS",!!!
 ;. Q
 S MAGSRV="IRM" ;S MAGSRV=$P(^DIC(49,MAGSRV,0),U,2) ;ABBREVIATION = Sub-directory
PAT I $D(MAGVERB) W:$D(IOF) @IOF W !!?15,"==========> IMAGE DELETE <==========",!!!
I S MAGDWN="NONE",MAGT=0 ;flag for display routines
 ;D MED^MAGSET3 S:'$D(MAGSYS) MAGSYS=^%ZOSF("VOL") S MAGL=0 D ERASE^MAGSET3
 S:'$D(MAGSYS) MAGSYS=^%ZOSF("VOL") S MAGL=0
 D DPT^MAGPT1 G EXIT:Y<0 K COL,ROW,^TMP("MAG",$J,MAGSYS)
EN2 S PROC="" F  S PROC=$O(^MAG(2005,"APPXDT",DFN,PROC)) Q:PROC=""  D
 . S RDT="" F  S RDT=$O(^MAG(2005,"APPXDT",DFN,PROC,RDT)) Q:RDT=""  D
 . . S DA="" F  S DA=$O(^MAG(2005,"APPXDT",DFN,PROC,RDT,DA)) Q:DA=""  D
 . . . S MAGT=MAGT+1,^TMP("MAG",$J,MAGSYS,MAGL,MAGT)=DA I MAGT=1 S MAGMIN=1
 . . . Q
 . . Q
 . Q
 I 'MAGT W !!?10,"There are no Images for this patient!",*7 H 2 G PAT
DN ;
 K ANSN,MAGMAX S MAGST=1,MAGX=""
 W !?15,"Select Image Number to DISPLAY and SELECT it"
 K Y S MAGBLOB="Delete this image? /Y// " D ENTRY^MAGABLP(0,MAGT,"Do you wish to delete this image? Y// ") S MAGI=Y
AGAIN I +Y<1 W !,"** No image selected **" R !,"Do you wish to delete another patient's images? ",ANS:DTIME
 I +Y<1 I ANS="Y"!(ANS="y") G PAT
 I +Y<1 I ANS="?" W !,"Enter Y or N" G AGAIN
 I +Y<1 G EXIT
 S MAGIFN=Y
 I '$D(MAGSUPER),$P(^MAG(2005,MAGIFN,2),U,2)'=DUZ D  G NOPRIV
 . W ?40,"You cannot delete an image that you did not capture."
 . W *7,*7
 . Q
 W !!?5,"You have selected Image#: ",MAGIFN_"  to delete",!
 W !,?10,"Image Name: ",$P($P(^MAG(2005,MAGIFN,0),U)," ",1,2),!,?10,"Image Description: ",$P(^(2),U,4),!
TEST S DIR("A")="     ARE YOU SURE you want to DELETE IMAGE",DIR(0)="Y"
 S DIR("B")="N" D ^DIR G EN2:Y="^" I 'Y K MAGI G PAT
DELPAR D DELPAR^MAGSDEL2
 I '$D(MAGERR) G DF0
 E  S RY="-1^Error deleting parent pointers" G EXIT
 Q
QUESTOP R !,"Do you wish to delete image and Image File entry? N// ",ANS:DTIME G:ANS="N"!("ANS"="n")!(ANS="") PAT
 I ANS="^" G EXIT
 I ANS="Q"!(ANS="q") G PAT
 I ANS="?" W !,"Because incomplete information is on file for this image, you may want to answer N to stop the deletion process." G QUESTOP
DF0 I $G(DF) G DF
 E  G DELIM
DF ;Delete image file on server if exists
 S X0=^MAG(2005,MAGIFN,0) I $P(X0,U,3)'="" D
 . S MAGXX=MAGIFN D VSTNOCP^MAGFILEB
 . S X=$$DELETE^MAGBAPI(MAGFILE2)
 . I $D(MAGVERB) W !,"Image file deleted from Server..."
 . Q
 ;delete image abstract if one exists
DELABS I $P(X0,U,4)'="" S MAGFILE=$P(MAGFILE2,".")_".ABS",X=$$DELETE^MAGBAPI(MAGFILE)
 I $D(MAGVERB) W !,"Abstract file deleted from Server..."
DELIM ;delete image record & xref's
 K ^TMP("MAG",$J,MAGSYS,MAGI)
 K MAGI,MAGROOT,MAGNODE
 D DELGRP
 I $G(MAGERR) G EXIT
 D ARCHIVE^MAGSDEL(MAGIFN)
 K DIK,DA,DA(1),DA(2),DIC,DR,DIE,DIR S DIK="^MAG(2005,",DA=MAGIFN
 S DFN=$P($G(^MAG(2005,MAGIFN,0)),"^",7)
 D ^DIK
 I $D(^MAG(2005,"AC",DFN,MAGIFN)) K ^MAG(2005,"AC",DFN,MAGIFN)
 I $D(MAGVERB) W !,"Image entry deleted from IMAGE file..." H 2
 D ENTRY^MAGLOG("DELETE",$G(DUZ),$D(MAGIFN),"PARENT:"_$G(MAGSTORE),$G(DFN),1)
 S MAGT=0
NODEL I $D(MAGBIKIL) S RY="1^Delete Successful" G EXIT
 G EN2
NOPRIV Q
DELGRP ;del grp ptrs and check to see if this is the last image in the group
 S MAGGRP=$P($G(^MAG(2005,MAGIFN,0)),"^",10)
 Q:'$G(MAGGRP)
 K DIK,DA,DA(1),DA(2),DIC,DR,DIE,DIR
 S MAGX=0,MAGQUIT=0
 F  S MAGX=$O(^MAG(2005,MAGGRP,1,MAGX)) Q:'MAGX  D  Q:MAGQUIT
 . I ^MAG(2005,MAGGRP,1,MAGX,0)=MAGIFN D
 . . S DIK="^MAG(2005,MAGGRP,1,",DA=MAGX D ^DIK S MAGQUIT=1
 . I $O(^MAG(2005,MAGGRP,1,0))="" D
 . . I $P($G(^MAG(2005,MAGGRP,2)),"^",6) D
 . . . ;report is on group - need to delete it
 . . . S MAGIFNS=MAGIFN,MAGI=MAGGRP,MAGIFN=MAGGRP
 . . . D DELPAR^MAGSDEL2
 . . . S MAGIFN=MAGIFNS
 . . I '$D(MAGERR) D
 . . . D ARCHIVE^MAGSDEL(MAGGRP)
 . . . S DIK="^MAG(2005,",DA=MAGGRP D ^DIK
 Q
ARCHIVE(MAGARCIE) ;save image data before deletion
 S MAGCNT=$P(^MAG(2005.1,0),U,4)+1
 S %X="^MAG(2005,"_MAGARCIE_",",%Y="^MAG(2005.1,"_MAGARCIE_","
 D %XY^%RCR
 S ^MAG(2005.1,0)=$P(^MAG(2005.1,0),U,1,2)_U_MAGARCIE_U_MAGCNT
 S DA=MAGARCIE
 S DIK="^MAG(2005.1," D IX1^DIK
 Q
EXIT ;EXIT
 K MAGGRP,MAGQUIT,MAGX,MAGVERB,MAGSUPER,MAGVOL,MAGDWN,MAGSRV,DFN,AND,MAGT,MAGPTR,MAGLOC,MAGSRV,MAGSTORE,MAGPAR,MAGPARRT,MAGTYP
 K MAGBILIL,MAGI,MAGIFN,MAGIFNS,MAGSTAT,MAGSYS,MAGTMP,MAGCNT,MAGARCIE
 Q
