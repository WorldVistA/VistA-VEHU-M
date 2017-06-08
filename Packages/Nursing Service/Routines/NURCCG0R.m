NURCCG0R ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,290,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,290,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,291,0)
 ;;=exertional dyspnea^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,292,0)
 ;;=inability to be independent for self-care^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,293,0)
 ;;=weight loss or gain^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,294,0)
 ;;=deteriorating personal appearance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,295,0)
 ;;=sleep pattern^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,296,0)
 ;;=Dietetic Service^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,297,0)
 ;;=Chaplain Service^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,298,0)
 ;;=use of adaptive equipment to assist with ADLs^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,298,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,298,1,1,0)
 ;;=301^tub bench^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,298,1,2,0)
 ;;=302^shower hose^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,298,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,298,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,299,0)
 ;;=using analgesics appropriately^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,300,0)
 ;;=relaxation therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,301,0)
 ;;=tub bench^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,302,0)
 ;;=shower hose^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,303,0)
 ;;=Related Problems^2^NURSC^7^7^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,303,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,303,1,1,0)
 ;;=2398^Breathing Pattern, Ineffective^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,303,1,2,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,303,1,3,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,303,1,4,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,303,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,303,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,304,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^8^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,304,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,304,1,1,0)
 ;;=420^decreased energy and fatigue^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,304,1,2,0)
 ;;=305^infection, tracheobronchial^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,304,1,3,0)
 ;;=306^obstruction, tracheobronchial^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,304,1,4,0)
 ;;=307^secretions, tracheobronchial^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,304,1,5,0)
 ;;=308^perceptual/cognitive impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,304,1,6,0)
 ;;=309^trauma^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,304,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,305,0)
 ;;=infection, tracheobronchial^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,306,0)
 ;;=obstruction, tracheobronchial^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,307,0)
 ;;=secretions, tracheobronchial^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,308,0)
 ;;=perceptual/cognitive impairment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,309,0)
 ;;=trauma^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,310,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^6^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,310,1,0)
 ;;=^124.21PI^33^33
 ;;^UTILITY("^GMRD(124.2,",$J,310,1,1,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9^0
 ;;^UTILITY("^GMRD(124.2,",$J,310,1,2,0)
 ;;=321^TPR q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,310,1,3,0)
 ;;=322^B/P q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,310,1,4,0)
 ;;=324^monitor use of accessory muscles^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,310,1,5,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,310,1,6,0)
 ;;=326^cardiac rhythm q[frequency]^3^NURSC^1^0
