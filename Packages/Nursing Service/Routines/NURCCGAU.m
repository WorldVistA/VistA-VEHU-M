NURCCGAU ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6903,1,9,0)
 ;;=459^medications^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6903,1,10,0)
 ;;=2658^diet^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6903,1,11,0)
 ;;=11838^capillary blood glucose monitoring [specify type]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6903,1,12,0)
 ;;=11880^foot care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6903,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6911,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^96^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6911,1,0)
 ;;=^124.21PI^10^9
 ;;^UTILITY("^GMRD(124.2,",$J,6911,1,1,0)
 ;;=167^verbalizes ability to make decisions on health care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6911,1,2,0)
 ;;=2437^expresses appropriate knowledge base for self care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6911,1,3,0)
 ;;=2438^demonstrates positive health behaviors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6911,1,5,0)
 ;;=2486^verbalizes knowledge of treatments^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6911,1,6,0)
 ;;=6920^verbalizes knowledge of diseases^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,6911,1,7,0)
 ;;=2488^verbalizes knowledge of risks^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6911,1,8,0)
 ;;=2501^verbalizes prevention practice for [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6911,1,9,0)
 ;;=6974^[Extra Goal]^3^NURSC^134
 ;;^UTILITY("^GMRD(124.2,",$J,6911,1,10,0)
 ;;=12175^demonstrates skills and verbalizes knowledge regarding:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6911,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6920,0)
 ;;=verbalizes knowledge of diseases^3^NURSC^9^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6920,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6920,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6923,0)
 ;;=[Extra Goal]^3^NURSC^9^133^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6923,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6923,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6924,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^178^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6924,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,6924,1,1,0)
 ;;=169^assess knowledge base^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6924,1,2,0)
 ;;=170^decide what patient needs to know^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6924,1,3,0)
 ;;=171^determine ability to learn and implement plan^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6924,1,4,0)
 ;;=172^implement teaching plan based on readiness/ability to learn^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6924,1,5,0)
 ;;=173^involve S/O in teaching plan^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6924,1,6,0)
 ;;=174^evaluate effectiveness of teaching plan^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6924,1,7,0)
 ;;=6931^refer for appropriate consults^2^NURSC^14
 ;;^UTILITY("^GMRD(124.2,",$J,6924,1,8,0)
 ;;=6940^[Extra Order]^3^NURSC^136
 ;;^UTILITY("^GMRD(124.2,",$J,6924,1,9,0)
 ;;=4713^implement health teaching protocol^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6924,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6924,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6931,0)
 ;;=refer for appropriate consults^2^NURSC^11^14^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6931,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,6931,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6931,1,2,0)
 ;;=297^Chaplain Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6931,1,3,0)
 ;;=1928^Occupational Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6931,1,4,0)
 ;;=1927^Physical Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6931,1,5,0)
 ;;=1929^Corrective Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6931,1,6,0)
 ;;=2649^Respiratory Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6931,1,7,0)
 ;;=2579^Social Work Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6931,1,8,0)
 ;;=2718^Speech Therapy^3^NURSC^1
