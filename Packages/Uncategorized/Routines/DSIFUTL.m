DSIFUTL ;DSS/AMC - FEE UTILITY ROUTINE ;03/01/2009
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,8,2,23**;Jun 05, 2009;Build 8
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;   767  DBIA268-C
 ;  2051  LIST^DIC,FIND1^DIC
 ;  2171 - $$STA^XUAF4
 ;  2689  ^XTV(8992  
 ;  2834  ^TIUSRVLO 
 ;  3990  $$ICDDX^ICDCODE
 ;  5277  ^FBAAI("E"
 ;  5301  ^PRC(420)
 ; 10026  ^DIR
 ;  5107  ^FBAAC
 ; 10081  GETACT^XQALERT
 ; 2056   $$GET1^DIQ
 ; 5082   SITE^FBAACO
 ;
 Q
EN(DFN) ;CHECK WHETHER AUTHORIZATION FROM DATE OVERLAPS PREVIOUS ENTRIES
 ;COPIED FROM FBAAUTL2
 N FB0,FB1
 I $G(DFN)="" Q
 N XX,Z,FBAUT,FBOUT,FBLG S XX=1
 S ^XTMP("DSIFUTL"_$J,0)=DT_U_DT_U_"DSIFUTL utility, DSS/AMC"
 S (FBOUT,FBLG)=0 F Z=0:0 S Z=$O(^FBAAA(DFN,1,Z)) Q:Z'>0  I $D(^FBAAA(DFN,1,Z,0)),Z'=IEN S Z(0)=^FBAAA(DFN,1,Z,0),FBO=$P(Z(0),"^"),FB1=$P(Z(0),"^",2) I $P(Z(0),"^",3)=$G(FBPROG) S FBAUT($P(Z(0),"^"))=$P(Z(0),"^",2)
 I $G(FBO),($G(FB1)),($G(FBAUT(FBO))=FB1) K FBAUT(FBO)
 F Z=0:0 S Z=$O(FBAUT(Z)) Q:Z'>0!(FBOUT)  D CHKDT:FBFLAG=1,CHKBO:FBFLAG=2,ERRD:FBLG>0
 Q XX
CHKDT ;
 I FBBEGDT<Z&(FBENDDT<Z) S FBLG=0,FBOUT=1 Q
 I FBBEGDT<Z&(FBENDDT'<Z) S FBLG=2,FBOUT=1 Q
 ; CNH batches are currently out of scope, but we'll leave the lines of code in place for future use
 I $G(FBPROG)=7,FBAUT(Z)>DT S FBLG=0,FBOUT=1,FBBEGDT="" K FBAUT S XX="-1^There already is an active CNH authorization on file. Use the 'Edit CNH Authorization' option." Q
 I $G(FBPROG)=7,FBBEGDT=FBAUT(Z) Q
CHKBO ;
 I FBBEGDT'<Z&(FBBEGDT'>FBAUT(Z)) S FBLG=1,FBOUT=1 Q
 Q
ERRD ;
 S XX="-1^"_$S(FBLG=1:"FROM",1:"TO")_" DATE entered overlaps a previous Authorization!"
 Q
PRIDIG ; Used to check the Primary diagnosis for validation, **used only if patch 101 was installed previously
 ;
 W !!?3,"This will run a quick check to see if any Primary Diagnosis codes"
 W !?3,"were stored w/ external values rather than IEN's. If any are found"
 W !?3,"the before and after values will be stored in the global node:"
 W !?6,"^XTMP(""DSIFUTL"""_$J_") global nodes"
 K DIR S DIR(0)="S^R:Run Now;Q:Quit",DIR("A")="Choice" D ^DIR I $D(DIRUT) Q
 I $G(DUOUT)=1!(X="Q") Q
 W !!,"Running now, this may take a moment"
 N J,K,L,M,FBDIAG,CNT S CNT=0
 ; Loop through all payments
 F J=0:0 S J=$O(^FBAAC(J)) Q:J<1  F K=0:0 S K=$O(^FBAAC(J,1,K)) Q:K<1  F L=0:0 S L=$O(^FBAAC(J,1,K,1,L)) Q:L<1  F M=0:0 S M=$O(^FBAAC(J,1,K,1,L,1,M)) Q:M<1  D
 . S FBDIAG=$P($G(^FBAAC(J,1,K,1,L,1,M,0)),U,23) W "." Q:FBDIAG'["."   ;quit if the Primary diagnosis is not externally formatted 
 . I FBDIAG S FBRET=$$ICDDX^ICDCODE(FBDIAG) I +FBRET'=FBDIAG D  ;Changes found, resetting and storing ^XTMP values
 . . S ^XTMP("DSIFUTL"_$J,J,K,L,M,"OLD")=^FBAAC(J,1,K,1,L,1,M,0)
 . . S $P(^FBAAC(J,1,K,1,L,1,M,0),U,23)=+FBRET,^XTMP("DSIFUTL"_$J,J,K,L,M,"NEW")=^FBAAC(J,1,K,1,L,1,M,0),CNT=CNT+1
 . . Q
 I CNT>0 W !,"I found and fixed "_CNT_" entries," Q
 W !,"No problems found"
 Q
EDTCHK(AXY,IEN) ;RPC - DSIF INP 7078 EDIT CHECK
 ;Input Parameter
 ;    IEN - Internal Entry Number for 7078
 ;
 ;Return Values
 ;    -1 = Payments Exist Don't Edit
 ;    1 = No Payments Edit is Allowable
 ;    0 = Invalid IEN or NULL passed in
 ;
 I $G(IEN)<1 S AXY=0 Q
 I $G(IEN)'="",('$D(^FB7078(IEN,0))) S AXY=0 Q
 N X S X=+$G(IEN)_";FB7078("
 S AXY=$S('$$FIND1^DIC(162,,"Q",X,"AM",,"ERR"):1,1:-1)  ;DSIF*3.2*2 (Modified check to see if an payment exists)
 I AXY>0 S AXY=$S('$$FIND1^DIC(162.5,,,X,"E"):1,1:-1)  ;DSIF*3.2*2 (added check to see if an invoice exists)
 Q
GETDATA(ORY,XQAID) ; RPC - DSIF UTL GETDATA
 ; INPUT PARAMETER
 ;   XQAID - to be used in searching for the XQALERT data.
 ; RETURNS
 ;   XQADATA for an alert
 ; THIS IS A CLONE OF ORWORB^GETDATA
 N SHOWADD
 S ORY=""
 Q:$G(XQAID)=""!('$D(^XTV(8992,"AXQA",XQAID)))
 D GETACT^XQALERT(XQAID)
 S ORY=XQADATA
 I ($E(XQAID,1,3)="TIU"),(+ORY>0) D
 . S SHOWADD=1
 . S ORY=ORY_$$RESOLVE^TIUSRVLO(+ORY)
 K XQAID,XQADATA,XQAOPT,XQAROU
 Q
 ;
SELCHK(REC,DFN) ; RPC - DSIF SELCHK 
 ; Check for sensitive pt
 ; INPUT PARAMETER
 ;   DFN - PATIENT DFN
 ; RETURNS
 ;   SENSITIVE
 ;     0 - Patient record IS NOT sensitive
 ;     1 - Patient record IS sensitive
 S REC=$$GET1^DIQ(38.1,+$G(DFN),2,"I") ;DSIF*3.2*2 removed double negative
 Q
 ;
INVCHK(DSIFOUT,IEN,FILE) ; RPC:  DSIF INP INVOICE CHECK
 ;Used to check if Invoice is used in a previous 583 or 7078
 ;Inputs:  IEN = Ien of 7078 or 583,  FILE = 7078 (CH) or 583 (Unauthorized)
 ;Outputs:  1^No invoice referenced 
 ;          or -1^Invoice#1,Invoice#2
 ;
 N STRING,FBINV K DSIFOUT
 I 'IEN!('FILE) S DSIFOUT="-1^Invalid entry" Q
 I FILE'=583&(FILE'=7078) S DSIFOUT="-1^Invalid file entry" Q
 S STRING=IEN_";FB"_FILE_"(",DSIFOUT="-1" I '$D(^FBAAI("E",STRING)) S DSIFOUT="1^No invoice referenced" Q
 F FBINV=0:0 S FBINV=$O(^FBAAI("E",STRING,FBINV)) Q:'FBINV  D
 . S DSIFOUT=DSIFOUT_U_FBINV
 I '$D(DSIFOUT) S DSIFOUT(0)="1^No invoice referenced"
 Q
 ;
STATNUM(DSIFOUT) ;Check and display Station numbers   RPC: DSIF STATIONS
 ;Returns:  Station # (from files 161.4 & 4)^all station numbers the user has access to from file 420^Name of Station from IEN^IEN of Institution file
 N STATNUM,SITE,DSIFIEN K DSIFOUT
 D SITE^FBAACO S SITE=$$STA^XUAF4($P($G(FBSITE(1)),U,3)),DSIFIEN=$P($G(FBSITE(1)),U,3)
 I SITE="" S DSIFOUT="-1^No valid station numbers assigned in file 161.4" Q
 ;  Change the station number lookup to use "C" xref in file 420 - DSIF*3.2*8
 S STATNUM="" F Z=0:0 S Z=$O(^PRC(420,"C",DUZ,Z)) Q:'Z  S STATNUM=$S(STATNUM]"":STATNUM_";"_Z,1:Z)
 S DSIFOUT=SITE_U_STATNUM_U_$$GET1^DIQ(4,DSIFIEN_",",.01,,,)_U_DSIFIEN
 Q
VENCNT(FBOUT,FBV) ; RPC: DSIF VEN GET ACTIVE CONTRACTS
 ; Added in DSIF*3.2*2, modified in DSIF*3.2*23. *** Uses ; delimiter in return values
 ; Input Vendor IEN, Output = 0^Vendor has no active contracts", -1^Invalid vendor selection or contract IEN;contract number
 N SCREEN,RET,ERR,I,RET1,COUNT
 S FBOUT=$NA(^TMP("DSIFUTL",$J)),COUNT=0 K @FBOUT
 I '$D(^FBAAV(FBV)) S @FBOUT@(0)="-1^Invalid vendor selected" Q
 S I=0 F  S I=$O(^FBAA(161.43,"AV",FBV,I)) Q:'I  D
 .I $$GET1^DIQ(161.43,I_",",2,"I")="A" S COUNT=COUNT+1,@FBOUT@(COUNT)=I_";"_$$GET1^DIQ(161.43,I_",",.01,"I")
 I '$D(@FBOUT) S @FBOUT@(0)="0^Vendor has no active contracts" Q
 S @FBOUT@(0)="1^"_COUNT
 Q
 ;
GETINST(DSIFOUT,DSIFSTN) ; RPC:  DSIF FB INSTITUTION
 ; Input: Station number [FIELD 99 VALUE], output all populated fields in file #4   -- Added DSIF*3.2*2
 N SCREEN,RET,MSG K DSIFOUT,MSG
 S DSIFOUT=$NA(^TMP("DSIFUTL",$J)),DSIFIEN=0 K @DSIFOUT
 S DSIFIEN=$$FIND1^DIC(4,,,DSIFSTN,"D") I DSIFSTN?1.3NNN S DSIFIEN=DSIFSTN
 I DSIFIEN<1 S @DSIFOUT@(0)="-1^Invalid entry" Q
 S TARGET=$NA(^TMP("LIST",$J)) D GETS^DIQ(4,DSIFIEN_",","**",,TARGET,"MSG") S TARGET=$NA(^TMP("LIST",$J,4,DSIFIEN_","))
 I $D(MSG)>10 M DSIFOUT=MSG K MSG Q
 N I F I=0:0 S I=$O(@TARGET@(I)) Q:'I  I @TARGET@(I)]"" S @DSIFOUT@(I)=I_U_@TARGET@(I)
 I '$D(@DSIFOUT) S @DSIFOUT@(0)="0^entry not found" Q
 S @DSIFOUT@(0)=".001^"_DSIFIEN
 K @TARGET
 Q
