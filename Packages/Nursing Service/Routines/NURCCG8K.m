NURCCG8K ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4568,1,3,0)
 ;;=4636^Nursing Intervention/Orders^2^NURSC^217
 ;;^UTILITY("^GMRD(124.2,",$J,4568,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4568,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4568,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4569,0)
 ;;=[Extra Order]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4569,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4569,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4570,0)
 ;;=Pancreatitis^2^NURSC^8^2^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4570,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4570,1,1,0)
 ;;=4575^Pain, Acute^2^NURSC^13
 ;;^UTILITY("^GMRD(124.2,",$J,4570,1,2,0)
 ;;=4615^Fluid Volume Deficit^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4570,1,3,0)
 ;;=4379^Nutrition, Alteration in:(Less Than Required) ^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4570,1,4,0)
 ;;=4653^Nutrition, Alteration in:(Less Than Required)^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4570,1,5,0)
 ;;=4683^[Extra Problem]^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4573,0)
 ;;=Breathing Pattern, Ineffective^2^NURSC^2^13^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4573,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4573,1,1,0)
 ;;=4684^Etiology/Related and/or Risk Factors^2^NURSC^217
 ;;^UTILITY("^GMRD(124.2,",$J,4573,1,2,0)
 ;;=4687^Goals/Expected Outcomes^2^NURSC^222
 ;;^UTILITY("^GMRD(124.2,",$J,4573,1,3,0)
 ;;=4693^Nursing Intervention/Orders^2^NURSC^222
 ;;^UTILITY("^GMRD(124.2,",$J,4573,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4573,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4573,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4574,0)
 ;;=Fluid Volume, Excess^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4574,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,4574,1,1,0)
 ;;=4576^Etiology/Related and/or Risk Factors^2^NURSC^211
 ;;^UTILITY("^GMRD(124.2,",$J,4574,1,3,0)
 ;;=4598^Goals/Expected Outcomes^2^NURSC^213
 ;;^UTILITY("^GMRD(124.2,",$J,4574,1,4,0)
 ;;=4603^Nursing Intervention/Orders^2^NURSC^214
 ;;^UTILITY("^GMRD(124.2,",$J,4574,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4574,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4574,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4575,0)
 ;;=Pain, Acute^2^NURSC^2^13^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4575,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4575,1,1,0)
 ;;=4579^Goals/Expected Outcomes^2^NURSC^211
 ;;^UTILITY("^GMRD(124.2,",$J,4575,1,2,0)
 ;;=4583^Nursing Intervention/Orders^2^NURSC^212
 ;;^UTILITY("^GMRD(124.2,",$J,4575,1,3,0)
 ;;=2763^Etiology/Related and/or Risk Factors^2^NURSC^40
 ;;^UTILITY("^GMRD(124.2,",$J,4575,1,4,0)
 ;;=4205^Defining Characteristics^2^NURSC^31
 ;;^UTILITY("^GMRD(124.2,",$J,4575,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4575,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4575,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4576,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^211^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4576,1,0)
 ;;=^124.21PI^5^3
 ;;^UTILITY("^GMRD(124.2,",$J,4576,1,3,0)
 ;;=1510^excess fluid intake^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4576,1,4,0)
 ;;=1511^excess sodium intake^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4576,1,5,0)
 ;;=1509^compromised regulatory mechanism^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4576,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4578,0)
 ;;=Cardiac Output, Decreased (Electrical/Mechanical)^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4578,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4578,1,1,0)
 ;;=4703^Etiology/Related and/or Risk Factors^2^NURSC^219
 ;;^UTILITY("^GMRD(124.2,",$J,4578,1,2,0)
 ;;=4706^Goals/Expected Outcomes^2^NURSC^224
 ;;^UTILITY("^GMRD(124.2,",$J,4578,1,3,0)
 ;;=4714^Nursing Intervention/Orders^2^NURSC^224
