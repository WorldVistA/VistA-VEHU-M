VAQON002 ; ; 10-AUG-1994
 ;;1.5;PATIENT DATA EXCHANGE;**7**;NOV 17, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",148,1,0)
 ;;=^^1^1^2930721^^^^
 ;;^UTILITY(U,$J,"PRO",148,1,1,0)
 ;;=Allows the users to create multiple entries
 ;;^UTILITY(U,$J,"PRO",148,4)
 ;;=^^^COPY REQUEST
 ;;^UTILITY(U,$J,"PRO",148,20)
 ;;=D COPY^VAQREQ02
 ;;^UTILITY(U,$J,"PRO",148,99)
 ;;=55782,41814
 ;;^UTILITY(U,$J,"PRO",149,0)
 ;;=VAQ PDX3 (MENU)^List Process Options^^M^^^^^^^^PATIENT DATA EXCHANGE
 ;;^UTILITY(U,$J,"PRO",149,1,0)
 ;;=^^1^1^2940119^^^^
 ;;^UTILITY(U,$J,"PRO",149,1,1,0)
 ;;=display custom options to user for manual process PDX activity screen PDX3
 ;;^UTILITY(U,$J,"PRO",149,4)
 ;;=26^4^^custom entries for PDX3
 ;;^UTILITY(U,$J,"PRO",149,10,0)
 ;;=^101.01PA^1^14
 ;;^UTILITY(U,$J,"PRO",149,10,14,0)
 ;;=153^PM^11
 ;;^UTILITY(U,$J,"PRO",149,10,14,"^")
 ;;=VAQ PROCESS MANUAL
 ;;^UTILITY(U,$J,"PRO",149,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",149,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",149,99)
 ;;=55783,48362
 ;;^UTILITY(U,$J,"PRO",150,0)
 ;;=VAQ PROCESS RELEASE^Release W/Comment^^A^^^^^^^^PATIENT DATA EXCHANGE
 ;;^UTILITY(U,$J,"PRO",150,1,0)
 ;;=^^1^1^2930326^^^^
 ;;^UTILITY(U,$J,"PRO",150,1,1,0)
 ;;=Manual process PDX request, Release
 ;;^UTILITY(U,$J,"PRO",150,4)
 ;;=^^^ PROCESS RELEASE W/COMMENT
 ;;^UTILITY(U,$J,"PRO",150,20)
 ;;=D REL^VAQEXT02
 ;;^UTILITY(U,$J,"PRO",150,99)
 ;;=55782,41818
 ;;^UTILITY(U,$J,"PRO",151,0)
 ;;=VAQ PROCESS REJECT^Reject W/Comment^^A^^^^^^^^PATIENT DATA EXCHANGE
 ;;^UTILITY(U,$J,"PRO",151,1,0)
 ;;=^^1^1^2930326^^^^
 ;;^UTILITY(U,$J,"PRO",151,1,1,0)
 ;;=Manual process PDX, Reject
 ;;^UTILITY(U,$J,"PRO",151,4)
 ;;=^^^PROCESS REJECT W/COMMENT
 ;;^UTILITY(U,$J,"PRO",151,20)
 ;;=D REJ^VAQEXT02
 ;;^UTILITY(U,$J,"PRO",151,99)
 ;;=55782,41818
 ;;^UTILITY(U,$J,"PRO",152,0)
 ;;=VAQ PDX4 (MENU)^List Process Options^^M^^^^^^^^PATIENT DATA EXCHANGE
 ;;^UTILITY(U,$J,"PRO",152,1,0)
 ;;=^^1^1^2931008^^^^
 ;;^UTILITY(U,$J,"PRO",152,1,1,0)
 ;;=display custom options to user for manual process screen PDX4
 ;;^UTILITY(U,$J,"PRO",152,4)
 ;;=26^4^^VAQ PDX4 MANUAL PROCESS
 ;;^UTILITY(U,$J,"PRO",152,10,0)
 ;;=^101.01PA^2^16
 ;;^UTILITY(U,$J,"PRO",152,10,14,0)
 ;;=150^RL^11
 ;;^UTILITY(U,$J,"PRO",152,10,14,"^")
 ;;=VAQ PROCESS RELEASE
 ;;^UTILITY(U,$J,"PRO",152,10,15,0)
 ;;=151^RJ^12
 ;;^UTILITY(U,$J,"PRO",152,10,15,"^")
 ;;=VAQ PROCESS REJECT
 ;;^UTILITY(U,$J,"PRO",152,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",152,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",152,99)
 ;;=55979,31808
 ;;^UTILITY(U,$J,"PRO",153,0)
 ;;=VAQ PROCESS MANUAL^Process Manual^^A^^^^^^^^PATIENT DATA EXCHANGE
 ;;^UTILITY(U,$J,"PRO",153,1,0)
 ;;=^^1^1^2940119^^^^
 ;;^UTILITY(U,$J,"PRO",153,1,1,0)
 ;;=This option allows the user to select the PDX to manually process
 ;;^UTILITY(U,$J,"PRO",153,4)
 ;;=^^^PROCESS MANUAL PDX REQUEST
 ;;^UTILITY(U,$J,"PRO",153,20)
 ;;=D PM^VAQEXT04
 ;;^UTILITY(U,$J,"PRO",153,99)
 ;;=55782,41818
 ;;^UTILITY(U,$J,"PRO",206,0)
 ;;=VAQ PDX5 (MENU)^List Request Options^^M^^^^^^^^PATIENT DATA EXCHANGE
 ;;^UTILITY(U,$J,"PRO",206,1,0)
 ;;=^^1^1^2940128^^^^
 ;;^UTILITY(U,$J,"PRO",206,1,1,0)
 ;;=display custom options to user for status screen PDX5
 ;;^UTILITY(U,$J,"PRO",206,4)
 ;;=26^4^^VAQ LED STATUS MENU
 ;;^UTILITY(U,$J,"PRO",206,10,0)
 ;;=^101.01PA^1^24
 ;;^UTILITY(U,$J,"PRO",206,10,23,0)
 ;;=207^LE^11
 ;;^UTILITY(U,$J,"PRO",206,10,23,"^")
 ;;=VAQ LOAD EDIT
 ;;^UTILITY(U,$J,"PRO",206,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",206,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",206,99)
 ;;=56045,61391
 ;;^UTILITY(U,$J,"PRO",207,0)
 ;;=VAQ LOAD EDIT^Load/Edit^^A^^^^^^^^PATIENT DATA EXCHANGE
 ;;^UTILITY(U,$J,"PRO",207,4)
 ;;=^^^LOAD EDIT SELECTOR
