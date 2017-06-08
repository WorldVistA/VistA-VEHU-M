NURCCG8Q ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4644,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4644,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4646,0)
 ;;=fluid restriction [specify amt]cc q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4646,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4646,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4647,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^218^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4647,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4647,1,1,0)
 ;;=4465^position for comfort,mobilize secretions,ventilation q[freq]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4647,1,2,0)
 ;;=283^administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4647,1,3,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4647,1,4,0)
 ;;=4650^activity: chair q[frequency] or ambulate q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4647,1,5,0)
 ;;=4817^[Extra Order]^3^NURSC^19
 ;;^UTILITY("^GMRD(124.2,",$J,4647,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4647,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4648,0)
 ;;=maintains caloric intake of [calories] day^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4648,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4648,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4649,0)
 ;;=[Extra Order]^3^NURSC^11^12^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4649,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4649,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4650,0)
 ;;=activity: chair q[frequency] or ambulate q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4650,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4650,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4651,0)
 ;;=[Extra Order]^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4651,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4651,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4652,0)
 ;;=[Extra Problem]^2^NURSC^2^10^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4652,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4652,1,1,0)
 ;;=4654^Goals/Expected Outcomes^2^NURSC^219
 ;;^UTILITY("^GMRD(124.2,",$J,4652,1,2,0)
 ;;=4661^Nursing Intervention/Orders^2^NURSC^219
 ;;^UTILITY("^GMRD(124.2,",$J,4652,1,3,0)
 ;;=4966^Etiology/Related and/or Risk Factors^2^NURSC^241
 ;;^UTILITY("^GMRD(124.2,",$J,4652,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4652,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4652,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4653,0)
 ;;=Nutrition, Alteration in:(Less Than Required)^2^NURSC^2^9^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4653,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4653,1,1,0)
 ;;=4660^Goals/Expected Outcomes^2^NURSC^220
 ;;^UTILITY("^GMRD(124.2,",$J,4653,1,2,0)
 ;;=4672^Nursing Intervention/Orders^2^NURSC^221
 ;;^UTILITY("^GMRD(124.2,",$J,4653,1,3,0)
 ;;=2543^Etiology/Related and/or Risk Factors^2^NURSC^68
 ;;^UTILITY("^GMRD(124.2,",$J,4653,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4653,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4653,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4654,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^219^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4654,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4654,1,1,0)
 ;;=4656^[Extra Goal]^3^NURSC^275
 ;;^UTILITY("^GMRD(124.2,",$J,4654,1,2,0)
 ;;=4657^[Extra Goal]^3^NURSC^276
 ;;^UTILITY("^GMRD(124.2,",$J,4654,1,3,0)
 ;;=4658^[Extra Goal]^3^NURSC^277
 ;;^UTILITY("^GMRD(124.2,",$J,4654,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4655,0)
 ;;=Skin Integrity, Impaired ^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4655,1,0)
 ;;=^124.21PI^3^3
