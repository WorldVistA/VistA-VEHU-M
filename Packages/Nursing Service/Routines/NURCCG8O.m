NURCCG8O ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4619,1,4,0)
 ;;=4627^urine output less than [specify] cc/hr^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4619,1,5,0)
 ;;=4628^gradual decrease in post-op weight [specify amt] over 3-4d^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4619,1,6,0)
 ;;=4632^[Extra Goal]^3^NURSC^29
 ;;^UTILITY("^GMRD(124.2,",$J,4619,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4620,0)
 ;;=[Extra Order]^3^NURSC^11^212^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4620,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4620,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4621,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^216^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4621,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4621,1,1,0)
 ;;=4629^maintains fluid/electrolyte balance:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4621,1,2,0)
 ;;=4638^[Extra Goal]^3^NURSC^212
 ;;^UTILITY("^GMRD(124.2,",$J,4621,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4622,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^216^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4622,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4622,1,1,0)
 ;;=4514^assess, monitor & record:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4622,1,2,0)
 ;;=335^mouth care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4622,1,3,0)
 ;;=4681^[Extra Order]^3^NURSC^213
 ;;^UTILITY("^GMRD(124.2,",$J,4622,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4622,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4626,0)
 ;;=[Extra Order]^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4626,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4626,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4627,0)
 ;;=urine output less than [specify] cc/hr^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4627,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4627,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4628,0)
 ;;=gradual decrease in post-op weight [specify amt] over 3-4d^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4628,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4628,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4629,0)
 ;;=maintains fluid/electrolyte balance:^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4629,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4629,1,1,0)
 ;;=1519^balanced I/O, urine ouput WNL^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4629,1,2,0)
 ;;=1585^moist mucous membranes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4629,1,3,0)
 ;;=1582^skin turgor normal^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4629,1,4,0)
 ;;=1586^urine and specific gravity WNL^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4629,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4629,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4629,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4630,0)
 ;;=Gas Exchange, Impaired^2^NURSC^2^11^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4630,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4630,1,1,0)
 ;;=4633^Etiology/Related and/or Risk Factors^2^NURSC^214
 ;;^UTILITY("^GMRD(124.2,",$J,4630,1,2,0)
 ;;=4637^Goals/Expected Outcomes^2^NURSC^217
 ;;^UTILITY("^GMRD(124.2,",$J,4630,1,3,0)
 ;;=4647^Nursing Intervention/Orders^2^NURSC^218
 ;;^UTILITY("^GMRD(124.2,",$J,4630,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4630,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4630,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4631,0)
 ;;=Nutrition, Altered^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4631,1,0)
 ;;=^124.21PI^6^3
 ;;^UTILITY("^GMRD(124.2,",$J,4631,1,1,0)
 ;;=4634^Etiology/Related and/or Risk Factors^2^NURSC^215
 ;;^UTILITY("^GMRD(124.2,",$J,4631,1,4,0)
 ;;=4643^Goals/Expected Outcomes^2^NURSC^218
 ;;^UTILITY("^GMRD(124.2,",$J,4631,1,6,0)
 ;;=4705^Nursing Intervention/Orders^2^NURSC^223
