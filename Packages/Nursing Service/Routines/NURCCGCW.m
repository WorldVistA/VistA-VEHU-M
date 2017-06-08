NURCCGCW ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10705,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10705,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10706,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^121^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10706,1,0)
 ;;=^124.21PI^14^3
 ;;^UTILITY("^GMRD(124.2,",$J,10706,1,3,0)
 ;;=10709^instruct in use of assistive devices^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,10706,1,9,0)
 ;;=10715^instruct regarding correct body alignment^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,10706,1,14,0)
 ;;=11196^[Extra Order]^3^NURSC^184
 ;;^UTILITY("^GMRD(124.2,",$J,10706,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10706,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10709,0)
 ;;=instruct in use of assistive devices^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10709,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10709,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10715,0)
 ;;=instruct regarding correct body alignment^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10715,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10715,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10728,0)
 ;;=[Extra Order]^3^NURSC^11^179^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10728,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10728,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10729,0)
 ;;=Related Problems^2^NURSC^7^125^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10729,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,10729,1,1,0)
 ;;=819^skin integrity, impairment of^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10729,1,2,0)
 ;;=820^tissue perfusion, alteration in ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10729,1,3,0)
 ;;=821^gas exchange, impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10729,1,4,0)
 ;;=822^constipation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10729,1,5,0)
 ;;=823^injury, potential for^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10729,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,10729,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10735,0)
 ;;=Defining Characteristics^2^NURSC^12^124^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10735,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,10735,1,1,0)
 ;;=4337^decreased muscle strength,control and/or mass^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10735,1,2,0)
 ;;=4339^impaired coordination^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10735,1,3,0)
 ;;=4340^imposed restriction of movement including mechanical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10735,1,4,0)
 ;;=4341^limited range of motion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10735,1,5,0)
 ;;=1769^impaired physical mobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10735,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10741,0)
 ;;=[Extra Problem]^2^NURSC^2^24^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10741,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,10741,1,1,0)
 ;;=10742^Etiology/Related and/or Risk Factors^2^NURSC^270
 ;;^UTILITY("^GMRD(124.2,",$J,10741,1,2,0)
 ;;=10746^Goals/Expected Outcomes^2^NURSC^282
 ;;^UTILITY("^GMRD(124.2,",$J,10741,1,3,0)
 ;;=10750^Nursing Intervention/Orders^2^NURSC^286
 ;;^UTILITY("^GMRD(124.2,",$J,10741,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10741,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10741,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10742,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^270^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10742,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,10742,1,1,0)
 ;;=10744^[etiology]^3^NURSC^133
 ;;^UTILITY("^GMRD(124.2,",$J,10742,1,2,0)
 ;;=10745^[etiology]^3^NURSC^134
 ;;^UTILITY("^GMRD(124.2,",$J,10742,1,3,0)
 ;;=10900^[etiology]^3^NURSC^105
 ;;^UTILITY("^GMRD(124.2,",$J,10742,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10743,0)
 ;;=[etiology]^3^NURSC^^135^^^T
