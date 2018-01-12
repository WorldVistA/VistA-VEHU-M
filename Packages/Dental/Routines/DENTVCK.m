DENTVCK ;DSS/KC - CODING CHECKS ;2/21/2007 14:21
 ;;1.2;DENTAL;**53,59,63**;Aug 10, 2001;Build 19
 ;Copyright 1995-2013, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  ICR#  SUPPORTED  Description
 ;  -----  ---------  --------------------------------------
 ; 10000      x       ^%DTC
 ;
 Q
CK(RET,DFN,ECODE,VISDT,PROV,DATA) ;rpc DENTV TP CODING CHECKS
 ; DFN=patient, ECODE=code entered by user:AREA (tooth, quad, arch)
 ; VISDT=visit date, PROV=provider
 ; DATA(n)=array of current (unfiled) completed codes
 ; RET=0^OK, or 0^warning message, or 
 ;    -1^W:ADA Code:compliance warning, or 
 ;    -1^E:ADA Code:compliance error
 ;    flag=1 if coding review message added to warning/error
 ; This rpc checks input against params in 228.8 for coding compliance
 ; REGION=6 for areaquadrant, from ^DENT(228.3,7,0) piece 3
 ; 
 I '$G(DFN) S RET="0^Patient not sent, checks not peformed" Q  ;don't stop user for this type of issue
 S RET="0^OK",VISDT=+$G(VISDT) S:'VISDT VISDT=DT
 S D9110=0,X=0 F  S X=$O(DATA(X)) Q:'X!D9110  I DATA(X)["D9110" S D9110=1
 I $G(ECODE)["D9110"!D9110 D D9110 Q:RET
 I VISDT'=DT D V9110 Q:RET
 I $G(ECODE)="" D VIS Q  ;checking entire completed entry (not code by code)
 ;check each entry (ECODE) as it's entered
 N ECI,ECIEN,E0,E1,N0,N1,ECAREA,WARN,TEETH,TOOTH,TOI,NDATA,WARNC,X,I,D9110,CNT
 S X=+$O(DATA(0)) S X=$G(DATA(X)) I X="D9430:" S RET=$$ONLY(0) Q
 S TEETH=$P(ECODE,":",2),ECODE=$P(ECODE,":"),WARN=RET,WARNC=""
 S ECI=+$$CPT^DSICCPT(,ECODE,,,,1) I ECI<1 S RET="0^Code not valid, checks not performed" Q
 ;if code has warning and other checks, warning MUST be first entry into 228.8!
 S ECIEN=$O(^DENT(228.8,"B",ECI,0)) I 'ECIEN Q
 S E0=$G(^DENT(228.8,ECIEN,0)),E1=$G(^(1))
 I ECODE="D9430",$O(DATA(0)) S RET="-1^E:D9430:"_E1 Q
 I $P(E0,U,6)="W" S WARN="-1^"_$P(E0,U,6)_"::"_E1,WARNC=$P(E0,U,2)
 I '$O(^DENT(228.8,"C",ECI,0)) S RET=WARN Q  ;warning only
 I TEETH="" D SES(0) Q:RET  D  Q
 .K DATA S DATA(1)=ECODE D VIS Q:RET
 .I WARN,'WARNC S RET=WARN
 .Q
 S TOI=1 F  S TOOTH=$P(TEETH,";",TOI),NDATA(TOI)=ECODE_":"_TOOTH Q:(TOOTH="")!RET  D SES(TOOTH) S TOI=TOI+1
 Q:RET  K DATA M DATA=NDATA D VIS Q:RET
 I WARN,'WARNC S RET=WARN
 Q
SES(ECAREA) ;session check: entered code (EACH tooth separately!) against unfiled codes
 N I,CCODE,CCI,CCIEN,CCAREA
 S I=0 F  S I=$O(DATA(I)) Q:'I!RET  S CCODE=$G(DATA(I)) I CCODE]"" D
 .S CCAREA=$P(CCODE,":",2),CCODE=$P(CCODE,":")
 .S CCI=+$$CPT^DSICCPT(,CCODE,,,,1) I CCI<1 Q
 .S ECIEN=0 F  S ECIEN=$O(^DENT(228.8,"C",ECI,CCI,ECIEN)) Q:'ECIEN!($P(RET,U,2)="E")  D
 ..S N0=$G(^DENT(228.8,ECIEN,0)),N1=$G(^(1))
 ..I $$PSCAL(ECODE,CCODE) S RET="-1^"_$P(N0,U,6)_":"_ECODE_":"_N1 Q
 ..I $P(N0,U,5)]"",ECAREA'=CCAREA Q  ;validate area
 ..I $$MULT(ECODE,CCODE) S RET="-1^"_$P(N0,U,6)_":"_ECODE_":"_N1 Q
 ..S RET="-1^"_$P(N0,U,6)_":"_ECODE_":"_N1
 ..Q
 .Q
 Q
 ;
PSCAL(E,C) ;perio scaling special checks
 I E="D4341",C="D4341" Q 1
 I E="D4342",C="D4342" Q 1
 I E="D4341",C="D4342" Q 1
 I E="D4342",C="D4341" Q 1
 Q 0
MULT(E,C,DATE) ;checks for multiple exams
 N MULT S MULT=0
 I $P($G(DATE),".")'=$P($G(VISDT),".") Q MULT
 I (E="D0120")!(E="D0140")!(E="D0150")!(E="D0160")!(E="D0170")!(E="D0180") D
 .I (C="D0120")!(C="D0140")!(C="D0150")!(C="D0160")!(C="D0170")!(C="D0180") S MULT=1
 Q MULT
RF() ;get required fields to compare for D9110
 N X,IEN,N0,N1 S X=+$$CPT^DSICCPT(,"D9110",,,,1) I X<1 Q "0"
 S IEN=$O(^DENT(228.8,"B",X,0)) I IEN="" Q "0"
 S N0=$G(^DENT(228.8,IEN,0)),N1=$G(^(1))
 S X=$P(N0,U,6)_":D9110:"_N1
 Q X
D9110 ;look for D9110
 N RF S RF=$$RF Q:RF=0
 I D9110,$G(ECODE)]"",$$DIS($P(ECODE,":")) S RET="-1^"_RF Q
 Q:$G(ECODE)'["D9110"  S X=0
 F  S X=$O(DATA(X)) Q:'X!RET  I $$DIS($P(DATA(X),":")) S $P(RF,":",2)=$P(DATA(X),":"),RET="-1^"_RF
 Q
V9110 ;check specific visit for D9110
 N IEN,FLAG1,FLAG2,TXN,ADA,QUIT,RF,X,N0,N1
 S RF=$$RF Q:RF=0
 S IEN=0,FLAG1=0,FLAG2=0,QUIT=0 I $G(ECODE)["D9110" S D9110=1
 F  S IEN=$O(^DENT(228.1,"AE",DFN,VISDT,IEN)) Q:'IEN!QUIT  D
 .S TXN=0 F  S TXN=$O(^DENT(228.2,"AG",IEN,TXN)) Q:'TXN!QUIT  D
 ..S N0=$G(^DENT(228.2,TXN,0)),N1=$G(^(1))
 ..S ADA=+$P(N0,U,4) Q:'ADA  Q:$P(N1,U,3)  Q:$P(N0,U,12)'="104"  ;P53T9
 ..S ADA=$$CPT^DSICCPT(,ADA,,,,1) Q:ADA<0
 ..I $P(ADA,U,2)="D9110" S FLAG1=1,QUIT=1
 ..I $$DIS($P(ADA,U,2)) S FLAG2=1
 ..I D9110,FLAG2 S RET="-1^"_RF,QUIT=1 Q
 ..Q:'FLAG1
 ..I $G(ECODE)]"",$$DIS($P(ECODE,":")) S RET="-1^"_RF Q
 ..S X=0 F  S X=$O(DATA(X)) Q:'X!RET  I $$DIS($P(DATA(X),":")) S RET="-1^"_RF
 ..Q
 .Q
 Q
DIS(CODE) ;only allow certain codes with D9110
 I $E(CODE,2)=0 Q 0
 I CODE="D1310" Q 0
 I CODE="D1320" Q 0
 I CODE="D1330" Q 0
 I CODE="D9110" Q 0
 I CODE="D9310" Q 0
 Q 1
VIS ;check ALL codes in DATA array against data in VistA for visit date
 N DAYSB,X1,X2,CKDT,I,ECODE,ECI,ECIEN,CCI,MSGFLG
 S DAYSB=0,PROV=+$G(PROV),CKDT=VISDT,MSGFLG="" S:'PROV PROV=DUZ
 S I=0 F  S I=$O(DATA(I)) Q:'I!RET  S ECODE=$G(DATA(I)) I ECODE]"" D
 .S ECAREA=$P(ECODE,":",2),ECODE=$P(ECODE,":")
 .S ECI=+$$CPT^DSICCPT(,ECODE,,,,1) I ECI<1 Q
 .I ECODE="D0140"!(ECODE="D0170") S RET=$$SPEC(ECI) Q:RET  ;DENT*1.2*59
 .S CCI=0 F  S CCI=$O(^DENT(228.8,"C",ECI,CCI)) Q:'CCI!($P(RET,U,2)="E")  D
 ..S ECIEN=0 F  S ECIEN=$O(^DENT(228.8,"C",ECI,CCI,ECIEN)) Q:'ECIEN  D
 ...S N0=$G(^DENT(228.8,ECIEN,0)),N1=$G(^(1))
 ...D DDATA
 ...Q
 ..Q
 .Q
 Q
DDATA ;loop through 228.2, find CCI entries
 N LV,QUIT,IEN,NODE,CCAREA,CCODE S LV="",QUIT=0
 F  S LV=$O(^DENT(228.2,"AC",DFN,CCI,LV),-1) Q:'LV!QUIT  D
 .S IEN="" F  S IEN=$O(^DENT(228.2,"AC",DFN,CCI,LV,IEN),-1) Q:'IEN!QUIT  D
 ..S NODE=$G(^DENT(228.2,IEN,0)) Q:NODE=""!+$P($G(^DENT(228.2,IEN,1)),U,3)
 ..S CCAREA=$P(NODE,U,15)
 ..S CCODE=$P($$CPT^DSICCPT(,CCI,,,,1),U,2)
 ..I $P(N0,U,4),PROV'=$P(NODE,U,3) Q  ;validate provider
 ..I $$PSCAL(ECODE,CCODE) S RET="-1^"_$P(N0,U,6)_":"_ECODE_":"_N1,QUIT=1 Q
 ..I $P(N0,U,5)]"",ECAREA'=CCAREA Q  ;validate area
 ..I $$EXAM(ECODE,CCODE,LV) Q  ;validate exam dates
 ..S RET="-1^"_$P(N0,U,6)_":"_ECODE_":"_N1,QUIT=1,MSGFLG=$P(N0,U,6)
 ..Q
 .Q
 Q
EXAM(E,C,X) ;checks exam dates
 N DTDIF,HI,LO,%H,RSLT S RSLT=0
 D H^%DTC S HI=%H,X=VISDT D H^%DTC S LO=%H,DTDIF=HI-LO
 I $$MULT(ECODE,CCODE,LV) Q 0 ;validate exams/day
 I C="D0150",DTDIF<305,DTDIF>(-305) D  Q RSLT
 .I E="D0150" Q
 .I E="D0120",DTDIF<90,DTDIF>(-90) Q
 .S RSLT=1
 I C="D0120",DTDIF<90,DTDIF>(-90) D  Q RSLT
 .I E="D0120" Q
 .I E="D0150",DTDIF<305,DTDIF>(-305) Q
 .S RSLT=1
 Q 1
ONLY(CIEN) ;this code only allowed by itself
 I +$G(CIEN)=0 S CIEN=+$$CPT^DSICCPT(,"D9430",,,,1)
 S ECIEN=$O(^DENT(228.8,"B",CIEN,0)) Q:'ECIEN
 Q "-1^E:D9430:"_$G(^DENT(228.8,ECIEN,1))
 ;
SPEC(CIEN) ;D0140 and D0170 - no more than 3 per year - special check
 N OCIEN
 S ECIEN=$O(^DENT(228.8,"B",CIEN,0)) Q:'ECIEN
 S N0=$G(^DENT(228.8,ECIEN,0)),N1=$G(^(1))
 S DAYSB=$P(N0,U,3),X1=(VISDT\1),X2=-DAYSB D C^%DTC S CKDT=X
 I ECODE="D0140" S OCIEN=+$$CPT^DSICCPT(,"D0170",,,,1)
 I ECODE="D0170" S OCIEN=+$$CPT^DSICCPT(,"D0140",,,,1)
 S CNT=1 F CCI=CIEN,OCIEN D SDATA
 I CNT>3 S RET="-1^E:"_ECODE_":"_N1
 Q RET
 ;
SDATA ;loop through 228.2, find CCI entries and COUNT them
 N LV,QUIT,IEN,NODE,CCODE S LV="",QUIT=0
 F  S LV=$O(^DENT(228.2,"AC",DFN,CCI,LV),-1) Q:'LV!QUIT!(LV<CKDT)  D
 .S IEN="" F  S IEN=$O(^DENT(228.2,"AC",DFN,CCI,LV,IEN),-1) Q:'IEN!QUIT  D
 ..S NODE=$G(^DENT(228.2,IEN,0)) Q:NODE=""!+$P($G(^DENT(228.2,IEN,1)),U,3)
 ..I $P(N0,U,4),PROV'=$P(NODE,U,3) Q  ;validate provider
 ..S CNT=CNT+1 S:CNT>3 QUIT=1
 ..Q
 .Q
 Q
