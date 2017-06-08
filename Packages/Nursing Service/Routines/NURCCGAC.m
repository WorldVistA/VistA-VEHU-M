NURCCGAC ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6040,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,6040,1,1,0)
 ;;=1569^deviation affecting access, intake, absorption of fluids^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6040,1,2,0)
 ;;=1570^excessive loss through normal routes (e.g., diarrhea)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6040,1,3,0)
 ;;=1571^extremes of ages^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6040,1,4,0)
 ;;=1572^extremes of weight^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6040,1,5,0)
 ;;=1573^factors influencing fluid needs (e.g., hypermetabolic state)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6040,1,6,0)
 ;;=1574^knowledge deficiency related to fluid volume^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6040,1,7,0)
 ;;=1575^medications^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6040,1,8,0)
 ;;=2644^actual loss^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6040,1,9,0)
 ;;=2645^failure of regulatory mechanisms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6040,1,10,0)
 ;;=2646^loss of fluids though abnormal routes (indwelling tubes)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6040,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6051,0)
 ;;=Defining Characteristics^2^NURSC^12^78^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6051,1,0)
 ;;=^124.21PI^8^5
 ;;^UTILITY("^GMRD(124.2,",$J,6051,1,2,0)
 ;;=4072^intake altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6051,1,3,0)
 ;;=4073^thirst^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6051,1,6,0)
 ;;=438^Hypotension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6051,1,7,0)
 ;;=4199^skin turgor decreased^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6051,1,8,0)
 ;;=4201^urine output altered (diluted, increased or decreased)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6051,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6060,0)
 ;;=[Extra Problem]^2^NURSC^2^14^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,6060,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6060,1,1,0)
 ;;=6061^Etiology/Related and/or Risk Factors^2^NURSC^256
 ;;^UTILITY("^GMRD(124.2,",$J,6060,1,2,0)
 ;;=6065^Goals/Expected Outcomes^2^NURSC^267
 ;;^UTILITY("^GMRD(124.2,",$J,6060,1,3,0)
 ;;=6069^Nursing Intervention/Orders^2^NURSC^269
 ;;^UTILITY("^GMRD(124.2,",$J,6060,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6060,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6060,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6061,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^256^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6061,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6061,1,1,0)
 ;;=6063^[etiology]^3^NURSC^74
 ;;^UTILITY("^GMRD(124.2,",$J,6061,1,2,0)
 ;;=6064^[etiology]^3^NURSC^75
 ;;^UTILITY("^GMRD(124.2,",$J,6061,1,3,0)
 ;;=6341^[etiology]^3^NURSC^18
 ;;^UTILITY("^GMRD(124.2,",$J,6061,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6062,0)
 ;;=[etiology]^3^NURSC^^73^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6063,0)
 ;;=[etiology]^3^NURSC^^74^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6064,0)
 ;;=[etiology]^3^NURSC^^75^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6065,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^267^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6065,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6065,1,1,0)
 ;;=6066^[Extra Goal]^3^NURSC^320
 ;;^UTILITY("^GMRD(124.2,",$J,6065,1,2,0)
 ;;=6067^[Extra Goal]^3^NURSC^321
 ;;^UTILITY("^GMRD(124.2,",$J,6065,1,3,0)
 ;;=6068^[Extra Goal]^3^NURSC^322
 ;;^UTILITY("^GMRD(124.2,",$J,6065,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6066,0)
 ;;=[Extra Goal]^3^NURSC^9^320^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6066,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6066,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6067,0)
 ;;=[Extra Goal]^3^NURSC^9^321^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6067,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6067,10)
 ;;=D EN2^NURCCPU1
