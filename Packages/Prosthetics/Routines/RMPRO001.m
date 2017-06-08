RMPRO001 ; ;10/19/1993
 ;;2.0;PROSTHETICS;;10/19/1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",500,0)
 ;;=RMPR SCH EVENT^Update Prosthetics Scheduling Files.^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",500,1,0)
 ;;=^^1^1^2930226^^
 ;;^UTILITY(U,$J,"PRO",500,1,1,0)
 ;;=Update Prosthetics Scheduling Worksheet 2527
 ;;^UTILITY(U,$J,"PRO",500,20)
 ;;=D ^RMPRSC
 ;;^UTILITY(U,$J,"PRO",500,99)
 ;;=55809,58022
 ;;^UTILITY(U,$J,"PRO",500,"MEN","SDAM APPOINTMENT EVENTS")
 ;;=500^^3
