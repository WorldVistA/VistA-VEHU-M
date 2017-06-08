NURCCG8E ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4460,1,4,0)
 ;;=4465^position for comfort,mobilize secretions,ventilation q[freq]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4460,1,5,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4460,1,6,0)
 ;;=4468^[Extra Order]^3^NURSC^209
 ;;^UTILITY("^GMRD(124.2,",$J,4460,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4460,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4461,0)
 ;;=cough and deep breath q[]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4461,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4461,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4462,0)
 ;;=maintain fluid/electrolyte balance WNL for pt ^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4462,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4462,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4462,"TD",0)
 ;;=^^1^1^2910820^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,4462,"TD",1,0)
 ;;= 
 ;;^UTILITY("^GMRD(124.2,",$J,4464,0)
 ;;=maintains nutritional intake to meet metabolic requirements^2^NURSC^9^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4464,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4464,1,1,0)
 ;;=2558^absence of negative nitrogen balance indicators^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4464,1,2,0)
 ;;=4467^stable weight^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4464,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4464,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4464,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4465,0)
 ;;=position for comfort,mobilize secretions,ventilation q[freq]^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4465,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4465,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4467,0)
 ;;=stable weight^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4468,0)
 ;;=[Extra Order]^3^NURSC^11^209^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4468,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4468,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4469,0)
 ;;=[Extra Goal]^3^NURSC^9^208^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4469,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4469,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4470,0)
 ;;=Gas Exchange, Impaired^2^NURSC^2^9^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4470,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,4470,1,1,0)
 ;;=4472^Etiology/Related and/or Risk Factors^2^NURSC^207
 ;;^UTILITY("^GMRD(124.2,",$J,4470,1,3,0)
 ;;=4475^Goals/Expected Outcomes^2^NURSC^207
 ;;^UTILITY("^GMRD(124.2,",$J,4470,1,4,0)
 ;;=4476^Nursing Intervention/Orders^2^NURSC^207
 ;;^UTILITY("^GMRD(124.2,",$J,4470,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4470,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4470,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4472,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^207^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4472,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4472,1,1,0)
 ;;=4473^Blood flow altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4472,1,2,0)
 ;;=2696^ventilation, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4472,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4473,0)
 ;;=Blood flow altered^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4475,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^207^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4475,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4475,1,1,0)
 ;;=4376^maintain stable hemodynamics^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4475,1,2,0)
 ;;=4607^[Extra Goal]^3^NURSC^13
 ;;^UTILITY("^GMRD(124.2,",$J,4475,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4476,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^207^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4476,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4476,1,1,0)
 ;;=4477^assess level of consciousness q[frequency]^3^NURSC^3
