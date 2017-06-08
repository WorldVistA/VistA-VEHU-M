NURCCG0J ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;2/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,212,1,8,0)
 ;;=15315^verbalizes S/S reportable to health care professional^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,212,1,9,0)
 ;;=15310^describes measures to reduce risk factors^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,212,1,10,0)
 ;;=15309^verbalizes routine to meet basic needs^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,212,1,11,0)
 ;;=2242^uses assertive communication techniques^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,212,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,213,0)
 ;;=feeding deficit outcomes^2^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,213,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,213,1,1,0)
 ;;=221^increased interest and desire to eat^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,213,1,2,0)
 ;;=222^causative factors for feeding deficit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,213,1,3,0)
 ;;=223^use of adaptive devices^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,213,1,4,0)
 ;;=224^increased ability to feed self^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,213,1,5,0)
 ;;=225^participation in adaptive process^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,213,1,6,0)
 ;;=2497^achieves independence in feeding^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,213,1,7,0)
 ;;=2866^[Extra Goal]^3^NURSC^41^0
 ;;^UTILITY("^GMRD(124.2,",$J,213,1,8,0)
 ;;=7091^performs feeding with [min/mod/max] assistance [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,213,5)
 ;;=demonstrates or describes
 ;;^UTILITY("^GMRD(124.2,",$J,213,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,214,0)
 ;;=bathing/hygiene deficit outcomes^2^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,214,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,214,1,1,0)
 ;;=226^describes causative factors of bathing deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,214,1,2,0)
 ;;=227^performs bathing activity at optimal level^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,214,1,3,0)
 ;;=228^verbalizes comfort and satisfaction with body cleanliness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,214,1,4,0)
 ;;=2864^[Extra Goal]^3^NURSC^36^0
 ;;^UTILITY("^GMRD(124.2,",$J,214,1,5,0)
 ;;=6697^performs bathing with [min/mod/max] assistance [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,214,1,6,0)
 ;;=6777^performs bathing independently^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,214,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,215,0)
 ;;=dressing/grooming deficit outcomes^2^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,215,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,215,1,1,0)
 ;;=229^increased ability to dress self^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,215,1,2,0)
 ;;=230^ability to request/accept assistance in dressing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,215,1,3,0)
 ;;=231^increased interest in appearance and dress^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,215,1,4,0)
 ;;=2498^adaptive techniques/devices for independent dressing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,215,1,5,0)
 ;;=2499^independence in dressing/grooming^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,215,1,6,0)
 ;;=2865^[Extra Goal]^3^NURSC^37^0
 ;;^UTILITY("^GMRD(124.2,",$J,215,1,7,0)
 ;;=6780^performs dressing/grooming independently^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,215,1,8,0)
 ;;=6947^performs dressing/grooming with [min/mod/max] assistance^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,215,5)
 ;;=demonstrates
 ;;^UTILITY("^GMRD(124.2,",$J,215,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,216,0)
 ;;=identifies factors limiting self-care^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,216,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,216,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,217,0)
 ;;=accepts home health care^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,217,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,217,1,1,0)
 ;;=219^physical therapy^3^NURSC^1^0
