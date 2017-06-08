ADXTAFL1 ;523/KC set up variables from MRS Follow-up file ;4-AUG-1992
 ;;1.1;;
 ;
EN ;
 ; INPUT VARIABLES: ADXTX1,ADXTX2 (NODES FROM TMP)
 ; OUTPUT VARIABLES: ADXT(), WITH VAR'S STORED AT SUBSCRIPT LEVELS
 ;
 N ADXTNOD,ADXTVAR,ADXTSTA,ADXTEND,ADXTI,X
 K ADXT
 F ADXTI=1:1 S X=$P($TEXT(VAR+ADXTI),";;",2) Q:X=""  D
 .S ADXTNOD=$P(X,"^",2)
 .S ADXTVAR=$P(X,"^",3)
 .S ADXTSTA=$P(X,"^",4)
 .S ADXTEND=$P(X,"^",5)
 .I ADXTNOD=1 S ADXT(ADXTVAR)=$E(ADXTX1,ADXTSTA,ADXTEND)
 .I ADXTNOD=2 S ADXT(ADXTVAR)=$E(ADXTX2,ADXTSTA,ADXTEND)
EXIT ;
 K ADXTNOD,ADXTVAR,ADXTSTA,ADXTEND,ADXTI,X
 Q
 ;
 ; Pieces of $TEXT description:
 ; ============================
 ; 1: MRS source file
 ; 2: ^TMP subscript level stored at
 ; 3: MRS field name
 ; 4: MRS offset of start of field
 ; 5: MRS offset of end of field
VAR ;
 ;;Follow-up^1^PID^1^7^
 ;;Follow-up^1^DTOP^8^11^
 ;;Follow-up^1^DSQ^12^13^
 ;;Follow-up^1^FDT^14^21^
 ;;Follow-up^1^FCTMD^22^27^
 ;;Follow-up^1^FMTH^28^28^
 ;;Follow-up^1^FLEV^29^29^
 ;;Follow-up^1^FSRVQ^30^30^
 ;;Follow-up^1^FFRC^31^38^
 ;;Follow-up^1^FTYPRC^39^39^
 ;;Follow-up^1^FST1^40^40^
 ;;Follow-up^1^FST2^41^41^
 ;;Follow-up^1^FST3^42^42^
 ;;Follow-up^1^FSR^43^44^
 ;;Follow-up^1^FSRD^45^52^
 ;;Follow-up^1^FBCN^54^54^
 ;;Follow-up^1^FSQN^55^55^
 ;;Follow-up^1^FRD^57^57^
 ;;Follow-up^1^FRDD^58^65^
 ;;Follow-up^1^FCH^67^67^
 ;;Follow-up^1^FCHD^68^75^
 ;;Follow-up^1^FHM^77^77^
 ;;Follow-up^1^FHMD^78^85^
 ;;Follow-up^1^FBR^87^87^
 ;;Follow-up^1^FBRD^88^95^
 ;;Follow-up^1^FOT^97^97^
 ;;Follow-up^1^FOTD^98^105^
 ;;Follow-up^1^FCRG^106^113^
 ;;Follow-up^1^FCMM^114^163^
 ;
 Q
