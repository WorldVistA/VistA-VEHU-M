NURCCGC4 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9423,0)
 ;;=[Extra Problem]^2^NURSC^2^22^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9423,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,9423,1,1,0)
 ;;=9424^Etiology/Related and/or Risk Factors^2^NURSC^268
 ;;^UTILITY("^GMRD(124.2,",$J,9423,1,3,0)
 ;;=9429^Goals/Expected Outcomes^2^NURSC^280
 ;;^UTILITY("^GMRD(124.2,",$J,9423,1,4,0)
 ;;=9433^Nursing Intervention/Orders^2^NURSC^284
 ;;^UTILITY("^GMRD(124.2,",$J,9423,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9423,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9423,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9424,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^268^1^1^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9424,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,9424,1,1,0)
 ;;=9426^[etiology]^3^NURSC^106
 ;;^UTILITY("^GMRD(124.2,",$J,9424,1,2,0)
 ;;=9427^[etiology]^3^NURSC^107
 ;;^UTILITY("^GMRD(124.2,",$J,9424,1,3,0)
 ;;=10338^[etiology]^3^NURSC^66
 ;;^UTILITY("^GMRD(124.2,",$J,9424,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9425,0)
 ;;=[etiology]^3^NURSC^^108^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9426,0)
 ;;=[etiology]^3^NURSC^^106^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9427,0)
 ;;=[etiology]^3^NURSC^^107^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9429,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^280^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9429,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,9429,1,1,0)
 ;;=9430^[Extra Goal]^3^NURSC^347
 ;;^UTILITY("^GMRD(124.2,",$J,9429,1,2,0)
 ;;=9431^[Extra Goal]^3^NURSC^348
 ;;^UTILITY("^GMRD(124.2,",$J,9429,1,3,0)
 ;;=9432^[Extra Goal]^3^NURSC^349
 ;;^UTILITY("^GMRD(124.2,",$J,9429,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9430,0)
 ;;=[Extra Goal]^3^NURSC^9^347^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9430,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9430,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9431,0)
 ;;=[Extra Goal]^3^NURSC^9^348^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9431,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9431,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9432,0)
 ;;=[Extra Goal]^3^NURSC^9^349^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9432,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9432,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9433,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^284^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9433,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,9433,1,1,0)
 ;;=9434^[Extra Order]^3^NURSC^354
 ;;^UTILITY("^GMRD(124.2,",$J,9433,1,2,0)
 ;;=9435^[Extra Order]^3^NURSC^355
 ;;^UTILITY("^GMRD(124.2,",$J,9433,1,3,0)
 ;;=9436^[Extra Order]^3^NURSC^356
 ;;^UTILITY("^GMRD(124.2,",$J,9433,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9433,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9434,0)
 ;;=[Extra Order]^3^NURSC^11^354^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9434,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9434,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9435,0)
 ;;=[Extra Order]^3^NURSC^11^355^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9435,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9435,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9436,0)
 ;;=[Extra Order]^3^NURSC^11^356^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9436,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9436,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9437,0)
 ;;=Fluid Volume Deficit (Actual/Potential)^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9437,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9437,1,1,0)
 ;;=9438^Etiology/Related and/or Risk Factors^2^NURSC^128
 ;;^UTILITY("^GMRD(124.2,",$J,9437,1,2,0)
 ;;=9449^Related Problems^2^NURSC^109
 ;;^UTILITY("^GMRD(124.2,",$J,9437,1,3,0)
 ;;=9456^Goals/Expected Outcomes^2^NURSC^126
