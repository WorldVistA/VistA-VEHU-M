PXRMP71I ;ISP/AGP - PATCH 71 INSTALLATION ;Jul 07, 2021@16:42
 ;;2.0;CLINICAL REMINDERS;**71**;Feb 04, 2005;Build 43
 Q
 ;
BLDARRAY(ARRAY,TYPE) ;
 I TYPE="D" D  Q
 .S ARRAY("VA-WH BR BIRAD 1 MAMMOGRAM SCRN-1Y")="VA-WH BR MAMMOGRAM SCRN-1Y"
 .S ARRAY("VA-WH BR BIRAD 1 MAMMOGRAM SCRN-2Y")="VA-WH BR MAMMOGRAM SCRN-2Y"
 .S ARRAY("VA-WH BR BIRAD 1 RETURN TO AGE")="VA-WH BR RETURN TO AGE"
 .S ARRAY("VA-WH BR BIRAD 1 RETURN TO AGE 1Y")="VA-WH BR RETURN TO AGE 1Y"
 .S ARRAY("VA-WH BR BIRAD 1 RETURN TO AGE 2Y")="VA-WH BR RETURN TO AGE 2Y"
 .S ARRAY("VA-WH BR BIRAD 1 NEED MAMMOGRAM")="VA-WH BR NEED MAMMOGRAM"
 .S ARRAY("VA-WH BR BIRAD 1 NEED ULTRASOUND")="VA-WH BR NEED ULTRASOUND"
 .S ARRAY("VA-WH BR BIRAD 1 NEED MRI")="VA-WH BR NEED MRI"
 .S ARRAY("VA-WH BR BIRAD 0 PRIOR FILMS")="VA-WH BR PRIOR FILMS"
 .S ARRAY("VA-WH BR BIRAD 0 ADDITIONAL IMAGING")="VA-WH BR ADDITIONAL IMAGING"
 .S ARRAY("VA-WH BR BIRAD 0 NEED MAMMOGRAM")="VA-WH BR NEED MAMMOGRAM"
 .S ARRAY("VA-WH BR BIRAD 0 NEED ULTRASOUND")="VA-WH BR NEED ULTRASOUND"
 .S ARRAY("VA-WH BR BIRAD 0 NEED MRI")="VA-WH BR NEED MRI"
 .S ARRAY("VA-WH BIRAD 0 REFER BIOPSY")="VA-WH REFER BIOPSY"
 .S ARRAY("VA-WH BR BIRAD 0 REFERRALS")="VA-WH BR REFERRALS"
 .S ARRAY("VA-WH BIRAD 0 REFER SURGEON")="VA-WH REFER SURGEON"
 .S ARRAY("VA-WH BR BIRAD 0 REFER ONCOLOGIST")="VA-WH BR REFER ONCOLOGIST"
 .S ARRAY("VA-WH BR BIRAD 0 CONSULT")="VA-WH BR CONSULT"
 .S ARRAY("VA-WH BR BIRAD 0 CURRENTLY UNDER TREATMENT")="VA-WH BR CURRENTLY UNDER TREATMENT"
 .S ARRAY("VA-WH BR BIRAD 0 BIOPSY ALREADY OBTAIN")="VA-WH BR BIOPSY ALREADY OBTAIN"
 .S ARRAY("VA-WH BR GP BIRAD 1 OTHER")="VA-WH GP BR BIRAD SCREENING OTHER"
 I TYPE="GF" D
 .S ARRAY("BR 0 BIOPSY ALREADY OBTAIN")="BREAST BIOPSY ALREADY OBTAIN"
 .S ARRAY("BR 0 CURRENTLY UNDER TREATMENT")="BREAST CURRENTLY UNDER TREATMENT"
 .S ARRAY("BR BIRAD 1, next MAM AGE 1Y")="BREAST next MAM 1Y"
 .S ARRAY("BR BIRAD 1, next MAM AGE 2Y")="BREAST next MAM 2Y"
 .S ARRAY("BR BIRAD 0 CONSULT")="BREAST CONSULT"
 .S ARRAY("BR 0 REFER TO ONCOLOGIST")="BREAST REFER TO ONCOLOGIST"
 .S ARRAY("BR 0 REFER TO SURGEON")="BREAST REFER TO SURGEON"
 .S ARRAY("BR 0 REFER FOR BIOPSY")="BREAST REFER FOR BIOPSY"
 .S ARRAY("BR BIRAD 0 OBTAIN PRIOR FILMS")="BREAST OBTAIN PRIOR FILMS"
 .S ARRAY("BR BIRAD 1, RETURN TO AGE SCREENING")="BREAST next MAM AT START AGE"
 QUIT
 ;
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="PXRM*2.0*71 SMART UPDATES"
 I MODE["I" S ARRAY(LN,2)="07/07/2021@09:59:53"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="PXRM*2.0*71 HI RISK MEDS CONTENT"
 I MODE["I" S ARRAY(LN,2)="07/07/2021@16:35:08"
 I MODE["A" S ARRAY(LN,3)="O"
 Q
 ;
DIALOG ;
 N ARRAY,DIE,DA,DR,NAME,NEWNAME,PXRMINST,Y
 S NAME="VA-WH BR CLOSE CASCADE"
 D RENAME^PXRMUTIL(801.41,NAME,"VA-WH BR DUPLICATE REPORT")
 S PXRMINST=1
 D BLDARRAY(.ARRAY,"D")
 S NAME="" F  S NAME=$O(ARRAY(NAME)) Q:NAME=""  D
 .S NEWNAME=ARRAY(NAME)
 .D RENAME^PXRMUTIL(801.41,NAME,NEWNAME)
 S NAME="VA-WH SMART BR OUTSIDE REPORT"
 S DA=+$O(^PXRMD(801.41,"B",NAME,"")) I DA=0 Q
 D RENAME^PXRMUTIL(801.41,NAME,"ZZ"_NAME)
 S DIE="^PXRMD(801.41,",DR="3///DISABLE AND DO NOT SEND MESSAGE"
 D ^DIE
 Q
 ;
GFINDS ;
 N ARRAY,DA,DIE,DR,NAME,NEWNAME
 D BLDARRAY(.ARRAY,"GF")
 S DIE="^PXRMD(801.46,"
 D RENAME^PXRMUTIL(801.46,"RETURN REPEAT MAMMOGRAM SCREENING","RETURN FOR MAMMOGRAM")
 S NAME="" F  S NAME=$O(ARRAY(NAME)) Q:NAME=""  D
 .S NEWNAME=ARRAY(NAME)
 .D RENAME^PXRMUTIL(801.46,NAME,NEWNAME)
 .S DA=+$O(^PXRMD(801.46,"B",NEWNAME,""))
 .I DA=0 D BMES^XPDUTL("Could not find General Finding: "_NEWNAME) Q
 .S DR="4///^S X=NEWNAME"
 .D ^DIE
 Q
 ;
PRE ;
 D OPTIONS^PXRMUTIL("DISABLE","Install of PXRM*2.0*71")
 D PROTCOLS^PXRMUTIL("DISABLE","Install of PXRM*2.0*71")
 D GFINDS
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP71I")
 D DIALOG
 D TERM
 D REPOINT
 Q
 ;
POST ;
 D ROCGEDIT,RCOMP
 D OPTIONS^PXRMUTIL("ENABLE","Install of PXRM*2.0*71")
 D PROTCOLS^PXRMUTIL("ENABLE","Install of PXRM*2.0*71")
 D SETPVER^PXRMUTIL("2.0P71"),SENDIM
 Q
 ;
SENDIM ;Send install message.
 N FROM,NODE,PARAM,SYSTEM,SUBJECT,TO,VALUE
 S NODE="PXRM*2.0*71"
 K ^TMP(NODE,$J)
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM=NODE_" Install@"_^XMB("NETNAME")
 ;DBIA #2541
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@AADOMAIN.EXT")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="Install of "_NODE
 S ^TMP(NODE,$J,1,0)=NODE_" was installed."
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
 ;
REPOINT ;
 N BIEN,BNAME,DA,DIK,DR,GIEN,GNAME,IOP,PXRMINST,PXRMTID,TEXT
 S BNAME="VA-WH BR CA 40-44 WANTS SCREEN TERM "
 S GNAME="VA-WH BR CA 40-44 WANTS SCREEN TERM"
 S BIEN=+$O(^PXRMD(811.5,"B",BNAME,"")) I BIEN=0 Q
 S GIEN=+$O(^PXRMD(811.5,"B",GNAME,"")) I GIEN=0 D BMES^XPDUTL("Reminder Term: "_GNAME_" not found") Q
 D BMES^XPDUTL("Repointing Reminder Term: "_BNAME)
 S PXRMTID(1)=BIEN_U_GIEN
 S PXRMINST=1
 ;S OLDIOP=IOP
 S IOP="`"_+$P(IO("HOME"),U)
 D EN^DITP(811.5,.PXRMTID)
 S DIK="^PXRMD(811.5,"
 S DA=BIEN
 S DR=".01///@"
 D BMES^XPDUTL("Deleting Reminder Term: "_BNAME)
 D ^DIK
 D INIT^XPDID
 Q
 ;
TERM ;
 D RENAME^PXRMUTIL(811.5,"VA-WH MRI OF THE BREASTS CODES","VA-WH MRI BREASTS CODES")
 D RENAME^PXRMUTIL(811.5,"VA-WH ULTRASOUND OF THE BREAST CODES","VA-WH ULTRASOUND BREAST CODES")
 Q
 ;
ROCGEDIT ;Remove items from order check items group
 N GIEN,GNAME,MESSAGE,MEDS,MED,MIEN,REMOVE,IIEN,PXRMINST,EXIT
 S GNAME="VA-WH HIRISK MEDICATIONS (EXTREME RISK) GROUP"
 S GIEN=+$O(^PXD(801,"B",GNAME,""))
 I GIEN=0 D
 .S MESSAGE(1)="ERROR:"
 .S MESSAGE(2)="Could not find the "_GNAME_" reminder order check items group."
 .D BMES^XPDUTL(.MESSAGE) K MESSAGE
 I GIEN>0 D
 .S MEDS("ABACAVIR/DOLUTEGRAVIR/LAMIVUDINE")="",MEDS("DOLUTEGRAVIR")=""
 .S MEDS("DOLUTEGRAVIR/RILPIVIRINE")="",MEDS=3
 .S MED="" F  S MED=$O(MEDS(MED)) Q:(MED="")!($G(MIEN)=0)  D
 ..D ZERO^PSN50P6(,MED,DT,1,"PXRMINQ")
 ..S MIEN=+$O(^TMP($J,"PXRMINQ","B",MED,0))
 ..K ^TMP($J,"PXRMINQ")
 ..I MIEN=0 D  Q
 ...S MESSAGE(1)="ERROR:"
 ...S MESSAGE(2)="Could not find the "_MED_" entry in the"
 ...S MESSAGE(3)="VA GENERIC file (#50.6)."
 ...D BMES^XPDUTL(.MESSAGE)
 ...K MEDS(MED),MESSAGE S MEDS=MEDS-1
 ..S IIEN=+$O(^PXD(801,"O",MIEN_";PSNDF(50.6,",GIEN,0))
 ..I IIEN=0 K MEDS(MED) S MEDS=MEDS-1 Q
 ..S MEDS(MED)=IIEN_","_GIEN_","
 .I MEDS>0 D
 ..S MESSAGE(1)="Removing "_$S(MEDS=1:"a ",1:"")_"medication"
 ..S MESSAGE(1)=MESSAGE(1)_$S(MEDS>1:"s",1:"")_" from the "_GNAME
 ..S MESSAGE(2)="reminder order check items group:"
 ..D BMES^XPDUTL(.MESSAGE) K MESSAGE
 ..S PXRMINST=1
 ..S MED="" F  S MED=$O(MEDS(MED)) Q:(MED="")!($G(EXIT))  D
 ...D MES^XPDUTL("  "_MED)
 ...S REMOVE(801.015,MEDS(MED),.01)="@"
 ...D FILE^DIE("K","REMOVE")
 ...I $D(^TMP("DIERR",$J)) D  Q
 ....D MSG^DIALOG("AE",.MESSAGE,$G(IOM,75),2)
 ....K ^TMP("DIERR",$J)
 ....D MES^XPDUTL("  ERROR:"),MES^XPDUTL(.MESSAGE)
 ....S EXIT=1
 ..I '$D(EXIT) D
 ...D MES^XPDUTL("  DONE")
 S GNAME="VA-WH HIRISK MEDICATIONS (LACTATION LEVEL 2) GROUP"
 S GIEN=+$O(^PXD(801,"B",GNAME,""))
 I GIEN=0 D
 .S MESSAGE(1)="ERROR:"
 .S MESSAGE(2)="Could not find the "_GNAME_" reminder order check items group."
 .D BMES^XPDUTL(.MESSAGE) K MESSAGE
 I GIEN>0 D
 .K REMOVE
 .S MIEN=0 F  S MIEN=$O(^PXD(801,GIEN,1.5,MIEN)) Q:'+MIEN  D
 ..S REMOVE(801.015,MIEN_","_GIEN_",",.01)="@"
 .I $D(REMOVE(801.015))>9 D
 ..S MESSAGE(1)="Removing all items from the "_GNAME
 ..S MESSAGE(2)="reminder order check items group:"
 ..D BMES^XPDUTL(.MESSAGE) K MESSAGE
 ..D FILE^DIE("K","REMOVE")
 ..I $D(^TMP("DIERR",$J)) D  Q
 ...D MSG^DIALOG("AE",.MESSAGE,$G(IOM,75),2)
 ...K ^TMP("DIERR",$J)
 ...D MES^XPDUTL("  ERROR:"),MES^XPDUTL(.MESSAGE)
 ...K MESSAGE
 ..D MES^XPDUTL("  DONE")
 Q
 ;
RCOMP ;Remove components from the system
 N TYPES,ITEMS,GLOBAL,ITEM,TEST,IEN,MSG
 S TYPES("^PXD(811.9,")="reminder definition"
 S TYPES("^PXD(801.1,")="order check rule"
 S TYPES("^PXRMD(811.5,")="term"
 S TYPES("^PXD(801,")="order check group"
 S TYPES("^PXD(811.2,")="taxonomy"
 S TYPES("^PXRM(810.4,")="list rule"
 S TYPES("^PXRMD(801.41,")="reminder dialog"
 S ITEMS("^PXRMD(801.41,","VA-WH TD CLEAR PREGNANCY ALERT")="@"
 S ITEMS("^PXRMD(801.41,","VA-WH TD CLEAR LACTATION ALERT")="@"
 S GLOBAL="" F  S GLOBAL=$O(ITEMS(GLOBAL)) Q:GLOBAL=""  S ITEM="" F  S ITEM=$O(ITEMS(GLOBAL,ITEM)) Q:ITEM=""  D
 .S TEST=GLOBAL_"""B"","""_ITEM_""",0)"
 .S IEN=+$O(@TEST)
 .Q:'IEN
 .K MSG
 .S MSG(1)="  "_$S(ITEMS(GLOBAL,ITEM)'="@":"Renaming",1:"Deleting")_" the "_ITEM,MSG(2)="  "_TYPES(GLOBAL)_"..."
 .D MES^XPDUTL(.MSG)
 .I ITEMS(GLOBAL,ITEM)="@" D DELTLFE^PXRMUTIL($P($P(GLOBAL,"(",2),","),ITEM)
 .I ITEMS(GLOBAL,ITEM)'="@" D RENAME^PXRMUTIL($P($P(GLOBAL,"(",2),","),ITEM,ITEMS(GLOBAL,ITEM))
 .D MES^XPDUTL("    DONE")
 Q
 ;
INCCF(NAME) ;Include REMINDER COMPUTED FINDING file entry?
 Q:NAME="VA-WH PATIENT DOCUMENTATION" 1
 Q 0
