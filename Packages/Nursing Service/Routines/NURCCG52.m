NURCCG52 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1985,1,2,0)
 ;;=1987^Depression^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1985,1,3,0)
 ;;=1988^Non-compliance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1985,1,4,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1985,1,5,0)
 ;;=1990^Social Interaction, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1985,1,6,0)
 ;;=1918^Social Isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1985,1,7,0)
 ;;=1944^Grieving, Dysfunctional^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1985,1,8,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1985,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1986,0)
 ;;=development of alternative goals^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1987,0)
 ;;=Depression^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1988,0)
 ;;=Non-compliance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1989,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^54^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1989,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,1989,1,1,0)
 ;;=1997^interpersonal transmission and contagion^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1989,1,2,0)
 ;;=1851^situational crises^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1989,1,3,0)
 ;;=1847^maturational crises^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1989,1,4,0)
 ;;=1999^threat to or change in:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1989,1,5,0)
 ;;=2008^threat to self-concept^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1989,1,6,0)
 ;;=2009^threat of death^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1989,1,7,0)
 ;;=2010^unconscious conflict about essential values and goals^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1989,1,8,0)
 ;;=2012^unmet needs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1989,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1990,0)
 ;;=Social Interaction, Impaired^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1991,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^52^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1991,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1991,1,1,0)
 ;;=2022^identifies 3 signs and symptoms of anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1991,1,2,0)
 ;;=2024^identifies 3 precipitating events to anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1991,1,3,0)
 ;;=2025^reports decrease in signs/symptoms of anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1991,1,4,0)
 ;;=865^sleeps for 4-5 hours without awakening^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1991,1,5,0)
 ;;=2029^verbalizes 3 activities that promote feelings of comfort^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1991,1,6,0)
 ;;=2031^identifies 3 sources of support^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1991,1,7,0)
 ;;=2916^[Extra Goal]^3^NURSC^97^0
 ;;^UTILITY("^GMRD(124.2,",$J,1991,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1992,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^48^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1992,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,1992,1,1,0)
 ;;=2032^monitor anxiety level/occurrence^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1992,1,2,0)
 ;;=2033^help identify symptoms of anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1992,1,3,0)
 ;;=2034^point out observed behaviors indicative of anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1992,1,4,0)
 ;;=2036^spend [ ]min [freq]q shift to identify associated factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1992,1,5,0)
 ;;=2037^use active listening techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1992,1,6,0)
 ;;=2039^identify and encourage anxiety-reducing activities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1992,1,7,0)
 ;;=2040^administer anti-anxiety medication as prescribed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1992,1,8,0)
 ;;=628^teach relaxation techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1992,1,9,0)
 ;;=1735^teach expected side effects of drug therapy^3^NURSC^1^0
