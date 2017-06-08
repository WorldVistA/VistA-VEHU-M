NURCCG9K ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5030,1,2,0)
 ;;=5032^Goals/Expected Outcomes^2^NURSC^250
 ;;^UTILITY("^GMRD(124.2,",$J,5030,1,3,0)
 ;;=5039^Nursing Intervention/Orders^2^NURSC^251
 ;;^UTILITY("^GMRD(124.2,",$J,5030,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5030,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5030,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5031,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^245^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5031,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5031,1,1,0)
 ;;=1050^myocardial ischemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5031,1,2,0)
 ;;=419^anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5031,1,3,0)
 ;;=2009^threat of death^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5031,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5032,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^250^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5032,1,0)
 ;;=^124.21PI^7^6
 ;;^UTILITY("^GMRD(124.2,",$J,5032,1,1,0)
 ;;=4362^verbalizes pain level, [specify #] on a scale of 1-10 q[]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5032,1,3,0)
 ;;=2790^free of objective signs of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5032,1,4,0)
 ;;=2792^identifies appropriate pain relief measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5032,1,5,0)
 ;;=1059^verbalizes level of comfort/pain^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5032,1,6,0)
 ;;=2025^reports decrease in signs/symptoms of anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5032,1,7,0)
 ;;=5375^[Extra Goal]^3^NURSC^12
 ;;^UTILITY("^GMRD(124.2,",$J,5032,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5033,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^250^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,5033,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,5033,1,1,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5033,1,2,0)
 ;;=283^administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5033,1,3,0)
 ;;=4465^position for comfort,mobilize secretions,ventilation q[freq]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5033,1,4,0)
 ;;=4477^assess level of consciousness q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5033,1,5,0)
 ;;=4428^assess,monitor,document V/S^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5033,1,6,0)
 ;;=5064^[Extra Order]^3^NURSC^35
 ;;^UTILITY("^GMRD(124.2,",$J,5033,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5033,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5035,0)
 ;;=[Extra Order]^3^NURSC^11^34^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5035,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5035,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5036,0)
 ;;=[Extra Goal]^3^NURSC^9^38^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5036,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5036,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5037,0)
 ;;=[Extra Goal]^3^NURSC^9^8^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5037,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5037,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5038,0)
 ;;=Pain, Chronic^2^NURSC^2^6^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,5038,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5038,1,1,0)
 ;;=5040^Etiology/Related and/or Risk Factors^2^NURSC^246
 ;;^UTILITY("^GMRD(124.2,",$J,5038,1,2,0)
 ;;=5044^Goals/Expected Outcomes^2^NURSC^251
 ;;^UTILITY("^GMRD(124.2,",$J,5038,1,3,0)
 ;;=5047^Nursing Intervention/Orders^2^NURSC^252
 ;;^UTILITY("^GMRD(124.2,",$J,5038,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5038,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5038,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5039,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^251^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5039,1,0)
 ;;=^124.21PI^11^9
