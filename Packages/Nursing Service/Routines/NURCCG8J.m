NURCCG8J ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4551,0)
 ;;=[Extra Goal]^3^NURSC^9^273^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4551,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4551,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4552,0)
 ;;=[Extra Goal]^3^NURSC^9^274^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4552,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4552,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4553,0)
 ;;=[Extra Order]^3^NURSC^11^279^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4553,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4553,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4555,0)
 ;;=[Extra Order]^3^NURSC^11^280^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4555,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4555,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4556,0)
 ;;=[Extra Order]^3^NURSC^11^281^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4556,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4556,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4557,0)
 ;;=stable B/P^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4558,0)
 ;;=Cardiac Surgery^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4558,1,0)
 ;;=^124.21PI^10^7
 ;;^UTILITY("^GMRD(124.2,",$J,4558,1,4,0)
 ;;=4566^Pain, Acute^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4558,1,5,0)
 ;;=4568^Fluid Volume (Deficit/Excess)^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4558,1,6,0)
 ;;=4573^Breathing Pattern, Ineffective^2^NURSC^13
 ;;^UTILITY("^GMRD(124.2,",$J,4558,1,7,0)
 ;;=4578^Cardiac Output, Decreased (Electrical/Mechanical)^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4558,1,8,0)
 ;;=4580^Gas Exchange, Impaired^2^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,4558,1,9,0)
 ;;=4655^Skin Integrity, Impaired ^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4558,1,10,0)
 ;;=4738^[Extra Problem]^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,4560,0)
 ;;=assess,monitor lab values: lytes, BUN, creatinine^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4560,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4560,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4562,0)
 ;;=absence of S/S of fluid overload^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4562,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4562,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4563,0)
 ;;=initiate lethal dysrhythmia protocol^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4563,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4563,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4565,0)
 ;;=[Extra Goal]^3^NURSC^9^11^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4565,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4565,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4566,0)
 ;;=Pain, Acute^2^NURSC^2^9^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4566,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4566,1,1,0)
 ;;=4588^Goals/Expected Outcomes^2^NURSC^212
 ;;^UTILITY("^GMRD(124.2,",$J,4566,1,2,0)
 ;;=4590^Nursing Intervention/Orders^2^NURSC^213
 ;;^UTILITY("^GMRD(124.2,",$J,4566,1,3,0)
 ;;=15556^Etiology/Related and/or Risk Factors^2^NURSC^297
 ;;^UTILITY("^GMRD(124.2,",$J,4566,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4566,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4566,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4567,0)
 ;;=[Extra Goal]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4567,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4567,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4568,0)
 ;;=Fluid Volume (Deficit/Excess)^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4568,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4568,1,1,0)
 ;;=4612^Etiology/Related and/or Risk Factors^2^NURSC^213
 ;;^UTILITY("^GMRD(124.2,",$J,4568,1,2,0)
 ;;=4619^Goals/Expected Outcomes^2^NURSC^215
