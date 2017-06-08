NURCCGDW ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12210,1,5,0)
 ;;=211^pain, discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12210,1,6,0)
 ;;=308^perceptual/cognitive impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12210,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12217,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^163^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12217,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,12217,1,1,0)
 ;;=12218^general self-care deficit outcomes^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,12217,1,2,0)
 ;;=12227^feeding deficit outcomes^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,12217,1,3,0)
 ;;=12235^bathing/hygiene deficit outcomes^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,12217,1,4,0)
 ;;=12240^dressing/grooming deficit outcomes^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,12217,1,5,0)
 ;;=12247^toileting deficit outcomes^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,12217,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12218,0)
 ;;=general self-care deficit outcomes^2^NURSC^^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12218,1,0)
 ;;=^124.21PI^10^9
 ;;^UTILITY("^GMRD(124.2,",$J,12218,1,1,0)
 ;;=216^identifies factors limiting self-care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12218,1,3,0)
 ;;=218^accepts interventions to modify self-care deficits^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12218,1,4,0)
 ;;=2495^demonstrates adaptive techniques/devices for self-care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12218,1,5,0)
 ;;=2496^achieves independence in self-care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12218,1,6,0)
 ;;=12226^[Extra Goal]^3^NURSC^194
 ;;^UTILITY("^GMRD(124.2,",$J,12218,1,7,0)
 ;;=15309^verbalizes routine to meet basic needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12218,1,8,0)
 ;;=15310^describes measures to reduce risk factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12218,1,9,0)
 ;;=15315^verbalizes S/S reportable to health care professional^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12218,1,10,0)
 ;;=15324^communicates an understanding of follow-up care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12218,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12226,0)
 ;;=[Extra Goal]^3^NURSC^9^194^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12226,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12226,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12227,0)
 ;;=feeding deficit outcomes^2^NURSC^^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12227,1,0)
 ;;=^124.21PI^10^9
 ;;^UTILITY("^GMRD(124.2,",$J,12227,1,1,0)
 ;;=221^increased interest and desire to eat^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12227,1,2,0)
 ;;=222^causative factors for feeding deficit^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12227,1,3,0)
 ;;=223^use of adaptive devices^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12227,1,4,0)
 ;;=224^increased ability to feed self^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12227,1,5,0)
 ;;=225^participation in adaptive process^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12227,1,6,0)
 ;;=2497^achieves independence in feeding^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12227,1,7,0)
 ;;=12234^[Extra Goal]^3^NURSC^195
 ;;^UTILITY("^GMRD(124.2,",$J,12227,1,8,0)
 ;;=7024^tolerates food ingestion without aspiration^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12227,1,10,0)
 ;;=7091^performs feeding with [min/mod/max] assistance [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12227,5)
 ;;=demonstrates or describes
 ;;^UTILITY("^GMRD(124.2,",$J,12227,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12234,0)
 ;;=[Extra Goal]^3^NURSC^9^195^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12234,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12234,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12235,0)
 ;;=bathing/hygiene deficit outcomes^2^NURSC^^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12235,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,12235,1,1,0)
 ;;=226^describes causative factors of bathing deficit [specify]^3^NURSC^1
