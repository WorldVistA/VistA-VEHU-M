NURCCGE6 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12695,1,18,0)
 ;;=12723^encourage to remove dentures/foreign objects if aura occurs^3^NURSC^36
 ;;^UTILITY("^GMRD(124.2,",$J,12695,1,33,0)
 ;;=13151^[Extra Order]^3^NURSC^235
 ;;^UTILITY("^GMRD(124.2,",$J,12695,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12695,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12697,0)
 ;;=place in lying position/flat/head to side during seizures^3^NURSC^11^19^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12697,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12697,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12700,0)
 ;;=Anxiety^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12700,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,12700,1,1,0)
 ;;=12703^Etiology/Related and/or Risk Factors^2^NURSC^171
 ;;^UTILITY("^GMRD(124.2,",$J,12700,1,2,0)
 ;;=12737^Goals/Expected Outcomes^2^NURSC^169
 ;;^UTILITY("^GMRD(124.2,",$J,12700,1,3,0)
 ;;=12753^Nursing Intervention/Orders^2^NURSC^143
 ;;^UTILITY("^GMRD(124.2,",$J,12700,1,4,0)
 ;;=12782^Related Problems^2^NURSC^147
 ;;^UTILITY("^GMRD(124.2,",$J,12700,1,5,0)
 ;;=12802^Defining Characteristics^2^NURSC^147
 ;;^UTILITY("^GMRD(124.2,",$J,12700,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12700,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12700,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12701,0)
 ;;=foot care^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12703,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^171^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12703,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,12703,1,1,0)
 ;;=1997^interpersonal transmission and contagion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12703,1,2,0)
 ;;=1851^situational crises^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12703,1,3,0)
 ;;=1847^maturational crises^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12703,1,4,0)
 ;;=12716^threat to or change in:^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,12703,1,5,0)
 ;;=2008^threat to self-concept^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12703,1,6,0)
 ;;=2009^threat of death^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12703,1,7,0)
 ;;=2010^unconscious conflict about essential values and goals^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12703,1,8,0)
 ;;=2012^unmet needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12703,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12705,0)
 ;;=discuss post-operative expectations^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12705,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12705,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12716,0)
 ;;=threat to or change in:^2^NURSC^^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12716,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,12716,1,1,0)
 ;;=2000^health status^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12716,1,2,0)
 ;;=2001^socioeconomic status^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12716,1,3,0)
 ;;=2002^role functioning^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12716,1,4,0)
 ;;=1817^environment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12716,1,5,0)
 ;;=2004^interaction patterns^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12716,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12723,0)
 ;;=encourage to remove dentures/foreign objects if aura occurs^3^NURSC^11^36^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12723,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12723,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12737,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^169^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12737,1,0)
 ;;=^124.21PI^7^3
 ;;^UTILITY("^GMRD(124.2,",$J,12737,1,1,0)
 ;;=12740^have a network of support developed prior to discharge^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,12737,1,2,0)
 ;;=12743^verbalizes feelings and healthy ways to deal with them^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,12737,1,7,0)
 ;;=13002^[Extra Goal]^3^NURSC^207
