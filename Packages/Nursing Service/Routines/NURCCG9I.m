NURCCG9I ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5002,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5002,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5005,0)
 ;;=review factors that aggravate or alleviate pain^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5005,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5005,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5006,0)
 ;;=Cancer of the Lung^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,5006,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,5006,1,1,0)
 ;;=4800^Airway Clearance, Ineffective^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,5006,1,2,0)
 ;;=4827^Breathing Pattern, Ineffective^2^NURSC^14
 ;;^UTILITY("^GMRD(124.2,",$J,5006,1,3,0)
 ;;=5024^Gas Exchange, Impaired^2^NURSC^14
 ;;^UTILITY("^GMRD(124.2,",$J,5006,1,4,0)
 ;;=5038^Pain, Chronic^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,5006,1,5,0)
 ;;=5086^Nutrition,Alteration in (less than required)^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5006,1,6,0)
 ;;=5116^[Extra Problem]^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,5007,0)
 ;;=implement measures to promote sleep [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5007,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5007,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5008,0)
 ;;=[Extra Order]^3^NURSC^11^33^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5008,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5008,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5009,0)
 ;;=promote/maintain a safe environment [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5009,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5009,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5010,0)
 ;;=[Extra Problem]^2^NURSC^2^8^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5010,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5010,1,1,0)
 ;;=5011^Etiology/Related and/or Risk Factors^2^NURSC^243
 ;;^UTILITY("^GMRD(124.2,",$J,5010,1,2,0)
 ;;=5022^Goals/Expected Outcomes^2^NURSC^248
 ;;^UTILITY("^GMRD(124.2,",$J,5010,1,3,0)
 ;;=5380^Nursing Intervention/Orders^2^NURSC^263
 ;;^UTILITY("^GMRD(124.2,",$J,5010,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5010,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5010,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5011,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^243^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5011,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5011,1,1,0)
 ;;=5017^[etiology]^3^NURSC^50
 ;;^UTILITY("^GMRD(124.2,",$J,5011,1,2,0)
 ;;=5019^[etiology]^3^NURSC^51
 ;;^UTILITY("^GMRD(124.2,",$J,5011,1,3,0)
 ;;=5082^[etiology]^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,5011,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5012,0)
 ;;=decrease in verbal behavior^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5012,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5012,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5013,0)
 ;;=redirect motor and verbal behavior [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5013,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5013,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5014,0)
 ;;=[etiology]^3^NURSC^^49^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5015,0)
 ;;=protect from overstimulation^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5015,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5015,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5016,0)
 ;;=[Extra Order]^3^NURSC^11^227^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5016,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5016,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5017,0)
 ;;=[etiology]^3^NURSC^^50^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5018,0)
 ;;=monitor nutritional intake and weigh q[specify] days^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5018,9)
 ;;=D EN2^NURCCPU2
