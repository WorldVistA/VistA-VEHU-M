NURCCG0H ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,184,0)
 ;;=participates in development/implementation of treatment plan^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,184,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,184,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,185,0)
 ;;=verbalizes experiences causing alteration in prescribed plan^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,185,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,185,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,186,0)
 ;;=verbalizes accurate knowledge of disease^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,186,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,186,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,187,0)
 ;;=verbalizes accurate understanding of treatment regime^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,187,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,187,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,188,0)
 ;;=demonstrates realistic alternatives to treatment regime^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,188,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,188,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,189,0)
 ;;=identifies sources of dissatisfaction^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,189,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,189,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,190,0)
 ;;=participates in selection of more desirable treatment plan^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,190,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,190,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,191,0)
 ;;=verbalizes intent to adhere to realistic alternative plan^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,191,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,191,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,192,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^133^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,192,1,0)
 ;;=^124.21PI^12^12
 ;;^UTILITY("^GMRD(124.2,",$J,192,1,1,0)
 ;;=193^assist exploring factors influencing non-compliance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,192,1,2,0)
 ;;=194^develop therapeutic nurse/patient relationship^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,192,1,3,0)
 ;;=195^determine value systems and cultural factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,192,1,4,0)
 ;;=196^determine developmental level^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,192,1,5,0)
 ;;=197^determine prohibitive factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,192,1,6,0)
 ;;=198^assess level of anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,192,1,7,0)
 ;;=199^assess support system^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,192,1,8,0)
 ;;=200^provide for patient care conferences for mutual goal setting^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,192,1,9,0)
 ;;=201^discuss patient's/SO's understanding of treatment regime^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,192,1,10,0)
 ;;=203^provide information and encourage patient to seek it on own^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,192,1,11,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,192,1,12,0)
 ;;=2959^[Extra Order]^3^NURSC^36^0
 ;;^UTILITY("^GMRD(124.2,",$J,192,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,192,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,193,0)
 ;;=assist exploring factors influencing non-compliance^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,193,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,193,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,194,0)
 ;;=develop therapeutic nurse/patient relationship^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,194,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,194,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,195,0)
 ;;=determine value systems and cultural factors^3^NURSC^11^1^^^T
