NURCCG0O ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;2/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,256,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,256,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,257,0)
 ;;=ensure easy access to all clothing^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,257,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,257,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,258,0)
 ;;=lay clothing out in order for dressing^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,258,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,258,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,259,0)
 ;;=allow sufficient time for dressing and undressing^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,259,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,259,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,260,0)
 ;;=select appropriate clothing^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,260,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,260,1,1,0)
 ;;=264^loose fitting^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,260,1,2,0)
 ;;=265^wide sleeves^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,260,1,3,0)
 ;;=266^front fasteners^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,260,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,260,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,260,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,261,0)
 ;;=allow person to demonstrate activity in steps^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,261,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,261,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,262,0)
 ;;=keep instructions simple and repeat often^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,262,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,262,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,263,0)
 ;;=provide dressing aids as necessary^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,263,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,263,1,1,0)
 ;;=267^long handled shoe horn^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,263,1,2,0)
 ;;=268^velcro^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,263,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,263,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,263,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,263,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,264,0)
 ;;=loose fitting^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,265,0)
 ;;=wide sleeves^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,266,0)
 ;;=front fasteners^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,267,0)
 ;;=long handled shoe horn^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,268,0)
 ;;=velcro^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,269,0)
 ;;=toileting deficit outcomes^2^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,0)
 ;;=^124.21PI^15^15
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,1,0)
 ;;=270^demonstrates increased ability to toilet self^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,2,0)
 ;;=271^demonstrates increased ability to cope with assistance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,3,0)
 ;;=272^verbalizes positive feelings related to continency^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,4,0)
 ;;=273^identifies causative factors related to toileting deficit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,5,0)
 ;;=274^demonstrates use of adaptive devices to facilitate toileting^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,6,0)
 ;;=2500^achieves independence in toileting^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,7,0)
 ;;=2868^[Extra Goal]^3^NURSC^43^0
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,8,0)
 ;;=7409^demonstrates use of adaptive devices [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,9,0)
 ;;=7408^performs toileting hygiene independently^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,10,0)
 ;;=7406^performs toileting hygiene with [min/mod/max] assistance^3^NURSC^1^1
