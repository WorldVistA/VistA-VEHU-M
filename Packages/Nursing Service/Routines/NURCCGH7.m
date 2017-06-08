NURCCGH7 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15949,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15949,1,1,0)
 ;;=4205^Defining Characteristics^2^NURSC^31
 ;;^UTILITY("^GMRD(124.2,",$J,15949,1,2,0)
 ;;=3154^Related Problems^2^NURSC^65
 ;;^UTILITY("^GMRD(124.2,",$J,15949,1,3,0)
 ;;=15950^Goals/Expected Outcomes^2^NURSC^327
 ;;^UTILITY("^GMRD(124.2,",$J,15949,1,4,0)
 ;;=15952^Nursing Intervention/Orders^2^NURSC^329
 ;;^UTILITY("^GMRD(124.2,",$J,15949,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15949,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15949,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15950,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^327^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15950,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15950,1,1,0)
 ;;=15944^expresses pain is within tolerable limits ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15950,1,2,0)
 ;;=15945^verbalizes that pain is absent upon discharge^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15950,1,3,0)
 ;;=15962^[Extra Goal]^3^NURSC^30
 ;;^UTILITY("^GMRD(124.2,",$J,15950,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15952,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^329^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15952,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15952,1,1,0)
 ;;=392^administer pain medication as needed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15952,1,2,0)
 ;;=2798^assess pain (location, duration) q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15952,1,3,0)
 ;;=15889^teach pain relief measures:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15952,1,4,0)
 ;;=15964^[Extra Order]^3^NURSC^14
 ;;^UTILITY("^GMRD(124.2,",$J,15952,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15952,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15953,0)
 ;;=Anxiety^2^NURSC^2^5^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15953,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,15953,1,1,0)
 ;;=15954^Defining Characteristics^2^NURSC^61
 ;;^UTILITY("^GMRD(124.2,",$J,15953,1,3,0)
 ;;=15958^Etiology/Related and/or Risk Factors^2^NURSC^79
 ;;^UTILITY("^GMRD(124.2,",$J,15953,1,4,0)
 ;;=15959^Related Problems^2^NURSC^173
 ;;^UTILITY("^GMRD(124.2,",$J,15953,1,5,0)
 ;;=15960^Goals/Expected Outcomes^2^NURSC^328
 ;;^UTILITY("^GMRD(124.2,",$J,15953,1,6,0)
 ;;=15963^Nursing Intervention/Orders^2^NURSC^330
 ;;^UTILITY("^GMRD(124.2,",$J,15953,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15953,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15953,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15954,0)
 ;;=Defining Characteristics^2^NURSC^12^61^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15954,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15954,1,1,0)
 ;;=1045^pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15954,1,2,0)
 ;;=15955^extended hospitalization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15954,1,3,0)
 ;;=15956^treatment/procedure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15954,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15955,0)
 ;;=extended hospitalization^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15956,0)
 ;;=treatment/procedure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15958,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^79^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15958,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,15958,1,1,0)
 ;;=1851^situational crises^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15958,1,2,0)
 ;;=2012^unmet needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15958,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15959,0)
 ;;=Related Problems^2^NURSC^7^173^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15959,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,15959,1,1,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15959,1,2,0)
 ;;=2018^Sleep Pattern Disturbance^3^NURSC^1
