DGONI009 ; ; 13-AUG-1993
 ;;5.3;Registration;;Aug 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",796,1,2,0)
 ;;=Allows the user to select a group. The selected group, along with all of
 ;;^UTILITY(U,$J,"PRO",796,1,3,0)
 ;;=its selections, is deleted.
 ;;^UTILITY(U,$J,"PRO",796,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",796,2,1,0)
 ;;=DG
 ;;^UTILITY(U,$J,"PRO",796,2,"B","DG",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",796,20)
 ;;=D DELGRP^IBDF3
 ;;^UTILITY(U,$J,"PRO",796,99)
 ;;=55672,55951
 ;;^UTILITY(U,$J,"PRO",837,0)
 ;;=VAFED EDR INPATIENT CAPTURE^Inpatient EDR Interface for PIMS^^X^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",837,1,0)
 ;;=^^2^2^2930621^^
 ;;^UTILITY(U,$J,"PRO",837,1,1,0)
 ;;=This option is used to capture MAS events for reporting to the
 ;;^UTILITY(U,$J,"PRO",837,1,2,0)
 ;;=central system.
 ;;^UTILITY(U,$J,"PRO",837,20)
 ;;=D ^VAFEDG
 ;;^UTILITY(U,$J,"PRO",837,99)
 ;;=55712,61953
 ;;^UTILITY(U,$J,"PRO",837,"MEN","DGPM MOVEMENT EVENTS")
 ;;=837
 ;;^UTILITY(U,$J,"PRO",838,0)
 ;;=VAFED EDR OUTPATIENT CAPTURE^Outpatient EDR Interface for PIMS^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",838,1,0)
 ;;=^^3^3^2930623^^
 ;;^UTILITY(U,$J,"PRO",838,1,1,0)
 ;;=This option is used to collect specific out patient data and store it in
 ;;^UTILITY(U,$J,"PRO",838,1,2,0)
 ;;=the xxx file.  This data will transferred daily to the Boston Development
 ;;^UTILITY(U,$J,"PRO",838,1,3,0)
 ;;=Center.
 ;;^UTILITY(U,$J,"PRO",838,20)
 ;;=D ^VAFEDCAP
 ;;^UTILITY(U,$J,"PRO",838,99)
 ;;=55712,61954
 ;;^UTILITY(U,$J,"PRO",838,"MEN","SDAM APPOINTMENT EVENTS")
 ;;=838
