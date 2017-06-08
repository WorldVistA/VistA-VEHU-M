NURCCGGL ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15622,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15622,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15623,0)
 ;;=demonstrates safe use of adaptive equipment [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15623,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15623,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15625,0)
 ;;=develops effective program for bowel/bladder management^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15625,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15625,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15626,0)
 ;;=[Extra Goal]^3^NURSC^9^260^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15626,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15626,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15627,0)
 ;;=teach techniques of ADL care to patient/significant other(s)^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15627,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15627,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15629,0)
 ;;=evaluate effectiveness of bowel/bladder managment program^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15629,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15629,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15630,0)
 ;;=[Extra Order]^3^NURSC^11^263^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15630,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15630,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15632,0)
 ;;=Dysreflexia, Potential For^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15632,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15632,1,1,0)
 ;;=15633^Etiology/Related and/or Risk Factors^2^NURSC^299
 ;;^UTILITY("^GMRD(124.2,",$J,15632,1,2,0)
 ;;=15634^Goals/Expected Outcomes^2^NURSC^312
 ;;^UTILITY("^GMRD(124.2,",$J,15632,1,3,0)
 ;;=15635^Nursing Intervention/Orders^2^NURSC^314
 ;;^UTILITY("^GMRD(124.2,",$J,15632,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15632,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15632,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15633,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^299^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15633,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,15633,1,1,0)
 ;;=15636^spinal cord injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15633,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15634,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^312^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15634,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15634,1,1,0)
 ;;=15637^will not experience dysreflexia as evidenced by normal VS^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15634,1,2,0)
 ;;=15638^verbalizes signs/symptoms of dysreflexia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15634,1,3,0)
 ;;=15639^avoids complications of dysreflexia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15634,1,4,0)
 ;;=15640^[Extra Goal]^3^NURSC^261
 ;;^UTILITY("^GMRD(124.2,",$J,15634,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15635,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^314^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15635,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15635,1,1,0)
 ;;=15641^teach signs and symptoms of dysreflexia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15635,1,2,0)
 ;;=6404^vital signs q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,15635,1,3,0)
 ;;=15643^avoid bowel/bladder distention^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15635,1,4,0)
 ;;=15644^implement interventions for dysreflexia:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15635,1,5,0)
 ;;=15670^[Extra Order]^3^NURSC^267
 ;;^UTILITY("^GMRD(124.2,",$J,15635,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15635,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15636,0)
 ;;=spinal cord injury^3^NURSC^^1^^^T
