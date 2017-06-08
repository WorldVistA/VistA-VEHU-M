NURCCGAV ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6931,5)
 ;;=specifically
 ;;^UTILITY("^GMRD(124.2,",$J,6931,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6931,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6931,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6940,0)
 ;;=[Extra Order]^3^NURSC^11^136^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6940,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6940,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6941,0)
 ;;=Defining Characteristics^2^NURSC^12^88^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6941,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6941,1,1,0)
 ;;=4270^request for information^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6941,1,2,0)
 ;;=4272^statement of misconception^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6941,1,3,0)
 ;;=4275^verbalization of the problem^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6941,1,4,0)
 ;;=4322^inadequate performance of test or inadequate verbalization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6941,1,5,0)
 ;;=4323^inappropriate/exagerated behaviors ie.,hysterical,agitated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6941,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6947,0)
 ;;=performs dressing/grooming with [min/mod/max] assistance^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6947,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6947,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6948,0)
 ;;=Tissue Integrity, Impaired^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6948,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6948,1,1,0)
 ;;=6949^Etiology/Related and/or Risk Factors^2^NURSC^98
 ;;^UTILITY("^GMRD(124.2,",$J,6948,1,2,0)
 ;;=6956^Related Problems^2^NURSC^82
 ;;^UTILITY("^GMRD(124.2,",$J,6948,1,3,0)
 ;;=6960^Goals/Expected Outcomes^2^NURSC^97
 ;;^UTILITY("^GMRD(124.2,",$J,6948,1,4,0)
 ;;=6975^Nursing Intervention/Orders^2^NURSC^84
 ;;^UTILITY("^GMRD(124.2,",$J,6948,1,5,0)
 ;;=7008^Defining Characteristics^2^NURSC^89
 ;;^UTILITY("^GMRD(124.2,",$J,6948,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6948,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6948,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6948,"TD",0)
 ;;=^^1^1^2890306^^
 ;;^UTILITY("^GMRD(124.2,",$J,6948,"TD",1,0)
 ;;=State of tissue damage.
 ;;^UTILITY("^GMRD(124.2,",$J,6949,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^98^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6949,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,6949,1,1,0)
 ;;=1761^altered circulation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6949,1,2,0)
 ;;=1765^nutritional deficit/excess^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6949,1,4,0)
 ;;=645^knowledge deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6949,1,5,0)
 ;;=1769^impaired physical mobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6949,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6956,0)
 ;;=Related Problems^2^NURSC^7^82^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6956,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6956,1,1,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6956,1,2,0)
 ;;=1775^Knowledge Deficit (Specify)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6956,1,3,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6956,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6960,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^97^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6960,1,0)
 ;;=^124.21PI^12^11
 ;;^UTILITY("^GMRD(124.2,",$J,6960,1,2,0)
 ;;=1787^fluid intake is greater/equal to resting maintenace level^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6960,1,3,0)
 ;;=473^maintains optimal weight [specify lbs/kgs]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6960,1,4,0)
 ;;=1790^avoid irritants/noxious stimuli/oral irritants^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,6960,1,5,0)
 ;;=1791^moves all extremities freely^3^NURSC^1
