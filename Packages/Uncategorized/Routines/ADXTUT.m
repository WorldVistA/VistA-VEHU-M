ADXTUT ;523/kc utility functions for ONCO file transfer ; 5-AUG-1992
 ;;1.1;;
 ;
ABDATE(ADXTDTDX) ; return abstract date based on disch date + 6 mos.
 N X,X1,X2 S X1=$$DTCVT^ADXTUT(ADXTDTDX) I '+X1 Q 0
 S X2=182 D C^%DTC Q X
 ;
ALIVE(ADXTFDT,ADXTDA) ;
 ; ADXTFDT = date to check, ADXTDA = DA of patient to check
 ; quit 1 if vital status alive, 0 if dead (on date ADXTFDT)
 N ADXTPEXP S ADXTPEXP=$$DOD^ADXTUT(ADXTDA)
 I '+ADXTPEXP Q 1
 I ADXTFDT<ADXTPEXP Q 1
 Q 0
 ;
DOD(ADXTDA) ;
 ; ADXTDA= DA of patient to check
 ; quit DOD in FM format (0 if not dead)
 Q +$P($G(^ONCO(160,ADXTDA,523000)),"^",3)
 ;
DTCVT(X) ; convert cobol date to FM date
 ; cobol date passed as X
 ; output: FM date returned, 0 "00/00/00"
 I X'?2N1"/"2N1"/"2N Q 0
 N Y S Y="2"_$P(X,"/",1)_$P(X,"/",2)_$P(X,"/",3)
 Q $S((Y=2000000):0,1:Y)
 ;
GTCNTP(X) ; get pointer from ONCO file #165
 ; input:  Hospital's MRS "POINTER" in X
 ; output: pointer, or 0 if not found OR duplicates found
 N ADXTPREV S X=$$TRIM^ADXTUT(X),ADXTPREV=0
 ;
 I $D(^ONCO(165,"A523000",X)) S ADXTPREV=+$O(^ONCO(165,"A523000",X,0))
 I +ADXTPREV I +$O(^ONCO(165,"A523000",X,ADXTPREV)) Q 0
 I +ADXTPREV Q +ADXTPREV
 ;
 I $D(^ONCO(165,"A523008",X)) S ADXTPREV=+$O(^ONCO(165,"A523008",X,0))
 I +ADXTPREV I +$O(^ONCO(165,"A523008",X,ADXTPREV)) Q 0
 Q +ADXTPREV
 ;
GTCNTYP(ADXTDA) ; get 420-compatible contact type given contact DA
 N ADXTTYP,ADXTZ
 S ADXTZ=+$P($G(^ONCO(165,ADXTDA,0)),"^",2)
 Q $S(ADXTZ=1:"PT",ADXTZ=2:"MD",ADXTZ=3:"OTH",ADXTZ=4:"INST",ADXTZ=5:"OTH",ADXTZ=6:"OTH",1:"")
 ;
GTMP(X) ; get morphology code pointer from file #164.1
 ; input:  X is "DMOR" value from MRS
 ; output: pointer if found, 0 if not found
 I $D(^ONCO(164.1,X)) Q X
 Q 0
 ;
GTOPP(ZPID,ZDTOP,ZDSQ) ;get pointer to 165.5 via conversion id
 ; return 0 if not found or duplicates...
 N ADXTPREV
 S ZDTOP=$$TRIM^ADXTUT(ZDTOP),ZPID=$$TRIM^ADXTUT(ZPID),ZDSQ=$$TRIM^ADXTUT(ZDSQ)
 I '$D(^ONCO(165.5,"A523000",ZPID_ZDTOP_ZDSQ)) Q 0
 S ADXTPREV=+$O(^ONCO(165.5,"A523000",ZPID_ZDTOP_ZDSQ,0))
 I '+ADXTPREV Q 0
 I +$O(^ONCO(165.5,"A523000",ZPID_ZDTOP_ZDSQ,ADXTPREV)) Q 0
 Q ADXTPREV
 ;
GTPP(X) ; get pointer to ONCOLOGY patient file
 ; input:  PID
 ; output: pointer to ONCO patient file, 0 if not found or duplicate
 ;
 N ADXTPREV S X=$$TRIM^ADXTUT(X),ADXTPREV=0
 ;
 I $D(^ONCO(160,"A523000",X)) S ADXTPREV=+$O(^ONCO(160,"A523000",X,0))
 I +ADXTPREV I +$O(^ONCO(160,"A523000",X,ADXTPREV)) Q 0
 I +ADXTPREV Q +ADXTPREV
 ;
 I $D(^ONCO(160,"A523008",X)) S ADXTPREV=+$O(^ONCO(160,"A523008",X,0))
 I +ADXTPREV I +$O(^ONCO(160,"A523008",X,ADXTPREV)) Q 0
 Q +ADXTPREV
 ;
GTSP(X) ; get idco site pointer from DTOP value// new method via MLH
 ; input:  "DTOP" value from MRS as X;
 ; ??169??
 ; output: pointer if found FROM file #164, 0 if not found
 ;
 N ADXTDTOP
 S X=$$TRIM^ADXTUT(X) S ADXTDTOP=$$GTTP^ADXTUT(X) Q:'+ADXTDTOP 0
 Q +$P($G(^ONCO(164,ADXTDTOP,0)),"^",13)
 ;
GTTP(X) ; get topography pointer from DTOP value
 ; input:  "DTOP" value from MRS as X;
 ; output: pointer if found in file #164, 0 if not found
 S X=$$TRIM^ADXTUT(X)
 Q +$G(^ONCO(169,"ACV",X))
 ;
GTZPP(X) ; get zip code pointer from file #5.11
 ; input:  X: zip code
 ; DA: entry number of 165.5 entry being edited
 ; output: pointer, 0 if not found
 S X=$$TRIM^ADXTUT(X)
 N ADXTX2
 F ADXTX2=0:0 S ADXTX2=$O(^VIC(5.11,"B",X_" ",ADXTX2)) Q
 I ADXTX2="" Q 0
 I ADXTX2=-1 Q 0
 Q ADXTX2
GTCTY(X) ; get county pointer from zip code file #5.11
 ; input:  X: zip code
 ; DA: entry number of 165.5 entry being edited
 ; output: pointer, 0 if not found
 S X=$$TRIM^ADXTUT(X)
 N ADXTX2
 F ADXTX2=0:0 S ADXTX2=$O(^VIC(5.11,"B",X_" ",ADXTX2)) Q
 I ADXTX2="" Q 0
 I ADXTX2=-1 Q 0
 Q +$P($G(^VIC(5.11,ADXTX2,0)),"^",3)
 ;
MRS(X) ;
 Q:X="DI" "Diagnostic"
 Q:X="FL" "Follow-up"
 Q:X="PAT" "Patient"
 Q:X="SCD" "Secondary"
 Q:X="DOC" "Doctor"
 Q ""
 ;
LTRIM(X) ; trim leading spaces
 ; input:  X to trim leading spaces from
 ; output: L-trimmed X
 N ADXTI,ADXTLEN,ADXTPOS S ADXTPOS=1
 S ADXTLEN=$L(X) F ADXTI=1:1:ADXTLEN S ADXTPOS=ADXTI Q:$E(X,ADXTI)'=" "
 S X=$E(X,ADXTPOS,ADXTLEN) I ($L(X)=1)&($E(X)=" ") S X=""
 Q X
 ;
RTRIM(X) ; trim trailing spaces
 ; input: X to trim trailing spaces from
 ; output: R-trimmed X
 N ADXTI,ADXTLEN,ADXTPOS
 S (ADXTPOS,ADXTLEN)=$L(X) F ADXTI=ADXTLEN:-1:1 S ADXTPOS=ADXTI Q:$E(X,ADXTI)'=" "
 S X=$E(X,1,ADXTPOS) I ($L(X)=1)&($E(X)=" ") S X=""
 Q X
 ;
TRIM(X) ;returns LTRIM'd, RTRIM'd X
 Q $$LTRIM^ADXTUT($$RTRIM^ADXTUT(X))
 ;
TIME() ;returns the time
 D NOW^%DTC S Y=% D DD^%DT Q Y
 ;
TRANICD(X) ; translate ICD code
 N ADXTZ
 S X=$$TRIM^ADXTUT(X)
 Q:'+X 0
 S X=+X I $L(X)=3 S X=X_"0"
 S ADXTZ=$E(X,1,3)_"."_$E(X,4)
 Q ADXTZ
 ;
GTICD(X) ; get pointer to ICD file # 80
 N Y
 S X=$$TRANICD(X)
 Q:'+X 0
 S Y="" I $D(^ICD9("BA",+X)) S Y=$O(^ICD9("BA",+X,Y))
 Q +Y
 ;
SIXMO(X1) ; return date + 6 mos.
 N X2 S X2=182 D C^%DTC Q X
