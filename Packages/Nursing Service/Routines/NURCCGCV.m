NURCCGCV ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10680,1,1,0)
 ;;=10681^Etiology/Related and/or Risk Factors^2^NURSC^145
 ;;^UTILITY("^GMRD(124.2,",$J,10680,1,2,0)
 ;;=10701^Goals/Expected Outcomes^2^NURSC^143
 ;;^UTILITY("^GMRD(124.2,",$J,10680,1,3,0)
 ;;=10706^Nursing Intervention/Orders^2^NURSC^121
 ;;^UTILITY("^GMRD(124.2,",$J,10680,1,4,0)
 ;;=10729^Related Problems^2^NURSC^125
 ;;^UTILITY("^GMRD(124.2,",$J,10680,1,5,0)
 ;;=10735^Defining Characteristics^2^NURSC^124
 ;;^UTILITY("^GMRD(124.2,",$J,10680,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10680,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10680,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10680,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,10680,"TD",1,0)
 ;;=A state in which the individual experiences a limitation of ability
 ;;^UTILITY("^GMRD(124.2,",$J,10680,"TD",2,0)
 ;;=for independent physical movement.
 ;;^UTILITY("^GMRD(124.2,",$J,10681,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^145^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10681,1,0)
 ;;=^124.21PI^18^12
 ;;^UTILITY("^GMRD(124.2,",$J,10681,1,1,0)
 ;;=803^intolerance to activity; decreased strength and endurance^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,10681,1,2,0)
 ;;=209^musculoskeletal impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10681,1,3,0)
 ;;=210^neuromuscular impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10681,1,4,0)
 ;;=795^pain and discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10681,1,6,0)
 ;;=1038^reduced consciousness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10681,1,7,0)
 ;;=1039^perceptual impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10681,1,8,0)
 ;;=1040^psychological impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10681,1,9,0)
 ;;=1041^visual impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10681,1,10,0)
 ;;=1042^paralysis/plegia, loss of limb, quadri, para, hemi, mono^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10681,1,11,0)
 ;;=1043^injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10681,1,14,0)
 ;;=10695^decreased strength and endurance^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,10681,1,18,0)
 ;;=207^depression, severe anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10681,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10695,0)
 ;;=decreased strength and endurance^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10701,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^143^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10701,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,10701,1,1,0)
 ;;=10702^avoids complications of immobility^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,10701,1,2,0)
 ;;=10703^achieves maximum physical mobility within limitations^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,10701,1,3,0)
 ;;=10704^verbalizes acceptance of limitations^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,10701,1,4,0)
 ;;=10831^[Extra Goal]^3^NURSC^178
 ;;^UTILITY("^GMRD(124.2,",$J,10701,1,5,0)
 ;;=833^maintains intact skin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10701,1,6,0)
 ;;=2674^demonstrates ability to use assistive/adaptive devices [spe]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10701,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10702,0)
 ;;=avoids complications of immobility^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10702,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10702,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10703,0)
 ;;=achieves maximum physical mobility within limitations^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10703,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10703,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10704,0)
 ;;=verbalizes acceptance of limitations^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10704,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10704,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10705,0)
 ;;=[Extra Goal]^3^NURSC^9^176^^^T
