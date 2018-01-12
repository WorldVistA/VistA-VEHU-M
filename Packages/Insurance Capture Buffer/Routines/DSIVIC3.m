DSIVIC3 ;DSS/LM - Insurance card RPC's ;05/17/2006 11:19
 ;;2.2;INSURANCE CAPTURE BUFFER;**1,2,4,11,12**;May 19, 2009;Build 13
 ;Copyright 1995-2010, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ; 5307   $$HOLD^IBCNBLL, $$SYMBOL^IBCNBLL
 ; 4419   $$INSUR^IBBAPI
 ;  701   $$LST^DGMTU
 ; 2051   LIST^DIC
 ; 2052   FIELD^DID,FILE^DID
 ; 2056   $$GET1^DIQ,GETS^DIQ
 ; 5317   $$DIV^DSICDUZ
 ; 5309   $$X12^IBCNERP2
 ; 10061  DEM^VADPT, INP^VADPT
 ; 10103  $$NOW^XLFDT, $$FMTE^XLFDT 
 Q
INSUR(DSIV,DFN,IBDT,IBSTAT,IBFLDS) ;RPC: DSIV PATIENT INSURANCE DATA
 ;Wraps $$INSUR^IBBAPI
 ; See REMOTE PROCEDURE entry for input parameter definitions
 ; Returns patient insurance data in local array
 ; 
 S DSIV(1)="-1^Patient ID Required" Q:'$G(DFN)
 S IBDT=$G(IBDT),IBSTAT=$G(IBSTAT)
 S IBFLDS=$G(IBFLDS,"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17")
 N VEJICR,Y S Y=$$INSUR^IBBAPI(DFN,IBDT,IBSTAT,.VEJICR,IBFLDS)
 I Y<0 D  Q
 .S DSIV(1)=Y,Y=$O(VEJICR("IBBAPI","INSUR","ERROR","")) Q:'Y
 .S DSIV(1)=DSIV(1)_U_VEJICR("IBBAPI","INSUR","ERROR",Y)
 .Q
 I Y=0 S DSIV(1)=Y_U_"No data found" Q
 N I S I=0,Y="VEJICR" F  S Y=$Q(@Y) Q:Y=""  D
 .S I=I+1,DSIV(I)=$QS(Y,3)_","_$QS(Y,4)_U_@Y
 .Q
 Q
 ;
LIST(RESULT,SDT,EDT,FLDS,NUMS,MORE) ; RPC: DSIV LIST ENTRIES2
 ; Return INSURANCE BUFFER file entries for date range
 ; SDT=Inclusive start date (optional)
 ; EDT=Inclusive end date (optional)
 ; FLDS=Field list (optional)
 ; NUMS=number of records to return to limit this list (optional)
 ; MORE=if there are more than NUMS records, this flag will get the rest from ^XTMP (optional)
 ; if NUMS and MORE aren't sent, then all records returned (up to 99999)
 ; the data will be followed with $END$ to denote the end of the list
 ; (so MORE is no longer needed)
 ; We only use ^XTMP if we have MORE records to send back
 N DSIVPARM,CNT,X,I,QUIT,IDT,DSIVX,DSIVI,DATA,DSIVFLDS,UDIV,UDUZ,SSN,RESTMP S CNT=0
 S SDT=$G(SDT,0)-.0001,EDT=$G(EDT,DT),FLDS=$G(FLDS,".01I;.01") S:EDT=DT EDT=EDT+.24
 S NUMS=$G(NUMS,50),MORE=+$G(MORE)
 S FLDS="60.01I;.02I;"_FLDS,DSIVFLDS=$TR(FLDS,"IE") ;FLDS='60.01;20.01;60.04;.03;.01;.02;.04;.04I;.01I' from gui
 S RESULT=$NA(^TMP("DSIVIC",$J)) K @RESULT ;9.13.05 KC now a global array returned
 S RESTMP=$NA(^XTMP("DSIVIC"_$J)) ;12.14.05 KC get batches of data
 I MORE,$D(@RESTMP) D  S:'$O(@RESTMP@(0)) @RESULT@("~")="$END$" Q
 .S X=$G(@RESTMP@(1)) I X S SDT=+X,IEN=$P(X,U,2)
 .K @RESTMP I $G(SDT),$G(IEN) D LOOP(SDT,IEN)
 .Q
 D LOOP(SDT,0)
 I '$D(@RESULT) S @RESULT@(1)="-1^No records found" Q
 I $D(@RESTMP) S @RESTMP@(0)=DT_U_$$NOW^XLFDT_U_DUZ_U_1
 E  S @RESULT@("~")="$END$"
 Q
OVFL S @RESTMP@(1)=SDT_U_DSIVI,QUIT=1 Q  ;overflow the NUMS param
LOOP(SDT,IENST) ;
 S EDT=EDT+.24,QUIT=0
 I IENST,$D(^IBA(355.33,"AEST","E",SDT,IENST)) S DSIVI=IENST D DATA
 I IENST F  S DSIVI=$O(^IBA(355.33,"AEST","E",SDT,DSIVI)) Q:'DSIVI!QUIT  D
 .I '$P($G(^IBA(355.33,DSIVI,0)),U,5) D DATA
 .Q
 F  S SDT=$O(^IBA(355.33,"AEST","E",SDT)) Q:'SDT!(SDT>EDT)!QUIT  D
 .S DSIVI="" F  S DSIVI=$O(^IBA(355.33,"AEST","E",SDT,DSIVI)) Q:'DSIVI!QUIT  D
 ..I '$P($G(^IBA(355.33,DSIVI,0)),U,5) D DATA
 .Q
 Q
DATA ;
 I CNT>NUMS D OVFL Q
 N CDT,AUD,IMAGES,DSI,SYM
 K DSIVX D GETS^DIQ(355.33,DSIVI_",",DSIVFLDS,"IE","DSIVX")
 S I=1,DATA=DSIVI F  S X=$P(FLDS,";",I) Q:X=""  D  S I=I+1
 .I X["I" S DATA=DATA_U_$G(DSIVX(355.33,DSIVI_",",+X,"I")) Q
 .S DATA=DATA_U_$G(DSIVX(355.33,DSIVI_",",+X,"E"))
 .Q
 S CNT=CNT+1,DFN=$P(DATA,U,2),SSN=$$GET1^DIQ(2,+DFN,.09,"I")
 I $G(DSIVX(355.33,DSIVI_",",.03,"I"))=6 S UDIV=$$PCG() ;2.0T8
 E  S UDUZ=$P(DATA,U,3) S:UDUZ UDIV=$P($$DIV^DSICDUZ(,UDUZ,1,1),U,2)
 D PATCH^DSICXPDU(.DSI,"IB*2.0*438") I DSI D ICB^IBCNBLA1(+DSIVI) ;update symbol DSIV*2.2*4, requires IB*2.0*438
 S SYM=$$SYM(+DSIVI)
 S DATA=DATA_U_SSN_U_$$FLGS(DFN)_U_SYM_U_$G(UDIV)
 S CDT=$P(DATA,U,12),IMAGES="",AUD=""
 I CDT,DFN S AUD=$O(^DSI(19625,"G",DFN,DSIVI,CDT,"")) I AUD D  ;DSIV*2.2*4 check DFN (bad data)
 .S IMAGES=$$GET1^DIQ(19625,AUD,2,"I") ;DSIV*2.2*1 get images scanned here vs network call
 S DATA=DATA_U_IMAGES
 K ERR D ERR(+DSIVI,1,SYM,.ERR) I $D(ERR) S DATA=DATA_U_ERR(1) K ERR ;DSIV*2.2*4 return eIV error msg
 I $L(DATA)<256 S @RESULT@(CNT)=DATA Q
 S @RESULT@(CNT)=$E(DATA,1,255)
 S CNT=CNT+1
 S @RESULT@(CNT)="$$APPEND$$"_U_$E(DATA,256,$L(DATA))
 Q
FLGS(DFN) ;Compute iIEYH flags - Private, not an RPC
 ; Adapted from routine ^IBCNBLL
 ; DFN=Patient IEN
 I $G(DFN) N VADM,VAIN,DSIVICY,X
 E  Q ""
 D DEM^VADPT,INP^VADPT S DSIVICY=""
 S DSIVICY=$S(+$$INSUR^IBBAPI(DFN,DT):"i",1:" ") ;V2.2 change ICR to 4419
 S DSIVICY=DSIVICY_$S(+$G(VAIN(1)):"I",1:" ")
 S DSIVICY=DSIVICY_$S(+$G(VADM(6)):"E",1:" "),X=$P($$LST^DGMTU(DFN),U,4)
 S DSIVICY=DSIVICY_$S(X="C":"Y",X="G":"Y",1:" ")
 S DSIVICY=DSIVICY_$S(+$$HOLD^IBCNBLL(DFN):"H",1:" ")
 Q DSIVICY
 ;
SYM(IEN)    ;Retrieve entry IIV (eIV) symbol - Private, not an RPC
 ; IEN=Insurance Buffer IEN
 Q:'$G(IEN) "" Q $$SYMBOL^IBCNBLL(IEN)
 ;
ERR(DSIVIEN,TYP,SYM,ERR) ;Retrieve more information on the eIV symbol error
 ;DSIVIEN is the buffer ien, TYP=1 return single line short err msg
 ;TYP=2 return full error entry from 365.15
 ;ERR is variable to return array error message data
 I '$G(DSIVIEN) Q
 N SYMI,MSG,DSIVM,DSIVMM,I,CNT,DSIVE,SYMN K ERR
 S SYMI=$$GET1^DIQ(355.33,DSIVIEN,.12,"I") Q:'SYMI
 ; No error if manually verified
 I $G(SYM)]"",$G(SYM)'="!" Q
 S SYMN=$$GET1^DIQ(365.15,SYMI,.01,"I")
 I TYP=1,SYMN="B8"!(SYMN="B12") S ERR(1)="An error has occured. Please see the eIV tab for details" Q
 ; invoke the function that trys to find a valid payer
 ; This call returns a customized message to display to the user
 I (SYMN'="B8")&(SYMN'="B12") S DSIVE=$$INSERROR^IBCNEUT3("B",DSIVIEN,1,.DSIVMM) Q:'DSIVE
 I $G(TYP)=1 S ERR(1)=$G(DSIVMM(1,1)) Q  ;only need short message
 ;return the full error information
 K DSIVM D GETS^DIQ(365.15,SYMI,"**","IE","DSIVM") Q:'$D(DSIVM)
 S ERR(1)=DSIVM(365.15,SYMI_",",.01,"E")
 S ERR(2)=$G(DSIVMM(1,1)),ERR(3)="",CNT=3
 F I=1:1 Q:'$D(DSIVM(365.15,SYMI_",",1,I))  S CNT=CNT+1,ERR(CNT)=DSIVM(365.15,SYMI_",",1,I)
 S CNT=CNT+1,ERR(CNT)=""
 F I=1:1 Q:'$D(DSIVM(365.15,SYMI_",",2,I))  S CNT=CNT+1,ERR(CNT)=DSIVM(365.15,SYMI_",",2,I)
 Q
PCG()    ;2.0T8 IA# 1850
 Q:'$G(DFN) "" Q $$GET1^DIQ(2,DFN,27.02)
 ;
IIV(DSIV,BUFFER) ;RPC: DSIV GET EIV REPORT (get data from file 365 using buffer ien)
 ;returns array as file#^field#^data^fieldname
 ;           or as file#^subfile entry#^field#^data^fieldname
 S DSIV=$NA(^TMP("DSIVIC3",$J)) K @DSIV
 I '$G(BUFFER) S @DSIV@(0)="-1^Invalid Buffer ien" Q
 N IEN S IEN=$O(^IBCN(365,"AF",BUFFER,""),-1) I 'IEN S @DSIV@(0)="-1^No eIV Response" Q  ;DSIV*2.2*2 reverse $O
 N DSIVD S DSIVD=$NA(^TMP("DSIVIC365",$J)) K @DSIVD ;DSIV*2.2*4T4 avoid local space limit
 N X,Y,I,CNT,FLD,DATA,STOP D GETS^DIQ(365,IEN,"**","IN",DSIVD)
 S STOP=$E(DSIVD,1,$L(DSIVD)-1)_"," ;DSIV*2.2*4T7 stop before we get into another user's TMP global
 S X=DSIVD,CNT=0 F I=1:1 S X=$Q(@X) Q:X=""  Q:X'[STOP  S Y=@X,FLD=$QS(X,5) D
 .I $QS(X,3)=365.02,FLD=.01 Q
 .I Y["DSIVD(" Q
 .S CNT=CNT+1,LABEL="",DATA=$$X12(FLD,$QS(X,3),Y,.LABEL)
 .I $QS(X,3)=365 S @DSIV@(CNT)=365_U_FLD_U_DATA_U_LABEL Q
 .S @DSIV@(CNT)=$QS(X,3)_U_+$QS(X,4)_U_FLD_U_DATA_U_LABEL
 .Q
 K ERR D ERR(BUFFER,2,"",.ERR) Q:'$D(ERR)  ;add full error description to eIV report
 S CNT=CNT+1,@DSIV@(CNT)="$$ERROR$$"
 F I=1:1 Q:'$D(ERR(I))  S CNT=CNT+1,@DSIV@(CNT)="^^^"_ERR(I)
 K @DSIVD
 Q
 ;
X12(DSIVFLD,DSIVFILE,DSIVY,LABEL) ;convert X12 elements to readable data DSIV 2.0P2
 ;flds are 365.11^365.012^365.013^365.014^365.015^365.016^, etc  DSIV*2.2*2 change to read DD"
 N DSIVX12,FILE,DSIVF,DSIVSTOP,DSIVCT,DSINDEX,DSIVT1
 D FIELD^DID(DSIVFILE,DSIVFLD,"","TYPE;SPECIFIER;POINTER;LABEL","DSIVX12")
 S LABEL=$G(DSIVX12("LABEL")) ;save for return
 ; Resolve Pointers External Format
 I $G(DSIVX12("TYPE"))="POINTER" D
 . S FILE=+$E(DSIVX12("SPECIFIER"),$F(DSIVX12("SPECIFIER"),"P"),20)
 . D FILE^DID(FILE,"","NAME","DSIVF")
 . I $E($G(DSIVF("NAME")),1,3)="X12" S DSIVY=$$X12^IBCNERP2(FILE,DSIVY)
 . E  S DSIVY=$$GET1^DIQ(FILE,DSIVY,.01)
 ; Resolve SETS
 I DSIVX12("TYPE")="SET" D  ;Q $S(DSIVY]"":DSIVY,1:DSIVY2B)
 . ;POINTER has set of codes values "Y:YES;N:NO;U:UNKNOWN;"
 . S DSIVSTOP=0,DSIVCT=$L(DSIVX12("POINTER"),";")-1
 . F DSINDEX=1:1:DSIVCT D  Q:DSIVSTOP=1
 . . S DSIVT1=$P(DSIVX12("POINTER"),";",DSINDEX)
 . . I $P(DSIVT1,":")=DSIVY S DSIVSTOP=1 S DSIVY=$P(DSIVT1,":",2)
 ; Resolve NUMERIC types
 I DSIVX12("TYPE")="NUMERIC" D
 .I DSIVX12("LABEL")="MONETARY AMOUNT" S DSIVY="$"_$FN(DSIVY,",",2)
 .I DSIVX12("LABEL")="PERCENT" S DSIVY=$S(DSIVY<1:DSIVY*100,1:DSIVY)_"%"
 ; Resolve Dates and Times
 I DSIVX12("TYPE")["DATE" S DSIVY=$$FMTE^XLFDT(DSIVY)
 Q DSIVY
PIIV(DSIV,DFN,DSIVPATP) ;DSIV GET EIV PATIENT REPORT(from file 2.333 using buffer ien) DSIV*2.2*2
 ;returns array(1)="$$PTPOL$$1"  (1=pt policy ien in this example)
 ;        array(2)="$$INS$$27^BLUE CROSS BLUE SHIELD" (policy ins co ien^name)
 ;        array(3)="$$GRP$$15^PENN WORKERS" (group ien^name)
 ;        array(4+)= 2.322^.02^Active Coverage^ELIGIBILITY/BENEFIT INFO (file#^field#^data^fieldname)
 ;                or 2.3226^1^1^555-9090^COMMUNICATION NUMBER (file#^subfile entry#^field#^data^fieldname)
 ;
 S DSIV=$NA(^TMP("DSIVIC3",$J)) K @DSIV
 N DSIVDL,DSIVD,DSIVERR,CNT,JOB S CNT=1,JOB=$J
 S DSIVD=$NA(^TMP("DSIVD",JOB)) K ^TMP("DSIVD")
 I '$G(DFN) S @DSIV@(0)="-1^Invalid Patient ien" Q
 I $G(DSIVPATP) D GETS^DIQ(2.312,DSIVPATP_","_DFN_",","**","IEN",$NA(^TMP("DSIVD",JOB)),"DSIVERR") D RPT(.DSIVD) Q
 D LIST^DIC(2.312,","_DFN_",","@;.01;","I",,,,,,,"DSIVDL","DSIVERR")
 S DSIVPATP=0 F  S DSIVPATP=$O(DSIVDL("DILIST","ID",DSIVPATP)) Q:'DSIVPATP  D
 .K @DSIVD D GETS^DIQ(2.312,DSIVPATP_","_DFN_",","**","IEN",$NA(^TMP("DSIVD",JOB)),"DSIVERR") D RPT(.DSIVD)
 .Q
 I '$D(@DSIV) S @DSIV@(0)="-1^No data"
 K @DSIVD
 Q
RPT(DSIVD) ;eIV DATA for one or more patient policies
 N INS,GRP
 S CNT=CNT+1,@DSIV@(CNT)="$$PTPOL$$"_DSIVPATP
 S INS=$G(@DSIVD@(2.312,DSIVPATP_","_DFN_",",.01,"I"))_U_$G(@DSIVD@(2.312,DSIVPATP_","_DFN_",",.01,"E"))
 S GRP=$G(@DSIVD@(2.312,DSIVPATP_","_DFN_",",.18,"I"))
 I +GRP S GRP=GRP_U_$$GET1^DIQ(355.3,GRP,2.01) ;get correct group name DSIV*2.2*2T2
 S CNT=CNT+1,@DSIV@(CNT)="$$INS$$"_INS
 S CNT=CNT+1,@DSIV@(CNT)="$$GRP$$"_GRP
 F I=2.322,2.3226 S X=$NA(@DSIVD@(I)) D
 .F  S X=$Q(@X) Q:X=""  Q:$QS(X,1)'="DSIVD"  Q:$QS(X,3)'=I  S Y=@X,FLD=$QS(X,5) D
 ..I $QS(X,6)="E" Q
 ..I FLD=.01 Q
 ..I Y["^TMP(" Q
 ..S CNT=CNT+1,LABEL="",DATA=$$X12(FLD,$QS(X,3),Y,.LABEL)
 ..I $QS(X,3)=2.322 S @DSIV@(CNT)=$QS(X,3)_U_FLD_U_DATA_U_LABEL Q
 ..N DSIVSUB
 ..S @DSIV@(CNT)=$QS(X,3)_U_+$QS(X,4)
 ..F DSIVSUB="FLD","DATA","LABEL" D
 ...I ($L(@DSIV@(CNT))+$L(@DSIVSUB))<255 S @DSIV@(CNT)=@DSIV@(CNT)_U_@DSIVSUB Q
 ...S CNT=CNT+1,@DSIV@(CNT)="$$CONT$$"_U_@DSIVSUB
 ..Q
