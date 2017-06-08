NURCCG8S ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4669,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4670,0)
 ;;=wound edges approximated with no drainage^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4670,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4670,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4671,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^220^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4671,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4671,1,1,0)
 ;;=4673^assess,monitor,document incision q[frequency] for:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4671,1,2,0)
 ;;=1877^aseptic dressing change q [frequency]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4671,1,3,0)
 ;;=4682^[Extra Order]^3^NURSC^214
 ;;^UTILITY("^GMRD(124.2,",$J,4671,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4671,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4672,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^221^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4672,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4672,1,1,0)
 ;;=4675^promote patient participation in dietary planning^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4672,1,2,0)
 ;;=4679^resume/advance diet as indicated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4672,1,3,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4672,1,4,0)
 ;;=4699^[Extra Order]^3^NURSC^215
 ;;^UTILITY("^GMRD(124.2,",$J,4672,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4672,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4673,0)
 ;;=assess,monitor,document incision q[frequency] for:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4673,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,4673,1,1,0)
 ;;=4674^drainage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4673,1,2,0)
 ;;=4676^intact incision line^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4673,1,3,0)
 ;;=4144^redness and/or drainage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4673,1,5,0)
 ;;=1781^edema^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4673,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4673,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4673,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4674,0)
 ;;=drainage^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4675,0)
 ;;=promote patient participation in dietary planning^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4675,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4675,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4676,0)
 ;;=intact incision line^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4679,0)
 ;;=resume/advance diet as indicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4679,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4679,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4681,0)
 ;;=[Extra Order]^3^NURSC^11^213^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4681,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4681,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4682,0)
 ;;=[Extra Order]^3^NURSC^11^214^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4682,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4682,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4683,0)
 ;;=[Extra Problem]^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4683,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4683,1,1,0)
 ;;=4893^Etiology/Related and/or Risk Factors^2^NURSC^236
 ;;^UTILITY("^GMRD(124.2,",$J,4683,1,2,0)
 ;;=4903^Goals/Expected Outcomes^2^NURSC^242
 ;;^UTILITY("^GMRD(124.2,",$J,4683,1,3,0)
 ;;=4919^Nursing Intervention/Orders^2^NURSC^243
 ;;^UTILITY("^GMRD(124.2,",$J,4683,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4683,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4683,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4684,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^217^1^^T^1
