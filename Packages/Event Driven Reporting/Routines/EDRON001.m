EDRON001 ; ; 09-JUL-1993
 ;;1.5;EVENT DRIVEN REPORTING;;JUL 09, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",559,0)
 ;;=EDR CAPTURE EVENTS^Event Driven Reporting Interface for MAS^^X^^^^^^^^EVENT DRIVEN REPORTING
 ;;^UTILITY(U,$J,"PRO",559,1,0)
 ;;=^^2^2^2930320^^
 ;;^UTILITY(U,$J,"PRO",559,1,1,0)
 ;;=This option is used to capture MAS events for reporting to the
 ;;^UTILITY(U,$J,"PRO",559,1,2,0)
 ;;=central system.
 ;;^UTILITY(U,$J,"PRO",559,20)
 ;;=D ^EDRGEN
 ;;^UTILITY(U,$J,"PRO",559,99)
 ;;=55662,67167
 ;;^UTILITY(U,$J,"PRO",559,"MEN","DGPM MOVEMENT EVENTS")
 ;;=559
