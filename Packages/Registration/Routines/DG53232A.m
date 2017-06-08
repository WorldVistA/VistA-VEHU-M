DG53232A ;ALB/KCL,Zoltan - DG*5.3*232 Post-install Updates ; 04-JUN-1999
 ;;5.3;Registration;**232**;Aug 13, 1993
 ;
NOTIFY ; Description: This function will generate a notification message
 ; that the facility has installed the patch in a production account.
 ;
 N DIFROM,DGENSITE,DGENTEXT,XMTEXT,XMSUB,XMDUZ,XMY,Y
 ;
 ; if not in production account, do not send notification message (exit)
 X ^%ZOSF("UCI") I Y'=^%ZOSF("PROD") Q
 ;
 D BMES^XPDUTL(">>> Sending a 'completed installation' notification to the HEC...")
 ;
 ; get facility name/station number
 S DGENSITE=$$SITE^VASITE
 ;
 S XMSUB="Patch DG*5.3*232 Installed "_"("_$P(DGENSITE,"^",3)_")"  ; subject
 S XMDUZ="ENROLLMENT PACKAGE"  ; sender
 S XMY(DUZ)="",XMY(.5)=""  ; local recipients
 S XMY("G.IRM SOFTWARE SECTION@IVM.VA.GOV")=""  ; remote recipient
 ;
 ; notification message text
 S XMTEXT="DGENTEXT("
 S DGENTEXT(1)="               Facility Name:  "_$P(DGENSITE,"^",2)
 S DGENTEXT(2)="              Station Number:  "_$P(DGENSITE,"^",3)
 S DGENTEXT(3)=""
 S DGENTEXT(4)="  Installed DG*5.3*232 patch on:  "_$$FMTE^XLFDT($$NOW^XLFDT)
 D ^XMD
 D BMES^XPDUTL("Notification message sent.")
 Q
 ;
INACT() ; Inactivate CATASTROPHICALLY DISABLED Eligibility Code
 N DGIEN,DGERR,DGFDA
 ; This code is in the ELIGIBILITY CODE file (#8).
 S DGIEN=$O(^DIC(8,"B","CATASTROPHICALLY DISABLED",""))
 Q:DGIEN=""
 S DGFDA(8,DGIEN_",",6)="1"
 D FILE^DIE("K","DGFDA","DGERR")
 I $D(DGERR) D ERRDISP(.DGERR) Q "Failed to Inactivate CD Eligibility Code in ELIGIBILITY CODE file (#8)."
 ; This code is in the MAS ELIGIBILITY CODE file (#8.1).
 K DGFDA ; Don't allow data from last call to carry over...
 S DGIEN=$O(^DIC(8.1,"B","CATASTROPHICALLY DISABLED",""))
 Q:DGIEN=""
 S DGFDA(8.1,DGIEN_",",6)="1"
 D FILE^DIE("K","DGFDA","DGERR")
 I $D(DGERR) D ERRDISP(.DGERR) Q "Failed to Inactivate CD Eligibility Code in MAS ELIGIBILITY CODE file (#8.1)."
 Q ""
 ;
LOAD2717() ; Load contents of #27.17 CATASTROPHIC DISABILITY REASONS.
 N DGLN,DGTEXT,DGEXIT,DGERROR,DGERR
 S DGEXIT=0,DGERROR=0
 F DGLN=1:1 D  Q:DGEXIT
 . S DGTEXT=$T(DATA+DGLN)
 . I $P(DGTEXT,";;",2)="" S DGEXIT=1 Q
 . N DGHELP,DGHLN,DGIEN,DGFDA,DGLIMB1,DGLIMB2,X,DGNAME,DGCODE
 . S DGTEXT=$P(DGTEXT,";;",2,$L(DGTEXT,";;"))
 . S DGNAME=$P(DGTEXT,"~",1)
 . S DGCODE=$P(DGTEXT,"~",8)
 . S DGIEN=$O(^DGEN(27.17,"C",DGCODE,""))
 . I DGIEN="" D  Q:DGEXIT  ; New entry.
 . . N DO,DA,DIC,Y,X,DD
 . . S DIC="^DGEN(27.17,"
 . . S DIC(0)=""
 . . S X=DGNAME
 . . D FILE^DICN
 . . S DGIEN=+Y
 . . I DGIEN=-1 S DGEXIT=1,DGERROR="Failed to create new CD Reason"
 . I DGNAME'="" S DGFDA(27.17,DGIEN_",",.01)=DGNAME
 . I $P(DGTEXT,"~",2)'="" S DGFDA(27.17,DGIEN_",",1)=$P(DGTEXT,"~",2)
 . I $P(DGTEXT,"~",3)'="" S DGFDA(27.17,DGIEN_",",3)=$P(DGTEXT,"~",3)
 . I $P(DGTEXT,"~",6)'="" S DGFDA(27.17,DGIEN_",",5)=$P(DGTEXT,"~",6)
 . I $P(DGTEXT,"~",7)'="" S DGFDA(27.17,DGIEN_",",7)=$P(DGTEXT,"~",7)
 . I DGCODE'="" S DGFDA(27.17,DGIEN_",",8)=DGCODE
 . D FILE^DIE("","DGFDA","DGERR")
 . I $D(DGERR) D ERRDISP(.DGERR) S DGERROR="Failed to Save CD Reason",DGEXIT=1 Q
 . S DGLIMB1=$P(DGTEXT,"~",4)
 . S DGLIMB2=$P(DGTEXT,"~",5)
 . I DGLIMB1_DGLIMB2'="" F X=DGLIMB1,DGLIMB2 D  Q:DGEXIT
 . . Q:$D(^DGEN(27.17,DGIEN,1,"B",X))  ; Limb already defined.
 . . N DGFDA,DIC,DO,DD,Y,DA
 . . S DIC="^DGEN(27.17,"_DGIEN_",1,"
 . . S DIC(0)="L"
 . . S DIC("P")="27.174SA"
 . . S DA(1)=DGIEN
 . . D FILE^DICN
 . . I Y=-1 S DGERROR="Couldn't add "_X_" to CD REASON "_DGNAME,DGEXIT=1 Q
 . S DGHELP=$P(DGTEXT,"~",9)
 . I DGHELP D
 . . N LINE
 . . F LINE=1:1:DGHELP D
 . . . S DGLN=DGLN+1
 . . . S DGHELP(LINE)=$P($T(DATA+DGLN),";;",2,9999)
 . . D WP^DIE(27.17,DGIEN_",",6,"K","DGHELP")
 ;---------------------------------------------------
 ; This code is related to DG*5.3*232 test version 2.
 ; This code can be removed in future test versions.
 ; This code is not required for the final patch.
 ; It fixes an incompatibility between TV1 and TV2.
 K ^DGEN(27.17,"B")
 N DIK
 S DIK="^DGEN(27.17,"
 S DIK(1)=".01^B"
 D ENALL^DIK ; Rebuild new "B" cross-reference.
 ; --------------------------------------------------
 Q $G(DGERROR)
 ;
ERRDISP(DGERR) ; Display FM error message.
 N ERR,LINE
 S (ERR,LINE)=0
 F  S ERR=$O(DGERR("DIERR",ERR)) Q:'ERR  F  S LINE=$O(DGERR("DIERR",ERR,"TEXT",LINE)) Q:'LINE  D
 . D BMES^XPDUTL("     "_DGERR("DIERR",ERR,"TEXT",LINE))
 Q
 ;
DATA ; Data for 27.17 CATASTROPHIC DISABILITY REASONS goes here.
 ;;Quadriplegia, Unspecified~D~12977;ICD9(~~~~~344.00~0
 ;;Quadriplegia, C1-C4, Complete~D~12978;ICD9(~~~~~344.01~0
 ;;Quadriplegia, C1-C4, Incomplete~D~12979;ICD9(~~~~~344.02~0
 ;;Quadriplegia, C5-C7, Incomplete~D~12981;ICD9(~~~~~344.04~0
 ;;Quadriplegia, Other~D~12982;ICD9(~~~~~344.09~0
 ;;Paraplegia~D~1539;ICD9(~~~~~344.1~0
 ;;Blindness~D~1942;ICD9(~~~~~369.4~0
 ;;Persistent Vegetative State~D~12905;ICD9(~~~~~780.03~0
 ;;Amputation through Hand~P~2110;ICD0(~LUE~RUE~~~84.03~0
 ;;Disarticulation of Wrist~P~2111;ICD0(~LUE~RUE~~~84.04~0
 ;;Disarticulation of Forearm~P~2112;ICD0(~LUE~RUE~~~84.05~0
 ;;Amputation or Disarticulation through Elbow~P~2113;ICD0(~LUE~RUE~~~84.06~0
 ;;Amputation through Humerus~P~2114;ICD0(~LUE~RUE~~~84.07~0
 ;;Shoulder Disarticulation~P~2115;ICD0(~LUE~RUE~~~84.08~0
 ;;Forequarter Amputation~P~2116;ICD0(~LUE~RUE~~~84.09~0
 ;;Lower Limb Amputation~P~3360;ICD0(~LLE~RLE~~~84.10~0
 ;;Amputation of Great Toe~P~2117;ICD0(~LLE~RLE~~~84.11~0
 ;;Amputation through Foot~P~2118;ICD0(~LLE~RLE~~~84.12~0
 ;;Disarticulation of Ankle~P~2119;ICD0(~LLE~RLE~~~84.13~0
 ;;Amputation through Malleoli~P~2120;ICD0(~LLE~RLE~~~84.14~0
 ;;Other Amputation below Knee~P~2121;ICD0(~LLE~RLE~~~84.15~0
 ;;Disarticulation of Knee~P~2122;ICD0(~LLE~RLE~~~84.16~0
 ;;Above Knee Amputation~P~2123;ICD0(~LLE~RLE~~~84.17~0
 ;;Disarticulation of Hip~P~2124;ICD0(~LLE~RLE~~~84.18~0
 ;;Hindquarter Amputation~P~2125;ICD0(~LLE~RLE~~~84.19~0
 ;;Forequarter Amputation~P~23900;ICPT(~LUE~RUE~~~23900~0
 ;;Shoulder Disarticulation~P~23920;ICPT(~LUE~RUE~~~23920~0
 ;;Amputation through Humerus~P~24900;ICPT(~LUE~RUE~~~24900~0
 ;;Amputation through Humerus~P~24920;ICPT(~LUE~RUE~~~24920~0
 ;;Amputation or Disarticulation through Elbow~P~24999;ICPT(~LUE~RUE~~~24999~0
 ;;Amputation or Disarticulation of Forearm~P~25900;ICPT(~LUE~RUE~~~25900~0
 ;;Amputation or Disarticulation of Forearm~P~25905;ICPT(~LUE~RUE~~~25905~0
 ;;Disarticulation of Wrist~P~25920;ICPT(~LUE~RUE~~~25920~0
 ;;Amputation through Hand~P~25927;ICPT(~LUE~RUE~~~25927~0
 ;;Hindquarter Amputation~P~27290;ICPT(~LLE~RLE~~~27290~0
 ;;Disarticulation of Hip~P~27295;ICPT(~LLE~RLE~~~27295~0
 ;;Above Knee Amputation~P~27598;ICPT(~LLE~RLE~~~27598~0
 ;;Other Amputation Below Knee~P~27880;ICPT(~LLE~RLE~~~27880~0
 ;;Lower Limb Amputation not otherwise specified~P~27882;ICPT(~LLE~RLE~~~27882~0
 ;;Amputation through Malleoli~P~27888;ICPT(~LLE~RLE~~~27888~0
 ;;Disarticulation of Ankle~P~27889;ICPT(~LLE~RLE~~~27889~0
 ;;Amputation through Foot~P~28800;ICPT(~LLE~RLE~~~28800~0
 ;;Amputation through Foot~P~28805;ICPT(~LLE~RLE~~~28805~0
 ;;Amputation of Great Toe~P~28810;ICPT(~LLE~RLE~~~28810~0
 ;;Amputation of Great Toe~P~28820;ICPT(~LLE~RLE~~~28820~0
 ;;Katz Scale~C~~~~SCORE'<3&(PERM=1)~X\1=X&(X'<0)&(X'>6)~KATZ~8
 ;;The Katz Index of Activities of Daily Living (ADLs) assigns a number
 ;;from 1 to 3 in each of 6 activities.  1 is dependent, 2 is an intermediate
 ;;limitation, and 3 is independent.  The Katz Index may be used to determine
 ;;whether a veteran is catastrophically disabled.
 ;; 
 ;;This field must contain the number of permanent ADLs for which the veteran
 ;;received a score of 1 (dependent).  It is NOT the overall score on the
 ;;KATZ test (which can range from 6 to 18.)
 ;;Folstein Mini-Mental State Examination~C~~~~SCORE'>10&(PERM=1)~X\1=X,X'<0,X'>30~FOLS~2
 ;;Enter the veteran's score, a number between 0 - 30, on the Folstein
 ;;Mini-Mental State Examination (MMSE).
 ;;Functional Independence Measure~C~~~~SCORE'<4&(PERM=1)~X\1=X&(X'<0)&(X'>13)~FIM~8
 ;;The FIM contains 18 measures in 6 domains.  The 13 MOTOR ITEMS are in 4 
 ;;domains:
 ;; - self-care,
 ;; - sphincter control,
 ;; - transfers, and
 ;; - locomotion.  
 ;;When you respond to this field, you are entering the number of MOTOR items 
 ;;for which the veteran received a score of 2 or lower.
 ;;Global Assessment of Functioning~C~~~~SCORE'>30&(PERM=1)~X\1=X&(X'<1)&(X'>100)~GAF~1
 ;;Enter the veteran's GAF score, a number between 1 and 100.
