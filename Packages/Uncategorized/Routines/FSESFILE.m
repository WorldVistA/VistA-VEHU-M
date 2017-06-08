FSESFILE        ;JAS/ISA; CODE FOR EXTRACTING DATA FROM FILE 7100
 ;; v1
 S (CATEGORY,TYPE,ITEM,T1,T2,T3,SSUBCOMP)=""
 ; CODE FOR SELECTING OPEN CALLS AND CHECKING COUNTS
 S FSES1="",FSESTYPE="ESS OPEN CALLS"
 F  S FSES1=$O(^FSCD("CALL","ASTAT",1,FSES1)) Q:FSES1=""  S STATUS="Work In Progress" D
 . D PROCESS(FSES1),MAIL(FSESTYPE)
 . K REFNUMB,STATUS,DESC,SUBJECT,KEYWORD,DATEREC,REPSITE,PRISITE,PHONE,MODVERS,PRISPEC,PRIRITY,CLOPERS,HOURS,FUNAREA,PERTASK
 . K SUPOFFC,REFSTAT,AGEOFCA,AGESLED,DEVOFFC,REFSPEC,REOPEND,AGESLST,CURSTAT,DESCCNTR,NOTECNTR,PACKAGE,GROUP,PACK,GRP
 . K NOTE,NODE0,X,SUB,PRIPHON,SUBCOMP,VISN,VISNDA,WEBLINK,J,I,KEYWORD
 K FSES1,FSESTYPE
 ;
 ; CODE FOR SELECTING REFERRED CALLS AND CHECKING COUNTS
 S FSES3="",FSESTYPE="ESS REFERRED CALLS"
 F  S FSES3=$O(^FSCD("CALL","ASTAT",3,FSES3)) Q:FSES3=""  S STATUS="Referred To" D
 . D PROCESS(FSES3),MAIL(FSESTYPE)
 . K REFNUMB,STATUS,DESC,SUBJECT,KEYWORD,DATEREC,REPSITE,PRISITE,PHONE,MODVERS,PRISPEC,PRIRITY,CLOPERS,HOURS,FUNAREA,PERTASK
 . K SUPOFFC,REFSTAT,AGEOFCA,AGESLED,DEVOFFC,REFSPEC,REOPEND,AGESLST,CURSTAT,DESCCNTR,NOTECNTR,PACKAGE,GROUP,PACK,GRP
 . K NOTE,NODE0,X,SUB,PRIPHON,SUBCOMP,VISN,VISNDA,WEBLINK,J,I,KEYWORD
 K FSES3,FSESTYPE
 S DUZ=983
 Q        
PROCESS(FSESDA) ;
 ; DETERMINE HOW TO PROCESS THE OPEN AND REFERRED CALLS
 ; EXTRACT ALL THE DATA COMPONENTS
 ;
 ;NODE 0 FIELDS
 ;
 S NODE0=^FSCD("CALL",FSESDA,0)
 S REFNUMB=$P(NODE0,"^",1) ; NOIS REFERENCE NUMBER
 ;S STATUS=$P(^FSC("STATUS",$P(NODE0,"^",2),0),"^",1) ; STATUS - POINTER TO THE NOIS STATUS FILE (7106.1),
 S DATEREC=$P(NODE0,"^",3),X2=2700101,X1=DATEREC D ^%DTC S DATEREC=(X*1440) ; DATE CALL RECEIVED - FILEMAN DATE IN CYYMMDD.HHMMSS FORMAT
 I $P(NODE0,"^",5)="" S REPSITE="NO",VISN=0
 I $P(NODE0,"^",5)'="" S REPSITE=$P(^FSC("SITE",$P(NODE0,"^",5),776000),"^",1),VISNDA=$P(^FSC("SITE",$P(NODE0,"^",5),0),"^",12),VISN=$P(^FSC("VISN",VISNDA,0),"^",1) ; REPORTING SITE - POINTER TO THE NOIS LOCATION FILE (7105.1), RESOLVE POINTER
 I VISN="" S VISN=0
 I $P(NODE0,"^",6)="" S PRISITE="NO"
 I $P(NODE0,"^",6)'="" S PRISITE=$P(^VA(200,$P(NODE0,"^",6),776000),"^",1),CUSTID=$P(^VA(200,$P(NODE0,"^",6),776000),"^",2) ; PRIMARY SITE CONTACT - POINTER TO THE NEW PERSON FILE (200)
 S PRIPHON=$P(NODE0,"^",7) ; PHONE NUMBER OF THE PRIMARY SITE CONTACT
 I $P(NODE0,"^",8)="" S MODVERS="NO"
 I $P(NODE0,"^",8)'="" S MODVERS=$P(^FSC("MOD",$P(NODE0,"^",8),0),"^",1) D CTI ; MODULE/VERSION - POINTER TO THE NOIS MODULE/VERSION FILE (7105.4)
 I $P(NODE0,"^",9)="" S PRISPEC="NO"
 I $P(NODE0,"^",9)'="" S PRISPEC=$P(^VA(200,$P(^FSC("SPEC",$P(NODE0,"^",9),0),"^",1),776000),"^",1) ; PRIMARY SPECIALISTS - POINTER TO THE NOIS USER DEFAULTS FILE (7105.2)
 I $P(NODE0,"^",10)="" S PRIRITY="NO"
 I $P(NODE0,"^",10)'="" S PRIRITY=$P(^FSC("PRI",$P(NODE0,"^",10),0),"^",1) ; PRIORITY - POINTER TO THE NOIS PRIORITY FILE (7106.2)
 I $P(NODE0,"^",11)="" S CLOPERS="NO"
 I $P(NODE0,"^",11)'="" S CLOPERS=$P(^FSC("SPEC",$P(NODE0,"^",11),0),"^",1) ; CLOSING PERSON - POINTER TO THE NOIS USER DEFAULTS FILE (7105.2)
 S HOURS=$P(NODE0,"^",13) ; TOTAL HOURS ON CALL
 I $P(NODE0,"^",14)="" S FUNAREA="NO"
 I $P(NODE0,"^",14)'="" S FUNAREA=$P(^FSC("FUNC",$P(NODE0,"^",14),0),"^",1) ; FUNCTIONAL AREA - POINTER TO THE NOIS FUNCTIONAL AREA FILE (7106.4)
 I $P(NODE0,"^",15)="" S PERTASK="NO"
 I $P(NODE0,"^",15)'="" S PERTASK=$P(^FSC("TASK",$P(NODE0,"^",15),0),"^",1) ; PERFORMED TASK - POINTER TO THE NOIS TASK FILE (7106.3)
 I $P(NODE0,"^",16)="" S SUPOFFC="NO"
 I $P(NODE0,"^",16)'="" S SUPOFFC=$P(^FSC("ISC",$P(NODE0,"^",16),0),"^",1) ; SUPPORT OFFICE - POINTER TO THE NOIS OFFICE FILE (7105.3)
 I $P(NODE0,"^",17)="" S REFSTAT="NO"
 I $P(NODE0,"^",17)'="" S REFSTAT=$P(^FSC("STATUS",$P(NODE0,"^",17),0),"^",1) ; REFERRAL STATUS - POINTER TO THE NOIS REFERRAL STATUS FILE (7106.1)
 S AGEOFCA=$P(NODE0,"^",18) ; AGE OF CALL
 S AGESLED=$P(NODE0,"^",19) ; AGE SINCE LAST EDIT
 I $P(NODE0,"^",20)="" S DEVOFFC="NO"
 I $P(NODE0,"^",20)'="" S DEVOFFC=$P(^FSC("ISC",$P(NODE0,"^",20),0),"^",1) ; DEVELOPING OFFICE - POINTER TO THE NOIS OFFICE FILE (7105.3)
 I $P(NODE0,"^",21)="" S REFSPEC="NO"
 I $P(NODE0,"^",21)'="" S REFSPEC=$P(^FSC("SPEC",$P(NODE0,"^",21),0),"^",1) ; REFERRAL SPECIALISTS - POINTER TO THE NOIS USER DEFAULTS FILE (7105.2)
 S REOPEND=$P(NODE0,"^",22) ; REOPENED - FILEMAN DATE IN CYYMMDD.HHMMSS FORMAT
 S AGESLST=$P(NODE0,"^",23) ; AGE SINCE LAST STATUS
 I $P(NODE0,"^",24)="" S CURSTAT="NO"
 I $P(NODE0,"^",24)'="" S CURSTAT=$P(^FSC("STATUS",$P(NODE0,"^",24),0),"^",1) ; CURRENT STATUS - POINTER TO THE NOIS STATUS FILE (7106.1)
 ;
 ;NODE 1 FIELDS
 ;
 S SUBJECT=$S($D(^FSCD("CALL",FSESDA,1))=1:^FSCD("CALL",FSESDA,1),$D(^FSCD("CALL",FSESDA,1))=0:"no SUBJECT",1:0)
 ; SUBJECT
 ;
 ;NODE 1.5 FIELDS
 S KEYWORDS=$S($D(^FSCD("CALL",FSESDA,1.5))=1:^FSCD("CALL",FSESDA,1.5),$D(^FSCD("CALL",FSESDA,1.5))=0:"no KEYWORDS",1:0)
 ; KEYWORDS
 ;
 ;NODE 1.7 FIELDS
 ;
 S WEBLINK=$S($D(^FSCD("CALL",FSESDA,1.7))=1:^FSCD("CALL",FSESDA,1.7),$D(^FSCD("CALL",FSESDA,1.7))=0:"no WEBLINK",1:0)
 ; WEB LINK
 ;
 ;NODE 30 FIELDS
 ;
 I $D(^FSCD("CALL",FSESDA,30,0))=1 S %X="^FSCD(""CALL"",FSESDA,30",%Y="DESC(" D %XY^%RCR S DESCCNTR=$P(DESC(30,0),"^",3)
 I $D(^FSCD("CALL",FSESDA,30,0))=0 S DESC(30,0)="0^0^0^0",DESCCNTR=0
 ; SUPPORT REQUEST DESCRIPTION
 ;
 ;NODE 50 FIELDS
 ;
 I $D(^FSCD("CALL",FSESDA,50,0))=1 S %X="^FSCD(""CALL"",FSESDA,50",%Y="NOTE(" D %XY^%RCR S NOTECNTR=$P(NOTE(50,0),"^",3)
 I $D(^FSCD("CALL",FSESDA,50,0))=0 S NOTE(50,0)="0^0^0^0",NOTECNTR=0
 ;
 ;NODE 120 FIELDS
 ;
 I $D(^FSCD("CALL",FSESDA,120)) S PACK=$P(^FSCD("CALL",FSESDA,120),"^",9),GRP=$P(^FSCD("CALL",FSESDA,120),"^",13),SUB=$P(^FSCD("CALL",FSESDA,120),"^",11)
 ;PACKAGE
 I PACK'="" S PACKAGE=$P(^FSC("PACK",PACK,0),"^",1)
 I PACK="" S PACKAGE="NO"
 ;GROUP
 I GRP'="" S GROUP=$P(^FSC("PACKG",GRP,0),"^",1)
 I GRP="" S GROUP="NO"
 ;SUBCOMPONENT
 I SUB'="" S SUBCOMP=$P(^FSC("SUB",SUB,0),"^",1)
 I SUB="" S SUBCOMP=""       
 Q
 Q
MAIL(VAL)       ; WHERE VAL IS THE SUBJECT HEADING
 S XMDUZ=DUZ,U="^"
 S XMSUB=VAL_" "_REFNUMB
 ;S XMY("essresource@med.va.gov")=""
 S XMY("jerry.sicard@med.va.gov")=""
 ;S XMY("neil.piper@med.va.gov")=""
 S XMY(983)=""
 ;S XMY($P(NODE0,"^",9))=""
 ;D NOW^%DTC S Y=X D DD^%DT
 S XMTEXT(1)="Reference Number    :"_REFNUMB
 S XMTEXT(2)="Status              :"_STATUS
 S XMTEXT(3)="Subject             :"_SUBJECT
 S XMTEXT(4)="Date Received       :"_DATEREC
 S XMTEXT(5)="Reporting Site      :"_REPSITE
 S XMTEXT(6)="Tier 2 Specialist   :"_PRISPEC
 S XMTEXT(7)="Category            :"_CATEGORY
 S XMTEXT(8)="Type                :"_TYPE
 S XMTEXT(9)="Item                :"_MODVERS
 S XMTEXT(10)="Subcomponent        :"_SUBCOMP
 S XMTEXT(11)="Sub Subcomponent    :"_SSUBCOMP
 S XMTEXT(12)="Requesters Name     :"_PRISITE
 S XMTEXT(13)="Phone Number        :"_PRIPHON
 S XMTEXT(14)="Functional Area     :"_FUNAREA
 S XMTEXT(15)="Package             :"_PACKAGE
 S XMTEXT(16)="Group               :"_GROUP
 S XMTEXT(17)="VISN                :"_VISN
 S XMTEXT(18)="Tier 1 Group        :"_T1
 S XMTEXT(19)="Tier 2 Group        :"_T2
 S XMTEXT(20)="Tier 3 Group        :"_T3
 S XMTEXT(21)="Customer ID         :"_CUSTID        
 S XMTEXT(22)="Description---------:"
 F I=1:1:DESCCNTR S XMTEXT(I+22)=DESC(30,I,0)
 S XMTEXT(I+22+1)="End_Description-----:"
 S XMTEXT(I+22+2)="Notes---------------:"
 F J=1:1:NOTECNTR S XMTEXT(I+22+J+2)=NOTE(50,J,0)
 S XMTEXT(I+22+J+2)="End_Notes-----------:"
 S XMTEXT="XMTEXT("
 S XMCHAN=1
 D ^XMD                       
 Q 
CTI ;    
 I MODVERS["90 DAY CLAIMS COLLECT" S CATEGORY="Applications",TYPE="VistA",MODVERS="90 Day Claims Collect V1.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Medical Center Management",T3="" Q
 I MODVERS["ACCOUNTS RECEIVABLE/4.5" S CATEGORY="Applications",TYPE="VistA",MODVERS="Accounts Receivable V4.5",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Medical Center Management",T3="" Q
 I MODVERS["AICS/3.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="AICS V3.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Medical Center Management",T3="" Q
 I MODVERS["ALPHA/NT" S CATEGORY="Applications",TYPE="VistA",MODVERS="Alpha/NT",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Avanti",T3="" Q
 I MODVERS["ALPHA/VMS" S CATEGORY="Applications",TYPE="VistA",MODVERS="Alpha/VMS",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/AXP",T3="" Q
 I MODVERS["AMB CARE REPORTING PROJECT" S CATEGORY="Applications",TYPE="VistA",MODVERS="Scheduling V5.3",SUBCOMP="Package/Patch",SSUBCOMP="Ambulatory Care",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["AMIE II" S CATEGORY="Applications",TYPE="COTS/Vendor",MODVERS="AMIE II",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["AMIE/2.7" S CATEGORY="Applications",TYPE="VistA",MODVERS="AMIE V2.7",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["ASISTS/1.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="ASISTS V1.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Fiscal Management",T3="" Q
 I MODVERS["AUTHORIZATION/SUBSCRIPTION/1.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Authorization Subscription V1.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["BAR CODE MED ADMIN/1.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Bar Code Medication Administration V1.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 1",T3="" Q
 I MODVERS["BED CONTROL/1.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="ADT/R V5.3",SUBCOMP="Package/Patch",SSUBCOMP="Bed Control V1.0",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["BROUTER/ROUTER" S CATEGORY="Communications",TYPE="Internal",MODVERS="Data Networks",SUBCOMP="Router",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Local and Wide Area Network",T3="" Q
 I MODVERS["CACHE/NT" S CATEGORY="Systems",TYPE="Software",MODVERS="Cache/NT",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Avanti",T3="" Q
 I MODVERS["CIRN/1.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="CIRN V1.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["CLINICAL LEXICON/2.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Clinical Lexicon V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["CLINICAL REMINDERS/1.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Clinical Reminders V1.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["CONSOLIDATED MAIL OPT PHARMACY" S CATEGORY="Applications",TYPE="VistA",MODVERS="CMOP V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 1",T3="" Q
 I MODVERS["CONSULT/REQUEST TRACKING/3.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Consult Request Tracking V3.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["CONTROLLED SUBSTANCE/3.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Controlled Substance V3.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 1",T3="TS/Clinical Ancillary" Q
 I MODVERS["CPT/6.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="CPT V6.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["DENTAL/1.2" S CATEGORY="Applications",TYPE="VistA",MODVERS="Dental V1.2",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 1",T3="TS/Clinical Ancillary" Q
 I MODVERS["DIETETICS/5.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Dietetics V5.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["DRG GROUPER/16.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="DRG V16.0",SUBCOMP="Package/Patch Release",SSUBCOMP="Modifers",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["DRUG ACCOUNTABILITY/3.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Drug Accountability V3.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 1",T3="TS/Clinical Ancillary" Q
 I MODVERS="DSM" S CATEGORY="Systems",TYPE="Software",MODVERS="DSM/VMS",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/AXP",T3="" Q
 I MODVERS["DSS/3.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="DSS V3.0",SUBCOMP="Package/Patch Release",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Fiscal Management",T3="" Q
 I MODVERS["EEO/2.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="EE0 V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Medical Center Management",T3="" Q
 I MODVERS["ENGINEERING/7.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Engineering V7.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Fiscal Management",T3="" Q
 I MODVERS["ENROLLMENT-HEC" S CATEGORY="Applications",TYPE="VistA",MODVERS="ADT/R V5.3",SUBCOMP="Package/Patch Release",SSUBCOMP="Enrollment-HEC",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["ENROLLMENT-VISTA" S CATEGORY="Applications",TYPE="VistA",MODVERS="ADT/R V5.3",SUBCOMP="Package/Patch Release",SSUBCOMP="Enrollment-VISTA",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["EQUINOX" S CATEGORY="Communications",TYPE="Internal",MODVERS="Terminal Server/NT",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Avanti",T3="" Q
 I MODVERS["EQUIPMENT/TURN-IN REQUEST/1.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Equipment Turn-In Request V1.0",SUBCOMP="Package/Patch Release",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Fiscal Management",T3="" Q
 I MODVERS["EVENT CAPTURE/2.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Event Capture V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Fiscal Management",T3="" Q
 I MODVERS["EXTENSIBLE EDITOR/2.6" S CATEGORY="Applications",TYPE="VistA",MODVERS="Extensible Editor (Cairo) V2.6",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["FEE BASIS/3.5" S CATEGORY="Applications",TYPE="VistA",MODVERS="Fee Basis V3.5",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Medical Center Management",T3="" Q
 I MODVERS["FILEMAN DELPHI COMPONENTS" S CATEGORY="Applications",TYPE="VistA",MODVERS="Fileman Delphi Components",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Infrastructure",T3="" Q
 I MODVERS["FILEMAN/20" S CATEGORY="Applications",TYPE="VistA",MODVERS="Fileman V20.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Infrastructure",T3="" Q
 I MODVERS["FILEMAN/21" S CATEGORY="Applications",TYPE="VistA",MODVERS="Fileman V21.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Infrastructure",T3="" Q
 I MODVERS["FILEMAN/22" S CATEGORY="Applications",TYPE="VistA",MODVERS="Fileman V22.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Infrastructure",T3="" Q
 I MODVERS["FMS" S CATEGORY="Applications",TYPE="COTS/Vendor",MODVERS="FMS",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Fiscal Management",T3="" Q
 I MODVERS["GENERIC CODE SHEET/2.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Generic Code Sheet V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Fiscal Management",T3="" Q
 I MODVERS["HBHC/1.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="HBHC V1.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["HEALTH SUMMARY/2.5" S CATEGORY="Applications",TYPE="VistA",MODVERS="Health Summary V2.7",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["HINQ/4.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="HINQ V4.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["HL7/1.6" S CATEGORY="Applications",TYPE="VistA",MODVERS="HL7 V1.6",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Infrastucture",T3="" Q
 I MODVERS["IFCAP/5.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="IFCAP V5.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Fiscal Management",T3="" Q
 I MODVERS["IMAGING/2.0" S CATEGORY="Applications",TYPE="COTS/Vendor",MODVERS="Imaging V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Imaging",T3="" Q
 I MODVERS["IMMUNOLOGY CASE REGISTRY/2.1" S CATEGORY="Applications",TYPE="VistA",MODVERS="Immunology Case Registry V2.1",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 1",T3="TS/Clinical Ancillary" Q
 I MODVERS["INTAKE/OUTPUT/4.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Intake/Output V4.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["INTEGRATED BILLING/2.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Integrated Billing V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Medical Center Management",T3="" Q
 I MODVERS["IVM/2.0-HEC" S CATEGORY="Applications",TYPE="VistA",MODVERS="IVM V2.0-HEC",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Medical Center Management",T3="" Q
 I MODVERS["IVM/2.0-VistA" S CATEGORY="Applications",TYPE="VistA",MODVERS="IVM V2.0-VISTA",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Medical Center Management",T3="" Q
 I MODVERS["KERNEL TOOLKIT/7.3" S CATEGORY="Applications",TYPE="VistA",MODVERS="Kernel Toolkit V7.3",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Infrastructure",T3="" Q
 I MODVERS["KERNEL/8.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Kernel V8.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Infrastructure",T3="" Q
 I MODVERS["LAB/5.2" S CATEGORY="Applications",TYPE="VistA",MODVERS="Laboratory V5.2",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["LIBRARY/5.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Library V5.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Fiscal Management",T3="" Q
 I MODVERS["LIST MANAGER" S CATEGORY="Applications",TYPE="VistA",MODVERS="List Manager",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Infrastructure",T3="" Q
 I MODVERS["MAILMAN/7.1" S CATEGORY="Applications",TYPE="VistA",MODVERS="Mailman V7.1",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Infrastructure",T3="" Q
 I MODVERS["MAS/5.3" S CATEGORY="Applications",TYPE="VistA",MODVERS="ADT/R V5.3",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["MASTER PATIENT INDEX/1.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="MPI V1.0 (Master Patient Index)",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["MEDICINE/2.3" S CATEGORY="Applications",TYPE="VistA",MODVERS="Medicine V2.3",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["MENTAL HEALTH/5.01" S CATEGORY="Applications",TYPE="VistA",MODVERS="Mental Health V5.01",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["MICRONETICS MUMPS" S CATEGORY="Applications",TYPE="VistA",MODVERS="MSM/NT",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Avanti",T3="" Q
 I MODVERS["MINIMUM PATIENT DATASET/1.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="MPD V1,0 (Minimum Patient Dataset)",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["MS EXCHANGE/5.5" S CATEGORY="Applications",TYPE="COTS/Vendor",MODVERS="Microsoft",SUBCOMP="Exchange",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Internal Ops",T3="" Q
 I MODVERS["NETWORK HEALTH EXCHANGE/5.1" S CATEGORY="Applications",TYPE="VistA",MODVERS="Network Health Exchange V5.1",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["NT SERVER/4.0" S CATEGORY="Applications",TYPE="COTS/Vendor",MODVERS="Microsoft",SUBCOMP="Windows NT Server",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Internal Ops",T3="" Q
 I MODVERS["NT WORKSTATION/4.0" S CATEGORY="Applications",TYPE="COTS/Vendor",MODVERS="Windows NT Workstation",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Internal Ops",T3="" Q
 I MODVERS["NURSING/4.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Nursing V4.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["OERR/3.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="OERR V3.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["ONCOLOGY/2.11" S CATEGORY="Applications",TYPE="VistA",MODVERS="Oncology V2.11",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["ONLINE BACKUP (DSM)/3.0" S CATEGORY="Systems",TYPE="Software",MODVERS="VISTA BACKUP/VMS",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/AXP",T3="" Q
 I MODVERS["PAID/4.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="PAID V4.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Fiscal Management",T3="" Q
 I MODVERS["PATIENT CARE ENCOUNTER/1.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="PCE V1.0 (Patient Care Encounter)",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["PATIENT DATA EXCHANGE/1.5" S CATEGORY="Applications",TYPE="VistA",MODVERS="PDE V1.5 (Patient Data Exchange)",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["PATIENT MERGE" S CATEGORY="Applications",TYPE="VistA",MODVERS="Patient Merge",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["PATIENT REPRESENTATIVE/2.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Patient Representative V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Medical Center Management",T3="" Q
 I MODVERS["PBM/3.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="PBM V3.0 (Pharmacy Benefits Management)",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/",T3="" Q
 I MODVERS["PCMM" S CATEGORY="Applications",TYPE="VistA",MODVERS="Scheduling V5.3",SUBCOMP="Package/Patch Release",SSUBCOMP="PCMM",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["PHARM-DATA MANAGEMENT" S CATEGORY="Applications",TYPE="VistA",MODVERS="PDM V1.0 (Pharmacy Data Management)",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 1",T3="TS/Clinical Ancillary" Q
 I MODVERS["PHARM-INPAT/5.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Inpatient Medications V5.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 1",T3="TS/Clinical Ancillary" Q
 I MODVERS["PHARM-NATIONAL DRUG FILE/4.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="National Drug File V4.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 1",T3="TS/Clinical Ancillary" Q
 I MODVERS["PHARM-OUTPT/7.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Outpatient Pharmacy V7.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 1",T3="TS/Clinical Ancillary" Q
 I MODVERS["PHARM-PHARMACY DATA MANAGEMENT/1.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="PDM V1.0 (Pharmacy Data Management)",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 1",T3="TS/Clinical Ancillary" Q
 I MODVERS["PROBLEM LIST/2.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Problem List V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["PROSTHETICS/3.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Prosthetics V3.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Fiscal Management",T3="" Q
 I MODVERS["QA-CREDENTIALS & PRIV/2.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="QA Credentials & Privledging V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["QA-INCIDENT REPORTING/2.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="QA Incident Reporting V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["QA-OCCURENCE SCREENING/3.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="QA Screening V3.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
QUASAR ;I MODVERS["QUASAR/2.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="QUASAR V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["QUASAR/3.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="QUASAR V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["RADIOLOGY/5.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Radiology V5.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["RECORDS TRACKING/2.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Record Tracking V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["ROES/2.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="ROES V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Fiscal Management",T3="" Q
 I MODVERS["RPC BROKER/1.1" S CATEGORY="Applications",TYPE="VistA",MODVERS="RPC Broker V1.1",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Infrastructure",T3="" Q
 I MODVERS["SCHEDULING/5.3" S CATEGORY="Applications",TYPE="VistA",MODVERS="Scheduling V5.3",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["SECURITY POLICE/1.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Police/Security V1.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Fiscal Management",T3="" Q
 I MODVERS["SOCIAL WORK/3.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Social Work V3.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["SPINAL CORD DYSFUNCTION/2.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Spinal Cord Dysfunction V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["SURGERY/3.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Surgery V3.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 1",T3="TS/Clinical Ancillary" Q
 I MODVERS["TEXT INTEGRATION UTILITY/1.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="TIU V1.0 (Text Integration Utility)",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["VISIT TRACKING" S CATEGORY="Applications",TYPE="VistA",MODVERS="Visit Tracking V2.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 I MODVERS["VMS" S CATEGORY="Systems",TYPE="Software",MODVERS="VMS",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/AXP",T3="" Q
 I MODVERS["VOLUNTEER TIMEKEEPING/4.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Volunteer Timekeeping V4.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Fiscal Management",T3="" Q
 I MODVERS["WAN" S CATEGORY="Communications",TYPE="Internal",MODVERS="Data Networks",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Local and Wide Area Network",T3="" Q
 I MODVERS["WOMEN'S HEALTH/1.0" S CATEGORY="Applications",TYPE="VistA",MODVERS="Women's Health V1.0",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Clinical 2",T3="" Q
 I MODVERS["SYSTEMS MANAGEMENT SERVER" S CATEGORY="Applications",TYPE="VistA",MODVERS="",SUBCOMP="",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/",T3="" Q
 I MODVERS["VETERANS ID CARD" S CATEGORY="Applications",TYPE="VistA",MODVERS="",SUBCOMP="Package/Patch Release",SSUBCOMP="VIC",T1="VHA National Help Desk",T2="CS/PIMS",T3="" Q
 ;I MODVERS["" S CATEGORY="Applications",TYPE="COTS/Vendor",MODVERS="Microsoft",SUBCOMP="SMS",SSUBCOMP="",T1="VHA National Help Desk",T2="CS/Internal Ops",T3="" Q
 Q
