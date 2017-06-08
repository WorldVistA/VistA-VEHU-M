NURCCGFC ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14315,1,4,0)
 ;;=1927^Physical Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14315,1,5,0)
 ;;=1929^Corrective Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14315,1,6,0)
 ;;=2649^Respiratory Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14315,1,7,0)
 ;;=2579^Social Work Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14315,1,8,0)
 ;;=2718^Speech Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14315,5)
 ;;=specifically
 ;;^UTILITY("^GMRD(124.2,",$J,14315,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14315,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14315,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14320,0)
 ;;=assist to identify triggers to substance use/abuse [specify]^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14320,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14320,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14327,0)
 ;;=teach coping strategies^2^NURSC^11^24^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14327,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14327,1,1,0)
 ;;=2214^assertiveness training^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14327,1,2,0)
 ;;=15270^anger management^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14327,1,3,0)
 ;;=15271^stress management^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14327,1,4,0)
 ;;=1890^problem solving skills^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14327,1,5,0)
 ;;=15273^goal setting^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14327,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14327,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14327,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14328,0)
 ;;=[Extra Order]^3^NURSC^11^249^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14328,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14328,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14330,0)
 ;;=Related Problems^2^NURSC^7^164^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14330,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,14330,1,1,0)
 ;;=1987^Depression^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14330,1,2,0)
 ;;=1918^Social Isolation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14330,1,3,0)
 ;;=1944^Grieving, Dysfunctional^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14330,1,4,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14330,1,5,0)
 ;;=2077^Post Trauma Response^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14330,1,6,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14330,1,7,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14330,1,8,0)
 ;;=2079^Substance Abuse, Drugs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14330,1,9,0)
 ;;=1420^Fear^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14330,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14333,0)
 ;;=[Extra Order]^3^NURSC^11^250^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14333,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14333,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14348,0)
 ;;=Defining Characteristics^2^NURSC^12^168^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14348,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,14348,1,1,0)
 ;;=4036^cough effective with or without sputum^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14348,1,2,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14348,1,3,0)
 ;;=4038^breath sounds abnormal ie., wheezing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14348,1,4,0)
 ;;=4039^cough ineffective with or without wheezing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14348,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14348,1,6,0)
 ;;=1468^tachypnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14348,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14349,0)
 ;;=Defining Characteristics^2^NURSC^12^167^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14349,1,0)
 ;;=^124.21PI^8^8
