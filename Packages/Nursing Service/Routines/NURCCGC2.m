NURCCGC2 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9293,0)
 ;;=Related Problems^2^NURSC^7^107^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9293,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,9293,1,1,0)
 ;;=1420^Fear^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9293,1,2,0)
 ;;=1405^Depressive Behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9293,1,3,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9293,1,4,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9293,1,5,0)
 ;;=1915^Grieving, Anticipatory^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9293,1,6,0)
 ;;=1944^Grieving, Dysfunctional^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9293,1,7,0)
 ;;=1945^Family Process, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9293,1,8,0)
 ;;=1946^Violence, Potential For, Self Directed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9293,1,9,0)
 ;;=1948^Violence, Potential For, Directed At Others^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9293,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9307,0)
 ;;=Defining Characteristics^2^NURSC^12^109^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9307,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9307,1,1,0)
 ;;=4133^chronic worry, anxiety, depression^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9307,1,2,0)
 ;;=4135^inability to meet role expectations and for basic needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9307,1,3,0)
 ;;=4137^verbalization of inability to cope or ask for assistance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9307,1,4,0)
 ;;=4146^inability to problem solve^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9307,1,5,0)
 ;;=4147^inappropriate use of defense mechanisms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9307,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9352,0)
 ;;=[Extra Order]^3^NURSC^11^159^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9352,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9352,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9353,0)
 ;;=Defining Characteristics^2^NURSC^12^110^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9353,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,9353,1,1,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9353,1,2,0)
 ;;=630^fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9353,1,3,0)
 ;;=4122^abnormal heart sounds^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9353,1,4,0)
 ;;=4033^ECG changes reflecting arrhythmias or ischemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9353,1,5,0)
 ;;=4124^variations in hemodynamic readings^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9353,1,6,0)
 ;;=4125^cold clammy skin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9353,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9360,0)
 ;;=Pain, Acute^2^NURSC^2^7^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9360,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9360,1,1,0)
 ;;=9361^Etiology/Related and/or Risk Factors^2^NURSC^127
 ;;^UTILITY("^GMRD(124.2,",$J,9360,1,2,0)
 ;;=9379^Goals/Expected Outcomes^2^NURSC^125
 ;;^UTILITY("^GMRD(124.2,",$J,9360,1,3,0)
 ;;=9389^Nursing Intervention/Orders^2^NURSC^186
 ;;^UTILITY("^GMRD(124.2,",$J,9360,1,4,0)
 ;;=9406^Related Problems^2^NURSC^108
 ;;^UTILITY("^GMRD(124.2,",$J,9360,1,5,0)
 ;;=9417^Defining Characteristics^2^NURSC^111
 ;;^UTILITY("^GMRD(124.2,",$J,9360,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9360,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9360,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9360,"TD",0)
 ;;=^^2^2^2890825^^^
 ;;^UTILITY("^GMRD(124.2,",$J,9360,"TD",1,0)
 ;;=A state of discomfort that can last from one second to as long as 
 ;;^UTILITY("^GMRD(124.2,",$J,9360,"TD",2,0)
 ;;=six months.
 ;;^UTILITY("^GMRD(124.2,",$J,9361,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^127^^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9361,1,0)
 ;;=^124.21PI^11^2
 ;;^UTILITY("^GMRD(124.2,",$J,9361,1,3,0)
 ;;=2778^inflammation injury^3^NURSC^1
