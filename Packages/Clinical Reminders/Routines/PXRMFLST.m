PXRMFLST ; SLC/PJH - List Resolution Statuses ;07/25/2018
 ;;2.0;CLINICAL REMINDERS;**65**;Feb 04, 2005;Build 439
 ;
 ;List selected finding type parameter
 ;------------------------------------
START N BY,DC,DHD,DIC,FLDS,FR,L,LOGIC,MODE,NOW,TO,Y
 ;Get lists of finding types for display
 N DEF,DEF1,DEF2 D DEF^PXRMRUTL("811.902",.DEF,.DEF1,.DEF2)
 ;
SELECT S MODE=""
 S DIC="^PXRMD(801.45,"
 S DIC(0)="AEMQ"
 S DIC("A")="Select Finding Type: "
 D ^DIC
 I Y'=-1 D  G SELECT
 .D SET
 .D DISP
END Q
 ;
 ;List all statuses
 ;-----------------
ALL N BY,DC,DHD,DIC,FLDS,FR,L,LOGIC,MODE,NOW,TO,Y
 S Y=1,MODE="GENERAL"
 ;Get lists of finding types for display
 N DEF,DEF1,DEF2 D DEF^PXRMRUTL("811.902",.DEF,.DEF1,.DEF2)
 ; Set Date for Header
 S NOW=$$NOW^XLFDT
 S NOW=$$FMTE^XLFDT(NOW,"1P")
 D SET
 S DIC="^PXRMD(801.45,"
 S BY=".01"
 S FR="",TO=""
 S DHD="W ?0 D HED^PXRMFLST"
 D DISP
 Q
 ;
 ;Inquire/Print Option (for protocol PXRM GENERAL INQUIRE/PRINT)
 ;--------------------
INQ(Y) N BY,DC,DHD,DIC,FLDS,FR,L,LOGIC,MODE,NOW,TO
 ;Get lists of finding types for display
 N DEF,DEF1,DEF2 D DEF^PXRMRUTL("811.902",.DEF,.DEF1,.DEF2)
 S MODE=""
 S DIC="^PXRMD(801.45,"
 S DIC(0)="AEMQ"
 D SET
 D DISP
 Q
 ;
HED ; Display Header (see DHD variable)
 N TEMP,TEXTLEN,TEXTHED,TEXTUND
 S TEXTHED="RESOLUTION STATUS LIST"
 S TEXTUND=$TR($J("",IOM)," ","-")
 S TEMP=NOW_"  Page "_DC
 S TEXTLEN=$L(TEMP)
 W TEXTHED
 W ?(IOM-TEXTLEN),TEMP
 W !,TEXTUND,!!
 Q
 ;
DISP ;DISPLAY (Display from FLDS array)
 S L=0,FLDS="[PXRM FINDING TYPE PARAMETERS]"
 D EN1^DIP
 Q
 ;
SET ;Setup all the variables
 ;
 ; Set Date for Header
 S NOW=$$NOW^XLFDT
 S NOW=$$FMTE^XLFDT(NOW,"1P")
 ;
 ;These variables need to be setup every time because DIP kills them.
 S BY="NUMBER"
 S (FR,TO)=+$P(Y,U,1)
 S DHD="W ?0 D HED^PXRMFLST"
 ;
 Q
 ;
FDES N X S X=$P($G(^PXRMD(801.45,D0,0)),U) Q:X="" 
 I X="POV" W "(DIAGNOSIS)" Q
 I X="CPT" W "(PROCEDURE)" Q
 W "("_$G(DEF2(X))_")"
 Q
 ;
DEF(RESULT,IEN) ;
 N FIEN,GBL,GBLARR,TYPE
 D BLDRLIST^PXRMVPTR(811.902,.01,.GBLARR)
 S GBL="" F  S GBL=$O(^PXD(811.9,IEN,20,"B",GBL)) Q:GBL=""  D
 .S FIEN=$P(GBL,";")
 .S NODE=$G(GBLARR($P(GBL,";",2)))
 .S TYPE=$P(NODE,U,4)
 .I TYPE="RT" D TERM(.RESULT,FIEN) Q
 .S RESULT(TYPE,$P(GBL,";"))=""
 Q
 ;
TERM(RESULT,IEN) ;
 N FIEN,GBL,GBLARR,TYPE
 D BLDRLIST^PXRMVPTR(811.52,.01,.GBLARR)
 S GBL="" F  S GBL=$O(^PXRMD(811.5,IEN,20,"B",GBL)) Q:GBL=""  D
 .S FIEN=$P(GBL,";")
 .S NODE=$G(GBLARR($P(GBL,";",2)))
 .S TYPE=$P(NODE,U,4)
 .S RESULT(TYPE,$P(GBL,";"))=""
 Q
 ;
