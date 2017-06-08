NURCCG0B ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,113,0)
 ;;=refer to Social Work for assistance with finances^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,114,0)
 ;;=assist patient/family to acquire needed equipment/supplies^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,115,0)
 ;;=refer to O.T. for instructions on work simplification skills^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,116,0)
 ;;=refer to community agency for homemaker services/meals^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,117,0)
 ;;=report building violations to landlord/city department^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,118,0)
 ;;=encourage patient/family to report building violations^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,119,0)
 ;;=assess ability to safely maintain household^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,120,0)
 ;;=discuss long-term plan for managing situation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,121,0)
 ;;=Activity Intolerance^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,121,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,121,1,1,0)
 ;;=128^Etiology/Related and/or Risk Factors^2^NURSC^5^0
 ;;^UTILITY("^GMRD(124.2,",$J,121,1,2,0)
 ;;=129^Goals/Expected Outcomes^2^NURSC^5^0
 ;;^UTILITY("^GMRD(124.2,",$J,121,1,3,0)
 ;;=130^Nursing Intervention/Orders^2^NURSC^5^0
 ;;^UTILITY("^GMRD(124.2,",$J,121,1,4,0)
 ;;=131^Related Problems^2^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,121,1,5,0)
 ;;=4029^Defining Characteristics^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,121,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,121,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,121,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,121,"TD",0)
 ;;=^^3^3^2890623^^^
 ;;^UTILITY("^GMRD(124.2,",$J,121,"TD",1,0)
 ;;=A state in which an individual has insufficient physiological or
 ;;^UTILITY("^GMRD(124.2,",$J,121,"TD",2,0)
 ;;=psychological energy to endure or complete required or desired
 ;;^UTILITY("^GMRD(124.2,",$J,121,"TD",3,0)
 ;;=daily activities.
 ;;^UTILITY("^GMRD(124.2,",$J,122,0)
 ;;=Airway Clearance, Ineffective^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,122,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,122,1,1,0)
 ;;=303^Related Problems^2^NURSC^7^0
 ;;^UTILITY("^GMRD(124.2,",$J,122,1,2,0)
 ;;=304^Etiology/Related and/or Risk Factors^2^NURSC^8^0
 ;;^UTILITY("^GMRD(124.2,",$J,122,1,3,0)
 ;;=311^Goals/Expected Outcomes^2^NURSC^8^0
 ;;^UTILITY("^GMRD(124.2,",$J,122,1,4,0)
 ;;=310^Nursing Intervention/Orders^2^NURSC^6^0
 ;;^UTILITY("^GMRD(124.2,",$J,122,1,6,0)
 ;;=4034^Defining Characteristics^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,122,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,122,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,122,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,122,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,122,"TD",1,0)
 ;;=A state in which an individual is unable to clear secretions or
 ;;^UTILITY("^GMRD(124.2,",$J,122,"TD",2,0)
 ;;=obstructions from the respiratory tract to maintain airway patency.
 ;;^UTILITY("^GMRD(124.2,",$J,123,0)
 ;;=Breathing Pattern, Ineffective^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,123,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,123,1,1,0)
 ;;=415^Etiology/Related and/or Risk Factors^2^NURSC^9^0
 ;;^UTILITY("^GMRD(124.2,",$J,123,1,2,0)
 ;;=416^Related Problems^2^NURSC^8^0
 ;;^UTILITY("^GMRD(124.2,",$J,123,1,3,0)
 ;;=417^Goals/Expected Outcomes^2^NURSC^9^0
 ;;^UTILITY("^GMRD(124.2,",$J,123,1,4,0)
 ;;=418^Nursing Intervention/Orders^2^NURSC^167^0
 ;;^UTILITY("^GMRD(124.2,",$J,123,1,5,0)
 ;;=4070^Defining Characteristics^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,123,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,123,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,123,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,123,"TD",0)
 ;;=^^2^2^2890301^
