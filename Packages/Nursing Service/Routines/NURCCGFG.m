NURCCGFG ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14431,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14434,0)
 ;;=[Extra Goal]^3^NURSC^9^397^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14434,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14434,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14435,0)
 ;;=bronchial hygiene q[frequency]hrs^2^NURSC^11^14^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,14435,1,0)
 ;;=^124.21PI^9^4
 ;;^UTILITY("^GMRD(124.2,",$J,14435,1,3,0)
 ;;=2705^postural drainage q[specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14435,1,4,0)
 ;;=430^percussion q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14435,1,8,0)
 ;;=4766^vibrations q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14435,1,9,0)
 ;;=4767^cough/turn/deep breathe q[specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14435,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14435,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14435,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14436,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^303^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14436,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14436,1,1,0)
 ;;=14438^[Extra Order]^3^NURSC^402
 ;;^UTILITY("^GMRD(124.2,",$J,14436,1,2,0)
 ;;=14440^[Extra Order]^3^NURSC^403
 ;;^UTILITY("^GMRD(124.2,",$J,14436,1,3,0)
 ;;=14442^[Extra Order]^3^NURSC^404
 ;;^UTILITY("^GMRD(124.2,",$J,14436,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14436,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14438,0)
 ;;=[Extra Order]^3^NURSC^11^402^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14438,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14438,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14440,0)
 ;;=[Extra Order]^3^NURSC^11^403^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14440,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14440,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14442,0)
 ;;=[Extra Order]^3^NURSC^11^404^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14442,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14442,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14453,0)
 ;;=refer for appropriate consults^2^NURSC^11^78^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14453,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,14453,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14453,1,2,0)
 ;;=297^Chaplain Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14453,1,3,0)
 ;;=1928^Occupational Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14453,1,4,0)
 ;;=1927^Physical Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14453,1,5,0)
 ;;=1929^Corrective Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14453,1,6,0)
 ;;=2649^Respiratory Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14453,1,7,0)
 ;;=2579^Social Work Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14453,1,8,0)
 ;;=2718^Speech Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14453,5)
 ;;=specifically
 ;;^UTILITY("^GMRD(124.2,",$J,14453,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14453,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14453,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14462,0)
 ;;=[Extra Order]^3^NURSC^11^251^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14462,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14462,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14463,0)
 ;;=Defining Characteristics^2^NURSC^12^169^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14463,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14463,1,1,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14463,1,2,0)
 ;;=996^shortness of breath^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14463,1,3,0)
 ;;=4077^abnormal arterial blood gases^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14463,1,4,0)
 ;;=4079^respiratory depth changes^3^NURSC^1
