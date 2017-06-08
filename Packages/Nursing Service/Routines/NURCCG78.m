NURCCG78 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3044,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3044,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3045,0)
 ;;=perform rectal examination^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3045,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3045,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3046,0)
 ;;=institute bowel program [specify]^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3046,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3046,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3047,0)
 ;;=encourage physical activity within limits^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3047,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3047,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3048,0)
 ;;=instruct against habitual use of laxatives/enemas^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3048,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3048,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3049,0)
 ;;=instruct to attempt defecation [value]hours pc^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3049,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3049,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3050,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^72^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3050,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,3050,1,1,0)
 ;;=3051^establishment of a bowel elimination pattern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3050,1,2,0)
 ;;=3052^reduction of laxative/enema/suppository use^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3050,1,3,0)
 ;;=3053^patient verbalizes factors influencing elimination [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3050,1,4,0)
 ;;=16558^[Extra Goal]^3^NURSC^426
 ;;^UTILITY("^GMRD(124.2,",$J,3050,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3051,0)
 ;;=establishment of a bowel elimination pattern^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3051,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3051,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3052,0)
 ;;=reduction of laxative/enema/suppository use^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3052,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3052,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3053,0)
 ;;=patient verbalizes factors influencing elimination [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3053,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3053,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3054,0)
 ;;=Decisional Conflict [specify]^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,3054,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,3054,1,1,0)
 ;;=3055^Etiology/Related and/or Risk Factors^2^NURSC^73^0
 ;;^UTILITY("^GMRD(124.2,",$J,3054,1,2,0)
 ;;=3062^Related Problems^2^NURSC^61^0
 ;;^UTILITY("^GMRD(124.2,",$J,3054,1,3,0)
 ;;=3064^Goals/Expected Outcomes^2^NURSC^73^0
 ;;^UTILITY("^GMRD(124.2,",$J,3054,1,4,0)
 ;;=3070^Nursing Intervention/Orders^2^NURSC^66^0
 ;;^UTILITY("^GMRD(124.2,",$J,3054,1,5,0)
 ;;=5586^Defining Characteristics^2^NURSC^71
 ;;^UTILITY("^GMRD(124.2,",$J,3054,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3054,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3054,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3055,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^73^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3055,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,3055,1,1,0)
 ;;=3056^unclear personal values/beliefs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3055,1,2,0)
 ;;=3057^perceived threat to value system^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3055,1,3,0)
 ;;=3058^lack of experience or interface with decision making^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3055,1,4,0)
 ;;=3059^lack of relevant information^3^NURSC^1^0
