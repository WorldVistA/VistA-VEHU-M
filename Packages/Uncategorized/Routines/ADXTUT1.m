ADXTUT1 ;523/KC sets-of-codes translations MRS to VA ;13-AUG-1992
 ;;1.1;;
DST1 ;;
DST2 ;;
DST3 ;;
FST1 ;;
FST2 ;;
FST3 ;;
 ;;0^1^2^3^4^5^6^7^8^9
 ;;0^1^2^3^4^5^6^7^8^9SGB
 ;...S,G,B to 9's as per DAM p3.52.
 ;...Sites of Distant Metastasis
DGS ;;
 ;;0^1^2^3^4^5^7^9
 ;;0^1^2^3^4^5^78^9B^6
 ;...8 to 7 as per DAM p 3.54.
 ;...B to 9 unstageable because non-malignant.
 ;...reject 6 as per DAM p3.55.
 ;...Summary Stage
 ;
DBR ;;
FBR ;;
 ;;0^1^2^7^8^9
 ;;0^15^2^7^8^9
 ;...05 goes with ones, as per DAM p3.111.
 ;...2 USED TO get rejected FOR tr review. Now code has been added!
 ;...Biological response modifier
FTYPRC ;;
 ;;0^1^2^3^4^9
 ;;05^1^2^3^4^9
 ;...put 5 with 0 as per DAM p 3.115.
 ;...type of recurrence
FMTH ;;
 ;;0^1^2^3^4^5^7^8^9
 ;;0^16^2^3^4^5^7^8^9
 ;...6 to 1 as per DAM p3.124.
 ;...follow-up method
 ;
TRANSET(ADXTLB,X) ;
 ; INPUT:  ADXTLABL=MRS VARIABLE NAME TO TRANSLATE
 ; X=VALUE OF VARIABLE TO TRANSLATE
 ; OUTPUT: CORRESPONDING VA SET-OF-CODES VALUE
 ; RETURN -1 IF INVALID CODE
 ;
 N ADXTVA,ADXTMRS,ADXTPOS,ADXTRET
 S X=$$TRIM^ADXTUT(X)
 Q:(X="")!(ADXTLB="") -1
 S ADXTVA=""
 F ADXTPOS=1:1  S ADXTVA=$TEXT(@ADXTLB+ADXTPOS) Q:ADXTVA=""  Q:$P(ADXTVA,";;",2)'=""
 S ADXTVA=$P($TEXT(@ADXTLB+ADXTPOS),";;",2) Q:ADXTVA="" -1
 S ADXTMRS=$P($TEXT(@ADXTLB+ADXTPOS+1),";;",2) Q:ADXTMRS="" -1
 F ADXTPOS=1:1  Q:ADXTPOS>$L(ADXTMRS)  Q:$P(ADXTMRS,"^",ADXTPOS)[X
 Q:$P(ADXTMRS,"^",ADXTPOS)'[X -1
 S ADXTRET=$P(ADXTVA,"^",ADXTPOS) Q:ADXTRET="" -1
 Q ADXTRET
