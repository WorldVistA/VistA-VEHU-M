NURCCG1R ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,627,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,628,0)
 ;;=teach relaxation techniques^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,628,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,628,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,629,0)
 ;;=refer for consultation or support resource^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,629,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,629,1,1,0)
 ;;=636^psychology^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,629,1,2,0)
 ;;=637^psychiatry^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,629,1,3,0)
 ;;=638^American Cancer Society^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,629,1,4,0)
 ;;=639^American Heart Association^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,629,1,5,0)
 ;;=640^other [ ADDITIONAL TEXT ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,629,1,6,0)
 ;;=2658^diet^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,629,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,629,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,629,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,629,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,630,0)
 ;;=fatigue^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,631,0)
 ;;=alcohol consumption^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,632,0)
 ;;=prostatitis/urethritis^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,633,0)
 ;;=anger^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,634,0)
 ;;=ignorance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,635,0)
 ;;=therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,636,0)
 ;;=psychology^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,637,0)
 ;;=psychiatry^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,638,0)
 ;;=American Cancer Society^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,639,0)
 ;;=American Heart Association^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,640,0)
 ;;=other [ ADDITIONAL TEXT ]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,641,0)
 ;;=Infection Potential^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,641,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,641,1,1,0)
 ;;=534^Etiology/Related and/or Risk Factors^2^NURSC^13^0
 ;;^UTILITY("^GMRD(124.2,",$J,641,1,2,0)
 ;;=535^Goals/Expected Outcomes^2^NURSC^13^0
 ;;^UTILITY("^GMRD(124.2,",$J,641,1,3,0)
 ;;=536^Nursing Intervention/Orders^2^NURSC^10^0
 ;;^UTILITY("^GMRD(124.2,",$J,641,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,641,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,641,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,641,"TD",0)
 ;;=^^2^2^2890802^^
 ;;^UTILITY("^GMRD(124.2,",$J,641,"TD",1,0)
 ;;=The state in which an individual is at increased risk for being invaded
 ;;^UTILITY("^GMRD(124.2,",$J,641,"TD",2,0)
 ;;=by pathogenic organisms.
 ;;^UTILITY("^GMRD(124.2,",$J,642,0)
 ;;=Sexual Dysfunction^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,642,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,642,1,1,0)
 ;;=601^Etiology/Related and/or Risk Factors^2^NURSC^15^0
 ;;^UTILITY("^GMRD(124.2,",$J,642,1,2,0)
 ;;=602^Goals/Expected Outcomes^2^NURSC^15^0
 ;;^UTILITY("^GMRD(124.2,",$J,642,1,3,0)
 ;;=603^Nursing Intervention/Orders^2^NURSC^12^0
 ;;^UTILITY("^GMRD(124.2,",$J,642,1,4,0)
 ;;=604^Related Problems^2^NURSC^12^0
 ;;^UTILITY("^GMRD(124.2,",$J,642,1,5,0)
 ;;=4204^Defining Characteristics^2^NURSC^30
 ;;^UTILITY("^GMRD(124.2,",$J,642,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,642,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,642,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,642,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,642,"TD",1,0)
 ;;=The state in which an individual experiences a change in sexual function
 ;;^UTILITY("^GMRD(124.2,",$J,642,"TD",2,0)
 ;;=that is viewed as unsatisfying, unrewarding, or inadequate.
 ;;^UTILITY("^GMRD(124.2,",$J,643,0)
 ;;=Sexual Pattern, Altered^2^NURSC^2^1^1^^T
