NURCCGD3 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10912,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,10912,1,1,0)
 ;;=2398^Breathing Pattern, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10912,1,2,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10912,1,3,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10912,1,4,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10912,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,10912,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10917,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^148^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10917,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,10917,1,2,0)
 ;;=305^infection, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10917,1,3,0)
 ;;=306^obstruction, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10917,1,4,0)
 ;;=307^secretions, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10917,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10924,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^146^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10924,1,0)
 ;;=^124.21PI^10^3
 ;;^UTILITY("^GMRD(124.2,",$J,10924,1,8,0)
 ;;=11126^[Extra Goal]^3^NURSC^181
 ;;^UTILITY("^GMRD(124.2,",$J,10924,1,9,0)
 ;;=15385^normal repiratory rate and pattern [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10924,1,10,0)
 ;;=8325^normal breath sounds^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,10924,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10934,0)
 ;;=[Extra Goal]^3^NURSC^9^179^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10934,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10934,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10935,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^123^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10935,1,0)
 ;;=^124.21PI^37^6
 ;;^UTILITY("^GMRD(124.2,",$J,10935,1,21,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10935,1,33,0)
 ;;=11427^[Extra Order]^3^NURSC^187
 ;;^UTILITY("^GMRD(124.2,",$J,10935,1,34,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,10935,1,35,0)
 ;;=329^administer bronchodilators as ordered^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,10935,1,36,0)
 ;;=8425^bronchial hygiene:^2^NURSC^26
 ;;^UTILITY("^GMRD(124.2,",$J,10935,1,37,0)
 ;;=15388^hydration and nutrition q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10935,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10935,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10996,0)
 ;;=[Extra Order]^3^NURSC^11^182^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10996,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10996,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11002,0)
 ;;=Defining Characteristics^2^NURSC^12^128^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11002,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,11002,1,1,0)
 ;;=4036^cough effective with or without sputum^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11002,1,2,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11002,1,3,0)
 ;;=4038^breath sounds abnormal ie., wheezing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11002,1,4,0)
 ;;=4039^cough ineffective with or without wheezing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11002,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11002,1,6,0)
 ;;=1468^tachypnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11002,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11009,0)
 ;;=Breathing Pattern, Ineffective^2^NURSC^2^7^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11009,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11009,1,1,0)
 ;;=11010^Etiology/Related and/or Risk Factors^2^NURSC^149
 ;;^UTILITY("^GMRD(124.2,",$J,11009,1,2,0)
 ;;=11019^Related Problems^2^NURSC^129
