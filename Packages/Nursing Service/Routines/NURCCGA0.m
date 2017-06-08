NURCCGA0 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5399,1,1,0)
 ;;=4999^decrease in motor behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5399,1,2,0)
 ;;=5012^decrease in verbal behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5399,1,3,0)
 ;;=5001^demonstrates ability to complete a structured activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5399,1,4,0)
 ;;=5002^develops plan to manage mood changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5399,1,5,0)
 ;;=5000^maintains/attains usual body weight^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5399,1,6,0)
 ;;=4998^reports/demonstrates return to usual sleep pattern^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5399,1,7,0)
 ;;=5564^[Extra Goal]^3^NURSC^225
 ;;^UTILITY("^GMRD(124.2,",$J,5399,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5401,0)
 ;;=triceps skinfold greater than 15mm in male^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5431,0)
 ;;=sedentary activity level^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5457,0)
 ;;=monitor post void residuals^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5457,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5457,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5534,0)
 ;;=eating in response to cues other than hunger^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5548,0)
 ;;=teach measures to promote bladder emptying^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5548,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5548,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5563,0)
 ;;=implement measures to maintain continence^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5563,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5563,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5564,0)
 ;;=[Extra Goal]^3^NURSC^9^225^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5564,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5564,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5565,0)
 ;;=assess for S/S of self concept disturbance^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5565,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5565,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5566,0)
 ;;=Defining Characteristics^2^NURSC^12^69^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5566,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,5566,1,1,0)
 ;;=5569^inability to maintain usual routines^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5566,1,2,0)
 ;;=5571^verbalization of overwhelming lack of energy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5566,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5567,0)
 ;;=implement measures to improve patient self esteem^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5567,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5567,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5568,0)
 ;;=[Extra Order]^3^NURSC^11^24^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5568,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5568,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5569,0)
 ;;=inability to maintain usual routines^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5570,0)
 ;;=Infection Potential^2^NURSC^2^12^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5570,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,5570,1,1,0)
 ;;=5573^Goals/Expected Outcomes^2^NURSC^263
 ;;^UTILITY("^GMRD(124.2,",$J,5570,1,2,0)
 ;;=5597^Nursing Intervention/Orders^2^NURSC^265
 ;;^UTILITY("^GMRD(124.2,",$J,5570,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5570,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5570,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5571,0)
 ;;=verbalization of overwhelming lack of energy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5573,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^263^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5573,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,5573,1,1,0)
 ;;=5575^infection free^3^NURSC^1
