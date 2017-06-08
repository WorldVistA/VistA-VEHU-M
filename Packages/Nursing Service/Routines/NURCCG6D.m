NURCCG6D ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2598,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2599,0)
 ;;=assess factors contributing to increased food intake^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2599,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2599,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2600,0)
 ;;=record caloric intake q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2600,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2600,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2601,0)
 ;;=maintain activity level commensurate with caloric intake^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2601,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,2601,1,1,0)
 ;;=2602^increase caloric expenditure by [ ] calories/day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2601,1,2,0)
 ;;=2603^decrease food intake to [ ] calories per day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2601,5)
 ;;=, e.g.,
 ;;^UTILITY("^GMRD(124.2,",$J,2601,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2601,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2601,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2602,0)
 ;;=increase caloric expenditure by [ ] calories/day^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2603,0)
 ;;=decrease food intake to [ ] calories per day^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2604,0)
 ;;=refer to support groups^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2604,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2604,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2605,0)
 ;;=teach METS activities and progression of same^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2605,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2605,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2606,0)
 ;;=teach behavior modification techniques related to intake^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2606,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2606,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2607,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^70^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2607,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,2607,1,1,0)
 ;;=2608^alteration in dentition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2607,1,2,0)
 ;;=2609^alteration in oral mucous membrane^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2607,1,3,0)
 ;;=2610^altered levels of consciousness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2607,1,4,0)
 ;;=630^fatigue^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2607,1,5,0)
 ;;=2611^mechanical obstruction, i.e., tumors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2607,1,6,0)
 ;;=2612^neuromuscular impairment, i.e, decreased/absent gag^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2607,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2608,0)
 ;;=alteration in dentition^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2609,0)
 ;;=alteration in oral mucous membrane^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2610,0)
 ;;=altered levels of consciousness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2611,0)
 ;;=mechanical obstruction, i.e., tumors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2612,0)
 ;;=neuromuscular impairment, i.e, decreased/absent gag^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2613,0)
 ;;=Related Problems^2^NURSC^7^58^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2613,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,2613,1,1,0)
 ;;=1578^Oral Mucous Membrane, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2613,1,2,0)
 ;;=1398^Nutrition, Alteration In: Less Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2613,5)
 ;;=see:
 ;;^UTILITY("^GMRD(124.2,",$J,2613,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2614,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^70^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2614,1,0)
 ;;=^124.21PI^5^5
