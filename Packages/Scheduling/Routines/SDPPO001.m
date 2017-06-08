SDPPO001 ; ; 22-OCT-1993
 ;;5.3;Scheduling;**6**;AUG 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",471,0)
 ;;=SDPP PATIENT PROFILE DISPLAY ADD/EDITS^Add/Edits^^A^^^^^^^^SCHEDULING
 ;;^UTILITY(U,$J,"PRO",471,1,0)
 ;;=^^5^5^2920512^^^^
 ;;^UTILITY(U,$J,"PRO",471,1,1,0)
 ;;=This action will allow the user to display all add/edits or add/edits for
 ;;^UTILITY(U,$J,"PRO",471,1,2,0)
 ;;=a date range.
 ;;^UTILITY(U,$J,"PRO",471,1,3,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",471,1,4,0)
 ;;=It will also allow the user to select a specific clinic stop code to 
 ;;^UTILITY(U,$J,"PRO",471,1,5,0)
 ;;=display.
 ;;^UTILITY(U,$J,"PRO",471,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",471,2,1,0)
 ;;=AE
 ;;^UTILITY(U,$J,"PRO",471,2,"B","AE",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",471,15)
 ;;=K SDBEG,SDEND,SDLN,SDFLG,SDTYP,VALMHDREND
 ;;^UTILITY(U,$J,"PRO",471,20)
 ;;=N SDY S (SDTYP,SDFLG)=1,DIC=40.7 D ALL^SDPPSEL Q:SDERR  D ASK^SDPPSEL Q:SDERR  D ^SDPPALL
 ;;^UTILITY(U,$J,"PRO",471,99)
 ;;=55236,30073
 ;;^UTILITY(U,$J,"PRO",472,0)
 ;;=SDPP PATIENT PROFILE DISPLAY APPOINTMENTS^Appointments^^A^^^^^^^^SCHEDULING
 ;;^UTILITY(U,$J,"PRO",472,1,0)
 ;;=^^4^4^2930303^^^^
 ;;^UTILITY(U,$J,"PRO",472,1,1,0)
 ;;=This action will allow the user to display all appointments or appointments
 ;;^UTILITY(U,$J,"PRO",472,1,2,0)
 ;;=for a date range.
 ;;^UTILITY(U,$J,"PRO",472,1,3,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",472,1,4,0)
 ;;=It will also allow the user to select a specific clinic to display.
 ;;^UTILITY(U,$J,"PRO",472,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",472,2,1,0)
 ;;=AP
 ;;^UTILITY(U,$J,"PRO",472,2,"B","AP",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",472,15)
 ;;=K SDBEG,SDEND,SDLN,SDFLG,SDTYP,VALMHDREND,^TMP("SDAPT",$J)
 ;;^UTILITY(U,$J,"PRO",472,20)
 ;;=N SDY S (SDTYP,SDFLG)=2,DIC=44 D ALL^SDPPSEL Q:SDERR  D ASK^SDPPSEL Q:SDERR  D ^SDPPALL
 ;;^UTILITY(U,$J,"PRO",472,99)
 ;;=55236,30355
 ;;^UTILITY(U,$J,"PRO",473,0)
 ;;=SDPP PATIENT PROFILE DISPLAY ENROLLMENTS^Enrollments^^A^^^^^^^^SCHEDULING
 ;;^UTILITY(U,$J,"PRO",473,1,0)
 ;;=^^4^4^2930608^^^^
 ;;^UTILITY(U,$J,"PRO",473,1,1,0)
 ;;=This action will allow the user to display all enrollments or enrollments
 ;;^UTILITY(U,$J,"PRO",473,1,2,0)
 ;;=for a date range.
 ;;^UTILITY(U,$J,"PRO",473,1,3,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",473,1,4,0)
 ;;=It will also allow the user to select a specific clinic to display.
 ;;^UTILITY(U,$J,"PRO",473,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",473,2,2,0)
 ;;=DE
 ;;^UTILITY(U,$J,"PRO",473,2,"B","DE",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",473,15)
 ;;=K SDBEG,SDEND,SDFLG,SDLN,SDTYP,VALMHDREND,^TMP("SDENR",$J)
 ;;^UTILITY(U,$J,"PRO",473,20)
 ;;=N SDY,SDACT S (SDTYP,SDFLG)=4,DIC=44 D ALL^SDPPSEL Q:SDERR  D ASK^SDPPSEL Q:SDERR  D ^SDPPALL
 ;;^UTILITY(U,$J,"PRO",473,99)
 ;;=55236,30587
 ;;^UTILITY(U,$J,"PRO",474,0)
 ;;=SDPP PATIENT PROFILE DISPLAY DISPOSITIONS^Dispositions^^A^^^^^^^^SCHEDULING
 ;;^UTILITY(U,$J,"PRO",474,1,0)
 ;;=^^2^2^2920512^^
 ;;^UTILITY(U,$J,"PRO",474,1,1,0)
 ;;=This action will allow the user to display all dispositions or
 ;;^UTILITY(U,$J,"PRO",474,1,2,0)
 ;;=dispositions for a date range.
 ;;^UTILITY(U,$J,"PRO",474,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",474,2,2,0)
 ;;=DD
 ;;^UTILITY(U,$J,"PRO",474,2,"B","DD",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",474,15)
 ;;=K SDBEG,SDEND,SDLN,SDTYP,SDFLG,VALMHDREND
 ;;^UTILITY(U,$J,"PRO",474,20)
 ;;=N SDY S (SDTYP,SDFLG)=3 D ALL^SDPPSEL Q:SDERR  D ^SDPPALL
 ;;^UTILITY(U,$J,"PRO",474,99)
 ;;=55236,30706
 ;;^UTILITY(U,$J,"PRO",475,0)
 ;;=SDPP PATIENT PROFILE DISPLAY MEANS TEST^Means Test^^A^^^^^^^^SCHEDULING
 ;;^UTILITY(U,$J,"PRO",475,1,0)
 ;;=^^2^2^2920518^^^^
 ;;^UTILITY(U,$J,"PRO",475,1,1,0)
 ;;=This actions allows the user to display all Means Test Information or
