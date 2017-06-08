NURCCG31 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,999,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1000,0)
 ;;=assess general appearance^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1000,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1000,1,1,0)
 ;;=1002^diaphoretic^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1000,1,2,0)
 ;;=1003^pale^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1000,1,3,0)
 ;;=1004^cyanotic^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1000,1,4,0)
 ;;=1005^anxious/fearful^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1000,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,1000,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1000,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1000,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1001,0)
 ;;=test stool for Guiac^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1001,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1001,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1002,0)
 ;;=diaphoretic^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1003,0)
 ;;=pale^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1004,0)
 ;;=cyanotic^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1005,0)
 ;;=anxious/fearful^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1006,0)
 ;;=about critical care environment and routines^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1007,0)
 ;;=monitor side effects and tolerance of all medications^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1007,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1007,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1008,0)
 ;;=advise patient to notify the nurse of pain/discomfort^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1008,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1008,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1009,0)
 ;;=administer prescribed narcotic/analgesic^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1009,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1009,1,1,0)
 ;;=1011^Morphine Sulfate [dose] or other analgesic^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1009,1,2,0)
 ;;=1012^document medication response^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1009,1,3,0)
 ;;=1013^notify MD of untoward reactions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1009,1,4,0)
 ;;=1014^anticipate drug orders for persistent angina^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1009,1,5,0)
 ;;=1032^assess enzyme and iso-enzyme levels^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1009,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,1009,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1009,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1009,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1010,0)
 ;;=restrict foods/fluids that percipitate diarrhea [list items]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1010,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1010,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1011,0)
 ;;=Morphine Sulfate [dose] or other analgesic^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1012,0)
 ;;=document medication response^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1013,0)
 ;;=notify MD of untoward reactions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1014,0)
 ;;=anticipate drug orders for persistent angina^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1014,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1014,1,1,0)
 ;;=1017^nitroglycerin Sl or IV [sig] repeat at 5 min intervals^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1014,1,2,0)
 ;;=1025^isordil [dose] as indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1014,1,3,0)
 ;;=1028^propranolol [dose] as indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1014,1,4,0)
 ;;=1031^calcium channel blockers [agent] as indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1014,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,1014,7)
 ;;=D EN4^NURCCPU1
