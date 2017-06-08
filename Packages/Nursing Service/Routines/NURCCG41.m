NURCCG41 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1496,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^38^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1496,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,1496,1,1,0)
 ;;=477^chronic disease^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1496,1,2,0)
 ;;=478^immunosuppression^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1496,1,3,0)
 ;;=537^inadequate primary defenses:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1496,1,4,0)
 ;;=479^inadequate acquired immunity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1496,1,5,0)
 ;;=544^inadequate secondary defenses:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1496,1,6,0)
 ;;=482^malnutrition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1496,1,7,0)
 ;;=483^medical procedures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1496,1,8,0)
 ;;=484^pharmaceutical agents^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1496,1,9,0)
 ;;=485^tissue destruction and increased environmental exposure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1496,1,10,0)
 ;;=309^trauma^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1496,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1497,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^37^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1497,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1497,1,1,0)
 ;;=1504^absence of inflammation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1497,1,2,0)
 ;;=1505^absence of purulent drainage^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1497,1,3,0)
 ;;=1506^absence of tenderness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1497,1,4,0)
 ;;=1507^return of skin integrity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1497,1,5,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1497,1,6,0)
 ;;=2687^maintains intact skin^3^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,1497,1,7,0)
 ;;=2902^[Extra Goal]^3^NURSC^81^0
 ;;^UTILITY("^GMRD(124.2,",$J,1497,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1498,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^34^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1498,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1498,1,1,0)
 ;;=1676^inspect skin/mucous membranes q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1498,1,2,0)
 ;;=556^temperature per[route] q[ frequency ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1498,1,3,0)
 ;;=1679^provide skin care q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1498,1,4,0)
 ;;=335^mouth care q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1498,1,5,0)
 ;;=336^provide adequate hydration and nutrition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1498,1,6,0)
 ;;=1682^provide patient teaching^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1498,1,7,0)
 ;;=2989^[Extra Order]^3^NURSC^74^0
 ;;^UTILITY("^GMRD(124.2,",$J,1498,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1498,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1499,0)
 ;;=Related Problems^2^NURSC^7^28^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1499,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1499,1,1,0)
 ;;=1775^Knowledge Deficit (Specify)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1499,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1500,0)
 ;;=arterial/venous dilators [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1501,0)
 ;;=titrate drugs to therapeutic response and document^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1501,5)
 ;;=; notify MD
 ;;^UTILITY("^GMRD(124.2,",$J,1501,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1501,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1502,0)
 ;;=reassure patient/SO; explain procedure/therapy^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1502,5)
 ;;=and its purpose
 ;;^UTILITY("^GMRD(124.2,",$J,1502,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1502,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1503,0)
 ;;=maintains temperature within normal limits [degrees]^3^NURSC^9^1^^^T
