NURCCGGT ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15764,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15764,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15765,0)
 ;;=[Extra Goal]^3^NURSC^9^414^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15765,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15765,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15766,0)
 ;;=[Extra Goal]^3^NURSC^9^415^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15766,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15766,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15767,0)
 ;;=[Extra Order]^3^NURSC^11^420^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15767,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15767,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15768,0)
 ;;=[Extra Order]^3^NURSC^11^421^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15768,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15768,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15769,0)
 ;;=[Extra Order]^3^NURSC^11^422^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15769,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15769,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15770,0)
 ;;=Generic Discharge Care Plan^2^NURSC^3^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15770,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,15770,1,1,0)
 ;;=15771^Discharge Planning (Health Maintenance, Alteration in)^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15770,1,2,0)
 ;;=15908^[Extra Problem]^2^NURSC^52
 ;;^UTILITY("^GMRD(124.2,",$J,15771,0)
 ;;=Discharge Planning (Health Maintenance, Alteration in)^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15771,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15771,1,1,0)
 ;;=15772^Etiology/Related and/or Risk Factors^2^NURSC^304
 ;;^UTILITY("^GMRD(124.2,",$J,15771,1,2,0)
 ;;=15773^Goals/Expected Outcomes^2^NURSC^318
 ;;^UTILITY("^GMRD(124.2,",$J,15771,1,3,0)
 ;;=15774^Nursing Intervention/Orders^2^NURSC^320
 ;;^UTILITY("^GMRD(124.2,",$J,15771,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15771,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15771,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^304^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,0)
 ;;=^124.21PI^21^21
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,1,0)
 ;;=4371^activity intolerance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,2,0)
 ;;=140^alteration in comfort related to pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,3,0)
 ;;=20^altered communication^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,4,0)
 ;;=15775^anxiety regarding health management^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,5,0)
 ;;=21^cognition impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,6,0)
 ;;=15776^alteration in family process^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,7,0)
 ;;=142^health beliefs (lack of perceived health threat)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,8,0)
 ;;=15777^homelessness/abandonement^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,9,0)
 ;;=143^inaccessibility to adequate health care services^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,10,0)
 ;;=15778^inadequate financial resources^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,11,0)
 ;;=1844^inadequate support systems^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,12,0)
 ;;=2850^infection potential^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,13,0)
 ;;=823^injury, potential for^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,14,0)
 ;;=645^knowledge deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,15,0)
 ;;=15781^mobility impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,16,0)
 ;;=15782^noncompliance with treatment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,17,0)
 ;;=15783^nutrition/fluid volume altered^3^NURSC^1
