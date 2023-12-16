ISIJLS2 ; ISI/JHC - ISIRAD exam list functions ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**99,105,107,110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 ; Reference to SVMAG2A^MAGJLS3 in ICR #7403
 ; Reference to GETEXAM2^MAGJUTL1 in ICR #7404
 ; Reference to File #2006.63 in ICR #7408
 ; Reference to File #2006.69 in ICR #7410
 Q
 ;
ERR N ERR S ERR=$$EC^%ZOSV S ^TMP($J,"RET",0)="0^4~"_ERR
 S MAGGRY=$NA(^TMP($J,"RET"))
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
 ; entry point for Dynamic Query list compile; this is
 ;   a List Type "I" list, so is called indirect from INDXBLD^ISIJLS1,
 ;   as defined in the exams list entry for Dynamic Query, #9820
 ;
QRYCOMP(REPLY) ; Compile dynamic query lists
 N FULLSCAN,QAGE,QDATFR,QDATTO,QIMGTYP,QRIST,QSEX,QPTNAME,QSTATUS,QUERY,QNIMG,QASSN
 N QIMGLOC
 N AGE1,AGE2,COMMA,ERRMSG,DATTEST,IDX,IDXFIL,MAGRET,NOGO,NIMG1,NIMG2,NIMGSPEC
 N PTDATA,PTNAME,RADATA,RADFN,RADTI,RACNI,RISTCHK,SCAN,SESSION,SEX,STS,STATTEST
 N SCANSTRT,EXAMDAT,ABORT,RECCOUNT,RSLLIMIT,ASSNCHK,ASSNDATA
 S COMMA=",",SESSION=MAGJOB("SESSION"),ERRMSG=""
 S REPLY=""
 D QRYGET(.FULLSCAN,.QUERY)  ; get query info
 I QUERY D
 . D QRSPECS^ISIJLS2C(1,.ERRMSG)  ; validates specs & DEFINES (Initializes) SCAN VARIABLES
 . I ERRMSG]"" S REPLY="0^1~Problem with Query List compile ("_ERRMSG_")"
 . E  D
 . . D NOW^%DTC S SCANSTRT=% S ^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION)=SCANSTRT_U_FULLSCAN_U_QDATFR_U_QDATTO
 . . S ABORT=0,RECCOUNT=0,RSLLIMIT=+$P($G(^MAG(2006.69,1,"ISI")),U,3)
 . . I FULLSCAN D QRSCAN  ; run the FULL scan
 . . E  D QRSCANP  ;  scan Prior results
 . . I ABORT S ^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION,"ABORT")="   <<<<<<<<  Query aborted after scanning "_RSLLIMIT_" exams.  >>>>>>>>   "  ;
 E  S REPLY="0^1~No Query defined"
 I REPLY="" S REPLY="0^1~No results found for Query list."
 Q
 ;
QRSCAN ; scan the db--Full scan
 N DATTEST,DFNPC,DTIPC,SSTEST,SCANIDX
 S SCANIDX=1
 I $D(MAGJOB("DIVSCRN")),($G(^ISINDX(70,"SIT"))=1) S SCANIDX=2
 ;   Scan thru primary date index to process records for input date range
 I SCANIDX=1 D
 . S IDXFIL=$NA(^RADPT("AR"))  ;  radpt DATE index: NORML-DT/DFN/DTI
 . S DATTEST=2 ; subscript comma-piece for testing date range
 . S SSTEST=1  ; #subscripts holding scan variable root
 . S DFNPC=3,DTIPC=4  ; $p locs for dfn & dti
 . D QRSCAN1
 E  I SCANIDX=2 D
 . ;  radpt Site, Date index: SITE/NORML-DT/DFN/DTI
 . S DATTEST=4 ; subscript comma-piece for testing date range
 . S SSTEST=3  ; #subscripts holding scan variable root
 . S DFNPC=5,DTIPC=6  ; $p locs for dfn & dti
 . N SITE S SITE=0
 . F  S SITE=$O(MAGJOB("DIVSCRN",SITE)) Q:'SITE  S IDXFIL=$NA(^ISINDX(70,"SIT",SITE)) D QRSCAN1 Q:ABORT
 Q
 ;
QRSCAN1 ;
 N STOP
 S SCAN=$NA(@IDXFIL@(QDATFR)),STOP=0
 F  S SCAN=$Q(@SCAN) Q:SCAN=""  D  Q:STOP  Q:ABORT
 . I IDXFIL'[($P(SCAN,COMMA,1,SSTEST)_")") S STOP=1 Q  ; end of index
 . S EXAMDAT=$P(SCAN,COMMA,DATTEST) I EXAMDAT>QDATTO S STOP=1 Q  ; passed to-date
 . S RADFN=$P(SCAN,COMMA,DFNPC),RADTI=+$P(SCAN,COMMA,DTIPC),RACNI=0 D QREXAMS  ; racni=0 important for logic below
 Q
 ;
QRSCANP ; Scan thru prior result records
 S IDXFIL=$NA(^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION,"RSL")),IDX=""
 F  S IDX=$O(@IDXFIL@(IDX)) Q:IDX=""  S X=^(IDX) D
 . S RADFN=$P(X,U),RADTI=$P(X,U,2),RACNI=$P(X,U,3),EXAMDAT=9999999.9999-RADTI D QREXAMS  ; ditto value of racni
 Q
 ;
QREXAMS ; process all exams this pt/dt
 ; "high-level" filtering performed below, for efficiency of DB scan
 ; any tested condition that fails sets NOGO to 1 --> skip record
 ; otherwise call normal list processing to check any other
 ; criteria and process for output
 S NOGO=0
 S RADATA=$G(^RADPT(RADFN,"DT",RADTI,0)) I RADATA]"" D  Q:NOGO
 . I $G(MAGJOB("CONSOLIDATED")) D  Q:NOGO
 . . S X=$P(RADATA,U,3)
 . . I X]"",'$D(MAGJOB("DIVSCRN",X)) S NOGO=1 Q  ; Screen for allowed Divisions for user
 . I 'QIMGTYP  ; any img type OK
 . E  I '$D(QIMGTYP($P(RADATA,U,2))) S NOGO=1 Q
 . I 'QIMGLOC  ; any img loc OK
 . E  I '$D(QIMGLOC($P(RADATA,U,4))) S NOGO=1 Q
 ;
 S PTDATA=$G(^DPT(RADFN,0)) I PTDATA]"" D  Q:NOGO
 . I 'QPTNAME
 . E  S NOGO=1 D  Q:NOGO
 . . ; this loop checks possible multiple input names & sets nogo = zero if get a match
 . . ;  X array has name from patient file; Y array has input name query values
 . . N C,I,J,L,NAMTST,X,Y,OK S C=","
 . . S X=$P(PTDATA,U,1),X=$$NAMEFMT(X)
 . . F I=1:1:$L(X,C) S X(I)=$P(X,C,I)
 . . F J=1:1:$G(PTNAME(0)) S NAMTST=PTNAME(J) D  Q:'NOGO
 . . . K Y F I=1:1:$L(NAMTST,C) S Y(I)=$P(NAMTST,C,I)
 . . . S OK=0 F I=1:1:$L(NAMTST,C) S:(Y(I)]"") L=$L(Y(I))+1,OK=OK+(L=$F(X(I),Y(I))) S:(Y(I)="") OK=OK+1  Q:'(OK=I)
 . . . I OK=I S NOGO=0 Q  ; this one matches!
 . I 'QSEX
 . E  S NOGO='($P(PTDATA,U,2)=SEX) Q:NOGO
 . I 'QAGE
 . E  D  Q:NOGO
 . . N PTAGE
 . . S X1=EXAMDAT,X2=$P(PTDATA,U,3)
 . . I X1<X2 S X1=X2,X2=EXAMDAT
 . . S PTAGE=$$AGECALC(X2,X1)
 . . I '(AGE1'>PTAGE&(AGE2'<PTAGE)) S NOGO=1 Q
 ;
 I RACNI D QREXAMS2(RACNI) Q  ; single exam from re-scan
 S RACNI=0                    ; Full scan loops thru all exams for this pt/date
 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:'RACNI  D QREXAMS2(RACNI)
 Q
QREXAMS2(RACNI) ; process one exam
 S RADATA=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),ASSNDATA=$G(^("ISI"))
 I RADATA="" Q  ; should never occur...
 S NOGO=0
 I 'QSTATUS  ; any status OK
 E  D  Q:NOGO
 . S STS=$P(RADATA,U,3) I STS]"" D  Q:NOGO
 . . S X=$$STATUS^ISIJLS1(STS)
 . . I X=0 S NOGO=1 Q  ; ignore Cancelled
 . . I X="" S NOGO=1 Q  ; ignore indeterminate (should never happen)
 . . E  I '$D(STATTEST(X)) S NOGO=1 Q
 I 'QRIST  ; any rist OK
 E  D  Q:NOGO
 . S NOGO=1 N RISTISME,RISTDEF S RISTISME=0,RISTDEF=0
 . F I=12,15 S X=$P(RADATA,U,I) S:'RISTDEF RISTDEF=+X I X=DUZ S RISTISME=1
 . I RISTCHK=1,RISTISME S NOGO=0 Q  ; rist is me desired condition
 . I 'RISTCHK,'RISTISME,RISTDEF S NOGO=0 Q  ; rist is NOT me desired condition
 . I RISTCHK=-1,'RISTDEF S NOGO=0 Q  ; rist not entered desired condition
 I 'QASSN  ; any assigned OK
 E  D  Q:NOGO
 . S NOGO=1 N ASSNISME,ASSNDEF S ASSNISME=0,ASSNDEF=0
 . S X=$P(ASSNDATA,U,1) S ASSNDEF=+X I X=DUZ S ASSNISME=1
 . I ASSNCHK=2,ASSNDEF S NOGO=0 Q  ; assigned to Anyone desired condition
 . I ASSNCHK=1,ASSNISME S NOGO=0 Q  ; assigned to me desired condition
 . I 'ASSNCHK,'ASSNISME,ASSNDEF S NOGO=0 Q  ; assigned to NOT me desired condition
 . I ASSNCHK=-1,'ASSNDEF S NOGO=0 Q  ; assigned to not entered desired condition
 ;
 ; "high-level" filtering ends here; continue to exam list subsystem
 ;
 D GETEXAM2^MAGJUTL1(RADFN,RADTI,RACNI,0,.MAGRET)
 I MAGRET K RAST,STATCHK D SVMAG2A^MAGJLS3()  ; --> Kill cmd impt for this call
 I RSLLIMIT,FULLSCAN S RECCOUNT=RECCOUNT+1 I RECCOUNT>RSLLIMIT S ABORT=1
 Q
 ;
SETVARS(DIS,MDCVAR,LSTHDR,MDLVAR) ; selection logic & column data modify
 ; *** called from magjls2b ***
 ; define search terms stuff for use in list selection logic (magjls2b)
 N QRCOLS,SPECFLDS,QRMD
 I $D(^XTMP("MAGJ2","ISIQUERY",DUZ,MAGJOB("SESSION"),"SPECQRMD")) D  ; defined by qrspecs subrtn
 . M QRMD=^XTMP("MAGJ2","ISIQUERY",DUZ,MAGJOB("SESSION"),"SPECQRMD")
 . K DIS,MDCVAR S DIS(0)=1,I=""  ; selection logic defined in the query form inserted here
 . F  S I=$O(QRMD(I)) Q:I=""  S MDCVAR(+QRMD(I))="",DIS(1)=$G(DIS(1))_$P(QRMD(I),U,2,99)
 ; update column data if needed--appends to end of defined list
 S I="" F  S I=$O(^XTMP("MAGJ2","ISIQUERY",DUZ,MAGJOB("SESSION"),"SPECFLDS",I)) Q:I=""  S SPECFLDS(I)=""
 F I=1:1:$L(LSTHDR,U) S T=$P(LSTHDR,U,I),T=$P(T,"~",3) K SPECFLDS(T)  ; add what remains to lsthdr
 I $D(SPECFLDS) D
 . N FLD,HDR,ORD,TYP
 . S FLD=""
 . F  S FLD=$O(SPECFLDS(FLD)) Q:FLD=""  D
 . . S X=$G(^MAG(2006.63,FLD,0))
 . . S ORD=$P(X,U,6),TYP=$P(X,U,8) S:'ORD ORD=999_"."_FLD  ; assure is unique
 . . S HDR=$P(X,U,3) I HDR="" S HDR=$P(X,U,2)
 . . S QRCOLS(ORD,FLD)=HDR_U_TYP  ; sort by relative column order
 . S T="QRCOLS" F  S T=$Q(@T) Q:T=""  D
 . . S FLD=+$P(T,",",2),X=@T,HDR=$P(X,U),TYP=$P(X,U,2)
 . . S LSTHDR=LSTHDR_U_HDR_"~"_TYP_"~"_FLD,MDLVAR=MDLVAR_U_FLD
 Q
 ;
QRYGET(FULLSCAN,QUERY) ; Dynamic query find & return query specs
 ; Returns:
 ;  -- fullscan TRUE if no scan results exist in this session
 ;  -- query TRUE if query specs are defined for this session
 ;
 N SESSION S SESSION=MAGJOB("SESSION")
 S FULLSCAN=1,QUERY=0
 I $D(^XTMP("MAGJ2","ISIQUERY",DUZ)) D
 . I '$D(^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION)) K ^XTMP("MAGJ2","ISIQUERY",DUZ) Q  ; clean up old queries, if any
 . I $D(^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION,"RSL")) S FULLSCAN=0  ; recycle prior processing from this session
 . I $D(^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION,"SPECS")) S QUERY=1  ; recycle query specs from this session
 . I FULLSCAN K ^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION,"ABORT")
 Q
 ;
QRYLOG ; Log queries run;  * * * called by magjls2  * * * 
 ;  --> possible future enh--create index(es) optimized for the types
 ;      of queries that are often run, based on evaluating this log
 ;
 N SCANEND,NSCANFUL,NSCANRE,SCANTERM,NSEC,NDAYSOFF,NDAYBAKS,NDAYSTOT
 N FULL,NRESULTS,SCANREC,SESSTR,VARSTR,THISDATE
 N FULLSCAN,ISCAN,LOGFILE,QDATFR,QDATTO,SESSION,SCANSTRT,STATREC
 S NRESULTS=0,SCANREC="",SCANTERM="",SESSION=MAGJOB("SESSION"),LOGFILE=23450
 S X=^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION)
 S SCANSTRT=$P(X,U,1),FULLSCAN=$P(X,U,2),QDATFR=$P(X,U,3),QDATTO=$P(X,U,4)
 D NOW^%DTC S SCANEND=%,THISDATE=X
 D QRYLOG2(.STATREC,.ISCAN) ; get stat record iens
 S SESSTR=^ISI(LOGFILE,STATREC,0)
 S T=$S(FULLSCAN:3,1:4)
 S X=+$P(SESSTR,U,T)+1,$P(SESSTR,U,T)=X
 S ^ISI(LOGFILE,STATREC,0)=SESSTR
 S FULL=$S(FULLSCAN:"Y",1:"N")
 S NSEC=$$TDELTA(SCANSTRT,SCANEND,"SEC")
 S X="" F  S X=$O(^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION,"SPECFLDS",X)) Q:X=""  D
 . S SCANTERM=SCANTERM_$S(SCANTERM="":"",1:",")_X
 S X="" F  S X=$O(^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION,"RSLSTAT",X)) Q:X=""  S N=^(X) D
 . S T=$F("WEIC~",X) S:T $P(SCANREC,U,T+6)=N  ; counts by exam status
 . S NRESULTS=NRESULTS+N
 S NDAYSOFF=$$TDELTA(QDATTO,SCANEND,"")
 S NDAYBAKS=$$TDELTA(QDATFR,SCANEND,"")
 S NDAYSTOT=$$TDELTA(QDATFR,QDATTO,"")
 S VARSTR="SCANTERM,FULL,NSEC,NDAYSOFF,NDAYBAKS,NDAYSTOT,NRESULTS"
 F I=1:1:$L(VARSTR,",") S X=$P(VARSTR,",",I),$P(SCANREC,U,I)=@X
 S ^ISI(LOGFILE,STATREC,1,ISCAN,0)=SCANREC
 Q
 ;
QRYLOG2(STATREC,ISCAN) ; init &/or return statistics record references
 N IEN,T,X
 S IEN=$O(^ISI(LOGFILE,"B",SESSION,""))
 I 'IEN S IEN=$$NEWLOG(SESSION)
 S STATREC=IEN
 L +^ISI(LOGFILE,STATREC,1,0):10
 S X=$G(^ISI(LOGFILE,STATREC,1,0)),T=$P(X,U,3)+1,IEN=$P(X,U,4)+1,$P(X,U,3)=T,$P(X,U,4)=IEN,$P(X,U,2)="23450.04A",^(0)=X
 S ^ISI(LOGFILE,STATREC,1,IEN,0)=""
 L -^ISI(LOGFILE,STATREC,1,0)
 S ISCAN=IEN
 Q
 ;;
NEWLOG(SESSION) ; Create new entry in Stats file; only called if not yet defined
 N ZJ,RSL
 S ZJ(LOGFILE,"+1,",.01)=SESSION
 S ZJ(LOGFILE,"+1,",1)=DUZ
 S ZJ(LOGFILE,"+1,",5)=THISDATE
 D UPDATE^DIE("","ZJ","RSL")
 Q:$Q RSL(1) Q
 ;
AGECALC(DT1,DT2) ; return age given 2 dates; up to 2 yrs returns decimal rsl
 N AGE
 S AGE=$J($$FMDIFF^XLFDT(DT2,DT1)/365.25,0,3)
 I AGE<2 I AGE'>1.999 S AGE=$E(AGE,1,3)
 E  S AGE=AGE\1
 Q:$Q AGE Q
 ;
NAMEFMT(X) ; normalize name text
 N I
 S X=$$UPCASE(X)
 F I=1:1:$L(X,",") S $P(X,",",I)=$$STRIP($P(X,",",I))
 Q:$Q X Q
 ;
STRIP(X) ; remove up-carets, extraneous spaces
 N I,T
 S X=$TR(X,U," ")
 F I=$L(X):-1:0 I $E(X,I)'=" " Q
 S X=$E(X,1,I)
 F I=1:1:$L(X) I $E(X,I)'=" " Q
 S X=$E(X,I,999)
 F  S T=$F(X,"  ") Q:'T  S X=$E(X,1,T-2)_$E(X,T,999)
 ; strip spaces around hyphen:
 F  S T=$F(X," -") Q:'T  S X=$E(X,1,T-3)_$E(X,T-1,999)
 F  S T=$F(X,"- ") Q:'T  S X=$E(X,1,T-2)_$E(X,T,999)
 Q:$Q X Q
 ;
UPCASE(X) ; cx to uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
TDELTA(T1,T2,SCALE) ; calc time delta in $s(scale="SEC": seconds, 1: days)
 N RSL,NDAY,NSEC,H1,H2,TT1,TT2
 S RSL=""
 S X=T1 D H^%DTC S TT1=%T,H1=%H
 S X=T2 D H^%DTC S TT2=%T,H2=%H
 S NDAY=H2-H1
 I NDAY S TT2=TT2+(NDAY*86400)
 S NSEC=TT2-TT1
 S RSL=$S(SCALE="SEC":NSEC,1:NDAY+1)
 Q:$Q RSL Q
 ;
QRYRPC(MAGGRY,PARAMS,DATA) ; ISIJ DYNAMIC QUERY -- RPC ep
 ; 1 = Create/Edit query (populate gui form: either new in session, or edit existing query)
 ; 3 = Clear session query (populate gui form)
 ; 2 = Validate query--validate, translate & store the specs (only if OK); else error msg
 N $ETRAP,$ESTACK S $ETRAP="G ERR^ISIJLS2"
 S DIQUIET=1 D DT^DICRW
 N ERRMSG,MAGLST,REPLY,SESSION
 S ERRMSG="",SESSION=MAGJOB("SESSION")
 S MAGLST="ISIJQRY"
 K MAGGRY S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY
 I PARAMS=3 K ^XTMP("MAGJ2","ISIQUERY",DUZ)  ; Clears prior query in this session
 I  S @MAGGRY@(0)="0^0~OK"
 I PARAMS=1 D
 . D FORMOUT^ISIJLS2B(.REPLY)
 . I ($G(REPLY(0,1))["<DIALOG name=") S T=$$Q^ISINUQRY($NA(REPLY("")),-1) I @T["</DIALOG>" ; test for completed xml def
 . I  D
 . . N IOUT S IOUT=$NA(REPLY)
 . . F I=1:1 S IOUT=$Q(@IOUT) Q:IOUT=""  S @MAGGRY@(I)=@(IOUT)
 . . S @MAGGRY@(0)=I-1_U_"0~OK"
 . E  S @MAGGRY@(0)="0^3~Problem with Query dialog create function--contact support"
 I PARAMS=2 D
 . I $D(DATA)<10 S ERRMSG="Invalid Query specification."
 . E  D QRSPECS^ISIJLS2C(0,.ERRMSG,.DATA)
 . I $G(ERRMSG)]"" S @MAGGRY@(0)="0^3~"_ERRMSG
 . E  S @MAGGRY@(0)="0^0~OK"
 Q
 ;
SX70SIT(X,DA) ;Set Query Site index for RAD/NUC MED PATIENT file
 ;DA(1)=DFN, DA=EXAM DATE (inverse date)
 ;X(1)=SITE Ien
 N DATE
 S DATE=9999999.9999-DA
 S ^ISINDX(70,"SIT",X(1),DATE,DA(1),DA)=""  ; Site, Date-Ext, DFN, DTI
 Q
 ;
KX70SIT(X,DA) ;Delete Query Site index for RAD/NUC MED PATIENT file
 N DATE
 S DATE=9999999.9999-DA
 K ^ISINDX(70,"SIT",X(1),DATE,DA(1),DA)
 Q
 ;
 ;
