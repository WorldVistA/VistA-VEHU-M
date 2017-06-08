NURCCG32 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1015,0)
 ;;=provide non-irritating diet (clear liquid/soft/low residue)^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1015,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1015,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1016,0)
 ;;=maintain good hygiene of perineal area:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1016,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1016,1,1,0)
 ;;=1018^pericare after each bowel movement^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1016,1,2,0)
 ;;=1019^apply lotion/ointment to skin as indicated/ordered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1016,1,3,0)
 ;;=1020^expose area to air, use heat lamp if needed to keep area dry^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1016,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1016,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1016,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1017,0)
 ;;=nitroglycerin Sl or IV [sig] repeat at 5 min intervals^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1018,0)
 ;;=pericare after each bowel movement^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1019,0)
 ;;=apply lotion/ointment to skin as indicated/ordered^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1020,0)
 ;;=expose area to air, use heat lamp if needed to keep area dry^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1021,0)
 ;;=administer antidiarrhea medication as ordered/indicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1021,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1021,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1022,0)
 ;;=teach appropriate diet, medication usage^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1022,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1022,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1023,0)
 ;;=obtain stool culture^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1023,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1023,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1024,0)
 ;;=initiate consult^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1024,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1024,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1025,0)
 ;;=isordil [dose] as indicated^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1026,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^24^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1026,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1026,1,1,0)
 ;;=207^depression, severe anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1026,1,2,0)
 ;;=209^musculoskeletal impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1026,1,3,0)
 ;;=210^neuromuscular impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1026,1,4,0)
 ;;=1033^perception or cognitive impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1026,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1027,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^23^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1027,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1027,1,1,0)
 ;;=613^verbalizes awareness of the cause/contributing factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1027,1,2,0)
 ;;=1119^achieves reduced number of incontinent episodes, <[ ]X/day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1027,1,3,0)
 ;;=1120^is continent of stool^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1027,1,4,0)
 ;;=1121^verbalizes knowledge of available assistive devices^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1027,1,5,0)
 ;;=1122^maintains skin integrity of perineal area^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1027,1,6,0)
 ;;=2656^utilizes management program^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1027,1,7,0)
 ;;=2888^[Extra Goal]^3^NURSC^65^0
 ;;^UTILITY("^GMRD(124.2,",$J,1027,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1028,0)
 ;;=propranolol [dose] as indicated^3^NURSC^^1^^^T
