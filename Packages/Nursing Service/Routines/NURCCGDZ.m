NURCCGDZ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12381,1,4,0)
 ;;=12512^[Extra Goal]^3^NURSC^201
 ;;^UTILITY("^GMRD(124.2,",$J,12381,1,5,0)
 ;;=2616^maintains adequate nutritional status^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12381,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12382,0)
 ;;=participates in nutritional planning^3^NURSC^9^6^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12382,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12382,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12395,0)
 ;;=[Extra Goal]^3^NURSC^9^199^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12395,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12395,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12396,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^138^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12396,1,0)
 ;;=^124.21PI^21^6
 ;;^UTILITY("^GMRD(124.2,",$J,12396,1,7,0)
 ;;=12407^provide pleasant enviroment during meal times^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,12396,1,14,0)
 ;;=12419^initiate consult(s)^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,12396,1,17,0)
 ;;=12809^[Extra Order]^3^NURSC^207
 ;;^UTILITY("^GMRD(124.2,",$J,12396,1,19,0)
 ;;=15358^provide,assess,monitor,document hydration & nutrition q[]hr^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12396,1,20,0)
 ;;=1747^oral hygiene q[frequency]hrs^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,12396,1,21,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12396,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12396,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12399,0)
 ;;=Mobility, Impaired Physical^2^NURSC^2^6^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12399,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,12399,1,1,0)
 ;;=12405^Etiology/Related and/or Risk Factors^2^NURSC^167
 ;;^UTILITY("^GMRD(124.2,",$J,12399,1,2,0)
 ;;=12442^Goals/Expected Outcomes^2^NURSC^165
 ;;^UTILITY("^GMRD(124.2,",$J,12399,1,4,0)
 ;;=12475^Related Problems^2^NURSC^144
 ;;^UTILITY("^GMRD(124.2,",$J,12399,1,5,0)
 ;;=12481^Defining Characteristics^2^NURSC^144
 ;;^UTILITY("^GMRD(124.2,",$J,12399,1,6,0)
 ;;=15697^Nursing Intervention/Orders^2^NURSC^315
 ;;^UTILITY("^GMRD(124.2,",$J,12399,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12399,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12399,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12399,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,12399,"TD",1,0)
 ;;=A state in which the individual experiences a limitation of ability
 ;;^UTILITY("^GMRD(124.2,",$J,12399,"TD",2,0)
 ;;=for independent physical movement.
 ;;^UTILITY("^GMRD(124.2,",$J,12405,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^167^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,0)
 ;;=^124.21PI^19^19
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,1,0)
 ;;=803^intolerance to activity; decreased strength and endurance^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,2,0)
 ;;=209^musculoskeletal impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,3,0)
 ;;=210^neuromuscular impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,4,0)
 ;;=795^pain and discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,5,0)
 ;;=796^perceptual or cognitive^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,6,0)
 ;;=1038^reduced consciousness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,7,0)
 ;;=1039^perceptual impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,8,0)
 ;;=1040^psychological impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,9,0)
 ;;=1041^visual impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,10,0)
 ;;=1042^paralysis/plegia, loss of limb, quadri, para, hemi, mono^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,11,0)
 ;;=1043^injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,12,0)
 ;;=1044^restrictive devices^3^NURSC^1
