NURCCGBD ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7821,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7821,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7822,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^109^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7822,1,0)
 ;;=^124.21PI^7^3
 ;;^UTILITY("^GMRD(124.2,",$J,7822,1,3,0)
 ;;=73^prolonged disease/disability exhausting SO^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7822,1,6,0)
 ;;=76^temporary family disorganization and role changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7822,1,7,0)
 ;;=15525^chronic illness required lifelong invasive/debilitating tx^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7822,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7837,0)
 ;;=[Extra Goal]^3^NURSC^9^121^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7837,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7837,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7839,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^279^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7839,1,0)
 ;;=^124.21PI^10^9
 ;;^UTILITY("^GMRD(124.2,",$J,7839,1,2,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7839,1,3,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7839,1,4,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,7839,1,5,0)
 ;;=4646^fluid restriction [specify amt]cc q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7839,1,6,0)
 ;;=7851^[Extra Order]^3^NURSC^30
 ;;^UTILITY("^GMRD(124.2,",$J,7839,1,7,0)
 ;;=4409^assess,monitor,document hemodynamics ^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7839,1,8,0)
 ;;=15667^assess,monitor,document venous distention q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7839,1,9,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7839,1,10,0)
 ;;=4438^monitor lab values^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7839,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7839,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7840,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^107^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7840,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,7840,1,1,0)
 ;;=7843^realistic responses to stress^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7840,1,2,0)
 ;;=60^effective problem solving^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7840,1,3,0)
 ;;=2491^effective decision making skills^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7840,1,4,0)
 ;;=7849^effective family coping skills^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7840,1,5,0)
 ;;=7920^[Extra Goal]^3^NURSC^142
 ;;^UTILITY("^GMRD(124.2,",$J,7840,5)
 ;;=family demonstrates
 ;;^UTILITY("^GMRD(124.2,",$J,7840,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7843,0)
 ;;=realistic responses to stress^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7843,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7843,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7849,0)
 ;;=effective family coping skills^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7849,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7849,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7851,0)
 ;;=[Extra Order]^3^NURSC^11^30^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7851,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7851,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7852,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^92^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7852,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,7852,1,1,0)
 ;;=61^assess family's coping response^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7852,1,2,0)
 ;;=62^assist family to appraise stressors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7852,1,3,0)
 ;;=63^assist family to develop plan to cope with stressors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7852,1,4,0)
 ;;=7856^teach effective coping skills^2^NURSC^2
