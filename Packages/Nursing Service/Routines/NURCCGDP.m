NURCCGDP ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11927,1,10,0)
 ;;=330^elevate head of bed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11927,1,11,0)
 ;;=429^reposition/turn q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11927,1,30,0)
 ;;=12032^refer for appropriate consults^2^NURSC^59
 ;;^UTILITY("^GMRD(124.2,",$J,11927,1,31,0)
 ;;=12474^[Extra Order]^3^NURSC^203
 ;;^UTILITY("^GMRD(124.2,",$J,11927,1,32,0)
 ;;=1601^encourage fluid intake of [amt]cc/24hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11927,1,33,0)
 ;;=2830^assess respiratory rate and pattern/breath sounds^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11927,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11927,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11928,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^160^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11928,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,11928,1,1,0)
 ;;=2551^expresses factors that contribute to decreased nutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11928,1,2,0)
 ;;=11930^maintains nutritional intake to meet metabolic requirements:^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,11928,1,4,0)
 ;;=12163^[Extra Goal]^3^NURSC^193
 ;;^UTILITY("^GMRD(124.2,",$J,11928,1,5,0)
 ;;=15393^wound size decreases^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11928,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11930,0)
 ;;=maintains nutritional intake to meet metabolic requirements:^2^NURSC^9^5^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11930,1,0)
 ;;=^124.21PI^8^4
 ;;^UTILITY("^GMRD(124.2,",$J,11930,1,3,0)
 ;;=2555^daily intake of [number of] calories^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11930,1,6,0)
 ;;=2558^absence of negative nitrogen balance indicators^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11930,1,7,0)
 ;;=9534^stable weight [specify weight range]lbs/kgs, w/i 20% ideal^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11930,1,8,0)
 ;;=2556^balance between activity and caloric intake^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11930,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,11930,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11930,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11930,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11953,0)
 ;;=[Extra Goal]^3^NURSC^9^191^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11953,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11953,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11955,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^134^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11955,1,0)
 ;;=^124.21PI^20^9
 ;;^UTILITY("^GMRD(124.2,",$J,11955,1,2,0)
 ;;=11962^assess ability to eat,masticate, & presence nausea/vomiting^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,11955,1,3,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11955,1,5,0)
 ;;=2567^assess need for calorie count q[specify frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11955,1,9,0)
 ;;=11978^provide supplemental feedings at [specify]am and [specify]pm^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,11955,1,15,0)
 ;;=12000^teach techniques to enhance nutritional content of foods^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,11955,1,17,0)
 ;;=12532^[Extra Order]^3^NURSC^204
 ;;^UTILITY("^GMRD(124.2,",$J,11955,1,18,0)
 ;;=15388^hydration and nutrition q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11955,1,19,0)
 ;;=4438^monitor lab values^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11955,1,20,0)
 ;;=12093^wound drainage:assess for color,consistency,amt,odor q[frq]^3^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,11955,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11955,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11962,0)
 ;;=assess ability to eat,masticate, & presence nausea/vomiting^3^NURSC^11^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11962,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11962,10)
 ;;=D EN1^NURCCPU3
