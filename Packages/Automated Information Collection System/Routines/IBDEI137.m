IBDEI137 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19181,1,4,0)
 ;;=4^311.
 ;;^UTILITY(U,$J,358.3,19181,1,5,0)
 ;;=5^Depression
 ;;^UTILITY(U,$J,358.3,19181,2)
 ;;=^35603
 ;;^UTILITY(U,$J,358.3,19182,0)
 ;;=309.0^^105^1228^17
 ;;^UTILITY(U,$J,358.3,19182,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19182,1,4,0)
 ;;=4^309.0
 ;;^UTILITY(U,$J,358.3,19182,1,5,0)
 ;;=5^Depressive Reaction, Brief
 ;;^UTILITY(U,$J,358.3,19182,2)
 ;;=^3308
 ;;^UTILITY(U,$J,358.3,19183,0)
 ;;=305.50^^105^1228^24
 ;;^UTILITY(U,$J,358.3,19183,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19183,1,4,0)
 ;;=4^305.50
 ;;^UTILITY(U,$J,358.3,19183,1,5,0)
 ;;=5^IV Drug Use
 ;;^UTILITY(U,$J,358.3,19183,2)
 ;;=^85868
 ;;^UTILITY(U,$J,358.3,19184,0)
 ;;=302.72^^105^1228^25
 ;;^UTILITY(U,$J,358.3,19184,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19184,1,4,0)
 ;;=4^302.72
 ;;^UTILITY(U,$J,358.3,19184,1,5,0)
 ;;=5^Inhibited Sex Excitement(Not Organic Impotence)
 ;;^UTILITY(U,$J,358.3,19184,2)
 ;;=^1
 ;;^UTILITY(U,$J,358.3,19185,0)
 ;;=780.52^^105^1228^26
 ;;^UTILITY(U,$J,358.3,19185,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19185,1,4,0)
 ;;=4^780.52
 ;;^UTILITY(U,$J,358.3,19185,1,5,0)
 ;;=5^Insomnia
 ;;^UTILITY(U,$J,358.3,19185,2)
 ;;=^87662
 ;;^UTILITY(U,$J,358.3,19186,0)
 ;;=300.3^^105^1228^28
 ;;^UTILITY(U,$J,358.3,19186,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19186,1,4,0)
 ;;=4^300.3
 ;;^UTILITY(U,$J,358.3,19186,1,5,0)
 ;;=5^Obsessive-Compulsive
 ;;^UTILITY(U,$J,358.3,19186,2)
 ;;=^1
 ;;^UTILITY(U,$J,358.3,19187,0)
 ;;=304.00^^105^1228^29
 ;;^UTILITY(U,$J,358.3,19187,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19187,1,4,0)
 ;;=4^304.00
 ;;^UTILITY(U,$J,358.3,19187,1,5,0)
 ;;=5^Opioid Dependence 
 ;;^UTILITY(U,$J,358.3,19187,2)
 ;;=^81364
 ;;^UTILITY(U,$J,358.3,19188,0)
 ;;=301.9^^105^1228^31
 ;;^UTILITY(U,$J,358.3,19188,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19188,1,4,0)
 ;;=4^301.9
 ;;^UTILITY(U,$J,358.3,19188,1,5,0)
 ;;=5^Personality Disorder 
 ;;^UTILITY(U,$J,358.3,19188,2)
 ;;=^92451
 ;;^UTILITY(U,$J,358.3,19189,0)
 ;;=298.9^^105^1228^32
 ;;^UTILITY(U,$J,358.3,19189,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19189,1,4,0)
 ;;=4^298.9
 ;;^UTILITY(U,$J,358.3,19189,1,5,0)
 ;;=5^Psychosis
 ;;^UTILITY(U,$J,358.3,19189,2)
 ;;=^1
 ;;^UTILITY(U,$J,358.3,19190,0)
 ;;=309.81^^105^1228^30
 ;;^UTILITY(U,$J,358.3,19190,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19190,1,4,0)
 ;;=4^309.81
 ;;^UTILITY(U,$J,358.3,19190,1,5,0)
 ;;=5^PTSD (chronic)
 ;;^UTILITY(U,$J,358.3,19190,2)
 ;;=^114716
 ;;^UTILITY(U,$J,358.3,19191,0)
 ;;=295.90^^105^1228^33
 ;;^UTILITY(U,$J,358.3,19191,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19191,1,4,0)
 ;;=4^295.90
 ;;^UTILITY(U,$J,358.3,19191,1,5,0)
 ;;=5^Schizophrenia 
 ;;^UTILITY(U,$J,358.3,19191,2)
 ;;=^108287
 ;;^UTILITY(U,$J,358.3,19192,0)
 ;;=300.81^^105^1228^34
 ;;^UTILITY(U,$J,358.3,19192,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19192,1,4,0)
 ;;=4^300.81
 ;;^UTILITY(U,$J,358.3,19192,1,5,0)
 ;;=5^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,19192,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,19193,0)
 ;;=306.9^^105^1228^35
 ;;^UTILITY(U,$J,358.3,19193,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19193,1,4,0)
 ;;=4^306.9
 ;;^UTILITY(U,$J,358.3,19193,1,5,0)
 ;;=5^Somatization Reaction
 ;;^UTILITY(U,$J,358.3,19193,2)
 ;;=^123979
 ;;^UTILITY(U,$J,358.3,19194,0)
 ;;=305.1^^105^1228^37
 ;;^UTILITY(U,$J,358.3,19194,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19194,1,4,0)
 ;;=4^305.1
 ;;^UTILITY(U,$J,358.3,19194,1,5,0)
 ;;=5^Tobacco Dependence
 ;;^UTILITY(U,$J,358.3,19194,2)
 ;;=^119899
 ;;^UTILITY(U,$J,358.3,19195,0)
 ;;=V61.01^^105^1228^21
 ;;
 ;;$END ROU IBDEI137
