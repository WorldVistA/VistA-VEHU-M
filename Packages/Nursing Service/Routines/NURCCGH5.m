NURCCGH5 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15918,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15919,0)
 ;;=[Extra Order]^3^NURSC^11^424^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15919,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15919,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15920,0)
 ;;=[Extra Order]^3^NURSC^11^425^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15920,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15920,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15921,0)
 ;;=encourage use of soft toothbrush & floss only if necessary^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15921,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15921,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15922,0)
 ;;=free of objective S/S of pain^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15922,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15922,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15923,0)
 ;;=able to carry out ADLs^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15923,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15923,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15924,0)
 ;;=analgesics/antiemetics as ordered^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15924,4)
 ;;=administer, assess, monitor, & document
 ;;^UTILITY("^GMRD(124.2,",$J,15924,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15924,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15925,0)
 ;;=titrate analgesics/antiemetics as ordered^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15925,5)
 ;;=; notify MD if not effective
 ;;^UTILITY("^GMRD(124.2,",$J,15925,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15925,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15926,0)
 ;;=provide activity for patients as tolerated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15926,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15926,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15927,0)
 ;;=encourage activity as tolerated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15927,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15927,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15928,0)
 ;;=assist to maintain correct positioning^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15928,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15928,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15929,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^325^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15929,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15929,1,1,0)
 ;;=15930^demonstrate positive health behaviors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15929,1,2,0)
 ;;=15931^verbalize knowledge of disease, risks, and treatment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15929,1,3,0)
 ;;=15932^verbalizes knowledge of preventive practices^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15929,1,4,0)
 ;;=15946^[Extra Goal]^3^NURSC^28
 ;;^UTILITY("^GMRD(124.2,",$J,15929,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15930,0)
 ;;=demonstrate positive health behaviors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15930,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15930,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15931,0)
 ;;=verbalize knowledge of disease, risks, and treatment^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15931,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15931,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15932,0)
 ;;=verbalizes knowledge of preventive practices^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15932,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15932,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15933,0)
 ;;=[Extra Goal]^3^NURSC^9^26^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15933,9)
 ;;=D EN5^NURCCPU0
