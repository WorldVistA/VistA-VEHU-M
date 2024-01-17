PSOERUT ;ALB/MFR - eRx Utilities; 06/25/2022 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**692,700**;DEC 1997;Build 261
 ;
XML2GBL(XML,OUTARR) ;Transfers XML incoming data into a TMP Gobal
 ; Input: XML   - XML Message to be transferred to a Temp Global or Local Array
 ;        OUTARR - Output Array (Temp Global or Local Array, e.g. $NA(^TMP($J,"PSOERUT")), "XMLMSG", "MSG(""ERX"")", etc.
 ;Output: Parsed XML data in the Temp Global or Local Array
 ;
 ; Protecting from saving non-TEMP globals
 I $G(OUTARR)["^",$E(OUTARR,1,5)'="^TMP(",$E(OUTARR,1,6)'="^XTMP(" Q
 ;
 K @OUTARR
 N STATUS,READER,ARRDPTH,PRVDPTH,SEQ
 S PRVDPTH=0,ARRDPTH=$S(OUTARR[",":$L(OUTARR,","),OUTARR[")":1,1:0)
 S STATUS=##class(%XML.TextReader).ParseStream(XML,.READER)
 I $$STATCHK^XOBWLIB(STATUS,.XOBERR,1) D
 . F  Q:'READER.Read()!READER.EOF  D
 . . I (READER.Depth'<PRVDPTH),READER.LocalName'="" D
 . . . S SEQ=+$O(@$NA(@OUTARR@(READER.LocalName,999999)),-1)+1
 . . . S OUTARR=$NA(@OUTARR@(READER.LocalName,SEQ))
 . . E  S:READER.Depth<PRVDPTH OUTARR=$NA(@OUTARR,ARRDPTH+(READER.Depth*2))
 . . I (READER.Value'="") D
 . . . S @(OUTARR)=READER.Value
 . . S PRVDPTH=READER.Depth
 Q
 ;
PATNAME(ERXIEN) ; Returns the eRx Patient Name for a specific eRx Record
 ; Input: ERXIEN - eRx IEN - Pointer to #52.49
 ;Output: PATNAME - eRx Patient Name
 N PATIEN,MTYPE,PATNAME,NEWERX
 S PATIEN=+$$GET1^DIQ(52.49,ERXIEN,.04)
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 S PATNAME=$$GET1^DIQ(52.46,PATIEN,.01,"E") I MTYPE="IE"!(MTYPE="OE") S PATNAME=$$GET1^DIQ(52.49,ERXIEN,.08,"E")
 I PATNAME="" D
 . S NEWERX=$$RESOLV^PSOERXU2(ERXIEN)
 . I NEWERX S PATNAME=$$GET1^DIQ(52.49,ERXIEN,.04,"E")
 . I PATNAME="" S PATNAME="N/A"
 Q PATNAME
 ;
EPATFLST(MAXSIZE) ; Returns the eRx Patient Filter as a String List
 ;Input: MAXSIZE - Maximum Size for the String
 N PAT,PATFLST,TMP,PATNAM
 I '$D(PATFLTR) Q ""
 S PATFLST=""
 S PAT=0 F  S PAT=$O(PATFLTR(PAT)) Q:'PAT  D
 . S PATNAM=$$GET1^DIQ(52.46,PAT,.01) I PATNAM="" Q
 . S:'$D(TMP(PATNAM)) PATFLST=PATFLST_"|"_PATNAM
 . S TMP(PATNAM)=""
 S $E(PATFLST,1)=""
 I $L(PATFLST)>MAXSIZE S PATFLST=$E(PATFLST,1,MAXSIZE-3)_"..."
 Q PATFLST
 ;
VPATFLST(MAXSIZE) ; Returns the VistA Patient Filter as a String List
 ;Input: MAXSIZE - Maximum Size for the String
 N VPAT,VPATFLST,TMP,PATNAM
 I '$D(VPATFLTR) Q ""
 S VPATFLST=""
 S VPAT=0 F  S VPAT=$O(VPATFLTR(VPAT)) Q:'VPAT  D
 . S PATNAM=$$GET1^DIQ(2,VPAT,.01) I PATNAM="" Q
 . S:'$D(TMP(PATNAM)) VPATFLST=VPATFLST_"|"_PATNAM
 . S TMP(PATNAM)=""
 S $E(VPATFLST,1)=""
 I $L(VPATFLST)>MAXSIZE S VPATFLST=$E(VPATFLST,1,MAXSIZE-3)_"..."
 Q VPATFLST
 ;
VPRVFLST(MAXSIZE) ; Returns the VistA Provider Filter as a String List
 ;Input: MAXSIZE - Maximum Size for the String
 N VPRV,VPRVFLST,TMP,PRVNAM
 I '$D(VPRVFLTR) Q ""
 S VPRVFLST=""
 S VPRV=0 F  S VPRV=$O(VPRVFLTR(VPRV)) Q:'VPRV  D
 . S PRVNAM=$$GET1^DIQ(200,VPRV,.01) I PRVNAM="" Q
 . S:'$D(TMP(PRVNAM)) VPRVFLST=VPRVFLST_"|"_PRVNAM
 . S TMP(PRVNAM)=""
 S $E(VPRVFLST,1)=""
 I $L(VPRVFLST)>MAXSIZE S VPRVFLST=$E(VPRVFLST,1,MAXSIZE-3)_"..."
 Q VPRVFLST
 ;
EPRVFLST(MAXSIZE) ; Returns the eRx Provider Filter as a String List
 ;Input: MAXSIZE - Maximum Size for the String
 N PRV,PRVFLST,TMP,PRVNAM
 I '$D(PRVFLTR) Q ""
 S PRVFLST=""
 S PRV=0 F  S PRV=$O(PRVFLTR(PRV)) Q:'PRV  D
 . S PRVNAM=$$GET1^DIQ(52.48,PRV,.01) I PRVNAM="" Q
 . S:'$D(TMP(PRVNAM)) PRVFLST=PRVFLST_"|"_$$GET1^DIQ(52.48,PRV,.01)
 . S TMP(PRVNAM)=""
 S $E(PRVFLST,1)=""
 I $L(PRVFLST)>MAXSIZE S PRVFLST=$E(PRVFLST,1,MAXSIZE-3)_"..."
 Q PRVFLST
 ;
STATEABB(FILE,IEN) ; Returns the Patient or Provider State Abbreviation (eRx and VistA)
 ; Input: FILE - VistA File # (Can be 2, 200, 52.46 or 52.48)
 ;        IEN  - Internal Entry #
 ;Output: Abbreviated State (e.g., "TX", "AZ", "NY", etc...)
 N STATEIEN,FIELD
 S FIELD=$S(FILE=2:.115,FILE=52.46:3.4,FILE=200:.115,FILE=52.48:4.4,1:0) I 'FIELD!'$G(IEN) Q ""
 S STATEIEN=$$GET1^DIQ(FILE,IEN,FIELD,"I") I 'STATEIEN Q ""
 Q $$GET1^DIQ(5,STATEIEN,1)
 ;
LASTREDT(XREF,IEN) ; Returns the Last eRx Received Date for a VistA Patient OR Provider
 ;Input: XREF - "AVPAT": VistA Patient | "AVPRV": VistA Provider
 ;       IEN  - Pointer to either VistA Patient (#2) or VistA Provider (#200) 
 N LASTREDT,EIEN
 S LASTREDT=""
 S EIEN=0 F  S EIEN=$O(^PS(52.49,XREF,+$G(IEN),EIEN)) Q:'EIEN  D
 . I $O(^PS(52.49,XREF,+$G(IEN),EIEN,9999999),-1)>LASTREDT D
 . . S LASTREDT=$O(^PS(52.49,XREF,+$G(IEN),EIEN,9999999),-1)\1
 Q LASTREDT
 ;
SSN(SSN) ; Returns the formatted SSN (999-99-9999)
 ; Input: SSN - Unformatted SSN (999999999)
 ;Output: Formatted SSN (999-99-9999)
 S SSN=$$NUMERIC^PSOASAP0(SSN)
 I $G(SSN)=""!(SSN'?.N)!($L(SSN)'=9) Q ""
 Q $E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 ;
ACTIONSTS(STS) ; Returns whether the eRx status is Actionable or no
 ; Input: STS - eRx Status. It can be external (e.g.,"N","RXF","RRN", etc...) or internal value (pointer to #52.45)
 ;Output: 1 - Actionable Status | 0 - Non-actionable status
 ;
 I $G(STS) S STS=$$GET1^DIQ(52.45,STS,.01)
 I $G(STS)="" Q 0
 I ",N,H,I,W,CAH,CAO,CAP,CAR,CAX,CAF,RXN,RXD,RXR,RXI,RXW,RXF,RXE,RRE,CXN,CXI,CXD,CXW,CXV,CXY,CXE,CRE,"[(","_STS_",") Q 1
 Q 0
 ;
C2S(STR) ; Replaces commas with spaces (for auto-wrap to work) - Arbitrarily using '@' (not likely to be on the string)
 N C2S
 S C2S=$TR(STR," ","@")
 S C2S=$TR(C2S,","," ")
 Q C2S
 ;
S2C(STR) ; Replaces spaces with commas (for auto-wrap to work)
 N S2C
 S S2C=$TR(STR," ",",")
 S S2C=$TR(S2C,"@"," ")
 I $E(S2C,$L(S2C))="," S $E(S2C,$L(S2C))=""
 Q S2C
 ;
SORT(STR) ; Sorts a comma (,) separated list alphabetically
 N I,SARR,SSTR,WORD
 F I=1:1:$L(STR,",") I $TR($P(STR,",",I)," ")'="" S SARR($P(STR,",",I))=""
 S (SSTR,WORD)="" F  S WORD=$O(SARR(WORD)) Q:WORD=""  S SSTR=SSTR_","_WORD
 S $E(SSTR)=""
 Q SSTR
 ;
WRAP(STRING,LENGTH,WRPSTR) ; Formats a String into an Array
 ;  Input: STRING - String to be formatted/wrapped in multiple lines
 ;         LENGHT - Text line length
 ;Output: .WRPSTR - String wrapped (Passed in by Reference)
 ;
 N X,I,DIWL,DIWR,DIWF,TOOLONG K WRPSTR
 S X=STRING K ^UTILITY($J,"W") S DIWL=1,DIWR=LENGTH,DIWF="|" D ^DIWP
 S TOOLONG=0 F I=1:1 Q:'$D(^UTILITY($J,"W",1,I))  I $L($$TRIM^XLFSTR(^UTILITY($J,"W",1,I,0)))>LENGTH S TOOLONG=1 Q
 I 'TOOLONG D
 . F I=1:1 Q:'$D(^UTILITY($J,"W",1,I))  S WRPSTR(I,0)=$$TRIM^XLFSTR(^UTILITY($J,"W",1,I,0))
 E  D
 . S STRING=$$TRIM^XLFSTR(STRING)
 . F I=1:1  Q:STRING=""  D
 . . S WRPSTR(I,0)=$E(STRING,1,LENGTH),STRING=$E(STRING,LENGTH+1,9999)
 I $G(WRPSTR(1,0))=" ",'$O(WRPSTR(1)) K WRPSTR
 Q
 ;
SADRGVRX(ERXIEN,RXIEN) ; Sets the "ADRGVRX" cross-reference on the ERX HOLDING QUEUE file (#52.49),
 ;                       PHARMACY PRESCRIPTION NUMBER field (#.13)
 ; Input: ERXIEN - Pointer to the ERX HOLDING QUEUE file (#52.49)
 ;        RXIEN  - Pointer to the PRESCRIPTION file (#52)
 I '$D(^PS(52.49,+$G(ERXIEN),0))!'$D(^PSRX(+$G(RXIEN),0)) Q
 N PSOHASH
 I $$GET1^DIQ(52.49,ERXIEN,.08,"I")'="N" Q
 I $$GET1^DIQ(52.49,ERXIEN,1)'="PR" Q
 S PSOHASH=$$DRUGHASH(ERXIEN) I 'PSOHASH Q
 S ^PS(52.49,"ADRGVRX",PSOHASH,RXIEN,ERXIEN)=""
 Q
 ;
KADRGVRX(ERXIEN,RXIEN) ; Kills the "ADRGVRX" cross-reference on the ERX HOLDING QUEUE file (#52.49),
 ;                       PHARMACY PRESCRIPTION NUMBER field (#.13)
 ; Input: ERXIEN - Pointer to the ERX HOLDING QUEUE file (#52.49)
 ;        RXIEN  - Pointer to the PRESCRIPTION file (#52)
 I '$D(^PS(52.49,+$G(ERXIEN),0))!'$D(^PSRX(+$G(RXIEN),0)) Q
 N PSOHASH
 S PSOHASH=$$DRUGHASH^PSOERUT(ERXIEN) I 'PSOHASH Q
 K ^PS(52.49,"ADRGVRX",PSOHASH,RXIEN,ERXIEN)
 Q
 ;
DRUGHASH(ERXIEN) ; Return the Drug Information corresponding Hash Value
 ; Input: ERXIEN   - Pointer to the eRx being worked on (Pointer to #52.49)
 ;Output: DRUGHASH - Hash value calculated based on the Drug information for the eRx passed in
 ;
 ;NOTICE: Any change that alters the hash value will require the ADRGVRX cross-reference to be rebuild
 ;
 N DRUGHASH,MTYPE,RSPTYPE,DRUG,NDCCODE,QTY,SUBS,DAYS,REFS,X,I,L
 S DRUGHASH=0 I '$G(ERXIEN) Q 0
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 S RSPTYPE=$$GET1^DIQ(52.49,ERXIEN,52.1,"I")
 S DRUG=$$GET1^DIQ(52.49,ERXIEN,3.1) I DRUG="" Q 0
 S NDCCODE=$TR($TR($$GET1^DIQ(52.49,ERXIEN,4.1)," "),"-")
 I NDCCODE="" S NDCCODE=$TR($TR($$GET1^DIQ(52.49311,"1,"_ERXIEN_",",1.1,"I")," "),"-")
 I NDCCODE="" Q 0
 S QTY=+$$GET1^DIQ(52.49,ERXIEN,5.1) I 'QTY Q 0
 S SUBS=+$$GET1^DIQ(52.49,ERXIEN,5.8,"I")
 S DAYS=+$$GET1^DIQ(52.49,ERXIEN,5.5,"I")
 S REFS=+$$GET1^DIQ(52.49,ERXIEN,5.6,"I") I MTYPE="RE",RSPTYPE="R",REFS>0 S REFS=$G(REFS)-1
 ; Concatenating Drug Name+SIG for Hash Calculation
 S X=$$UP^XLFSTR(DRUG_$$ERXSIG^PSOERXUT(ERXIEN))
 S L=$L(X)
 F I=1:1:L I $E(X,I)?.AN S DRUGHASH=($A(X,I)*I)+DRUGHASH
 F I=L:-1:1 I $E(X,I)?.AN S DRUGHASH=($A(X,I)*(L-I+1))+DRUGHASH
 ; NDC Code|Drug Name+SIG Hash|Substitution|Qty|Days Supply|# of Refills
 Q (NDCCODE_DRUGHASH_SUBS_$E(1000+QTY,2,4)_$E(1000+DAYS,2,4)_$E(100+REFS,2,3))
