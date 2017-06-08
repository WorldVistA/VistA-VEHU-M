NURCCGES ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13766,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^182^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13766,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,13766,1,1,0)
 ;;=13768^infection free:^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,13766,1,2,0)
 ;;=1260^establishes or re-establishes control over micturition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13766,1,3,0)
 ;;=13772^temperature=[specify]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,13766,1,4,0)
 ;;=13775^demonstrates practice to prevent reoccurrence^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,13766,1,5,0)
 ;;=5364^verbalizes decrease in frequency, pain, urgency, nocturia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13766,1,6,0)
 ;;=14092^[Extra Goal]^3^NURSC^241
 ;;^UTILITY("^GMRD(124.2,",$J,13766,1,7,0)
 ;;=5577^verbalizes S/S of urinary tract infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13766,1,8,0)
 ;;=15323^verbalizes understanding of medication regime^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13766,1,9,0)
 ;;=5584^demonstrates absence of foul smelling urine^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13766,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13768,0)
 ;;=infection free:^2^NURSC^9^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13768,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13768,1,1,0)
 ;;=15320^per urine analysis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13768,1,2,0)
 ;;=15321^per urine culture^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13768,1,3,0)
 ;;=15322^per clinical signs/symptoms [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13768,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13768,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13768,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13772,0)
 ;;=temperature=[specify]^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13772,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13772,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13775,0)
 ;;=demonstrates practice to prevent reoccurrence^2^NURSC^9^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13775,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,13775,1,1,0)
 ;;=13777^correct catheterization technique^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,13775,1,2,0)
 ;;=13780^daily fluid intake of [specify]cc^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,13775,1,3,0)
 ;;=15314^regular voiding schedule^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13775,1,4,0)
 ;;=2861^perineal hygiene^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13775,1,5,0)
 ;;=15318^G.U. follow-up^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13775,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13775,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13775,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13777,0)
 ;;=correct catheterization technique^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13780,0)
 ;;=daily fluid intake of [specify]cc^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13781,0)
 ;;=[Extra Order]^3^NURSC^11^243^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13781,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13781,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13783,0)
 ;;=[Extra Goal]^3^NURSC^9^238^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13783,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13783,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13785,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^153^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,0)
 ;;=^124.21PI^19^18
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,1,0)
 ;;=6404^vital signs q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,2,0)
 ;;=1147^maintain fluid intake of [ ]cc q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,3,0)
 ;;=1274^record time between voidings^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,5,0)
 ;;=13806^assess for bladder emptying^3^NURSC^2
