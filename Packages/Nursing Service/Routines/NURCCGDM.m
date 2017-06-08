NURCCGDM ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11828,1,2,0)
 ;;=11833^maintains ROM in all joints, and strength in muscles^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,11828,1,3,0)
 ;;=11835^activity: optimal level WNL/pt [specify activity], q[freq]^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,11828,1,4,0)
 ;;=11953^[Extra Goal]^3^NURSC^191
 ;;^UTILITY("^GMRD(124.2,",$J,11828,1,6,0)
 ;;=2674^demonstrates ability to use assistive/adaptive devices [spe]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11828,1,7,0)
 ;;=15381^remains free of complications of immobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11828,1,8,0)
 ;;=15383^verbalizes need to avoid certain positions [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11828,1,9,0)
 ;;=15389^demonstrates,participates in measures to improve circulation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11828,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11833,0)
 ;;=maintains ROM in all joints, and strength in muscles^3^NURSC^9^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11833,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11833,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11835,0)
 ;;=activity: optimal level WNL/pt [specify activity], q[freq]^3^NURSC^9^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11835,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11835,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11837,0)
 ;;=[Extra Goal]^3^NURSC^9^189^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11837,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11837,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11838,0)
 ;;=capillary blood glucose monitoring [specify type]^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11840,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^132^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11840,1,0)
 ;;=^124.21PI^16^9
 ;;^UTILITY("^GMRD(124.2,",$J,11840,1,3,0)
 ;;=811^protect from injury as indicated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11840,1,8,0)
 ;;=814^adjust environment as appropriate^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11840,1,9,0)
 ;;=11858^teach/provide range of motion exercise  q [frequency]^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,11840,1,10,0)
 ;;=429^reposition/turn q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11840,1,11,0)
 ;;=11863^teach assistive devices [specify] to facilitate mobility^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,11840,1,12,0)
 ;;=818^limit activities as set by medical protocols & as indicated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11840,1,14,0)
 ;;=12437^[Extra Order]^3^NURSC^202
 ;;^UTILITY("^GMRD(124.2,",$J,11840,1,15,0)
 ;;=15384^teach repositioning techniques^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11840,1,16,0)
 ;;=15390^teach use/care of wheelchair cushion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11840,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11840,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11849,0)
 ;;=Defining Characteristics^2^NURSC^12^138^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11849,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11849,1,1,0)
 ;;=4185^verbal report of pain experienced for more than 6 months^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11849,1,2,0)
 ;;=4192^alteration in muscle tone (may span from listless to rigid)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11849,1,3,0)
 ;;=4197^distractive behavior(moaning,crying,pacing,restlessness,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11849,1,4,0)
 ;;=4200^facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11849,1,5,0)
 ;;=4202^narrowed focus(altered time perception,withdrawn etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11849,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11858,0)
 ;;=teach/provide range of motion exercise  q [frequency]^3^NURSC^11^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11858,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11858,10)
 ;;=D EN1^NURCCPU3
