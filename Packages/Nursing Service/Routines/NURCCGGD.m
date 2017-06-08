NURCCGGD ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15439,1,1,0)
 ;;=15440^maintain stable hemodynamics^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,15439,1,3,0)
 ;;=1458^myocardial oxygen demand is minimized^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15439,1,6,0)
 ;;=15626^[Extra Goal]^3^NURSC^260
 ;;^UTILITY("^GMRD(124.2,",$J,15439,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15440,0)
 ;;=maintain stable hemodynamics^2^NURSC^9^4^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15440,1,0)
 ;;=^124.21PI^9^8
 ;;^UTILITY("^GMRD(124.2,",$J,15440,1,1,0)
 ;;=4380^Cardiac Index (CI) [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15440,1,2,0)
 ;;=4382^Cardiac Output (CO) [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15440,1,3,0)
 ;;=4383^SVR (systemic vascular resistance) [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15440,1,4,0)
 ;;=4384^PAWP pulmonary artery wedge pressure [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15440,1,6,0)
 ;;=4386^BP [specify systolic/diastolic HIGH] to [specify LOW]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15440,1,7,0)
 ;;=4387^pulse [specify range] ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15440,1,8,0)
 ;;=4388^respirations [specify range]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,15440,1,9,0)
 ;;=4436^temperature per[route] q[ frequency ]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,15440,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15440,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15440,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15457,0)
 ;;=[Extra Goal]^3^NURSC^9^257^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15457,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15457,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15459,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^310^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15459,1,0)
 ;;=^124.21PI^16^5
 ;;^UTILITY("^GMRD(124.2,",$J,15459,1,1,0)
 ;;=15460^assess,monitor,document hemodynamics of:^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,15459,1,10,0)
 ;;=15600^[Extra Order]^3^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,15459,1,13,0)
 ;;=5021^assess for S/S of weakness or fatigue q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15459,1,15,0)
 ;;=4433^assess assistance needed with ADL q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15459,1,16,0)
 ;;=1610^initiate febrile protocol^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15459,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15459,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15460,0)
 ;;=assess,monitor,document hemodynamics of:^2^NURSC^11^5^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15460,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,15460,1,1,0)
 ;;=4382^Cardiac Output (CO) [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15460,1,2,0)
 ;;=4380^Cardiac Index (CI) [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15460,1,3,0)
 ;;=4412^systemic vascular resistance [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15460,1,4,0)
 ;;=4384^PAWP pulmonary artery wedge pressure [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15460,1,5,0)
 ;;=4386^BP [specify systolic/diastolic HIGH] to [specify LOW]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15460,1,6,0)
 ;;=4387^pulse [specify range] ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15460,1,7,0)
 ;;=4388^respirations [specify range]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,15460,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15460,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15460,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15482,0)
 ;;=[Extra Order]^3^NURSC^11^128^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15482,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15482,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15487,0)
 ;;=compromised respiratory mechanism^3^NURSC^^1^^^T
