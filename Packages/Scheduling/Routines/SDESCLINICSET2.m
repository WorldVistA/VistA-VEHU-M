SDESCLINICSET2 ;ALB/TAW/MGD/RRM/MGD - CLINIC CREATE AND UPDATE ;July 10, 2023
 ;;5.3;Scheduling;**799,813,827,828,846**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to ^ICDEX( in ICR #5747
 ; Reference to ^VA(200 in ICR #10060
 ;
 Q
GETDEFAULT(INDEX,SDIEN) ;Get the IEN of the disposition or provider flagged as default
 N KEY,RETURN,SDIENS
 S RETURN=""
 Q:'$G(SDIEN) ""
 S KEY=$O(^SC(INDEX,SDIEN,""))
 I INDEX="ADDX",KEY D
 .S SDIENS=KEY_","_SDIEN_","
 .S RETURN=$$GET1^DIQ(44.11,SDIENS,.01,"I")
 I INDEX="ADPR",KEY D
 .S SDIENS=KEY_","_SDIEN_","
 .S RETURN=$$GET1^DIQ(44.1,SDIENS,.01,"I")
 Q RETURN
 ;
CHECKYN(VAR) ;
 I VAR'="@",VAR'="",VAR'="Y",VAR'="N" Q 0
 Q 1
 ;
LETTERIEN(LETTER,NAME) ;Look up the letter IEN
 N RETURN
 I LETTER'="@",LETTER'="" D
 .;I +LETTER,$D(^VA(407.5,LETTER,0)) Q
 .I +LETTER,$$GET1^DIQ(407.5,LETTER,.01)'="" Q
 .S LETTER=$O(^VA(407.5,"B",$E(LETTER,1,30),""))
 .I 'LETTER D ERRLOG^SDESCLINICSET(82,NAME)
 Q LETTER
 ;
SAVE(POP,SDIEN,FDA,SDCLINIC,PROVIDER,DIAGNOSIS,SPECIALINSTRUCT,PRIVLIAGEDUSER) ;
 N CLINRET,CLINMSG,MI,IEN
 I $D(FDA(44))'>9 D ERRLOG^SDESCLINICSET(47,"No changes found") Q
 D UPDATE^DIE("","FDA","CLINRET","CLINMSG")
 I $D(CLINMSG) D  Q
 . F MI=1:1:$G(CLINMSG("DIERR")) D ERRLOG^SDESCLINICSET(48,$G(CLINMSG("DIERR",MI,"TEXT",1)))
 ;
 S IEN=$S(+SDIEN:+SDIEN,1:CLINRET(1))
 ; Add clinic HASH info
 D ADDHASH2CLIN^SDESRTVCLN2(IEN)
 ; Add entry to SDEC RESOURCE (#409.831) file VSE-2769
 D SDRES(IEN)
 ;
 I $D(PROVIDER) D PROVIDER
 I $D(DIAGNOSIS) D DIAGNOSIS
 I $D(SPECIALINSTRUCT) D INSTRUCTION
 I $D(PRIVLIAGEDUSER) D PRIVUSERS(IEN,.PRIVLIAGEDUSER)
 ;
 I +$G(CLINRET(1)) S SDCLINIC("ClinicCreate","IEN")=IEN
 E  S SDCLINIC("ClinicUpdate","IEN")=IEN
 Q
 ;
PROVIDER ;Upodate the Provider multiple in field 44.1
 N KEY,ACTION,SDFDA,PROVIEN,PROV44IEN
 S KEY=""
 F  S KEY=$O(PROVIDER(KEY)) Q:KEY=""  D
 .S PROVIEN=""
 .F  S PROVIEN=$O(PROVIDER(KEY,PROVIEN)) Q:PROVIEN=""  D
 ..S ACTION=PROVIDER(KEY,PROVIEN)
 ..; Is provider already linked to clinic?
 ..S PROV44IEN=$O(^SC(IEN,"PR","B",PROVIEN,""))
 ..I PROV44IEN="" S PROV44IEN="+1"  ;New provider
 ..I ACTION="@",PROV44IEN="+1" Q  ;Can't delete if not linked to clinic
 ..I ACTION="@" S SDFDA(44.1,PROV44IEN_","_IEN_",",.01)="@"
 ..I PROV44IEN="+1" S SDFDA(44.1,PROV44IEN_","_IEN_",",.01)=PROVIEN
 ..I ACTION'="@" S SDFDA(44.1,PROV44IEN_","_IEN_",",.02)=$S(ACTION="D":1,1:0)
 ..D UPDATE^DIE("","SDFDA") K SDFDA
 Q
 ;
DIAGNOSIS ;Diagnosis multiple in field 44.11
 N SDFDA,KEY,ACTION,DIAGIEN,DIAG44IEN
 ;SD*828:remove any existing diagnosis tied to this clinic before adding
 ;the diagnosis list(s) to be exactly what was passed in as input from the RPC
 D DELDIAGNOSIS^SDESINPUTVALUTL($G(SDIEN))
 S KEY=""
 F  S KEY=$O(DIAGNOSIS(KEY)) Q:KEY=""  D
 .S DIAGIEN=""
 .F  S DIAGIEN=$O(DIAGNOSIS(KEY,DIAGIEN)) Q:DIAGIEN=""  D
 ..S ACTION=DIAGNOSIS(KEY,DIAGIEN)
 ..; Is diag already linked to clinic?
 ..S DIAG44IEN=$O(^SC(IEN,"DX","B",DIAGIEN,""))
 ..I DIAG44IEN="" S DIAG44IEN="+1"  ;New diag
 ..I ACTION="@",DIAG44IEN="+1" Q  ;Can't delete if not linked to clinic
 ..I ACTION="@" S SDFDA(44.11,DIAG44IEN_","_IEN_",",.01)="@"
 ..I DIAG44IEN="+1" S SDFDA(44.11,DIAG44IEN_","_IEN_",",.01)=DIAGIEN
 ..I ACTION'="@" S SDFDA(44.11,DIAG44IEN_","_IEN_",",.02)=$S(ACTION="D":1,1:0)
 ..D UPDATE^DIE("","SDFDA") K SDFDA
 Q
 ;
INSTRUCTION  ;Special instructions multiple in field 44.03
 N SDFDA,KEY,DATA,SIIEN
 S KEY=""
 F  S KEY=$O(SPECIALINSTRUCT(KEY)) Q:KEY=""  D
 .S INSTRUCTION=""
 .F  S INSTRUCTION=$O(SPECIALINSTRUCT(KEY,INSTRUCTION)) Q:INSTRUCTION=""  D
 ..S ACTION=SPECIALINSTRUCT(KEY,INSTRUCTION),SIIEN=""
 ..I INSTRUCTION?1.N S SIIEN=INSTRUCTION
 ..E  S SIIEN=0 F  S SIIEN=$O(^SC(IEN,"SI",SIIEN)) Q:SIIEN=""  Q:INSTRUCTION=$G(^SC(IEN,"SI",+SIIEN,0))
 ..I SIIEN="" S SIIEN="+1"
 ..I ACTION="@",SIIEN="+1" Q  ;Can't delete iF not linked to Clinic
 ..S SDFDA(44.03,SIIEN_","_IEN_",",.01)=$S(ACTION="@":"@",1:INSTRUCTION)
 ..D UPDATE^DIE("","SDFDA") K SDFDA
 Q
 ;
PRIVUSERS(SDIEN,PRIVLIAGEDUSER) ;Privileged user multiple 44.04
 N KEY,PRIVUSER,ELGRETURN,ADDFLAG
 S KEY="",ELGRETURN=""
 F  S KEY=$O(PRIVLIAGEDUSER(KEY)) Q:KEY=""  D
 .S PRIVUSER=""
 .F  S PRIVUSER=$O(PRIVLIAGEDUSER(KEY,PRIVUSER)) Q:PRIVUSER=""  D
 ..S ADDFLAG=$S(+KEY=1:0,1:1)
 ..D UPDPRIV^SDESLOC(ELGRETURN,ADDFLAG,SDIEN,PRIVUSER)
 Q
 ;
VALIDATEPROV(SDPROVIDER,PROVIDER,IEN) ;
 N DEFAULT,DEFAULTCNT,DEFAULTCNT2,DEFAULTREMOVE,DEFAULTNEW,I,ACTION,PROV,PROVDATA,KEY
 S (DEFAULTCNT,DEFAULTCNT2,DEFAULTREMOVE,DEFAULTNEW)=""
 S DEFAULT=$$GETDEFAULT("ADPR",IEN)  ;Get current diag default for this clinic
 S I="" F I=1:1:$L(SDPROVIDER,";") D
 .S PROVDATA=$P(SDPROVIDER,";",I)
 .Q:$P(PROVDATA,"|")=""!(PROVDATA="@")
 .S ACTION=$P(PROVDATA,"|",2)
 .I ACTION'="",ACTION'="@",ACTION'="D",ACTION'="@D" D ERRLOG^SDESCLINICSET(52,"Provider special action code is invalid") Q
 .S PROV=$P(PROVDATA,"|")
 .;
 .S KEY="3-ADD PROVIDER"  ;default
 .I ACTION="@D" S KEY="2-REMOVE DEFAULT"  ;takes priority over add provider
 .I ACTION="@" S KEY="1-REMOVE PROVIDER"  ;takes priority over remove default
 .I +PROV,$D(^VA(200,PROV,0)) D SETPROV Q
 .S PROV=$O(^VA(200,"B",$E(PROV,1,30),""),-1)
 .I PROV="" D ERRLOG^SDESCLINICSET(54) Q
 .D SETPROV
 .; Only 1 provider allowed to be flagged as default / default removal
 I DEFAULTCNT>1 D ERRLOG^SDESCLINICSET(52,"Only 1 provider can be set as default") Q
 I DEFAULTCNT2>1 D ERRLOG^SDESCLINICSET(52,"Only 1 default provider removal is allowed") Q
 ;If adding a default, make sure the current default is being removed
 I DEFAULTNEW,DEFAULT,DEFAULT'=DEFAULTNEW D
 .; If current default is not identified to have its default flag removed then send error
 .I DEFAULT'=DEFAULTREMOVE D ERRLOG^SDESCLINICSET(120)
 Q
SETPROV ;
 S PROVIDER(KEY,PROV)=ACTION
 I ACTION="D" S DEFAULTCNT=DEFAULTCNT+1,DEFAULTNEW=PROV
 I ACTION="@D" S DEFAULTCNT2=DEFAULTCNT2+1,DEFAULTREMOVE=PROV
 Q
 ;
VALIDATEDIAG(SDDIAG,DIAGNOSIS,IEN) ;
 N DEFAULT,DEFAULTCNT,DEFAULTCNT2,DEFAULTREMOVE,DEFAULTNEW,I,ACTION,DIAG,DIAGDATA,KEY
 S (DEFAULTCNT,DEFAULTCNT2,DEFAULTREMOVE,DEFAULTNEW)=""
 S DEFAULT=$$GETDEFAULT("ADDX",IEN)  ;Get current Diagnosis default for this clinic
 S I="" F I=1:1:$L(SDDIAG,";") D
 .S DIAGDATA=$P(SDDIAG,";",I)
 .Q:$P(DIAGDATA,"|")=""!(DIAGDATA="@")
 .S ACTION=$P(DIAGDATA,"|",2)
 .I ACTION'="",ACTION'="@",ACTION'="D",ACTION'="@D" D ERRLOG^SDESCLINICSET(52,"Diagnosis special action code is invalid") Q
 .S DIAG=$P(DIAGDATA,"|")
 .;
 .S KEY="3-ADD DIAGNOSIS"  ;default
 .I ACTION="@D" S KEY="2-REMOVE DEFAULT"  ;takes priority over add diagnosis
 .I ACTION="@" S KEY="1-REMOVE DIAGNOSIS"  ;Takes priority over remove default
 .;I +DIAG,$D(^ICD9(DIAG,0)) D SETDIAG Q
 .I +DIAG,$$GET1^DIQ(80,DIAG,.01)'="" D  Q
 ..I $$GETDIAGSTAT^SDESINPUTVALUTL(DIAG)<1 D ERRLOG^SDESCLINICSET(363) Q  ;SD*828-Inactive diagnosis not allowed
 ..D SETDIAG
 .;S DIAG=$O(^ICD9("BA",$E(DIAG_" ",1,30),""),-1)
 .S DIAG=+$$CODEN^ICDEX(DIAG,80)
 .I DIAG=-1 D ERRLOG^SDESCLINICSET(85) Q
 .I $$GETDIAGSTAT^SDESINPUTVALUTL(DIAG)<1 D ERRLOG^SDESCLINICSET(363) Q
 .D SETDIAG
 ; Only 1 diag allowed to be flagged as default / default removal
 I DEFAULTCNT>1 D ERRLOG^SDESCLINICSET(52,"Only 1 diagnosis can be set as default") Q
 I DEFAULTCNT2>1 D ERRLOG^SDESCLINICSET(52,"Only 1 default diagnosis removal is allowed") Q
 ;If adding a default, make sure the current default is being removed
 I DEFAULTNEW,DEFAULT,DEFAULT'=DEFAULTNEW D
 .; If current default is not identified to have its default flag removed then send error
 .I DEFAULT'=DEFAULTREMOVE D ERRLOG^SDESCLINICSET(121)
 Q
SETDIAG ;
 S DIAGNOSIS(KEY,DIAG)=ACTION
 I ACTION="D" S DEFAULTCNT=DEFAULTCNT+1,DEFAULTNEW=DIAG
 I ACTION="@D" S DEFAULTCNT2=DEFAULTCNT2+1,DEFAULTREMOVE=DIAG
 Q
 ;
VALIDATEPPRIVUSR(SDNOACCESS,PRIVLIAGEDUSER) ;
 N I,PRIVUSER,ACTION,KEY
 I $E(SDNOACCESS)="@" S SDNOACCESS="@"
 I SDNOACCESS'="@",$E(SDNOACCESS)'="Y" S SDNOACCESS=""  ;Default
 I $E(SDNOACCESS)="Y" D
 .F I=2:1:$L(SDNOACCESS,";") D
 ..S PRIVUSER=$P(SDNOACCESS,";",I)
 ..S ACTION=$P(PRIVUSER,"|",2)
 ..S PRIVUSER=$P(PRIVUSER,"|")
 ..Q:PRIVUSER=""
 ..I ACTION'="@" S ACTION=""
 ..S KEY="1-REMOVE USER"
 ..S:ACTION="" KEY="2-ADD USER"
 ..I +PRIVUSER,$D(^VA(200,PRIVUSER,0)) S PRIVLIAGEDUSER(KEY,PRIVUSER)=ACTION Q
 ..S PRIVUSER=$O(^VA(200,"B",$E(PRIVUSER,1,30),""),-1)
 ..I PRIVUSER="" D ERRLOG^SDESCLINICSET(86) Q
 ..S PRIVLIAGEDUSER(KEY,PRIVUSER)=ACTION
 .S SDNOACCESS="Y"
 Q
 ;
VALIDATESI(SDSPECINSTRU,SPECIALINSTRUCT) ;
 N I,INSTRUCTION,ACTION,KEY,MAXCHAR
 S MAXCHAR=80
 S I="" F I=1:1:$L(SDSPECINSTRU,";") D
 .S INSTRUCTION=$P(SDSPECINSTRU,";",I)
 .Q:$P(INSTRUCTION,"|")=""!(INSTRUCTION="@")
 .S ACTION=$P(INSTRUCTION,"|",2)
 .I ACTION'="",ACTION'="@" D ERRLOG^SDESCLINICSET(52,"Instructions special action code is invalid") Q
 .S INSTRUCTION=$P(INSTRUCTION,"|")
 .I $L(INSTRUCTION)>MAXCHAR D ERRLOG^SDESCLINICSET(52,"Instructions can not exceed "_MAXCHAR_" chars") Q
 .S KEY="2-ADD INSTRUCTION"
 .I ACTION="@" S KEY="1-REMOVE INSTRUCTION"
 .S SPECIALINSTRUCT(KEY,INSTRUCTION)=ACTION
 S SDSPECINSTRU=$E(SDSPECINSTRU) ;Get the Y/N value
 Q
 ;
YNTOBOOL(VAR) ;convert a Y/N input param to 1 or 0
 Q $S(VAR="Y":1,VAR="N":0,1:VAR)
 ;
SDRES(SDCL) ;add clinic resource
 N ABBR,SDDATA,SDDI,SDFDA,SDFOUND,SDI,SDNOD,SDRT,SDFIELDS
 S SDFOUND=0
 S SDI="" F  S SDI=$O(^SDEC(409.831,"ALOC",SDCL,SDI)) Q:SDI=""  D  Q:SDFOUND=1
 .S SDNOD=$G(^SDEC(409.831,SDI,0))
 .S SDRT=$P(SDNOD,U,11)
 .I $P(SDRT,";",2)="SC(",$P(SDRT,";",1)=SDCL S SDFOUND=1
 S SDI=$S(SDFOUND=1:SDI,1:"+1")
 S SDFIELDS=".01;1;1917"   ;alb/sat 658 - add field 1
 D GETS^DIQ(44,SDCL_",",SDFIELDS,"IE","SDDATA")
 S SDFDA(409.831,SDI_",",.01)=SDDATA(44,SDCL_",",.01,"E")
 S SDDI=SDDATA(44,SDCL_",",1917,"E") S SDFDA(409.831,SDI_",",.03)=$E(SDDI,1,2)
 S ABBR=SDDATA(44,SDCL_",",1,"E") S:ABBR'="" SDFDA(409.831,SDI_",",.011)=ABBR   ;alb/sat 658 - add abbreviation
 S SDFDA(409.831,SDI_",",.04)=SDCL
 S SDFDA(409.831,SDI_",",.012)=SDCL_";SC("
 S SDFDA(409.831,SDI_",",.015)=$E($$NOW^XLFDT,1,12)
 S SDFDA(409.831,SDI_",",.016)=DUZ
 D UPDATE^DIE("","SDFDA")
 Q
