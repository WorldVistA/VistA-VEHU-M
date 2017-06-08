NURCCG9U ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5165,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,5165,1,1,0)
 ;;=15572^[Extra Problem]^2^NURSC^43
 ;;^UTILITY("^GMRD(124.2,",$J,5165,1,2,0)
 ;;=15874^Impaired Physical Mobility^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5165,1,3,0)
 ;;=15885^Pain, Acute^2^NURSC^18
 ;;^UTILITY("^GMRD(124.2,",$J,5165,1,4,0)
 ;;=15893^Alteration in Self-Concept^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5166,0)
 ;;=Traumatic Brain Injury^2^NURSC^8^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5166,1,0)
 ;;=^124.21PI^7^5
 ;;^UTILITY("^GMRD(124.2,",$J,5166,1,2,0)
 ;;=5825^Mobility, Impaired Physical^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5166,1,3,0)
 ;;=51^Self-Care Deficit [Specify]^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5166,1,4,0)
 ;;=12488^Sensory-Perceptual, Alteration In^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5166,1,5,0)
 ;;=15845^Cognitive Impairment^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5166,1,7,0)
 ;;=15860^Thought Process, Alteration In^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5172,0)
 ;;=[Extra Goal]^3^NURSC^9^263^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5172,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5172,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5173,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^259^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5173,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,5173,1,1,0)
 ;;=5174^reposition at night^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5173,1,2,0)
 ;;=283^administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5173,1,3,0)
 ;;=4959^administer medications as ordered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5173,1,4,0)
 ;;=2751^assess usual sleep pattern^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5173,1,5,0)
 ;;=5182^assess,monitor,document snoring^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5173,1,6,0)
 ;;=5183^assess,monitor,document level of alertness q [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5173,1,7,0)
 ;;=5568^[Extra Order]^3^NURSC^24
 ;;^UTILITY("^GMRD(124.2,",$J,5173,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5173,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5174,0)
 ;;=reposition at night^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5174,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5174,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5175,0)
 ;;=Expectation of daily bowel movement^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5177,0)
 ;;=overuse of laxatives, enemas, suppositories^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5179,0)
 ;;=expected passage of stool at same time daily^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5182,0)
 ;;=assess,monitor,document snoring^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5182,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5182,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5183,0)
 ;;=assess,monitor,document level of alertness q [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5183,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5183,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5184,0)
 ;;=[Extra Order]^3^NURSC^11^41^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5184,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5184,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5185,0)
 ;;=Defining Characteristics^2^NURSC^12^62^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5185,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,5185,1,1,0)
 ;;=5190^oral pain/discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5185,1,2,0)
 ;;=5192^stomatitis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5185,1,3,0)
 ;;=5193^leukoplakia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5185,1,4,0)
 ;;=5195^oral lesions/ulcers^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5185,1,5,0)
 ;;=5196^hyperemia^3^NURSC^1
