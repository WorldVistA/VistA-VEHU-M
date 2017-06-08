NURCCG44 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1535,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1536,0)
 ;;=free from pain in extremities^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1536,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1536,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1537,0)
 ;;=normal response to stimuli^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1537,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1537,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1538,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^35^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,0)
 ;;=^124.21PI^25^25
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,1,0)
 ;;=1539^assess for presence/amt. of edema q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,2,0)
 ;;=1462^I&O q[frequency]^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,3,0)
 ;;=1474^lab data^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,4,0)
 ;;=1266^sensorium q[frequency]hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,5,0)
 ;;=1541^assess changes in body image^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,6,0)
 ;;=1542^assess self esteem^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,7,0)
 ;;=384^weight q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,8,0)
 ;;=1543^limit fluids to [amount]cc q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,9,0)
 ;;=1544^B/P in [ ] extremity q[ ]hrs.^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,10,0)
 ;;=1545^passive/active ROM q[frequency]hrs.^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,11,0)
 ;;=816^reposition/turn q[frequency]^3^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,12,0)
 ;;=1546^abdominal girth q[ ]hrs. and document^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,13,0)
 ;;=1547^elevate feet while sitting^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,14,0)
 ;;=1548^oral hygiene following meals, using soft brush^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,15,0)
 ;;=1549^nails cleaned and cut^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,16,0)
 ;;=1550^provide support to edematous areas^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,17,0)
 ;;=1553^provide K+ rich fluids and increased protein/calories^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,18,0)
 ;;=1554^restrict sodium intake to [specify]mg daily^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,19,0)
 ;;=1555^reassure weight/fluid will decrease with therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,20,0)
 ;;=1556^be accepting of patient's behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,21,0)
 ;;=1557^teach patient^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,22,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,23,0)
 ;;=321^TPR q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,24,0)
 ;;=322^B/P q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,1,25,0)
 ;;=2990^[Extra Order]^3^NURSC^75^0
 ;;^UTILITY("^GMRD(124.2,",$J,1538,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1538,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1539,0)
 ;;=assess for presence/amt. of edema q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1539,5)
 ;;=; monitor and record
 ;;^UTILITY("^GMRD(124.2,",$J,1539,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1539,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1540,0)
 ;;=Dixogin levels^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1541,0)
 ;;=assess changes in body image^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1541,5)
 ;;=; monitor and record
 ;;^UTILITY("^GMRD(124.2,",$J,1541,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1541,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1542,0)
 ;;=assess self esteem^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1542,5)
 ;;=; monitor and document
