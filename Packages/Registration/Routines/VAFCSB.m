VAFCSB ;BIR/CMC-CONT ADT PROCESSOR TO RETRIGGER A08 or A04 MESSAGES WITH AL/AL (COMMIT/APPLICATION) ACKNOWLEDGEMENTS ;2/2/22  17:24
 ;;5.3;Registration;**707,756,825,876,902,926,967,1059,1071**;Aug 13, 1993;Build 4
 ;
 ;Reference to $$XAMDT^RAO7UTL1 is supported by IA #4875
 ;Reference to RESUTLS^LRPXAPI is supported by IA #4245
 ;Reference to PROF^PSO52API is supported by IA #4820
 ;
PV2() ;build pv2 segment
 N PV2,LSTA,APPT,VASD,VAIP,VARP,VAROOT
 S PV2=""
 ;get next outpatient appointment
 K ^UTILITY("VASD",$J) S VASD("F")=DT D SDA^VADPT
 S APPT=$P($G(^UTILITY("VASD",$J,1,"I")),"^")
 I APPT'="" S $P(PV2,HL("FS"),9)=$$HLDATE^HLFNC(APPT)
 ;GET LAST ADMISSION DATE
 K VAIP S VAIP("D")="LAST",VAIP("M")=0 D IN5^VADPT
 ; **825,CR_1184: for PV2-14, it will be re-set as the 15th piece
 ; in PV2 segment a few lines below
 ; I VAIP(2)="1^ADMISSION" S $P(PV2,HL("FS"),15)=$$HLDATE^HLFNC($P(VAIP(3),"^"))
 I VAIP(2)="1^ADMISSION" S $P(PV2,HL("FS"),14)=$$HLDATE^HLFNC($P(VAIP(3),"^"))
 ;get last registration
 S VAROOT="VARP"
 D REG^VADPT
 I $D(VARP(1,"I")),$G(VARP(1,"I"))>0 S $P(PV2,HL("FS"),46)=$$HLDATE^HLFNC($P(VARP(1,"I"),"^"),"DT"),$P(PV2,HL("FS"),24)="CR"
 ;**756 ^ ONLY RETURN DATE FOR LAST REGISTRATION AS HL7 STANDARD CAN ONLY HAVE DATE
 I PV2'="" S PV2="PV2"_HL("FS")_PV2
 Q PV2
 ;
PHARA() ;build obx to show active prescriptions
 N RET S RET=""
 I '$$PATCH^XPDUTL("PSS*1.0*101") Q RET
 N PHARM,DGLIST
 S PHARM="" D PROF^PSO52API(DFN,"DGLIST")
 I +$G(^TMP($J,"DGLIST",DFN,0))>0 S PHARM="OBX"_HL("FS")_HL("FS")_"CE"_HL("FS")_"ACTIVE PRESCRIPTIONS"_HL("FS")_HL("FS")_"Y"
 ;**756 CE added as the data type
 Q PHARM
 ;
SIG(DFN) ;**876 MVI_3467 (ckn) Build OBX for Self Identified Gender
 N SIG,SIGE,SIGTMP,OBX S OBX=""
 ;I '$$PATCH^XPDUTL("DG*5.3*876") Q OBX
 S DIC=2,DA=DFN,DR=".024",DIQ="SIGTMP",DIQ(0)="I,E,N" D EN^DIQ1
 I '$D(SIGTMP) K DA,DR,DIQ  Q OBX
 S SIG=$G(SIGTMP(2,DFN,DR,"I")),SIGE=$G(SIGTMP(2,DFN,DR,"E"))
 S OBX="OBX"_HL("FS")_HL("FS")_"CE"_HL("FS")_"SELF ID GENDER"_HL("FS")_HL("FS")_SIG_$E(HL("ECH"),1)_SIGE
 K DA,DR,DIC,DIQ
 Q OBX
 ;
DODF(DFN) ;**902 MVI_4898 (ckn) Build OBX for DOD fields
 N DODTMP,DODEB,DODLEB,DODSRC,DODLUPD,DODSRCI,DODSRCE,CS,DODLNAM
 N DODFNAM,DODMNAM,DODEBE,DODEBI,DODLEBE,DODLEBI,DODSRCCD
 S CS=$E(HL("ECH")),SC=$E(HL("ECH"),4)
 S DIC=2,DA=DFN,DR=".352;.353;.354;.355",DIQ="DODTMP",DIQ(0)="I,E,N" D EN^DIQ1
 S DODSRCI=$G(DODTMP(2,DFN,.353,"I")),DODSRCE=$G(DODTMP(2,DFN,.353,"E")),DODSRC=HL("Q")
 ; **926, Story #323009 (ckn): Source of Notification moved from set of codes to pointer which is pointing to new Source Of Notification file (#47.76)
 I DODSRCE'="" D
 . S DODSRCCD=$P($G(^DG(47.76,DODSRCI,0)),"^",2)
 . S DODSRC=DODSRCCD_CS_DODSRCE_CS_"L"
 I DODSRCE'="" S DODSRC=DODSRCI_CS_DODSRCE_CS_"L"
 S DODLUPD=$G(DODTMP(2,DFN,.354,"I")) S DODLUPD=$S(DODLUPD="":HL("Q"),1:$$HLDATE^HLFNC(DODLUPD))
 ;If LAST EDITED BY field(#.355) have value, use it to populate sequence 16 of OBX
 ;If LAST EDITED BY field(#.355) does not have value, use DEATH ENTERED BY field(#.352) to populate sequence 16 of OBX
 ;If both fields empty, send double quotes in sequence 16 of OBX
 S DODLEB=HL("Q") ;Default seq 16
 S DODEBE=$G(DODTMP(2,DFN,.352,"E")),DODEBI=$G(DODTMP(2,DFN,.352,"I")) ;DOD Entered by
 S DODLEBE=$G(DODTMP(2,DFN,.355,"E")),DODLEBI=$G(DODTMP(2,DFN,.355,"I")) ;DOD Last Edited By
 I DODLEBE'="" D
 .S DODLEBE=$$HLNAME^HLFNC(DODLEBE,CS),DODLNAM=$S($P(DODLEBE,CS)="":HL("Q"),1:$P(DODLEBE,CS)),DODFNAM=$S($P(DODLEBE,CS,2)="":HL("Q"),1:$P(DODLEBE,CS,2)),DODMNAM=$S($P(DODLEBE,CS,3)="":HL("Q"),1:$P(DODLEBE,CS,3))
 .S DODLEB=$S(DODLEBI="":HL("Q"),1:DODLEBI)_CS_DODLNAM_CS_DODFNAM_CS_DODMNAM_CS_CS_CS_CS_CS_"USVHA"_SC_SC_"0363"_CS_"L"_CS_CS_CS_"PN"_CS_"VA FACILITY ID"_SC_$P($$SITE^VASITE(),"^",3)_SC_"L"
 I DODLEBE="",(DODEBE'="") D
 .S DODEBE=$$HLNAME^HLFNC(DODEBE,CS),DODLNAM=$S($P(DODEBE,CS)="":HL("Q"),1:$P(DODEBE,CS)),DODFNAM=$S($P(DODEBE,CS,2)="":HL("Q"),1:$P(DODEBE,CS,2)),DODMNAM=$S($P(DODEBE,CS,3)="":HL("Q"),1:$P(DODEBE,CS,3))
 .S DODLEB=$S(DODEBI="":HL("Q"),1:DODEBI)_CS_DODLNAM_CS_DODFNAM_CS_DODMNAM_CS_CS_CS_CS_CS_"USVHA"_SC_SC_"0363"_CS_"L"_CS_CS_CS_"PN"_CS_"VA FACILITY ID"_SC_$P($$SITE^VASITE(),"^",3)_SC_"L"
 S OBX="OBX"_HL("FS")_HL("FS")_"CE"_HL("FS")_"DATE OF DEATH DATA"_HL("FS")_HL("FS")_DODSRC_HL("FS")_HL("FS")_HL("FS")_HL("FS")_HL("FS")_HL("FS")_"R"_HL("FS")_HL("FS")_HL("FS")_DODLUPD_HL("FS")_HL("FS")_$G(DODLEB)
 K DA,DR,DIC,DIQ
 Q OBX
 ;
DODD(DFN) ;**926, Story #323009 (ckn): Build OBX for DATE OF DEATH DOCUMENTS
 N OBX,DODTMP,DODDI,DODD,DODDE,DODDCD
 S CS=$E(HL("ECH"))
 S DIC=2,DA=DFN,DR=".357",DIQ="DODTMP",DIQ(0)="I,E,N" D EN^DIQ1
 S DODDI=$G(DODTMP(2,DFN,.357,"I")),DODDE=$G(DODTMP(2,DFN,.357,"E")),DODD=HL("Q")
 I DODDE'="" D
 . S DODDCD=$P($G(^DG(47.75,DODDI,0)),"^",2)
 . S DODD=DODDCD_CS_DODDE_CS_"L"
 S OBX="OBX"_HL("FS")_HL("FS")_"CE"_HL("FS")_"DATE OF DEATH DOCUMENTS"_HL("FS")_HL("FS")_DODD
 K DA,DR,DIC,DIQ
 Q OBX
 ;
DODOPT(DFN) ;**926, Story #323009 (ckn): Build OBX for DATE OF DEATH OPTION
 N OBX,DODOPT,DODOPTE,DODOPTI
 S CS=$E(HL("ECH"))
 S DIC=2,DA=DFN,DR=".358",DIQ="DODTMP",DIQ(0)="I,E,N" D EN^DIQ1
 S DODOPTE=$G(DODTMP(2,DFN,.358,"E")),DODOPTI=$G(DODTMP(2,DFN,.358,"I")),DODOPT=HL("Q")
 I DODOPTE'="" S DODOPT=DODOPTI_CS_DODOPTE_CS_"L"
 S OBX="OBX"_HL("FS")_HL("FS")_"CE"_HL("FS")_"DATE OF DEATH OPTION"_HL("FS")_HL("FS")_DODOPT
 K DA,DR,DIC,DIQ
 Q OBX
 ;
DODDISDT(DFN) ;**926, Story #323009 (ckn): Build OBX for DATE OF DEATH DISCHARGE DATE
 ;Q OBX
 ;
DODNTPRV(DFN) ;**926, Story #323009 (ckn): Build OBX for DATE OF DEATH NOTIFICATION
 N OBX,DODNP,STN
 S CS=$E(HL("ECH")),STN=$$SITE^VASITE(),DODNP=""
 ;Populate notify provider if Date of Death last updated have value
 I $$GET1^DIQ(2,DFN_",",.354,"I")'="" S DODNP=$P(STN,"^",3)_CS_$P(STN,"^",2)_CS_"L"
 S OBX="OBX"_HL("FS")_HL("FS")_"CE"_HL("FS")_"NOTIFY PROVIDER"_HL("FS")_HL("FS")_DODNP
 Q OBX
 ;
SECLOG(DFN) ;**1059, Story #783361 (ckn): Build OBX for Sensitivity information
 N OBX,SECLVL,SECLOG
 S CS=$E(HL("ECH")),OBX=""
 S DA=$O(^DGSL(38.1,"B",DFN,"")) I DA="" Q OBX
 S DIC=38.1,DR="2",DIQ="SECLOG",DIQ(0)="I,E,N" D EN^DIQ1
 S SECLVL=$G(SECLOG(38.1,DA,2,"I")) I SECLVL="" Q OBX
 S SECLVL=SECLVL_CS_$G(SECLOG(38.1,DA,2,"E"))_CS_"L"
 S OBX="OBX"_HL("FS")_HL("FS")_"CE"_HL("FS")_"SECURITY LEVEL"_HL("FS")_HL("FS")_SECLVL_HL("FS")_HL("FS")_HL("FS")_HL("FS")_HL("FS")_HL("FS")_"F"
 Q OBX
 ;
NAMEOBX(DFN) ;**876,MVI_3453 (mko): Build OBX for Patient .01 and Name Components
 N FS
 S FS=HL("FS")
 Q "OBX"_FS_FS_"CE"_FS_"NAME COMPONENTS"_FS_FS_$$NAMECOMP(DFN,$E(HL("ECH")))
 ;
NAMEERR(DFN) ;**876,MVI_3453 (mko): Build ERR for Patient .01 and Name Components
 N CS,SC
 S CS=$E(HL("ECH")),SC=$E(HL("ECH"),4)
 Q "ERR"_HL("FS")_CS_CS_CS_SC_$$NAMECOMP(DFN,SC)
 ;
NAMECOMP(DFN,DELIM) ;**876,MVI_3453 (mko): Return Patient .01 and Name Components
 N DIHELP,DIMSG,DIERR,MSG,NC,NCIEN,NCIENS,NCPTR,TARG
 S NC=$P($G(^DPT(DFN,0)),"^")
 S NCPTR=$P($G(^DPT(DFN,"NAME")),"^") Q:'NCPTR NC
 S NCIEN=$$FIND1^DIC(20,"","","`"_NCPTR,"","","MSG") Q:'NCIEN NC
 S NCIENS=NCIEN_","
 D GETS^DIQ(20,NCIENS,"1:5","","TARG","MSG") Q:$G(DIERR) NC
 S NC=NC_DELIM_TARG(20,NCIENS,1)_DELIM_TARG(20,NCIENS,2)_DELIM_TARG(20,NCIENS,3)_DELIM_TARG(20,NCIENS,5)_DELIM_TARG(20,NCIENS,4)
 Q NC
 ;
SEXOR(DFN,OBX) ;build obx for sexual orientation multiple ;**1059, VAMPI-11114 (dri)
 ;**1071 VAMPI-13755 (dri) - include status, date created, date last updated
 N IENS,OBXCNT,SEXOR,SOCODE,SOCRDT,SOEDDT,SOEXT,SOIEN,SOOBX,SOSTAT
 D GETS^DIQ(2,DFN_",",".025*","IE","SEXOR")
 I '$D(SEXOR) Q
 S OBXCNT=1,IENS="" F  S IENS=$O(SEXOR(2.025,IENS)) Q:IENS=""  D
 .S SOIEN=+$G(SEXOR(2.025,IENS,.01,"I")) I 'SOIEN Q
 .S SOCODE=$$GET1^DIQ(47.77,SOIEN_",",1)
 .S SOEXT=$G(SEXOR(2.025,IENS,.01,"E"))
 .S SOOBX=SOCODE_COMP_SOEXT_COMP_"L"
 .S SOSTAT=$G(SEXOR(2.025,IENS,.02,"I")) ;sexual orientation status
 .I SOSTAT="" S SOSTAT="A" ;default to "A"ctive if null
 .S SOCRDT=$$HLDATE^HLFNC($G(SEXOR(2.025,IENS,.03,"I"))) ;create date
 .S SOEDDT=$$HLDATE^HLFNC($G(SEXOR(2.025,IENS,.04,"I"))) ;update date
 .S OBX(OBXCNT)="OBX"_HL("FS")_HL("FS")_"CE"_HL("FS")_"Sexual Orientation"_HL("FS")_HL("FS")_SOOBX_HL("FS")_HL("FS")_HL("FS")_HL("FS")_HL("FS")_HL("FS")_SOSTAT_HL("FS")_SOEDDT_HL("FS")_HL("FS")_SOCRDT S OBXCNT=OBXCNT+1
 Q
 ;
SEXORD(DFN,OBX) ;build obx for sexual orientation description ;**1059, VAMPI-11114 (dri)
 N SEXORDES
 S SEXORDES=$$GET1^DIQ(2,DFN_",",.0251)
 I SEXORDES="" Q
 S OBX(1)="OBX"_HL("FS")_HL("FS")_"ST"_HL("FS")_"Sexual Or Description"_HL("FS")_HL("FS")_$E(HL("ECH"),1)_SEXORDES_$E(HL("ECH"),1)_"L"
 I $L(OBX(1))>245 D
 .S OBX(2)=$E(OBX(1),246,$L(OBX(1)))
 .S OBX(1)=$E(OBX(1),1,245)
 Q
 ;
PRON(DFN,OBX) ;build obx for pronoun multiple ;**1059, VAMPI-11118 (dri)
 N IENS,OBXCNT,PRON,PRONCODE,PRONIEN,PRONTYP
 D GETS^DIQ(2,DFN_",",".2406*","IE","PRON")
 I '$D(PRON) Q
 S OBXCNT=1,IENS="" F  S IENS=$O(PRON(2.2406,IENS)) Q:IENS=""  S PRONIEN=+$G(PRON(2.2406,IENS,.01,"I")) I PRONIEN D
 .S PRONCODE=$$GET1^DIQ(47.78,PRONIEN_",",1)
 .S PRONTYP=$G(PRON(2.2406,IENS,.01,"E"))
 .S OBX(OBXCNT)="OBX"_HL("FS")_HL("FS")_"CE"_HL("FS")_"Pronoun"_HL("FS")_HL("FS")_PRONCODE_$E(HL("ECH"),1)_PRONTYP_$E(HL("ECH"),1)_"L" S OBXCNT=OBXCNT+1
 Q
 ;
PROND(DFN,OBX) ;build obx for pronoun description ;**1059, VAMPI-11118 (dri)
 N PRONDES
 S PRONDES=$$GET1^DIQ(2,DFN_",",.24061)
 I PRONDES="" Q
 S OBX(1)="OBX"_HL("FS")_HL("FS")_"ST"_HL("FS")_"Pronoun Description"_HL("FS")_HL("FS")_$E(HL("ECH"),1)_PRONDES_$E(HL("ECH"),1)_"L"
 I $L(OBX(1))>245 D
 .S OBX(2)=$E(OBX(1),246,$L(OBX(1)))
 .S OBX(1)=$E(OBX(1),1,245)
 Q
 ;
LABE() ;BUILD OBX FOR LAST LAB TEST DATE
 N OBX S OBX=""
 I '$$PATCH^XPDUTL("LR*5.2*295") Q OBX
 N LAB,LAB2,EN
 S LAB="" K ^TMP("DGLAB",$J) D RESULTS^LRPXAPI("DGLAB",DFN,"C")
 S EN=$O(^TMP("DGLAB",$J,"")) I EN'="" S LAB=$P($G(^TMP("DGLAB",$J,EN)),"^")
 K ^TMP("DGLAB",$J) D RESULTS^LRPXAPI("DGLAB",DFN,"A")
 S EN=$O(^TMP("DGLAB",$J,"")) I EN'="" S LAB2=$P($G(^TMP("DGLAB",$J,EN)),"^") I LAB2>LAB S LAB=LAB2
 K ^TMP("DGLAB",$J) D RESULTS^LRPXAPI("DGLAB",DFN,"M")
 S EN=$O(^TMP("DGLAB",$J,"")) I EN'="" S LAB2=$P($G(^TMP("DGLAB",$J,EN)),"^") I LAB2>LAB S LAB=LAB2
 I LAB'="" D
 .S $P(OBX,HL("FS"),2)="TS" ;**756 added the data type
 .S $P(OBX,HL("FS"),3)="LAST LAB TEST DATE/TIME"
 .S $P(OBX,HL("FS"),11)="F"
 .S $P(OBX,HL("FS"),14)=$$HLDATE^HLFNC(LAB)
 .S OBX="OBX"_HL("FS")_OBX
 Q OBX
 ;
RADE() ;BUILD OBX FOR LAST RADIOLOGY TEST DATE
 N RET S RET=""
 I '$$PATCH^XPDUTL("RA*5.0*76") Q RET
 N RAD,RADE
 S RAD="",RADE=$$XAMDT^RAO7UTL1(DFN) I +RADE<1 Q RAD
 I +RADE>0 D
 .S $P(OBX,HL("FS"),2)="TS" ;**756 added the data type
 .S $P(RAD,HL("FS"),3)="LAST RADIOLOGY EXAM DATE/TIME"
 .S $P(RAD,HL("FS"),11)="F"
 .S $P(RAD,HL("FS"),14)=$$HLDATE^HLFNC(RADE)
 .S RAD="OBX"_HL("FS")_RAD
 Q RAD
 ;
PD1() ;BUILD PD1 segment
 ;PREFERRED FACILITY -- NOT GOING TO BE PASSED PER IMDQ 9/7/06
 N TEAM,PD1
 S PD1=""
 ;S TEAM=$$PREF^DGENPTA(DFN)
 ;I TEAM'="" S PD1="PD1"_HL("FS")_HL("FS")_HL("FS")_$$STA^XUAF4(TEAM)
 Q PD1
 ;
PV1() ;BUILD PV1 SEGMENT
 ;CURRENTLY ADMITTED?
 N PV1,VAINDT
 S PV1=""
 S VAINDT=DT
 D INP^VADPT
 I $G(VAIN(1))'="" S $P(PV1,HL("FS"),44)=$$HLDATE^HLFNC($P(VAIN(7),"^")),PV1="PV1"_HL("FS")_PV1
 K VAIN
 Q PV1
 ;
