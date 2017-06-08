NURCCG1N ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,566,0)
 ;;=no emergency resuscitation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,567,0)
 ;;=divorce^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,568,0)
 ;;=blood transfusions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,569,0)
 ;;=death or illness of significant other^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,570,0)
 ;;=hospital barriers to practicing spiritual rituals^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,571,0)
 ;;=isolation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,572,0)
 ;;=ICU restrictions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,573,0)
 ;;=surgery^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,574,0)
 ;;=as a response^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,574,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,574,1,1,0)
 ;;=575^terminal illness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,574,1,2,0)
 ;;=576^debilitating disease^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,574,1,3,0)
 ;;=577^loss of body part or function^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,574,5)
 ;;=to
 ;;^UTILITY("^GMRD(124.2,",$J,574,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,575,0)
 ;;=terminal illness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,576,0)
 ;;=debilitating disease^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,577,0)
 ;;=loss of body part or function^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,578,0)
 ;;=achieves personal/spiritual goals of [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,578,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,578,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,579,0)
 ;;=expresses satisfaction about his relationship-God/Diety^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,579,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,579,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,580,0)
 ;;=continues spiritual practices not detrimental to health^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,580,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,580,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,581,0)
 ;;=expresses decreased feelings of guilt and fear^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,581,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,581,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,582,0)
 ;;=verbalizes feeling supported in health care decisions^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,582,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,582,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,583,0)
 ;;=assess causative, contributing factors^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,583,5)
 ;;=; monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,583,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,583,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,584,0)
 ;;=assess pt's beliefs, involvement, and spiritual practices^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,584,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,584,1,1,0)
 ;;=591^religious practices in use^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,584,1,2,0)
 ;;=592^if yes, to what religion do you belong?^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,584,1,3,0)
 ;;=593^how will your illness affect your practices/beliefs?^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,584,1,4,0)
 ;;=594^how can I help you maintain your spiritual strength?^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,584,5)
 ;;=ASK:
 ;;^UTILITY("^GMRD(124.2,",$J,584,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,584,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,584,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,585,0)
 ;;=note expression of inability to find reason for living^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,585,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,585,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,586,0)
 ;;=assist patient/family to deal with feelings:^2^NURSC^11^1^1^^T^1
