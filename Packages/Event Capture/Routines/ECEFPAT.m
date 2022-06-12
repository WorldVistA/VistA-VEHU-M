ECEFPAT ;ALB/JAM-Enter Event Capture Data Patient Filer ;9/6/19  15:40
 ;;2.0;EVENT CAPTURE;**25,32,39,42,47,49,54,65,72,95,76,112,119,114,126,134,139,148**;8 May 96;Build 4
 ;
 ; Reference to $$SINFO^ICDEX supported by ICR #5747
 ; Reference to $$ICDDX^ICDEX supported by ICR #5747
 ; 
FILE ;Used by the RPC broker to file patient encounter in file #721
 ;  Uses Supported IA 1995 - allow access to $$CPT^ICPTCOD
 ;
 ;     Variables passed in
 ;       ECIEN   - IEN of #721, if editing
 ;       ECDEL   - Delete record. 1- YES; 0- 0, null or undefine for NO.
 ;       ECDFN   - Patient IEN for file #2
 ;       ECDT    - Date and time of procedure
 ;       ECL     - Location
 ;       ECD     - DSS Unit
 ;       ECC     - Category
 ;       ECP     - Procedure
 ;       ECVOL   - Volume
 ;       ECU1..n - Provider (1 thru n), Prov 1 is required,other optional
 ;       ECMN    - Ordering Section
 ;       ECDUZ   - Entered/Edited by, pointer to #200
 ;       ECDX    - Primary Diagnosis
 ;       ECDXS   - Secondary Diagnosis; multiple, optional
 ;       EC4     - Associated Clinic, required if sending data to PCE
 ;       ECPTSTAT- Patient Status
 ;       ECPXREAS- Procedure reason, optional
 ;       ECPXREA2- Procedure reason #2, optional ;112
 ;       ECPXREA3- Procedure reason #3, optional ;112
 ;       ECMOD   - CPT modifiers, optional
 ;       ECLASS  - Classification, optional
 ;       ECELIG  - Eligibility, optional
 ;       ECSOURCE- Indicates source of input (e.g. STATE HOME)
 ;       ECSSID  - Unique Spread Sheet ID (ddmmyyyyhhmmss_hash)
 ;       ECSHNAME- Name of State Home from spread sheet upload
 ;
 ;     Variable return
 ;       ^TMP($J,"ECMSG",n)=Success or failure to file in #721^Message
 ;
 N NODE,ECS,ECM,ECID,ECCPT,ECINT,ECPCE,ECX,ECERR,ECOUT,ECFLG,ECRES
 N ECFIL,ECPRV,ECCS
 ; Determine Active Coding System based on Date of Interest
 S ECCS=$S($G(ECDT)'="":ECDT,1:DT)
 S ECCS=$$SINFO^ICDEX("DIAG",ECCS) ; Supported by ICR 5747
 ;
 S ECFLG=1,ECERR=0 D CHKDT(1) I ECERR Q
 F ECX=1:1 Q:'$D(@("ECU"_ECX))  D  I ECERR Q
 .I @("ECU"_ECX)="" Q
 .S NODE=$$GET^XUA4A72(@("ECU"_ECX),ECDT) I +NODE'>0&($P($G(^ECD(ECD,0)),U,14)'="N") S ECERR=1 D  Q  ;134 Added check for DSS Unit's send to PCE setting. If set to "no" allow non-providers to be used.
 ..S ^TMP($J,"ECMSG",1)="0^Provider doesn't have an active Person class"
 .S ECPRV(ECX)=@("ECU"_ECX)_"^^"_$S(ECX=1:"P",1:"S")
 I $G(ECIEN)'="" S ECFLG=0 D  I ECERR Q
 . I '$D(^ECH(ECIEN)) S ECERR=1,^TMP($J,"ECMSG",1)="0^Pat IEN Not Found"
 I $G(ECDEL) K ^TMP($J,"ECMSG") D  Q
 .S ECVST=$P($G(^ECH(ECIEN,0)),"^",21) I ECVST D
 ..;* Resend all EC records with same Visit file entry to PCE
 ..;* Remove Visit entry from ^ECH( so DELVFILE will complete cleanup
 ..K EC2PCE S ECVAR1=$$FNDVST^ECUTL(ECVST,,.EC2PCE) K ECVAR1
 ..;Set VALQUIET to stop Amb Care validator from broadcasting to screen
 ..N ECPKG,ECSOU
 ..S ECPKG=$O(^DIC(9.4,"B","EVENT CAPTURE",0)),ECSOU="EVENT CAPTURE DATA"
 ..S VALQUIET=1,ECVV=$$DELVFILE^PXAPI("ALL",ECVST,ECPKG,ECSOU) K ECVST,VALQUIET
 ..;- Send to PCE task
 ..D PCETASK^ECPCEU(.EC2PCE) K EC2PCE
 .S DA=ECIEN,DIK="^ECH(" D ^DIK K DA,DIK,ECVV
 .D TABLE("D",ECIEN) ;134 Remove entry from table
 .S ^TMP($J,"ECMSG",1)="1^Procedure Deleted"
 I '$D(ECPRV) S ^TMP($J,"ECMSG",1)="0^No provider present" Q
 S ECDT=+ECDT,NODE=$G(^ECD(ECD,0)) I NODE="" D MSG Q
 S ECFN=$G(ECIEN),ECVOL=$G(ECVOL,1),ECS=$P(NODE,U,2),ECM=$P(NODE,U,3)
 S ECPCE="U~"_$S($P(NODE,"^",14)]"":$P(NODE,"^",14),1:"N")
 ;S ECPTSTAT=$$INOUTPT^ECUTL0(ECDFN,+ECDT) ;pat stat may not need
 I $P(ECPCE,"~",2)="OOS" D OOSCLIN ;139 If OOS type DSS unit, get clinic for sending data to PCE
 I $G(EC4)="" D GETCLN^ECEDF
 S ECID=$S(+EC4:$P($G(^SC(+EC4,0)),"^",7),1:""),ECINP=ECPTSTAT
 I $P(ECPCE,"~",2)="A" D CHKDT(2) ;139
 I +EC4 S ECRES=$$CLNCK^SDUTL2(+EC4,0) I 'ECRES D  S ECERR=1
 .S ^TMP($J,"ECMSG",1)=ECRES_" Clinic MUST be corrected before filing."
 Q:ECERR  I ECFLG D NEWIEN I $G(ECSOURCE)="STATE HOME" D TABLE("A",ECIEN) ;134 If state home record, add to table
 S ECCPT=$S(ECP["ICPT":+ECP,1:$P($G(^EC(725,+ECP,0)),U,5))
 ;validate CPT value and handle HCPCS name to IEN conversion (HD223010)
 S ECCPT=+$$CPT^ICPTCOD(ECCPT)
 S ECCPT=$S(+ECCPT>0:ECCPT,1:0)
 K DA,DR,DIE S DIE="^ECH(",(DA,ECFN)=ECIEN K ECIEN
 S DR=".01////"_ECFN_";1////"_ECDFN_";3////"_ECL_";4////"_ECS
 S DR=DR_";5////"_ECM_";6////"_ECD_";7////"_+ECC_";9////"_ECVOL
 S $P(^ECH(ECFN,0),"^",9)=ECP
 D ^DIE I $D(DTOUT) D RECDEL,MSG Q
 K DA,DR,DIE S DIE="^ECH(" ;139
 S DA=ECFN,DR="11////"_ECMN_";13////"_ECDUZ_";2////"_ECDT
 ;S ECPXREAS=$G(ECPXREAS) ;112
 D CVTREAS Q:$G(ECERR)  ;119 Convert reasons from entries in 720.4 to entries in 720.5 before storing.
 S DR=DR_";19////"_$S(+ECCPT:ECCPT,1:"@")_";20////"_ECDX
 S DR=DR_";26////"_$S($G(EC4):EC4,1:"")_";27////"_$G(ECID)_";29////"_ECPTSTAT ;126 allow EC4 to be null if no associated clinic
 S DR=DR_";34////"_$S($G(ECPXREAS)="":"@",1:ECPXREAS) ;112
 S DR=DR_";43////"_$S($G(ECPXREA2)="":"@",1:ECPXREA2) ;112
 S DR=DR_";44////"_$S($G(ECPXREA3)="":"@",1:ECPXREA3) ;112
 I $G(ECSOURCE)="STATE HOME" D  ;139 Added section for state home records
 .N STATUS,IMPDT
 .S STATUS=$$STAT ;Determine if "late"
 .S IMPDT=($E(ECSSID,5,6)-17)_$E(ECSSID,7,8)_$E(ECSSID,1,4)_"."_$E(ECSSID,9,14) ;Convert date to intermal FM format
 .S DR=DR_";45////"_ECSOURCE_";46///"_STATUS_";47////"_IMPDT_";48////"_ECSSID_";49////"_$G(ECSHNAME) ;139,148 Add source, status, import date/time and spreadsheet ID - 148, add state home name
 .Q
 D ^DIE I $D(DTOUT) D RECDEL,MSG Q
 I ECDX S ^DISV(DUZ,"^ICD9(")=ECDX  ;last ICD9 code
 S ECX=$O(ECPRV("A"),-1) I ECX'="" S ^DISV(DUZ,"^VA(200,")=+ECPRV(ECX)
 ;Remove Old CPT modifiers
 I 'ECFLG D
 . K OLDMOD S (ECDA,DA(1))=ECFN,DIK="^ECH("_DA(1)_",""MOD"",",DA=0
 . F  S DA=$O(^ECH(ECDA,"MOD",DA)) Q:'DA  S OLDMOD(DA)="" D ^DIK
 . K DA,ECDA,DIK,^ECH(ECFN,"MOD")
 .;Remove old secondary diagnosis codes
 . K OLDDXS S (ECDA,DA(1))=ECFN,DIK="^ECH("_DA(1)_",""DX"",",DA=0
 . F  S DA=$O(^ECH(ECDA,"DX",DA)) Q:'DA  S OLDDXS(DA)="" D ^DIK
 . K DA,ECDA,DIK,^ECH(ECFN,"DX")
 I $D(DTOUT) D RECDEL,MSG Q
 ;File multiple providers
 S ECFIL=$$FILPRV^ECPRVMUT(ECFN,.ECPRV,.ECOUT) K ECOUT
 I 'ECFIL D RECDEL,MSG Q
 ;File CPT modifiers
 I $G(ECMOD)'="" D
 . S DIC(0)="L",DA(1)=ECFN,DIC("P")=$P(^DD(721,36,0),U,2)
 . S DIC="^ECH("_DA(1)_","_"""MOD"""_","
 . F ECX=1:1:$L(ECMOD,"^") S MODIEN=$P(ECMOD,U,ECX) I +MODIEN>0 D
 . . K DD,DO S X=MODIEN D FILE^DICN
 . K MODIEN,DIC
 I $D(DTOUT) D RECDEL,MSG Q
 ; File multiple secondary diagnosis codes
 I $G(ECDXS)'="" D
 . S DXS="",DIC(0)="L",DA(1)=ECFN,DIC("P")=$P(^DD(721,38,0),U,2)
 . S DIC="^ECH("_DA(1)_","_"""DX"""_",",ECDXY=ECDX K ECDXX
 . F ECX=1:1:$L(ECDXS,"^") S DXSIEN=$P(ECDXS,U,ECX) I +DXSIEN>0 D
 . . ; Retrieve ICD data - Supported by ICR 5747
 . . S DXCDE=$$ICDDX^ICDEX(DXSIEN,ECDT,+ECCS,"I") Q:+DXCDE<0  I '$P(DXCDE,U,10) Q
 . . K DD,DO S X=DXSIEN D FILE^DICN
 . . S DXCDE=$P(DXCDE,U,2),ECDXX(DXCDE)=DXSIEN
 . . S ^DISV(DUZ,"^ICD9(")=DXSIEN  ;last ICD9 code
 . ; Update all procedures for an encounter with same primary & second dx
 . S PXUPD=$$PXUPD^ECUTL2(ECDFN,ECDT,ECL,EC4,ECDXY,.ECDXX,ECFN)
 . K PXUPD,ECDXY,ECDXX,DXS,DXSIEN,DIC,DXCDE,DA,DD,DO
 I $D(DTOUT) D RECDEL,MSG Q
 S DA=ECFN
 ;File classification AO^IR^SC^EC^MST^HNC^CV^SHAD
 I $G(ECLASS)'="" D
 . S CLSTR="21^22^24^23^35^39^40^41",DR=""
 . F ECX=1:1:$L(CLSTR,"^") D
 . . S DR=DR_$P(CLSTR,U,ECX)_"////"_$P(ECLASS,U,ECX)_";"
 . S DR=$E(DR,1,($L(DR)-1)) D ^DIE
 . K CLSTR,DR,DIE
 I $D(DTOUT) D RECDEL,MSG Q
 ;
PCE ; format PCE data to send
 I ($P(ECPCE,"~",2)="N") D  Q  ;139
 .S ^TMP($J,"ECMSG",1)="1^Record Filed"
 D:ECFLG PCE^ECBEN2U I 'ECFLG S EC(0)=^ECH(ECFN,0) D PCEE^ECBEN2U K EC
 I $G(ECOUT)!(ECERR) D  Q
 . D RECDEL S STR=$S($G(^ECH(ECFN,"R")):^("R"),1:" PCE Data Missing")
 . S ^TMP($J,"ECMSG",1)="0^Record Not Filed, "_STR K STR
 S ^TMP($J,"ECMSG",1)="1^Record Filed"_U_$G(ECIEN)
 Q
 ;
NEWIEN ;Create new IEN in file #721
 N DIC,DA,DD,DO,ECRN
RLCK L +^ECH(0):60 S ECRN=$P(^ECH(0),"^",3)+1
 I $D(^ECH(ECRN)) S $P(^ECH(0),"^",3)=$P(^(0),"^",3)+1 L -^ECH(0) G RLCK
 L -^ECH(0) S DIC(0)="L",DIC="^ECH(",X=ECRN
 D FILE^DICN S ECIEN=+Y
 Q
RECDEL ; Delete record
 ;restore old data
 I 'ECFLG D  Q
 . I $O(OLDMOD("")) D
 . . S DIC(0)="L",DA(1)=ECFN,DIC("P")=$P(^DD(721,36,0),U,2)
 . . S DIC="^ECH("_DA(1)_","_"""MOD"""_",",ECX=0
 . . F  S ECX=$O(OLDMOD(ECX)) Q:'ECX  I ECX>0 K DD,DO S X=ECX D FILE^DICN
 . I $O(OLDDXS("")) D
 . . S DIC(0)="L",DA(1)=ECFN,DIC("P")=$P(^DD(721,38,0),U,2)
 . . S DIC="^ECH("_DA(1)_","_"""DX"""_",",ECX=0
 . . F  S ECX=$O(OLDDXS(ECX)) Q:'ECX  I ECX>0 K DD,DO S X=ECX D FILE^DICN
 . K DIC,DA,DD,DO,OLDMOD,OLDDXS,ECX
 S DA=ECFN,DIK="^ECH(" D ^DIK K DA,DIK
 D TABLE("D",ECFN) ;134 Delete record from table
 Q
MSG ;Record not filed
 S ^TMP($J,"ECMSG",1)="0^Record not Filed"
 Q
CHKDT(FLG) ;Required Data Check
 N I,C
 S C=1
 I FLG=1 D  Q
 .F I="ECD","ECC","ECL","ECDT","ECP","ECDFN","ECMN","ECDUZ","ECPTSTAT" D
 ..I $G(@I)="" S ^TMP($J,"ECMSG",C)="0^Key data missing "_I,C=C+1,ECERR=1
 .I $G(ECDEL),$D(ECIEN) K ^TMP($J,"ECMSG") S ECERR=0
 ;check PCE data
 I FLG=2 D  Q
 .F I="EC4","ECDX" D  Q
 ..I $G(@I)="" S ^TMP($J,"ECMSG",C)="0^Key PCE data missing "_I,C=C+1,ECERR=1
 Q
VALDATA ;validate data
 N ECRRX
 D CHK^DIE(721,1,,"`"_ECDFN,.ECRRX) I ECRRX'=ECDFN D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Patient"
 D CHK^DIE(721,2,,ECDT,.ECRRX) I ECRRX'=ECDT D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Procedure Date"
 D CHK^DIE(721,3,,"`"_ECL,.ECRRX) I ECRRX'=ECL D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Location"
 D CHK^DIE(721,6,,"`"_ECD,.ECRRX) I ECRRX'=ECD D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid DSS Unit"
 D CHK^DIE(721,7,,"`"_ECC,.ECRRX) I ECRRX'=ECC D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Category"
 D  I ECERR Q
 .I ECP["ICPT" S ECRRX=$$CPT^ICPTCOD(+ECP,ECDT) I +ECRRX>0,$P(ECRRX,U,7) Q
 .I ECP["EC",$D(^EC(725,+ECP,0)) Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Procedure"
 D CHK^DIE(721,11,,"`"_ECMN,.ECRRX) I ECRRX'=ECMN D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Ordering Section"
 D CHK^DIE(721,20,,"`"_ECDX,.ECRRX) I ECRRX'=ECDX D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Primary Diagnosis"
 I $G(EC4)'="" D CHK^DIE(721,26,,"`"_EC4,.ECRRX) I ECRRX'=EC4 D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Associated Clinic"
 Q
 ;
CVTREAS ;119 Section added to convert procedure reason IEN in 720.4 to EC Code Screen/Procedure reason link in file 720.5.
 N SCREEN,SCREENID,I
 S SCREEN=ECL_"-"_ECD_"-"_+$G(ECC,0)_"-"_ECP ;creates event code screen
 S SCREENID=$O(^ECJ("B",SCREEN,0)) I '+SCREENID S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Event Code Screen" Q  ;event code screen doesn't exist
 F I="ECPXREAS","ECPXREA2","ECPXREA3" I $G(@I) S @I=$$GETVAL(SCREENID,@I)
 Q
GETVAL(SCREENO,REASNO) ;119 section added to get link from 720.5 or add it if necessary
 N LINK,DIC,X,Y
 S LINK=$O(^ECL("AD",SCREENO,REASNO,0))
 I $G(LINK) Q LINK  ;Entry in 720.5 exists, return IEN
 S DIC="^ECL(",DIC(0)="",X=REASNO,DIC("DR")=".02////"_SCREENO
 K DD,DO D FILE^DICN
 S LINK=$S(+Y:+Y,1:"") ;New IEN or null if not added
 Q LINK
 ;
TABLE(OPTION,RECNO) ;134 Section added to add/delete state home records from XTMP table.
 I '$$PATCH^XPDUTL("ECX*3.0*166") Q  ;Don't start table maintenance until related patch in DSS is installed.
 I $G(OPTION)=""!($G(RECNO)="") Q
 I $G(OPTION)="A" S ^XTMP("ECEFPAT",RECNO)="" ;add to table
 I $G(OPTION)="D" K ^XTMP("ECEFPAT",RECNO) ;delete from table
 S ^XTMP("ECEFPAT",0)=$$FMADD^XLFDT($$DT^XLFDT,180)_"^"_$$DT^XLFDT_"^"_"Event capture state home records"
 Q
 ;
STAT() ;139 Returns status of record
 N LED
 S LED=$$LED+.24 ;Set last extract date to midnight of that day
 I ECDT'>LED Q "LATE"
 Q ""
 ;
LED() ;139 Determine last extract date for Event Capture
 N LAST,EXTNO,EXTNOLED
 S EXTNO=$P($G(^XTMP("EC LED",0)),U,4) ;Get extract number associated with last extract date
 F  S EXTNO=$O(^ECX(727,"D","EVENT CAPTURE",EXTNO)) Q:'+EXTNO  D
 .S EXTNOLED=$$GET1^DIQ(727,EXTNO,4,"I") ;Get end date for extract
 .S LAST=$P($G(^XTMP("EC LED",0)),U,5) ;Get last extract date if stored
 .I EXTNOLED'<LAST D  ;If extract end date is later than current last date then update
 ..S ^XTMP("EC LED",0)=$$FMADD^XLFDT($$DT^XLFDT,180)_"^"_$$DT^XLFDT_"^"_"Last event capture extract date"_"^"_EXTNO_"^"_EXTNOLED
 Q +$P($G(^XTMP("EC LED",0)),U,5)  ;Return last extract date
 ;
OOSCLIN ;139 Create an OOS related clinic for a location and DSS unit when DSS unit is an OOS type
 N CLNAME,STOP,ECCLN
 S STOP=$$GET1^DIQ(40.7,+$P(^ECD(ECD,0),U,10),1) ;Get stop code for DSS unit
 S CLNAME="EC "_$$GET1^DIQ(4,ECL,99)_" OOS "_STOP ;Create clinic name as EC_STA6_OOS_Stop code number
 S EC4=+$$FIND1^DIC(44,"","X",CLNAME) I EC4 Q  ;If clinic exists, skip creation
 S ECCLN=$$LOC^SCDXUAPI(CLNAME,ECL,STOP,"EC")
 S EC4=+ECCLN ;Set EC4 (clinic) to newly created clinic
 Q
