NURCCGAR ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6638,1,3,0)
 ;;=2002^role functioning^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6638,1,5,0)
 ;;=2004^interaction patterns^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6638,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6648,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^92^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6648,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,6648,1,1,0)
 ;;=2022^identifies 3 signs and symptoms of anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6648,1,2,0)
 ;;=2024^identifies 3 precipitating events to anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6648,1,3,0)
 ;;=2025^reports decrease in signs/symptoms of anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6648,1,4,0)
 ;;=865^sleeps for 4-5 hours without awakening^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6648,1,5,0)
 ;;=2029^verbalizes 3 activities that promote feelings of comfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6648,1,6,0)
 ;;=2031^identifies 3 sources of support^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6648,1,7,0)
 ;;=6923^[Extra Goal]^3^NURSC^133
 ;;^UTILITY("^GMRD(124.2,",$J,6648,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6655,0)
 ;;=[Extra Goal]^3^NURSC^9^129^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6655,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6655,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6656,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^80^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6656,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,6656,1,1,0)
 ;;=2032^monitor anxiety level/occurrence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6656,1,2,0)
 ;;=2033^help identify symptoms of anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6656,1,3,0)
 ;;=2034^point out observed behaviors indicative of anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6656,1,4,0)
 ;;=2036^spend [ ]min [freq]q shift to identify associated factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6656,1,5,0)
 ;;=2037^use active listening techniques^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6656,1,6,0)
 ;;=2039^identify and encourage anxiety-reducing activities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6656,1,7,0)
 ;;=2040^administer anti-anxiety medication as prescribed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6656,1,8,0)
 ;;=628^teach relaxation techniques^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6656,1,9,0)
 ;;=1735^teach expected side effects of drug therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6656,1,10,0)
 ;;=2041^teach/review medication use^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6656,1,11,0)
 ;;=6667^[Extra Order]^3^NURSC^135
 ;;^UTILITY("^GMRD(124.2,",$J,6656,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6656,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6667,0)
 ;;=[Extra Order]^3^NURSC^11^135^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6667,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6667,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6668,0)
 ;;=Related Problems^2^NURSC^7^79^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6668,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,6668,1,1,0)
 ;;=1948^Violence, Potential For, Directed At Others^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6668,1,2,0)
 ;;=1946^Violence, Potential For, Self Directed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6668,1,3,0)
 ;;=1945^Family Process, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6668,1,4,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6668,1,5,0)
 ;;=1416^Coping, Ineffective Family^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6668,1,6,0)
 ;;=1405^Depressive Behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6668,1,7,0)
 ;;=1420^Fear^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6668,1,8,0)
 ;;=1918^Social Isolation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6668,1,9,0)
 ;;=1916^Powerlessness^3^NURSC^1
