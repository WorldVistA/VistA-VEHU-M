NURCCGFS ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,7,0)
 ;;=2571^minimize noxious stimuli in environment^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,8,0)
 ;;=2572^restrict liquid intake to [ ]cc before meals^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,9,0)
 ;;=2573^provide nourishment at [ ] am and [ ] pm^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,10,0)
 ;;=2574^frequent cool clear liquids [ ]cc every [ ] hours^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,11,0)
 ;;=2575^elevate head to [ ] degrees for [ ] min. after meals^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,12,0)
 ;;=2576^provide rest periods after meals for [ ] hours^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,13,0)
 ;;=2577^provide financial resource contact for food purchase^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,14,0)
 ;;=14788^initiate consult(s)^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,15,0)
 ;;=2539^provide pt. education resources on nutrition as needed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,16,0)
 ;;=2581^teach suppression of vomiting reflex^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14772,1,17,0)
 ;;=15239^[Extra Order]^3^NURSC^260
 ;;^UTILITY("^GMRD(124.2,",$J,14772,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14772,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14778,0)
 ;;=maintain activity level commensurate with caloric intake^2^NURSC^11^8^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14778,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,14778,1,1,0)
 ;;=2569^maintain activity level; increase calories to [#] cal/day^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14778,1,2,0)
 ;;=2570^decrease activity level; maintain calories at [#] cal/day^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14778,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,14778,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14778,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14778,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14788,0)
 ;;=initiate consult(s)^2^NURSC^11^6^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14788,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,14788,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14788,1,2,0)
 ;;=2579^Social Work Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14788,1,3,0)
 ;;=2580^VNA^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14788,1,4,0)
 ;;=1928^Occupational Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14788,5)
 ;;=to:
 ;;^UTILITY("^GMRD(124.2,",$J,14788,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14788,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14788,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14795,0)
 ;;=[Extra Order]^3^NURSC^11^255^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14795,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14795,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14796,0)
 ;;=Defining Characteristics^2^NURSC^12^172^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14796,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14796,1,1,0)
 ;;=14797^body weight 20% or more under ideal^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,14796,1,2,0)
 ;;=14798^reported food intake under RDA^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,14796,1,3,0)
 ;;=14799^reported/observed lack of food^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,14796,1,4,0)
 ;;=14800^sore/inflammed bucal cavity^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,14796,1,5,0)
 ;;=14801^lack of interest in food^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,14796,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14797,0)
 ;;=body weight 20% or more under ideal^3^NURSC^^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14798,0)
 ;;=reported food intake under RDA^3^NURSC^^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14799,0)
 ;;=reported/observed lack of food^3^NURSC^^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14800,0)
 ;;=sore/inflammed bucal cavity^3^NURSC^^7^^^T
