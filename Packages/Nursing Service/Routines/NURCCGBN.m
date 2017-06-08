NURCCGBN ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8277,1,18,0)
 ;;=9920^high glucose level^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8277,1,19,0)
 ;;=1761^altered circulation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8277,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8296,0)
 ;;=Airway Clearance, Ineffective^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8296,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,8296,1,1,0)
 ;;=8299^Related Problems^2^NURSC^97
 ;;^UTILITY("^GMRD(124.2,",$J,8296,1,2,0)
 ;;=8310^Etiology/Related and/or Risk Factors^2^NURSC^115
 ;;^UTILITY("^GMRD(124.2,",$J,8296,1,3,0)
 ;;=8322^Goals/Expected Outcomes^2^NURSC^113
 ;;^UTILITY("^GMRD(124.2,",$J,8296,1,4,0)
 ;;=8343^Nursing Intervention/Orders^2^NURSC^97
 ;;^UTILITY("^GMRD(124.2,",$J,8296,1,6,0)
 ;;=8440^Defining Characteristics^2^NURSC^102
 ;;^UTILITY("^GMRD(124.2,",$J,8296,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8296,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8296,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8296,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,8296,"TD",1,0)
 ;;=A state in which an individual is unable to clear secretions or
 ;;^UTILITY("^GMRD(124.2,",$J,8296,"TD",2,0)
 ;;=obstructions from the respiratory tract to maintain airway patency.
 ;;^UTILITY("^GMRD(124.2,",$J,8299,0)
 ;;=Related Problems^2^NURSC^7^97^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8299,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,8299,1,1,0)
 ;;=2398^Breathing Pattern, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8299,1,2,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8299,1,3,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8299,1,4,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8299,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,8299,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8310,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^115^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8310,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,8310,1,2,0)
 ;;=305^infection, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8310,1,3,0)
 ;;=306^obstruction, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8310,1,4,0)
 ;;=307^secretions, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8310,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8317,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^112^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8317,1,0)
 ;;=^124.21PI^10^9
 ;;^UTILITY("^GMRD(124.2,",$J,8317,1,1,0)
 ;;=548^normal sputum production^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8317,1,2,0)
 ;;=549^reduced risk of pulmonary infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8317,1,3,0)
 ;;=550^intact mucous membrane^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8317,1,4,0)
 ;;=551^optimal weight^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8317,1,5,0)
 ;;=552^optimal fluid balance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8317,1,7,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8317,1,8,0)
 ;;=8342^[Extra Goal]^3^NURSC^147
 ;;^UTILITY("^GMRD(124.2,",$J,8317,1,9,0)
 ;;=10182^identifies S/S of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8317,1,10,0)
 ;;=10323^identifies interventions to prevent/reduce risk of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8317,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8322,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^113^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8322,1,0)
 ;;=^124.21PI^8^4
 ;;^UTILITY("^GMRD(124.2,",$J,8322,1,1,0)
 ;;=8325^normal breath sounds^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8322,1,3,0)
 ;;=548^normal sputum production^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8322,1,4,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
