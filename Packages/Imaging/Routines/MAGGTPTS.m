MAGGTPTS ;WIRMFO/GEK Temporary Patient security check [ 18-AUG-2000 14:47:56 ]
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
 ; copied, modified DGSEC for silent running from Imaging Delphi Window
 ;;
 ;DGSEC;ALB/RMO - MAS Patient Look-up Security Check ; 22 JUN 87 1:00 pm
 ;;5.3;Registration;**32,46**;Aug 13, 1993
DGSEC(MAGRY,DFN) ;RPC Call to return if a patient is restricted, and
 ;  if access has to be logged.
 ; NOT USED IN VERSION 2.5.   Kept in for backward compatibility.
 ;
 ; MAGRY="0^    not a sensitive patient or access is allowed.
 ; MAGRY="-1^   error, patient's sensitivity not determined
 ;              or user can't access a sensitive patient.
 ; MAGRY="1^    sensitive patient. App needs to display message,
 ;     ask to continue, and  log access if user continues.
 N DG1,DGA1,DGT,Y
 K MAGXXX
 S Y=DFN
 I $D(DGSENFLG)!($S('$D(^DGSL(38.1,+Y,0)):1,'$P(^(0),U,2):1,1:0))
 I  S MAGRY="0^Not a Sensitive Patient" Q
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 E  S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 U XWBNULL
 S MAGRY="-1^ERROR during processing"
 S DGMSG=$S('($D(DUZ)#2):"user code",'$D(^VA(200,DUZ,0)):"user name",1:"")
 I DGMSG'="" S MAGRY="-1^Your "_DGMSG_" is undefined." G Q
 ;
 D OP^XQCHK ; WE WERE DYING (UNDEF) IN THIS CALL.
 I '$G(XQOPT) S XQOPT="-1^Unknown"
 S DGOPT=$S(+XQOPT<0:"^UNKNOWN",1:$P(XQOPT,U)_U_$P(XQOPT,U,2))
 S DFN=+Y D H^DGUTL S DGT=DGTIME D ^DGPMSTAT ;GEK D ^DGINPW
 ;  if user answers yes to question in
 ;  a dialog window then we'll D BULTIN and SETLOG in another RPC call
 I 'DG1,'$D(^XUSEC("DG SENSITIVITY",DUZ)) S MAGRY="1^Sensitive Record" G Q
 ;
 ; if we get here, then access is allowed to this sensitive patient.
 S MAGRY="0^Access allowed"
 ;
SETLOG L ^DGSL(38.1,+Y):1 G:'$T SETLOG S:'$D(^DGSL(38.1,+Y,0)) ^(0)=+Y,^DGSL(38.1,"B",+Y,+Y)="",$P(^(0),U,3,4)=+Y_U_($P(^DGSL(38.1,0),U,4)+1) D H^DGUTL
SETUSR S DGDTE=9999999.9999-DGTIME I $D(^DGSL(38.1,+Y,"D",DGDTE,0)) S DGTIME=DGTIME+.00001 G SETUSR
 S:'$D(^DGSL(38.1,+Y,"D",0)) ^(0)="^38.11DA^^" S ^DGSL(38.1,+Y,"D",DGDTE,0)=DGTIME_U_DUZ_U_$P(DGOPT,U,2)_U_$S(DG1:"y",1:"n"),$P(^(0),U,3,4)=DGDTE_U_($P(^DGSL(38.1,+Y,"D",0),U,4)+1)
 S ^DGSL(38.1,"AD",DGDTE,+Y)="",^DGSL(38.1,"AU",+Y,DUZ,DGDTE)="" L
 ;
Q K DG1,DGDATE,DGDTE,DGLNE,DGMSG,DGOPT,DGSEN,DGTIME,DGY,XQOPT
 Q
NOTCE ;
 ; We don't download the notice, to save time we have the notice
 ; already in the delphi window.
 Q
ACCESS(MAGRY,DFN) ;RPC Call to send bulletin, and log access by user.
 ; NOT USED IN Version 2.5.  'DG SENSITIVE RECORD ACCESS' is used
 ;  instead.  This is kept for backward compatibility.
 N Y S Y=DFN
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 E  S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 S MAGRY="-1^ERROR Attempting to send Sensitive Patient Accessed bulletin"
 U XWBNULL ; Stop unwanted Writes
 D OP^XQCHK S DGOPT=$S(+XQOPT<0:"^UNKNOWN",1:$P(XQOPT,U)_U_$P(XQOPT,U,2))
 S DFN=+Y D H^DGUTL S DGT=DGTIME D ^DGPMSTAT
 S MAGRY="1^Bulletin Sent. "
 D BULTIN
 D SETLOG
 S MAGRY=MAGRY_" Access has been logged"
 Q
BULTIN K DGB I $D(^DG(43,1,"NOT")),+$P(^("NOT"),U,10) S DGB=10
 Q:'$D(DGB)  S XMSUB="RESTRICTED PATIENT RECORD ACCESSED",DGTEXT(1,0)="The following sensitive patient record has been accessed:",DGTEXT(2,0)="",DGTEXT(3,0)="  Patient Name: "_$P(^DPT(+Y,0),U),DGTEXT(4,0)="  Soc Sec Num : "_$P(^(0),U,9)
 ;We'll stuff MAG WINDOWS for now.
 ;S DGTEXT(5,0)="  Option Used : "_$P(DGOPT,U,2) S DGY.........
 ;  The kernel variable XQY0 is 'MAG WINDOWS' (should be, it doesn't
 ;   get set if user has '@' programmer access)
 S DGTEXT(5,0)="  Option Used : MAG WINDOWS" S DGY=Y,DGSM=0 N XMY,XMY0,XMB D ^DGBUL S Y=DGY
 Q
