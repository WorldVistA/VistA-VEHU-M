NURCCG0F ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,160,0)
 ;;=information misinterpretation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,161,0)
 ;;=lack of exposure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,162,0)
 ;;=lack of recall^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,163,0)
 ;;=lack of interest in learning^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,164,0)
 ;;=patient's request for no information^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,165,0)
 ;;=unfamiliarity with information resources^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,166,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^6^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,166,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,166,1,1,0)
 ;;=167^verbalizes ability to make decisions on health care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,166,1,2,0)
 ;;=2437^expresses appropriate knowledge base for self care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,166,1,3,0)
 ;;=2438^demonstrates positive health behaviors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,166,1,4,0)
 ;;=2439^expresses less anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,166,1,5,0)
 ;;=2486^verbalizes knowledge of treatments^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,166,1,6,0)
 ;;=2487^verbalizes knowledge of disease process & treatment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,166,1,7,0)
 ;;=2488^verbalizes knowledge of risks^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,166,1,8,0)
 ;;=2501^verbalizes prevention practice for [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,166,1,9,0)
 ;;=2871^[Extra Goal]^3^NURSC^46^0
 ;;^UTILITY("^GMRD(124.2,",$J,166,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,167,0)
 ;;=verbalizes ability to make decisions on health care^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,167,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,167,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,168,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^89^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,168,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,168,1,1,0)
 ;;=169^assess knowledge base^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,168,1,2,0)
 ;;=170^decide what patient needs to know^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,168,1,3,0)
 ;;=171^determine ability to learn and implement plan^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,168,1,4,0)
 ;;=172^implement teaching plan based on readiness/ability to learn^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,168,1,5,0)
 ;;=173^involve S/O in teaching plan^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,168,1,6,0)
 ;;=174^evaluate effectiveness of teaching plan^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,168,1,7,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,168,1,8,0)
 ;;=2958^[Extra Order]^3^NURSC^32^0
 ;;^UTILITY("^GMRD(124.2,",$J,168,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,168,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,169,0)
 ;;=assess knowledge base^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,169,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,169,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,170,0)
 ;;=decide what patient needs to know^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,170,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,170,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,171,0)
 ;;=determine ability to learn and implement plan^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,171,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,171,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,172,0)
 ;;=implement teaching plan based on readiness/ability to learn^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,172,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,172,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,173,0)
 ;;=involve S/O in teaching plan^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,173,9)
 ;;=D EN2^NURCCPU2
