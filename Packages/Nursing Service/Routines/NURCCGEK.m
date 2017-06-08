NURCCGEK ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13302,1,3,0)
 ;;=1103^decrease in circulation to the brain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13302,1,5,0)
 ;;=1106^physical barrier: brain tumor, tracheostomy, intubation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13302,1,7,0)
 ;;=1108^inability to speak^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13302,1,9,0)
 ;;=1038^reduced consciousness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13302,1,14,0)
 ;;=1113^language barriers^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13302,1,16,0)
 ;;=1115^impaired articulation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13302,1,17,0)
 ;;=573^surgery^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13302,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13340,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^176^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13340,1,0)
 ;;=^124.21PI^5^3
 ;;^UTILITY("^GMRD(124.2,",$J,13340,1,1,0)
 ;;=13343^experience reduction in anxiety level^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,13340,1,4,0)
 ;;=33^communicates within capacity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13340,1,5,0)
 ;;=13603^[Extra Goal]^3^NURSC^235
 ;;^UTILITY("^GMRD(124.2,",$J,13340,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13343,0)
 ;;=experience reduction in anxiety level^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13343,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13343,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13352,0)
 ;;=[Extra Goal]^3^NURSC^9^232^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13352,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13352,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13353,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^149^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13353,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,13353,1,1,0)
 ;;=13356^assess for reliable response/successful communication mode:^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,13353,1,2,0)
 ;;=13365^if unreliable response/attempt communication mode:^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,13353,1,3,0)
 ;;=1455^reassess communication ability q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13353,1,4,0)
 ;;=13781^[Extra Order]^3^NURSC^243
 ;;^UTILITY("^GMRD(124.2,",$J,13353,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13353,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13356,0)
 ;;=assess for reliable response/successful communication mode:^2^NURSC^11^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13356,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,13356,1,1,0)
 ;;=1445^to 'yes' and 'no'^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13356,1,2,0)
 ;;=1446^to choice^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13356,1,3,0)
 ;;=1447^to pantomime^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13356,1,4,0)
 ;;=1448^to writing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13356,1,5,0)
 ;;=1449^to English^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13356,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13356,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13356,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13358,0)
 ;;=refer for appropriate consults^2^NURSC^11^72^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13358,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,13358,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13358,1,2,0)
 ;;=297^Chaplain Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13358,1,3,0)
 ;;=1928^Occupational Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13358,1,4,0)
 ;;=1927^Physical Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13358,1,5,0)
 ;;=1929^Corrective Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13358,1,6,0)
 ;;=2649^Respiratory Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13358,1,7,0)
 ;;=2579^Social Work Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13358,1,8,0)
 ;;=2718^Speech Therapy^3^NURSC^1
