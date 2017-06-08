NURCCG60 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2417,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2418,0)
 ;;=assist/secure contact with support ind./group before D/C^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2418,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2418,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2419,0)
 ;;=writes plan identifying impulses to harm self^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2419,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2419,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2420,0)
 ;;=observe as indicated^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2420,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2420,1,1,0)
 ;;=2421^1:1 observation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2420,1,2,0)
 ;;=2422^constant observation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2420,1,3,0)
 ;;=2423^scheduled observation q [ ] minutes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2420,1,4,0)
 ;;=2424^routine observation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2420,5)
 ;;=:
 ;;^UTILITY("^GMRD(124.2,",$J,2420,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2420,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2420,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2421,0)
 ;;=1:1 observation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2422,0)
 ;;=constant observation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2423,0)
 ;;=scheduled observation q [ ] minutes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2424,0)
 ;;=routine observation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2425,0)
 ;;=reinforce that patient can maintain control^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2425,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2425,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2426,0)
 ;;=staff will give examples of controlled behavior^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2426,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2426,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2427,0)
 ;;=restrain as necessary^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2427,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2427,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2428,0)
 ;;=bypassing normal body defenses by suctioning, intubation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2429,0)
 ;;=inability to breathe deeply^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2429,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2429,1,1,0)
 ;;=2430^weakness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2429,1,2,0)
 ;;=2431^chest pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2429,1,3,0)
 ;;=306^obstruction, tracheobronchial^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2429,5)
 ;;=due to:
 ;;^UTILITY("^GMRD(124.2,",$J,2429,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2430,0)
 ;;=weakness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2431,0)
 ;;=chest pain^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2432,0)
 ;;=isolation^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2432,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2432,1,1,0)
 ;;=2433^AFB^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2432,1,2,0)
 ;;=2434^secretion/excretion^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2432,1,3,0)
 ;;=2435^respiratory^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2432,5)
 ;;=specifically:
 ;;^UTILITY("^GMRD(124.2,",$J,2432,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2432,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2432,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2433,0)
 ;;=AFB^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2434,0)
 ;;=secretion/excretion^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2435,0)
 ;;=respiratory^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2436,0)
 ;;=teach prevention of infection techniques [specify]^2^NURSC^11^1^1^^T^1
