ONCCS ;HINES OIFO/GWB - Collaborative Staging ;06/23/10
 ;;2.2;ONCOLOGY;**1,4,5,10,19**;Jul 31, 2013;Build 4
 ;
 N DIR,IEN,LV,PS,RC,X
 W !
 S DIR("A")=" Compute Collaborative Staging"
 S DIR(0)="Y",DIR("B")="Yes" D ^DIR
 I (Y=0)!(Y="")!(Y[U) S Y=$S(ONCOANS="A":"@4",1:"@0") Q
 ;
 ;re-initialize if 96703
 I ($P($G(^ONCO(165.5,D0,2.2)),U,3)=96703),($P($G(^ONCO(165.5,D0,0)),U,16)>3120000) D  Q
 .D CLNCS
 .W !!,"96703 is obsolete for primaries starting 2012!!!"
 ;
 S IEN=D0
 S $P(^ONCO(165.5,IEN,"CS1"),U,1,9)=U_U_U_U_U_U_U_U
 S $P(^ONCO(165.5,IEN,"CS1"),U,11)=""
 ;
 K INPUT,STORE,DISPLAY,STATUS,ONCSAPI
 D CLEAR^ONCSAPIE(1)
 ;
 S PS=$$GET1^DIQ(165.5,IEN,20,"I")
 S:PS'="" PS=$TR($$GET1^DIQ(164,PS,1,"I"),".","")
 S INPUT("SITE")=PS
 ;
 S INPUT("HIST")=$E($$GET1^DIQ(165.5,IEN,22.3,"I"),1,4)
 ;
 S INPUT("DIAGNOSIS_YEAR")=$E($$DATE^ONCACDU1($$GET1^DIQ(165.5,IEN,3,"I")),1,4)
 ;
 ;S INPUT("CSVER_ORIGINAL")=$P($$VERSION^ONCSAPIV,U,2)
 ;S:INPUT("CSVER_ORIGINAL")="" INPUT("CSVER_ORIGINAL")=$P($$VERSION^ONCSAPIV,U,2)
 S INPUT("CSVER_ORIGINAL")=$$GET1^DIQ(165.5,IEN,169.1,"I")
 S:INPUT("CSVER_ORIGINAL")="" INPUT("CSVER_ORIGINAL")="020550"
 ;
 S INPUT("BEHAV")=$E($$GET1^DIQ(165.5,IEN,22.3,"I"),5)
 ;
 S INPUT("GRADE")=$$GET1^DIQ(165.5,IEN,24,"I")
 ;
 S INPUT("AGE")=$$AGEDX^ONCACDU1(IEN)
 S:$L(INPUT("AGE"))=1 INPUT("AGE")="00"_INPUT("AGE")
 S:$L(INPUT("AGE"))=2 INPUT("AGE")=0_INPUT("AGE")
 ;
 S LV=$$GET1^DIQ(165.5,IEN,149,"I")_$$GET1^DIQ(165.5,IEN,151,"I")
 S INPUT("LVI")=$S(LV[1:1,LV[2:1,LV[0:0,LV["X":9,1:8)
 ;
 S INPUT("SIZE")=$$GET1^DIQ(165.5,IEN,29.2,"I")
 ;
 S INPUT("EXT")=$$GET1^DIQ(165.5,IEN,30.2,"I")
 ;
 S INPUT("EXTEVAL")=$$GET1^DIQ(165.5,IEN,29.1,"I")
 ;
 S INPUT("NODES")=$$GET1^DIQ(165.5,IEN,31.1,"I")
 ;
 S INPUT("LNPOS")=$$GET1^DIQ(165.5,IEN,32,"I")
 S:$L(INPUT("LNPOS"))=1 INPUT("LNPOS")=0_INPUT("LNPOS")
 ;
 S INPUT("LNEXAM")=$$GET1^DIQ(165.5,IEN,33,"I")
 S:$L(INPUT("LNEXAM"))=1 INPUT("LNEXAM")=0_INPUT("LNEXAM")
 ;
 S INPUT("NODESEVAL")=$$GET1^DIQ(165.5,IEN,32.1,"I")
 ;
 S INPUT("METS")=$$GET1^DIQ(165.5,IEN,34.3,"I")
 ;
 S INPUT("METSEVAL")=$$GET1^DIQ(165.5,IEN,34.4,"I")
 ;
 S INPUT("SSF1")=$$GET1^DIQ(165.5,IEN,44.1,"I")
 S INPUT("SSF2")=$$GET1^DIQ(165.5,IEN,44.2,"I")
 S INPUT("SSF3")=$$GET1^DIQ(165.5,IEN,44.3,"I")
 S INPUT("SSF4")=$$GET1^DIQ(165.5,IEN,44.4,"I")
 S INPUT("SSF5")=$$GET1^DIQ(165.5,IEN,44.5,"I")
 S INPUT("SSF6")=$$GET1^DIQ(165.5,IEN,44.6,"I")
 S INPUT("SSF7")=$$GET1^DIQ(165.5,IEN,44.7,"I")
 S INPUT("SSF8")=$$GET1^DIQ(165.5,IEN,44.8,"I")
 S INPUT("SSF9")=$$GET1^DIQ(165.5,IEN,44.9,"I")
 S INPUT("SSF10")=$$GET1^DIQ(165.5,IEN,44.101,"I")
 S INPUT("SSF11")=$$GET1^DIQ(165.5,IEN,44.11,"I")
 S INPUT("SSF12")=$$GET1^DIQ(165.5,IEN,44.12,"I")
 S INPUT("SSF13")=$$GET1^DIQ(165.5,IEN,44.13,"I")
 S INPUT("SSF14")=$$GET1^DIQ(165.5,IEN,44.14,"I")
 S INPUT("SSF15")=$$GET1^DIQ(165.5,IEN,44.15,"I")
 S INPUT("SSF16")=$$GET1^DIQ(165.5,IEN,44.16,"I")
 S INPUT("SSF17")=$$GET1^DIQ(165.5,IEN,44.17,"I")
 S INPUT("SSF18")=$$GET1^DIQ(165.5,IEN,44.18,"I")
 S INPUT("SSF19")=$$GET1^DIQ(165.5,IEN,44.19,"I")
 S INPUT("SSF20")=$$GET1^DIQ(165.5,IEN,44.201,"I")
 S INPUT("SSF21")=$$GET1^DIQ(165.5,IEN,44.21,"I")
 S INPUT("SSF22")=$$GET1^DIQ(165.5,IEN,44.22,"I")
 S INPUT("SSF23")=$$GET1^DIQ(165.5,IEN,44.23,"I")
 S INPUT("SSF24")=$$GET1^DIQ(165.5,IEN,44.24,"I")
 I $P($G(^ONCO(165.5,IEN,"CS3")),U,1)'="" D
 .S $P(^ONCO(165.5,IEN,"CS2"),U,19)=$P($G(^ONCO(165.5,IEN,"CS3")),U,1)
 S INPUT("SSF25")=$$GET1^DIQ(165.5,IEN,44.25,"I")
 ;patch 19 - stuff with BLANKS for NULL: cloud server migration
 S:INPUT("EXT")="" INPUT("EXT")="   "
 S:INPUT("EXTEVAL")="" INPUT("EXTEVAL")=" "
 S:INPUT("GRADE")="" INPUT("GRADE")=" "
 S:INPUT("METS")="" INPUT("METS")="  "
 S:INPUT("METSEVAL")="" INPUT("METSEVAL")=" "
 S:INPUT("NODES")="" INPUT("NODES")="   "
 S:INPUT("NODESEVAL")="" INPUT("NODESEVAL")=" "
 S:INPUT("SIZE")="" INPUT("SIZE")="   "
 S:INPUT("SSF1")="" INPUT("SSF1")="   "
 S:INPUT("SSF2")="" INPUT("SSF2")="   "
 S:INPUT("SSF3")="" INPUT("SSF3")="   "
 S:INPUT("SSF4")="" INPUT("SSF4")="   "
 S:INPUT("SSF5")="" INPUT("SSF5")="   "
 S:INPUT("SSF6")="" INPUT("SSF6")="   "
 S:INPUT("SSF7")="" INPUT("SSF7")="   "
 S:INPUT("SSF8")="" INPUT("SSF8")="   "
 S:INPUT("SSF9")="" INPUT("SSF9")="   "
 S:INPUT("SSF10")="" INPUT("SSF10")="   "
 S:INPUT("SSF11")="" INPUT("SSF11")="   "
 S:INPUT("SSF12")="" INPUT("SSF12")="   "
 S:INPUT("SSF13")="" INPUT("SSF13")="   "
 S:INPUT("SSF14")="" INPUT("SSF14")="   "
 S:INPUT("SSF15")="" INPUT("SSF15")="   "
 S:INPUT("SSF16")="" INPUT("SSF16")="   "
 S:INPUT("SSF17")="" INPUT("SSF17")="   "
 S:INPUT("SSF18")="" INPUT("SSF18")="   "
 S:INPUT("SSF19")="" INPUT("SSF19")="   "
 S:INPUT("SSF20")="" INPUT("SSF20")="   "
 S:INPUT("SSF21")="" INPUT("SSF21")="   "
 S:INPUT("SSF22")="" INPUT("SSF22")="   "
 S:INPUT("SSF23")="" INPUT("SSF23")="   "
 S:INPUT("SSF24")="" INPUT("SSF24")="   "
 S:INPUT("SSF25")="" INPUT("SSF25")="   "
 D XMLREQ
 ;
 K ^TMP("ONCCSRSP",$J) S ONCEXEC="P" D TCS^ONCWEB1
 S ERRFLG=0 D PARSECS^ONCWEBP2
 I ERRFLG=1 D DISERR^ONCWEBP2 W !," You have encountered a CS error/warning" G CSERR
 I ERRFLG=2 W !," You have encountered an XML/server problem" G CSERR
 ; S RC=$$CALC^ONCSAPI3(.ONCSAPI,.INPUT,.STORE,.DISPLAY,.STATUS)
 ; I RC D PRTERRS^ONCSAPIE() R "Press return to continue",X:DTIME
 ;
 I ONCSTORE("AJCC7-M")="   " S ONCSTORE("AJCC7-M")=""
 I ONCSTORE("AJCC7-MDESCR")=" " S ONCSTORE("AJCC7-MDESCR")=""
 I ONCSTORE("AJCC7-N")="   " S ONCSTORE("AJCC7-N")=""
 I ONCSTORE("AJCC7-NDESCR")=" " S ONCSTORE("AJCC7-NDESCR")=""
 I ONCSTORE("AJCC7-STAGE")="   " S ONCSTORE("AJCC7-STAGE")=""
 I ONCSTORE("AJCC7-T")="   " S ONCSTORE("AJCC7-T")=""
 I ONCSTORE("AJCC7-TDESCR")=" " S ONCSTORE("AJCC7-TDESCR")=""
 S $P(^ONCO(165.5,IEN,"CS1"),U,1)=ONCSTORE("T")
 S $P(^ONCO(165.5,IEN,"CS1"),U,2)=ONCSTORE("TDESCR")
 S $P(^ONCO(165.5,IEN,"CS1"),U,3)=ONCSTORE("N")
 S $P(^ONCO(165.5,IEN,"CS1"),U,4)=ONCSTORE("NDESCR")
 S $P(^ONCO(165.5,IEN,"CS1"),U,5)=ONCSTORE("M")
 S $P(^ONCO(165.5,IEN,"CS1"),U,6)=ONCSTORE("MDESCR")
 S $P(^ONCO(165.5,IEN,"CS1"),U,7)=ONCSTORE("AJCC")
 S $P(^ONCO(165.5,IEN,"CS1"),U,13)=ONCSTORE("AJCC7-T")
 S $P(^ONCO(165.5,IEN,"CS1"),U,14)=ONCSTORE("AJCC7-TDESCR")
 S $P(^ONCO(165.5,IEN,"CS1"),U,15)=ONCSTORE("AJCC7-N")
 S $P(^ONCO(165.5,IEN,"CS1"),U,16)=ONCSTORE("AJCC7-NDESCR")
 S $P(^ONCO(165.5,IEN,"CS1"),U,17)=ONCSTORE("AJCC7-M")
 S $P(^ONCO(165.5,IEN,"CS1"),U,18)=ONCSTORE("AJCC7-MDESCR")
 S $P(^ONCO(165.5,IEN,"CS1"),U,19)=ONCSTORE("AJCC7-STAGE")
 S $P(^ONCO(165.5,IEN,"CS1"),U,8)=ONCSTORE("SS1977")
 S $P(^ONCO(165.5,IEN,"CS1"),U,9)=ONCSTORE("SS2000")
 ;I $D(ONCAPIVR) W !!,"ONCAPIVR=",ONCAPIVR
 ;I $D(ONCVERSN) W !!,"ONCVERSN=",ONCVERSN
 ;S ONCAPIVR=020550 ;this line would hard set the CS version: cloud migration
 S $P(^ONCO(165.5,IEN,"CS1"),U,11)=$G(ONCAPIVR)
 S:$P(^ONCO(165.5,IEN,"CS1"),U,12)="" $P(^ONCO(165.5,IEN,"CS1"),U,12)=$G(ONCAPIVR)
 D ^ONCPCS
 I ERRFLG=0 W !," Collaborative Staging was successful" Q
 ;
 ;I $P(RC,U,1)=0 W !," Collaborative Staging was successful" Q
 ;I $P(RC,U,1)=-10 W !," CS server unavailable.  Contact IRM." Q
 ;I $P(RC,U,1)=-22 W !," Invalid COLLABORATIVE STAGING URL value in ONCOLOGY SITE PARAMETERS" Q
 ;I $P(RC,U,1)<0 W !," You have encountered a CS error" G CSERR
 ;I $P(RC,U,1)>0 W !," You have encountered a CS warning" G CSERR
 ;
CSERR N DIR,X
 S DIR("A")="Do you wish to re-enter the CS input values"
 S DIR(0)="Y",DIR("B")="Yes" D ^DIR
 I Y=1 S Y="@292" Q
 I Y[U S Y="@0" Q
 S Y=$S(ONCOANS="A":"@4",1:"@0")
 Q
 ;
XMLREQ ;Build the XML Request for cloud server from INPUT array
 K ^TMP("ONCINPUT",$J)
 N ONCTAG,ONCN
 S ONCN=1
 S ^TMP("ONCINPUT",$J,ONCN)="<?xml version=""1.0"" encoding=""UTF-8""?>"
 S ONCN=ONCN+1
 S ^TMP("ONCINPUT",$J,ONCN)="<CS-CALCULATE xmlns=""http://websrv.oncology.domain.ext"">"
 S ONCTAG="" F  S ONCTAG=$O(INPUT(ONCTAG)) Q:ONCTAG=""  D
 .S ONCN=ONCN+1
 .I ONCTAG="SITE",$L(INPUT(ONCTAG))=4 S ^TMP("ONCINPUT",$J,ONCN)="<"_ONCTAG_">"_INPUT(ONCTAG)_" </"_ONCTAG_">" Q
 .S ^TMP("ONCINPUT",$J,ONCN)="<"_ONCTAG_">"_INPUT(ONCTAG)_"</"_ONCTAG_">"
 S ONCN=ONCN+1
 S ^TMP("ONCINPUT",$J,ONCN)="</CS-CALCULATE>"
 Q
 ;
INIT ;Initialize CS fields when HISTOLOGY (ICD-O-3) (165.5,22.3) changes
 N FND,HISTNAM,HSTFLD,HSTI,LNS,LSC,MEL,OLDHST,SITEGRP,TEXT,Z,ZZHSTLST
 ;
 I ($P($G(^ONCO(165.5,D0,0)),U,16)>3010000),(X=94211) D  Q
 .W !!,"94211 is obsolete for primaries starting 2001!!!"
 .K X
 I ($P($G(^ONCO(165.5,D0,0)),U,16)>3120000),(X=96703) D  Q
 .W !!,"96703 is obsolete for primaries starting 2012!!!"
 .K X
 I $P($G(^ONCO(165.5,D0,0)),U,16)>3100000 D  I FND=1 Q
 .S FND=0
 .S ZZHSTLST="96543^96613^96623^96643^96653^96673^96703^96753^96843^97283^97293^97333^97503^97511^97521^97531^97543^97603^97643^98053^98353^98363^99603^99843^99873"
 .F Z=1:1:27 I $P(ZZHSTLST,U,Z)=X S FND=1
 .I FND=1 W !!,X," is obsolete for primaries starting 2010!!!" K X
 S LNS=$O(^ONCO(164.2,"B","LUNG NOS",0))
 S LSC=$O(^ONCO(164.2,"B","LUNG SMALL CELL",0))
 S MEL=$O(^ONCO(164.2,"B","MELANOMA",0))
 S SITEGRP=$P($G(^ONCO(165.5,D0,0)),U,1)
 S OLDHST=$P($G(^ONCO(165.5,D0,2.2)),U,3)
 I (OLDHST=96703),($P($G(^ONCO(165.5,D0,0)),U,16)>3120000) D CLNCS  ;re-initialized if 96703, obsolete histology.
 I X=OLDHST Q
 I SITEGRP=LNS D
 .I ($E(X,1,4)=8041)!($E(X,1,4)=8042)!($E(X,1,4)=8043)!($E(X,1,4)=8044)!($E(X,1,4)=8045)!($E(X,1,4)=8246) D  W !!," SITE/GP changed to LUNG SMALL CELL",!
 ..S $P(^ONCO(165.5,D0,0),U,1)=LSC
 ..K ^ONCO(165.5,"B",LNS,D0)
 ..S ^ONCO(165.5,"B",LSC,D0)=""
 I SITEGRP=LSC D
 .I ($E(X,1,4)'=8041)&($E(X,1,4)'=8042)&($E(X,1,4)'=8043)&($E(X,1,4)'=8044)&($E(X,1,4)'=8045)&($E(X,1,4)'=8246) D  W !!," SITE/GP changed to LUNG NOS",!
 ..S $P(^ONCO(165.5,D0,0),U,1)=LNS
 ..K ^ONCO(165.5,"B",LSC,D0)
 ..S ^ONCO(165.5,"B",LNS,D0)=""
 I SITEGRP'=MEL D
 .I (X'<87200)&(X<87910) D  W !!," SITE/GP changed to MELANOMA",!
 ..S $P(^ONCO(165.5,D0,0),U,1)=MEL
 ..K ^ONCO(165.5,"B",SITEGRP,D0)
 ..S ^ONCO(165.5,"B",MEL,D0)=""
 I SITEGRP=MEL D
 .I (X<87200)!(X>87900) D
 ..W !
 ..W !," WARNING: SITE/GP and HISTOLOGY discrepancy"
 ..W !,"          SITE/GP   = MELANOMA"
 ..W !,"          HISTOLOGY = ",$P(Y,U,1),"  ",$P(Y,U,2)
 ..W !
 I OLDHST="" Q
 S HSTI=$$HIST^ONCFUNC(D0,.HSTFLD,.HISTNAM)
 S TEXT=HISTNAM
 S $P(^ONCO(165.5,D0,8),U,2)=$E(TEXT,1,40)
 I $P($G(^ONCO(165.5,D0,0)),U,16)<3040000 Q
 I $P($G(^ONCO(165.5,D0,0)),U,16)>3171231 D CL2018 Q
 W !
 W !?3,"You have changed the HISTOLOGY (ICD-O-3).  This change may"
 W !?3,"affect the validity of the COLLABORATIVE STAGING data."
 W !?3,"Therefore, the CS fields have been initialized and need to"
 W !?3,"be re-entered."
 W !
CLNCS ;re-initialize if Histology 96703
 F PIECE=1:1:12 S $P(^ONCO(165.5,D0,"CS"),U,PIECE)=""
 F PIECE=1:1:19 S $P(^ONCO(165.5,D0,"CS1"),U,PIECE)=""
 F PIECE=1:1:19 S $P(^ONCO(165.5,D0,"CS2"),U,PIECE)=""
 S $P(^ONCO(165.5,D0,"CS3"),U,1)=""
 K PIECE
 Q
 ;
CL2018 ;
 W !
 W !?3,"You have changed the HISTOLOGY (ICD-O-3).  This change may"
 W !?3,"affect the validity of the SITE-SPECIFIC DATA ITEMS."
 W !?3,"Therefore, the SSDi fields have been initialized and need to"
 W !?3,"be re-entered."
 W !
 F PIECE=12:1:14 S $P(^ONCO(165.5,D0,2.3),U,PIECE)=""
 F PIECE=1:1:35 S $P(^ONCO(165.5,D0,"SSD1"),U,PIECE)=""
 F PIECE=1:1:36 S $P(^ONCO(165.5,D0,"SSD2"),U,PIECE)=""
 F PIECE=1:1:34 S $P(^ONCO(165.5,D0,"SSD3"),U,PIECE)=""
 F PIECE=1:1:33 S $P(^ONCO(165.5,D0,"SSD4"),U,PIECE)=""
 K PIECE
 D CLNCS
 Q
CLEANUP ;Cleanup
 K D0,ONCOANS,Y
 Q
