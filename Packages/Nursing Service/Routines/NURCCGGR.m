NURCCGGR ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15734,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15734,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15734,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15735,0)
 ;;=Breathing Pattern, Ineffective^2^NURSC^2^15^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15735,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15735,1,1,0)
 ;;=15753^Etiology/Related and/or Risk Factors^2^NURSC^302
 ;;^UTILITY("^GMRD(124.2,",$J,15735,1,2,0)
 ;;=15754^Goals/Expected Outcomes^2^NURSC^316
 ;;^UTILITY("^GMRD(124.2,",$J,15735,1,3,0)
 ;;=15757^Nursing Intervention/Orders^2^NURSC^318
 ;;^UTILITY("^GMRD(124.2,",$J,15735,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15735,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15735,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15736,0)
 ;;=[Extra Problem]^2^NURSC^2^45^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15736,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15736,1,1,0)
 ;;=15758^Etiology/Related and/or Risk Factors^2^NURSC^303
 ;;^UTILITY("^GMRD(124.2,",$J,15736,1,2,0)
 ;;=15759^Goals/Expected Outcomes^2^NURSC^317
 ;;^UTILITY("^GMRD(124.2,",$J,15736,1,3,0)
 ;;=15760^Nursing Intervention/Orders^2^NURSC^319
 ;;^UTILITY("^GMRD(124.2,",$J,15736,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15736,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15736,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15737,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^301^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15737,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15737,1,1,0)
 ;;=305^infection, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15737,1,2,0)
 ;;=306^obstruction, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15737,1,3,0)
 ;;=307^secretions, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15737,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15741,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^315^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15741,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15741,1,1,0)
 ;;=2691^has improved breath sounds^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15741,1,2,0)
 ;;=313^has normal respiratory rate/breathing pattern^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15741,1,3,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15741,1,4,0)
 ;;=316^attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15741,1,5,0)
 ;;=15756^[Extra Goal]^3^NURSC^18
 ;;^UTILITY("^GMRD(124.2,",$J,15741,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15748,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^317^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15748,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,15748,1,1,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,15748,1,2,0)
 ;;=6404^vital signs q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,15748,1,3,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15748,1,4,0)
 ;;=15750^pulse oximetry q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15748,1,5,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15748,1,6,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15748,1,7,0)
 ;;=426^level of consciousness q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15748,1,8,0)
 ;;=15752^[Extra Order]^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,15748,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15748,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15750,0)
 ;;=pulse oximetry q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15750,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15750,10)
 ;;=D EN1^NURCCPU3
