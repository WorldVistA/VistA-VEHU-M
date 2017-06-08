NURCCG59 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2075,1,7,0)
 ;;=2018^Sleep Pattern Disturbance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2075,1,8,0)
 ;;=1990^Social Interaction, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2075,1,9,0)
 ;;=1919^Spiritual Distress^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2075,1,10,0)
 ;;=1948^Violence, Potential For, Directed At Others^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2075,1,11,0)
 ;;=1946^Violence, Potential For, Self Directed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2075,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2076,0)
 ;;=physical problems related to alcohol use,e.g. cirrhosis^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2077,0)
 ;;=Post Trauma Response^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2078,0)
 ;;=Hopelessness ^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2079,0)
 ;;=Substance Abuse, Drugs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2080,0)
 ;;=free from all S/S of withdrawal within [ ]days of admission^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2080,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2080,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2081,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^55^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2081,1,0)
 ;;=^124.21PI^14^14
 ;;^UTILITY("^GMRD(124.2,",$J,2081,1,1,0)
 ;;=2082^verbalizes experience of overwhelming events by [date]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2081,1,2,0)
 ;;=2083^expresses feelings regarding events within [ ] hrs ^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2081,1,3,0)
 ;;=2089^develops 3 alternative coping methods prior to D/C^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2081,1,4,0)
 ;;=2090^verbalizes existence of flashbacks^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2081,1,5,0)
 ;;=2091^verbalizes intrusive thoughts^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2081,1,6,0)
 ;;=2092^verbalizes nightmares^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2081,1,7,0)
 ;;=2093^verbalizes repetitive dreams^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2081,1,8,0)
 ;;=2094^verbalizes emotional numbness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2081,1,9,0)
 ;;=2095^verbalizes social isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2081,1,10,0)
 ;;=2096^verbalizes other stress related symptoms: [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2081,1,11,0)
 ;;=2144^states presenting S/S to coorect stress response^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2081,1,12,0)
 ;;=2145^reports absence/significant decrease in stress symptoms^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2081,1,13,0)
 ;;=2146^develops written plan for achieving major life goals^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2081,1,14,0)
 ;;=2919^[Extra Goal]^3^NURSC^100^0
 ;;^UTILITY("^GMRD(124.2,",$J,2081,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2082,0)
 ;;=verbalizes experience of overwhelming events by [date]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2082,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2082,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2083,0)
 ;;=expresses feelings regarding events within [ ] hrs ^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2083,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,2083,1,1,0)
 ;;=2084^guilt^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2083,1,2,0)
 ;;=2086^grief^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2083,1,3,0)
 ;;=2085^remorse/self reproach^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2083,1,4,0)
 ;;=419^anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2083,1,5,0)
 ;;=2087^survivor guilt^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2083,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,2083,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2083,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2083,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2084,0)
 ;;=guilt^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2085,0)
 ;;=remorse/self reproach^3^NURSC^^1^^^T
