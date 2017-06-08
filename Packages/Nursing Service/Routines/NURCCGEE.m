NURCCGEE ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13054,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13059,0)
 ;;=[Extra Problem]^2^NURSC^2^32^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,13059,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13059,1,1,0)
 ;;=13061^Etiology/Related and/or Risk Factors^2^NURSC^279
 ;;^UTILITY("^GMRD(124.2,",$J,13059,1,2,0)
 ;;=13069^Goals/Expected Outcomes^2^NURSC^291
 ;;^UTILITY("^GMRD(124.2,",$J,13059,1,3,0)
 ;;=13077^Nursing Intervention/Orders^2^NURSC^295
 ;;^UTILITY("^GMRD(124.2,",$J,13059,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13059,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13059,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13060,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^175^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13060,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,13060,1,2,0)
 ;;=305^infection, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13060,1,3,0)
 ;;=306^obstruction, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13060,1,4,0)
 ;;=307^secretions, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13060,1,6,0)
 ;;=309^trauma^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13060,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13061,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^279^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13061,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13061,1,1,0)
 ;;=13065^[etiology]^3^NURSC^100
 ;;^UTILITY("^GMRD(124.2,",$J,13061,1,2,0)
 ;;=13067^[etiology]^3^NURSC^101
 ;;^UTILITY("^GMRD(124.2,",$J,13061,1,3,0)
 ;;=13393^[etiology]^3^NURSC^138
 ;;^UTILITY("^GMRD(124.2,",$J,13061,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13062,0)
 ;;=[etiology]^3^NURSC^^102^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13065,0)
 ;;=[etiology]^3^NURSC^^100^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13067,0)
 ;;=[etiology]^3^NURSC^^101^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13069,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^291^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13069,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13069,1,1,0)
 ;;=13073^[Extra Goal]^3^NURSC^374
 ;;^UTILITY("^GMRD(124.2,",$J,13069,1,2,0)
 ;;=13074^[Extra Goal]^3^NURSC^375
 ;;^UTILITY("^GMRD(124.2,",$J,13069,1,3,0)
 ;;=13075^[Extra Goal]^3^NURSC^376
 ;;^UTILITY("^GMRD(124.2,",$J,13069,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13072,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^173^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13072,1,0)
 ;;=^124.21PI^8^4
 ;;^UTILITY("^GMRD(124.2,",$J,13072,1,1,0)
 ;;=13076^clear, equal, bilateral breath sounds^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,13072,1,2,0)
 ;;=313^has normal respiratory rate/breathing pattern^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13072,1,4,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13072,1,8,0)
 ;;=13352^[Extra Goal]^3^NURSC^232
 ;;^UTILITY("^GMRD(124.2,",$J,13072,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13073,0)
 ;;=[Extra Goal]^3^NURSC^9^374^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13073,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13073,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13074,0)
 ;;=[Extra Goal]^3^NURSC^9^375^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13074,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13074,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13075,0)
 ;;=[Extra Goal]^3^NURSC^9^376^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13075,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13075,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13076,0)
 ;;=clear, equal, bilateral breath sounds^3^NURSC^9^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13076,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13076,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13077,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^295^1^^T
