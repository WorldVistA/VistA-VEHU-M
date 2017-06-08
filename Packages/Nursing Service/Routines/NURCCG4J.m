NURCCG4J ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1716,1,4,0)
 ;;=1720^urinary catheter^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1716,1,5,0)
 ;;=1721^exercise tolerance test^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1716,1,6,0)
 ;;=1722^cardiac catheterization^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1716,1,7,0)
 ;;=1723^EKG^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1716,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,1716,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1716,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1716,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1717,0)
 ;;=central venous pressure line^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1718,0)
 ;;=Swan-Ganz line^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1719,0)
 ;;=arterial line^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1720,0)
 ;;=urinary catheter^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1721,0)
 ;;=exercise tolerance test^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1722,0)
 ;;=cardiac catheterization^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1723,0)
 ;;=EKG^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1723,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1723,1,1,0)
 ;;=1724^purpose of test^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1723,1,2,0)
 ;;=1726^mechanics of the procedure/test itself^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1723,1,3,0)
 ;;=1727^potential complications^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1723,1,4,0)
 ;;=1730^precautions prior to and post/test procedure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1723,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,1723,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1724,0)
 ;;=purpose of test^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1725,0)
 ;;=clean^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1726,0)
 ;;=mechanics of the procedure/test itself^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1727,0)
 ;;=potential complications^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1728,0)
 ;;=moist^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1729,0)
 ;;=without lesions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1730,0)
 ;;=precautions prior to and post/test procedure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1731,0)
 ;;=without hardened crusts^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1732,0)
 ;;=achieves relief from pain^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1732,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1732,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1733,0)
 ;;=verbalizes importance of routine oral care^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1733,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1733,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1734,0)
 ;;=demonstrates adequate oral care^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1734,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1734,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1735,0)
 ;;=teach expected side effects of drug therapy^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1735,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1735,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1736,0)
 ;;=identifies and avoids common causes of mucosal irritation^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1736,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1736,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1737,0)
 ;;=teach dietary needs^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1737,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1737,1,1,0)
 ;;=1738^calories^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1737,1,2,0)
 ;;=1739^sodium^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1737,1,3,0)
 ;;=1740^potassium^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1737,1,4,0)
 ;;=1741^cholesterol^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1737,1,5,0)
 ;;=1742^low-density lipoprotein (LDL)^3^NURSC^1^0
