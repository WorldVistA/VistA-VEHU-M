NURCCG8N ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4603,1,7,0)
 ;;=4465^position for comfort,mobilize secretions,ventilation q[freq]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4603,1,8,0)
 ;;=4765^[Extra Order]^3^NURSC^13
 ;;^UTILITY("^GMRD(124.2,",$J,4603,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4603,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4605,0)
 ;;=positioning techniques^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4606,0)
 ;;=purpose/use of analgesics^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4607,0)
 ;;=[Extra Goal]^3^NURSC^9^13^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4607,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4607,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4608,0)
 ;;=use of imagery^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4609,0)
 ;;=[Extra Order]^3^NURSC^11^211^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4609,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4609,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4610,0)
 ;;=[Extra Order]^3^NURSC^11^11^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4610,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4610,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4611,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^215^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4611,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4611,1,1,0)
 ;;=392^administer pain medication as needed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4611,1,2,0)
 ;;=4617^minimize enviromental activity and noise^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4611,1,3,0)
 ;;=4620^[Extra Order]^3^NURSC^212
 ;;^UTILITY("^GMRD(124.2,",$J,4611,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4611,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4612,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^213^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4612,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4612,1,1,0)
 ;;=4613^blood/fluid loss in the operating room^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4612,1,2,0)
 ;;=4614^hypovolemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4612,1,3,0)
 ;;=4616^hypervolemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4612,1,4,0)
 ;;=4618^decreased cardiac output^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4612,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4613,0)
 ;;=blood/fluid loss in the operating room^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4614,0)
 ;;=hypovolemia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4615,0)
 ;;=Fluid Volume Deficit^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4615,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4615,1,1,0)
 ;;=4621^Goals/Expected Outcomes^2^NURSC^216
 ;;^UTILITY("^GMRD(124.2,",$J,4615,1,2,0)
 ;;=4622^Nursing Intervention/Orders^2^NURSC^216
 ;;^UTILITY("^GMRD(124.2,",$J,4615,1,3,0)
 ;;=1568^Etiology/Related and/or Risk Factors^2^NURSC^41
 ;;^UTILITY("^GMRD(124.2,",$J,4615,1,4,0)
 ;;=4066^Defining Characteristics^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,4615,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4615,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4615,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4616,0)
 ;;=hypervolemia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4617,0)
 ;;=minimize enviromental activity and noise^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4617,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4617,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4618,0)
 ;;=decreased cardiac output^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4619,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^215^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4619,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,4619,1,2,0)
 ;;=4462^maintain fluid/electrolyte balance WNL for pt ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4619,1,3,0)
 ;;=4392^maintain fluid/electrolytes WNL for patient^2^NURSC^1
