NURCCGF9 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14245,1,3,0)
 ;;=14288^Nursing Intervention/Orders^2^NURSC^158
 ;;^UTILITY("^GMRD(124.2,",$J,14245,1,4,0)
 ;;=14330^Related Problems^2^NURSC^164
 ;;^UTILITY("^GMRD(124.2,",$J,14245,1,5,0)
 ;;=14349^Defining Characteristics^2^NURSC^167
 ;;^UTILITY("^GMRD(124.2,",$J,14245,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14245,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14245,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14245,"TD",0)
 ;;=^^7^7^2910822^^^
 ;;^UTILITY("^GMRD(124.2,",$J,14245,"TD",1,0)
 ;;=A state which involves drinking of alcohol which occurs as follows:
 ;;^UTILITY("^GMRD(124.2,",$J,14245,"TD",2,0)
 ;;=  1) regular daily intervals, or regular weekend intervals or during
 ;;^UTILITY("^GMRD(124.2,",$J,14245,"TD",3,0)
 ;;=     binges, with difficulty stopping or reducing the amount of
 ;;^UTILITY("^GMRD(124.2,",$J,14245,"TD",4,0)
 ;;=     alcohol used,
 ;;^UTILITY("^GMRD(124.2,",$J,14245,"TD",5,0)
 ;;=  2) a pattern of pathological alcohol use extending for at least 1 
 ;;^UTILITY("^GMRD(124.2,",$J,14245,"TD",6,0)
 ;;=     month,
 ;;^UTILITY("^GMRD(124.2,",$J,14245,"TD",7,0)
 ;;=  3) impaired social or occupational role functioning.
 ;;^UTILITY("^GMRD(124.2,",$J,14247,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^191^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14247,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,14247,1,1,0)
 ;;=2052^genetic factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14247,1,2,0)
 ;;=2053^sociocultural drinking patterns^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14247,1,3,0)
 ;;=2054^peer pressure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14247,1,4,0)
 ;;=14255^psychological needs such as:^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14247,1,5,0)
 ;;=2064^increased stress^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14247,1,6,0)
 ;;=14267^pattern of pathological alcohol use such as:^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14247,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14255,0)
 ;;=psychological needs such as:^2^NURSC^^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14255,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14255,1,1,0)
 ;;=2061^dependency^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14255,1,2,0)
 ;;=2062^low self-esteem^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14255,1,3,0)
 ;;=2063^inadequate self identity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14255,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14267,0)
 ;;=pattern of pathological alcohol use such as:^2^NURSC^^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14267,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14267,1,1,0)
 ;;=2069^inability to stop drinking^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14267,1,2,0)
 ;;=2073^binges or alcohol use necessary for daily functioning^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14267,1,3,0)
 ;;=2076^physical problems related to alcohol use,e.g. cirrhosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14267,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14274,0)
 ;;=provide patient teaching (Airway Clearance, Ineffective)^2^NURSC^11^6^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14274,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,14274,1,1,0)
 ;;=397^anatomy, physiology, and corrective factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14274,1,2,0)
 ;;=398^educate in S/S of respiratory infection, bronchospasm, etc^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14274,1,3,0)
 ;;=14278^teach patient actions to take when S/S reoccur^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,14274,1,4,0)
 ;;=14293^consider/discuss preventive measures^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,14274,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14274,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14274,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14275,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^188^1^^T
