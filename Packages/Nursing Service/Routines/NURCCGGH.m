NURCCGGH ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15549,0)
 ;;=no S/S of peritonitis (dialysis return clear, lt yellow)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15550,0)
 ;;=assess ability to speak, read, hear, write and understand^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15550,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15550,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15551,0)
 ;;=assess ability to comprehend simple commands^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15551,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15551,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15552,0)
 ;;=assess ability to comprehend complex ideas^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15552,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15552,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15553,0)
 ;;=speak slowly in a normal tone^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15553,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15553,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15554,0)
 ;;=techniques of massage^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15555,0)
 ;;=[Extra Order]^3^NURSC^11^262^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15555,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15555,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15556,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^297^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15556,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,15556,1,1,0)
 ;;=2785^surgical incision^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15556,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15557,0)
 ;;=[Extra Goal]^3^NURSC^9^258^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15557,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15557,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15558,0)
 ;;=optimal dry weight^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15558,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15558,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15559,0)
 ;;=maintain strict asepis during dialysis^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15559,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15559,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15560,0)
 ;;=medicate PRN for c/o itching^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15560,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15560,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15561,0)
 ;;=instruct patient to avoid scratching^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15561,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15561,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15562,0)
 ;;=dialysis an invasive therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15563,0)
 ;;=decreased WBC activity with uremia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15564,0)
 ;;=instruct patient in:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15564,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15564,1,1,0)
 ;;=15565^use of adaptive equipment: [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15564,1,2,0)
 ;;=498^pacing activities, exercise, rest^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15564,1,3,0)
 ;;=15566^use of analgesics^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15564,1,4,0)
 ;;=300^relaxation therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15564,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15564,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15564,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15565,0)
 ;;=use of adaptive equipment: [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15566,0)
 ;;=use of analgesics^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15567,0)
 ;;=newly diagnosed^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15568,0)
 ;;=change in therapy made^3^NURSC^^1^^^T
