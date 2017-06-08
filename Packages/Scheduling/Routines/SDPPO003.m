SDPPO003 ; ; 22-OCT-1993
 ;;5.3;Scheduling;**6**;AUG 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",478,10,14,0)
 ;;=719^CD^31
 ;;^UTILITY(U,$J,"PRO",478,10,14,"^")
 ;;=SDPP PATIENT PROFILE CHANGE DATE
 ;;^UTILITY(U,$J,"PRO",478,10,15,0)
 ;;=1068^PP^11
 ;;^UTILITY(U,$J,"PRO",478,10,15,"^")
 ;;=SDPP PATIENT PROFILE PRINT ALL
 ;;^UTILITY(U,$J,"PRO",478,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",478,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",478,99)
 ;;=55808,46353
 ;;^UTILITY(U,$J,"PRO",600,0)
 ;;=SDPP PATIENT PROFILE CHANGE PATIENT^Change Patient^^A^^^^^^^^SCHEDULING
 ;;^UTILITY(U,$J,"PRO",600,1,0)
 ;;=^^1^1^2921116^^
 ;;^UTILITY(U,$J,"PRO",600,1,1,0)
 ;;=This allows a user to change the patient within the Patient Profile.
 ;;^UTILITY(U,$J,"PRO",600,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",600,2,1,0)
 ;;=CP
 ;;^UTILITY(U,$J,"PRO",600,2,"B","CP",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",600,20)
 ;;=D CHPT^SDPP
 ;;^UTILITY(U,$J,"PRO",600,99)
 ;;=55350,29965
 ;;^UTILITY(U,$J,"PRO",719,0)
 ;;=SDPP PATIENT PROFILE CHANGE DATE^Change Date Range^^A^^^^^^^^SCHEDULING
 ;;^UTILITY(U,$J,"PRO",719,1,0)
 ;;=^^1^1^2930706^^^^
 ;;^UTILITY(U,$J,"PRO",719,1,1,0)
 ;;=This allows a user to change the date range within the Patient Profile.
 ;;^UTILITY(U,$J,"PRO",719,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",719,2,1,0)
 ;;=CD
 ;;^UTILITY(U,$J,"PRO",719,2,"B","CD",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",719,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",719,20)
 ;;=D DATE^SDPPSEL,CHDT^SDPP
 ;;^UTILITY(U,$J,"PRO",719,99)
 ;;=55626,30978
 ;;^UTILITY(U,$J,"PRO",1068,0)
 ;;=SDPP PATIENT PROFILE PRINT ALL^Print Profile^^A^^^^^^^^SCHEDULING
 ;;^UTILITY(U,$J,"PRO",1068,1,0)
 ;;=^^1^1^2931018^
 ;;^UTILITY(U,$J,"PRO",1068,1,1,0)
 ;;=This prints the patient profile.
 ;;^UTILITY(U,$J,"PRO",1068,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1068,2,1,0)
 ;;=PP
 ;;^UTILITY(U,$J,"PRO",1068,2,"B","PP",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1068,4)
 ;;=^^^PP
 ;;^UTILITY(U,$J,"PRO",1068,20)
 ;;=D ^SDPPRT
 ;;^UTILITY(U,$J,"PRO",1068,99)
 ;;=55808,44269
