NURCCG92 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4793,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4793,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4794,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^226^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4794,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4794,1,1,0)
 ;;=2785^surgical incision^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4794,1,2,0)
 ;;=1761^altered circulation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4794,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4795,0)
 ;;=Pneumonia/Pleurisy^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4795,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,4795,1,2,0)
 ;;=4800^Airway Clearance, Ineffective^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,4795,1,3,0)
 ;;=4827^Breathing Pattern, Ineffective^2^NURSC^14
 ;;^UTILITY("^GMRD(124.2,",$J,4795,1,4,0)
 ;;=4891^Gas Exchange, Impaired^2^NURSC^13
 ;;^UTILITY("^GMRD(124.2,",$J,4795,1,5,0)
 ;;=4928^Pain, Acute^2^NURSC^16
 ;;^UTILITY("^GMRD(124.2,",$J,4795,1,6,0)
 ;;=4976^[Extra Problem]^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,4796,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^231^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4796,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4796,1,1,0)
 ;;=4667^incision free of redness, edema, drainage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4796,1,2,0)
 ;;=4670^wound edges approximated with no drainage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4796,1,3,0)
 ;;=4815^[Extra Goal]^3^NURSC^218
 ;;^UTILITY("^GMRD(124.2,",$J,4796,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4797,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^227^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4797,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4797,1,1,0)
 ;;=305^infection, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4797,1,2,0)
 ;;=307^secretions, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4797,1,3,0)
 ;;=306^obstruction, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4797,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4798,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^232^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4798,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4798,1,1,0)
 ;;=1877^aseptic dressing change q [frequency]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4798,1,2,0)
 ;;=4438^monitor lab values^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4798,1,3,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4798,1,4,0)
 ;;=4673^assess,monitor,document incision q[frequency] for:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4798,1,5,0)
 ;;=4828^[Extra Order]^3^NURSC^220
 ;;^UTILITY("^GMRD(124.2,",$J,4798,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4798,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4799,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^228^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4799,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,4799,1,1,0)
 ;;=4614^hypovolemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4799,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4800,0)
 ;;=Airway Clearance, Ineffective^2^NURSC^2^8^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4800,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4800,1,1,0)
 ;;=4797^Etiology/Related and/or Risk Factors^2^NURSC^227
 ;;^UTILITY("^GMRD(124.2,",$J,4800,1,2,0)
 ;;=4805^Goals/Expected Outcomes^2^NURSC^234
 ;;^UTILITY("^GMRD(124.2,",$J,4800,1,3,0)
 ;;=4810^Nursing Intervention/Orders^2^NURSC^235
 ;;^UTILITY("^GMRD(124.2,",$J,4800,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4800,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4800,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4801,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^232^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4801,1,0)
 ;;=^124.21PI^3^3
