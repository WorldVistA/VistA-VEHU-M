NURCCGF4 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14124,0)
 ;;=develops strategies to improve interpersonal relationships^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14124,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14124,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14125,0)
 ;;=identifies feelings,behaviors,events associated with trauma^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14125,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14125,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14134,0)
 ;;=[Extra Goal]^3^NURSC^9^242^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14134,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14134,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14135,0)
 ;;=assist to identify measures preventing destructive conduct^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14135,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14135,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14136,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^156^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14136,1,0)
 ;;=^124.21PI^11^7
 ;;^UTILITY("^GMRD(124.2,",$J,14136,1,3,0)
 ;;=14157^encourage verbalization of feelings about trauma [specify]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14136,1,6,0)
 ;;=14664^[Extra Order]^3^NURSC^253
 ;;^UTILITY("^GMRD(124.2,",$J,14136,1,7,0)
 ;;=15291^help to correlate past trauma w/present situations [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14136,1,8,0)
 ;;=15292^teach alternative methods for dealing with stress [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14136,1,9,0)
 ;;=15293^assist to identify triggers for impulsive behavior [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14136,1,10,0)
 ;;=15294^assist to learn and use pro-active behaviors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14136,1,11,0)
 ;;=15295^assist to identify community resources for discharge^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14136,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14136,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14137,0)
 ;;=assist in identifying self destructive thoughts/behaviors^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14137,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14137,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14138,0)
 ;;=[Extra Order]^3^NURSC^11^247^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14138,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14138,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14140,0)
 ;;=Defining Characteristics^2^NURSC^12^164^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14140,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14140,1,1,0)
 ;;=4042^self-destructive behavior,active aggression,suicidal acts^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14140,1,2,0)
 ;;=4043^body language-fists,facial expression,rigid posture,tautness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14140,1,3,0)
 ;;=4046^hostile threatening verbalizations, boasting or prior abuse ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14140,1,4,0)
 ;;=4062^overt,agressive acts-destruction of objects in environment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14140,1,5,0)
 ;;=4065^suspicion of others,paranoid ideation,delusions,hallucinates^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14140,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14157,0)
 ;;=encourage verbalization of feelings about trauma [specify]^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14157,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14157,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14175,0)
 ;;=Defining Characteristics^2^NURSC^12^165^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14175,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14175,1,1,0)
 ;;=4071^excessive verbalization of the traumatic event^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14175,1,2,0)
 ;;=4078^flashbacks,intrusive thoughts^3^NURSC^1
