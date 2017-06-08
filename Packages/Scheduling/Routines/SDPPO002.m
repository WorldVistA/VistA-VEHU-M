SDPPO002 ; ; 22-OCT-1993
 ;;5.3;Scheduling;**6**;AUG 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",475,1,2,0)
 ;;=specific Means Test Date.
 ;;^UTILITY(U,$J,"PRO",475,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",475,2,1,0)
 ;;=MT
 ;;^UTILITY(U,$J,"PRO",475,2,"B","MT",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",475,15)
 ;;=K SDBEG,SDEND,SDFLG,SDTYP,SDLN,VALMHDREND
 ;;^UTILITY(U,$J,"PRO",475,20)
 ;;=N SDY S (SDTYP,SDFLG)=5,DIC=408.31 D ALL^SDPPSEL Q:SDERR  D ASK^SDPPSEL Q:SDERR  D ^SDPPALL
 ;;^UTILITY(U,$J,"PRO",475,99)
 ;;=55236,30793
 ;;^UTILITY(U,$J,"PRO",476,0)
 ;;=SDPP PATIENT PROFILE DISPLAY ALL^All^^A^^^^^^^^SCHEDULING
 ;;^UTILITY(U,$J,"PRO",476,1,0)
 ;;=^^3^3^2920512^^
 ;;^UTILITY(U,$J,"PRO",476,1,1,0)
 ;;=This action allows the user to display all information concerning Add/Edits,
 ;;^UTILITY(U,$J,"PRO",476,1,2,0)
 ;;=Appointments, Enrollments, Dispositions, and Means Test Information, or
 ;;^UTILITY(U,$J,"PRO",476,1,3,0)
 ;;=will display the above for a date range.
 ;;^UTILITY(U,$J,"PRO",476,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",476,2,1,0)
 ;;=AL
 ;;^UTILITY(U,$J,"PRO",476,2,"B","AL",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",476,15)
 ;;=K SDBEG,SDEND,SDFLG,SDLN,SDTYP,SDALL,VALMHDREND
 ;;^UTILITY(U,$J,"PRO",476,20)
 ;;=K SDY S SDALL=1,(SDTYP,SDFLG)=6 D ALL^SDPPSEL Q:SDERR  D ^SDPPALL
 ;;^UTILITY(U,$J,"PRO",476,99)
 ;;=55236,34439
 ;;^UTILITY(U,$J,"PRO",477,0)
 ;;=SDPP PATIENT PROFILE DISPLAY INFO MENU^Display Info^^M^^^^^^^^SCHEDULING
 ;;^UTILITY(U,$J,"PRO",477,1,0)
 ;;=^^3^3^2920603^^^^
 ;;^UTILITY(U,$J,"PRO",477,1,1,0)
 ;;=This menu allows the user to display all time sensitive information.
 ;;^UTILITY(U,$J,"PRO",477,1,2,0)
 ;;=It will include Add/Edits, Appointments, Enrollments, Dispositions, and
 ;;^UTILITY(U,$J,"PRO",477,1,3,0)
 ;;=Mean Test Information.
 ;;^UTILITY(U,$J,"PRO",477,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",477,2,1,0)
 ;;=DI
 ;;^UTILITY(U,$J,"PRO",477,2,"B","DI",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",477,4)
 ;;=40^3
 ;;^UTILITY(U,$J,"PRO",477,10,0)
 ;;=^101.01PA^6^16
 ;;^UTILITY(U,$J,"PRO",477,10,1,0)
 ;;=471^AE^11
 ;;^UTILITY(U,$J,"PRO",477,10,1,"^")
 ;;=SDPP PATIENT PROFILE DISPLAY ADD/EDITS
 ;;^UTILITY(U,$J,"PRO",477,10,2,0)
 ;;=472^AP^12
 ;;^UTILITY(U,$J,"PRO",477,10,2,"^")
 ;;=SDPP PATIENT PROFILE DISPLAY APPOINTMENTS
 ;;^UTILITY(U,$J,"PRO",477,10,3,0)
 ;;=473^DE^13
 ;;^UTILITY(U,$J,"PRO",477,10,3,"^")
 ;;=SDPP PATIENT PROFILE DISPLAY ENROLLMENTS
 ;;^UTILITY(U,$J,"PRO",477,10,4,0)
 ;;=474^DD^14
 ;;^UTILITY(U,$J,"PRO",477,10,4,"^")
 ;;=SDPP PATIENT PROFILE DISPLAY DISPOSITIONS
 ;;^UTILITY(U,$J,"PRO",477,10,5,0)
 ;;=475^MT^15
 ;;^UTILITY(U,$J,"PRO",477,10,5,"^")
 ;;=SDPP PATIENT PROFILE DISPLAY MEANS TEST
 ;;^UTILITY(U,$J,"PRO",477,10,16,0)
 ;;=476^AL^21
 ;;^UTILITY(U,$J,"PRO",477,10,16,"^")
 ;;=SDPP PATIENT PROFILE DISPLAY ALL
 ;;^UTILITY(U,$J,"PRO",477,15)
 ;;=S VALMBCK="R"
 ;;^UTILITY(U,$J,"PRO",477,20)
 ;;=
 ;;^UTILITY(U,$J,"PRO",477,26)
 ;;=W ""
 ;;^UTILITY(U,$J,"PRO",477,27)
 ;;=S VAR="HLPTXT1" D HLP^SDPPHLP
 ;;^UTILITY(U,$J,"PRO",477,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",477,99)
 ;;=55315,56989
 ;;^UTILITY(U,$J,"PRO",478,0)
 ;;=SDPP PATIENT PROFILE MENU^Patient Profile^^M^^^^^^^^SCHEDULING
 ;;^UTILITY(U,$J,"PRO",478,1,0)
 ;;=^^1^1^2931015^^^^
 ;;^UTILITY(U,$J,"PRO",478,1,1,0)
 ;;=This is the main menu for the Patient Profile.
 ;;^UTILITY(U,$J,"PRO",478,4)
 ;;=26^3
 ;;^UTILITY(U,$J,"PRO",478,10,0)
 ;;=^101.01PA^4^15
 ;;^UTILITY(U,$J,"PRO",478,10,1,0)
 ;;=477^DI^10
 ;;^UTILITY(U,$J,"PRO",478,10,1,"^")
 ;;=SDPP PATIENT PROFILE DISPLAY INFO MENU
 ;;^UTILITY(U,$J,"PRO",478,10,13,0)
 ;;=600^CP^21
 ;;^UTILITY(U,$J,"PRO",478,10,13,"^")
 ;;=SDPP PATIENT PROFILE CHANGE PATIENT
