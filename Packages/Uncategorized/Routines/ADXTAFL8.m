ADXTAFL8 ;523/KC stuff follow-up contacts into 160,160.03 ; 07-MAY-1993
 ;;1.1;;
EN ;
 ; INPUT VARIABLES: ADXT(""), MRS FIELD VALUES ARE STORED BY SUBSCRIPT
 ; ADXTDA (ENTRY IN 160 TO ADD TO)
 ; ADXTFILE: FILE ADDING TO
 ; OUTPUT VARIABLES: NONE
 ;
 N ADXTSTAT,ADXTSBF,ADXTDTOP,ADXTFILE,ADXTFNUM,ADXTFLD,ADXTLBL,ADXTLINE,ADXTSB,ADXTSBDA,DIC,ADXTI,X,Y
 ;
 U IO
 ;
 Q:'+ADXTDA  ; if ptr to patient file not provided!!!
 ;
 ; quit if not a doctor to store
 Q:'+$$GTCNTP^ADXTUT(ADXT("FCTMD"))
 ;
 ; quit if follow-up contact for this fup already processed
 Q:$D(^ONCO(160,ADXTDA,"C","A523000",ADXT("PID")_ADXT("DTOP")_ADXT("DSQ")_ADXT("FDT")))
 ;
 ; add doc to follow-up contact multiple
 S ADXTDOC=$$GTCNTP^ADXTUT(ADXT("FCTMD"))
 ; quit if no contact type
 S X=$$GTCNTYP^ADXTUT(ADXTDOC) Q:X=""
 ; quit if doctor already stored as a contact in 160.03
 Q:$D(^ONCO(160,"APC",ADXTDA,ADXTDOC))
 S ADXTFNUM=160,ADXTFLD=420,ADXTLBL="FL"
 D ^ADXTMULT I +ADXTSBDA>0 D
 .S ADXTLINE=""
 .F ADXTI=1:1 S ADXTLINE=$P($TEXT(FIELDS+ADXTI),";;",2) Q:ADXTLINE=""  D
 ..S ADXTSBF=$P(ADXTLINE,"^",2)
 ..D ^ADXTEDIT
EXIT ;
 K ADXTSTAT,ADXTSBF,ADXTDTOP,ADXTFILE,ADXTFNUM,ADXTFLD,ADXTLBL,ADXTLINE,ADXTSB,ADXTSBDA,DIC,ADXTI,X,Y
 Q
 ;
 ; PIECE LISTING:
 ; ==============
 ; 1: VA file MRS var to be added into
 ; 2: VA field MRS var to be added into
 ; 3: MRS field to add
 ; 4: 3 OR 4 FOR SLASHES, OR W IF WORD PROCESSING
 ; 5:50: input transform
FIELDS ;
 ;;160.03^1^FCTMD^4^S X=$$GTCNTP^ADXTUT(X) K:'+X X
 ;;160.03^523000^FDT^3^S X=ADXT("PID")_ADXT("DTOP")_ADXT("DSQ")_ADXT("FDT")
