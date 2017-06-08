NURCCG8M ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4592,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,4592,1,1,0)
 ;;=4594^Etiology/Related and/or Risk Factors^2^NURSC^212
 ;;^UTILITY("^GMRD(124.2,",$J,4592,1,3,0)
 ;;=4600^Goals/Expected Outcomes^2^NURSC^214
 ;;^UTILITY("^GMRD(124.2,",$J,4592,1,4,0)
 ;;=4611^Nursing Intervention/Orders^2^NURSC^215
 ;;^UTILITY("^GMRD(124.2,",$J,4592,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4592,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4592,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4594,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^212^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4594,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,4594,1,1,0)
 ;;=4595^increased intracranial pressure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4594,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4595,0)
 ;;=increased intracranial pressure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4597,0)
 ;;=[Extra Goal]^3^NURSC^9^211^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4597,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4597,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4598,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^213^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4598,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4598,1,1,0)
 ;;=4462^maintain fluid/electrolyte balance WNL for pt ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4598,1,2,0)
 ;;=4644^[Extra Goal]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4598,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4599,0)
 ;;=teach pain control interventions^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4599,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,4599,1,1,0)
 ;;=4601^breathing exercises^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4599,1,2,0)
 ;;=4602^distraction techniques^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4599,1,3,0)
 ;;=4605^positioning techniques^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4599,1,4,0)
 ;;=4606^purpose/use of analgesics^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4599,1,5,0)
 ;;=4608^use of imagery^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4599,1,6,0)
 ;;=4973^splinting^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4599,1,7,0)
 ;;=300^relaxation therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4599,1,8,0)
 ;;=15554^techniques of massage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4599,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4599,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4599,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4600,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^214^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4600,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4600,1,1,0)
 ;;=1059^verbalizes level of comfort/pain^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4600,1,2,0)
 ;;=4691^[Extra Goal]^3^NURSC^15
 ;;^UTILITY("^GMRD(124.2,",$J,4600,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4601,0)
 ;;=breathing exercises^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4602,0)
 ;;=distraction techniques^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4603,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^214^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4603,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,4603,1,1,0)
 ;;=4560^assess,monitor lab values: lytes, BUN, creatinine^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4603,1,2,0)
 ;;=1539^assess for presence/amt. of edema q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4603,1,3,0)
 ;;=1543^limit fluids to [amount]cc q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4603,1,4,0)
 ;;=1554^restrict sodium intake to [specify]mg daily^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4603,1,5,0)
 ;;=4477^assess level of consciousness q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4603,1,6,0)
 ;;=4443^assess weight q[frequency]^3^NURSC^1
