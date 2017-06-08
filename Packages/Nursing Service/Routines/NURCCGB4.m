NURCCGB4 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7449,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7449,1,1,0)
 ;;=1535^healthy skin color and turgor^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7449,1,2,0)
 ;;=1536^free from pain in extremities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7449,1,3,0)
 ;;=1537^normal response to stimuli^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7449,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,7449,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7449,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7449,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7453,0)
 ;;=[Extra Goal]^3^NURSC^9^136^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7453,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7453,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^88^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,0)
 ;;=^124.21PI^26^19
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,1,0)
 ;;=1539^assess for presence/amt. of edema q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,2,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,3,0)
 ;;=7457^lab data^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,4,0)
 ;;=1266^sensorium q[frequency]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,7,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,8,0)
 ;;=1543^limit fluids to [amount]cc q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,9,0)
 ;;=1544^B/P in [ ] extremity q[ ]hrs.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,10,0)
 ;;=287^passive/active ROM q[frequency]hrs.^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,11,0)
 ;;=429^reposition/turn q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,13,0)
 ;;=1547^elevate feet while sitting^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,14,0)
 ;;=1548^oral hygiene following meals, using soft brush^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,15,0)
 ;;=1549^nails cleaned and cut^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,18,0)
 ;;=1554^restrict sodium intake to [specify]mg daily^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,19,0)
 ;;=1555^reassure weight/fluid will decrease with therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,21,0)
 ;;=7486^teach patient^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,22,0)
 ;;=7496^refer for appropriate consults^2^NURSC^19
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,23,0)
 ;;=321^TPR q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,25,0)
 ;;=7507^[Extra Order]^3^NURSC^139
 ;;^UTILITY("^GMRD(124.2,",$J,7454,1,26,0)
 ;;=15531^review hx for evidence of non-compliance with treatment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7454,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7457,0)
 ;;=lab data^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7457,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,7457,1,1,0)
 ;;=1475^increased specific gravity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7457,1,2,0)
 ;;=1476^significant proteinuria^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7457,1,3,0)
 ;;=1477^granular casts^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7457,1,4,0)
 ;;=1478^elevated BUN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7457,1,5,0)
 ;;=1479^serum levels of K+, Na+, and CO2^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7457,1,6,0)
 ;;=1480^elevated MCV^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7457,1,7,0)
 ;;=1481^low hemoglobin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7457,1,8,0)
 ;;=1482^low hematocrit^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7457,1,9,0)
 ;;=1540^Dixogin levels^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7457,5)
 ;;=; assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,7457,7)
 ;;=D EN4^NURCCPU1
