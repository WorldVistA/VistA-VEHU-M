NURCCGFQ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14728,0)
 ;;=isolation^2^NURSC^11^10^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14728,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14728,1,1,0)
 ;;=2433^AFB^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14728,1,2,0)
 ;;=2434^secretion/excretion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14728,1,3,0)
 ;;=2435^respiratory^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14728,5)
 ;;=specifically:
 ;;^UTILITY("^GMRD(124.2,",$J,14728,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14728,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14728,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14734,0)
 ;;=teach prevention of infection techniques [specify]^2^NURSC^11^10^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14734,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,14734,1,1,0)
 ;;=2749^actions to take to prevent cross-infection^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14734,1,2,0)
 ;;=1820^S/S of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14734,1,3,0)
 ;;=2750^personal hygiene measures as indicated [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14734,1,4,0)
 ;;=2938^assess knowledge base^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14734,1,5,0)
 ;;=2939^determine ability to learn and implement plan^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14734,1,6,0)
 ;;=2940^decide what patient needs to know^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14734,1,7,0)
 ;;=2941^evaluate effectiveness of teaching plan^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14734,1,8,0)
 ;;=2942^implement teaching plan based on readiness/ability to learn^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14734,1,9,0)
 ;;=2943^involve S/O in teaching plan^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14734,5)
 ;;=including:
 ;;^UTILITY("^GMRD(124.2,",$J,14734,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14734,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14734,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14744,0)
 ;;=[Extra Order]^3^NURSC^11^254^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14744,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14744,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14745,0)
 ;;=Nutrition, Alteration in:(Less Than Required)^2^NURSC^2^7^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14745,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14745,1,1,0)
 ;;=14746^Etiology/Related and/or Risk Factors^2^NURSC^196
 ;;^UTILITY("^GMRD(124.2,",$J,14745,1,2,0)
 ;;=14750^Related Problems^2^NURSC^167
 ;;^UTILITY("^GMRD(124.2,",$J,14745,1,3,0)
 ;;=14757^Goals/Expected Outcomes^2^NURSC^193
 ;;^UTILITY("^GMRD(124.2,",$J,14745,1,4,0)
 ;;=14772^Nursing Intervention/Orders^2^NURSC^162
 ;;^UTILITY("^GMRD(124.2,",$J,14745,1,5,0)
 ;;=14796^Defining Characteristics^2^NURSC^172
 ;;^UTILITY("^GMRD(124.2,",$J,14745,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14745,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14745,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14745,"TD",0)
 ;;=^^2^2^2910821^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,14745,"TD",1,0)
 ;;=The state in which an individual experiences an intake of nutrients
 ;;^UTILITY("^GMRD(124.2,",$J,14745,"TD",2,0)
 ;;=insufficient to meet metabolic needs.
 ;;^UTILITY("^GMRD(124.2,",$J,14746,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^196^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14746,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14746,1,1,0)
 ;;=2544^inability to digest/absorb nutrients due to biologic factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14746,1,2,0)
 ;;=2545^inability to digest/absorb nutrients due to psych. factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14746,1,3,0)
 ;;=2546^inability to digest/absorb nutrients due to economic factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14746,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14750,0)
 ;;=Related Problems^2^NURSC^7^167^1^^T^1
