NURCCG5H ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,8,0)
 ;;=2317^offer PRN medication when indicated^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,9,0)
 ;;=2328^recognize: pt. may be anxious about dismissing 'voices'^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,10,0)
 ;;=2329^encourage reality testing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,11,0)
 ;;=2331^teach: that delusional thoughts are hard to believe^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,12,0)
 ;;=2332^relate delusional thought content to level of anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,13,0)
 ;;=2333^allow brief description of delusions; do not reinforce^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,14,0)
 ;;=2336^explain the reality of the present situation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,15,0)
 ;;=2338^be clear and concrete in your statements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,16,0)
 ;;=2340^interject doubt regarding delusions (if able to accept)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,17,0)
 ;;=2343^encourage verbalization of feelings^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,18,0)
 ;;=2347^look for reality stimuli causing stress/explore factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,19,0)
 ;;=2350^interact with patient [specify] minutes/day^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,20,0)
 ;;=2361^monitor/assist with grooming & hygiene as necessary^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,21,0)
 ;;=3008^[Extra Order]^3^NURSC^94^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,22,0)
 ;;=16564^explain the reality of the present situation^3^NURSC^2^1
 ;;^UTILITY("^GMRD(124.2,",$J,2182,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2182,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2183,0)
 ;;=observe for S/S of auditory hallucinations^3^NURSC^11^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2183,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2183,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2184,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^59^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2184,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,2184,1,1,0)
 ;;=2185^antisocial^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2184,1,2,0)
 ;;=2186^battered women^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2184,1,3,0)
 ;;=2187^catatonic excitement^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2184,1,4,0)
 ;;=2188^child abuse^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2184,1,5,0)
 ;;=2189^manic excitement^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2184,1,6,0)
 ;;=2190^organic brain syndrome^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2184,1,7,0)
 ;;=2191^panic states^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2184,1,8,0)
 ;;=2192^rage reactions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2184,1,9,0)
 ;;=2193^suicidal behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2184,1,10,0)
 ;;=2194^temporal lobe epilepsy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2184,1,11,0)
 ;;=2195^toxic reactions to medications^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2184,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2185,0)
 ;;=antisocial^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2186,0)
 ;;=battered women^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2187,0)
 ;;=catatonic excitement^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2188,0)
 ;;=child abuse^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2189,0)
 ;;=manic excitement^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2190,0)
 ;;=organic brain syndrome^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2191,0)
 ;;=panic states^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2192,0)
 ;;=rage reactions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2193,0)
 ;;=suicidal behavior^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2194,0)
 ;;=temporal lobe epilepsy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2195,0)
 ;;=toxic reactions to medications^3^NURSC^^1^^^T
