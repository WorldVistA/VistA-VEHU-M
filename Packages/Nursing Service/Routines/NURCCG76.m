NURCCG76 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3020,0)
 ;;=[Extra Order]^3^NURSC^11^106^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3020,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3020,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3021,0)
 ;;=[Extra Order]^3^NURSC^11^107^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3021,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3021,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3022,0)
 ;;=[Extra Order]^3^NURSC^11^108^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3022,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3022,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3023,0)
 ;;=[Extra Order]^3^NURSC^11^109^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3023,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3023,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3024,0)
 ;;=[Extra Order]^3^NURSC^11^110^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3024,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3024,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3025,0)
 ;;=[Extra Order]^3^NURSC^11^111^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3025,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3025,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3026,0)
 ;;=[Extra Order]^3^NURSC^11^112^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3026,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3026,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3027,0)
 ;;=[Extra Order]^3^NURSC^11^113^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3027,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3027,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3028,0)
 ;;=Constipation, Perceived^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3028,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,3028,1,1,0)
 ;;=3029^Etiology/Related and/or Risk Factors^2^NURSC^72^0
 ;;^UTILITY("^GMRD(124.2,",$J,3028,1,2,0)
 ;;=3033^Related Problems^2^NURSC^60^0
 ;;^UTILITY("^GMRD(124.2,",$J,3028,1,3,0)
 ;;=3035^Nursing Intervention/Orders^2^NURSC^37^0
 ;;^UTILITY("^GMRD(124.2,",$J,3028,1,4,0)
 ;;=3050^Goals/Expected Outcomes^2^NURSC^72^0
 ;;^UTILITY("^GMRD(124.2,",$J,3028,1,5,0)
 ;;=5156^Defining Characteristics^2^NURSC^60
 ;;^UTILITY("^GMRD(124.2,",$J,3028,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3028,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3028,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3029,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^72^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3029,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,3029,1,1,0)
 ;;=3030^cultural/family health beliefs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3029,1,2,0)
 ;;=3031^faulty appraisal^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3029,1,3,0)
 ;;=3032^impaired thought processes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3029,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3030,0)
 ;;=cultural/family health beliefs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3031,0)
 ;;=faulty appraisal^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3032,0)
 ;;=impaired thought processes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3033,0)
 ;;=Related Problems^2^NURSC^7^60^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3033,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,3033,1,1,0)
 ;;=3034^Adjustment Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3033,1,2,0)
 ;;=645^knowledge deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3033,1,3,0)
 ;;=2851^nutrition, alteration in (less than body requirements)^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,3033,1,4,0)
 ;;=2197^Thought Processes, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3033,1,5,0)
 ;;=1398^Nutrition, Alteration In: Less Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3033,7)
 ;;=D EN4^NURCCPU1
