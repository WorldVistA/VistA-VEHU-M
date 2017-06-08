VAQON005 ; ; 10-AUG-1994
 ;;1.5;PATIENT DATA EXCHANGE;**7**;NOV 17, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",474,"MEN","VAQ PDX8 (MENU)")
 ;;=474^EE^13^^^Expand Entry
 ;;^UTILITY(U,$J,"PRO",476,0)
 ;;=VALM BLANK 1^^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",476,1,0)
 ;;=^^1^1^2920203^
 ;;^UTILITY(U,$J,"PRO",476,1,1,0)
 ;;=This protocol is used to format spaces in menu lists.
 ;;^UTILITY(U,$J,"PRO",476,10,0)
 ;;=^101.01PA^0^0
 ;;^UTILITY(U,$J,"PRO",476,"MEN","VAQ PDX12 (MENU)")
 ;;=476^^11
 ;;^UTILITY(U,$J,"PRO",476,"MEN","VAQ PDX2 (MENU)")
 ;;=476^^22
 ;;^UTILITY(U,$J,"PRO",478,0)
 ;;=VALM BLANK 2^^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",478,1,0)
 ;;=^^1^1^2920203^
 ;;^UTILITY(U,$J,"PRO",478,1,1,0)
 ;;=This protocol is used to format spaces in menu lists.
 ;;^UTILITY(U,$J,"PRO",478,"MEN","VAQ PDX2 (MENU)")
 ;;=478^^32
 ;;^UTILITY(U,$J,"PRO",507,0)
 ;;=VAQ NEW PATIENT^New Patient^^A^^^^^^^^PATIENT DATA EXCHANGE
 ;;^UTILITY(U,$J,"PRO",507,1,0)
 ;;=^^1^1^2930721^^^^
 ;;^UTILITY(U,$J,"PRO",507,1,1,0)
 ;;=Allows the users to a new patient in the database
 ;;^UTILITY(U,$J,"PRO",507,4)
 ;;=^^^NEW PATIENT
 ;;^UTILITY(U,$J,"PRO",507,10,0)
 ;;=^101.01PA^1^1
 ;;^UTILITY(U,$J,"PRO",507,10,1,0)
 ;;=213^
 ;;^UTILITY(U,$J,"PRO",507,10,1,"^")
 ;;=VAQ DUPLICATE
 ;;^UTILITY(U,$J,"PRO",507,20)
 ;;=D NEW^VAQLED03
 ;;^UTILITY(U,$J,"PRO",507,99)
 ;;=55782,41815
 ;;^UTILITY(U,$J,"PRO",510,0)
 ;;=VAQ DISPLAY BY REQUESTOR^DISPLAY PDX BY REQUESTOR^^A^^^^^^^^PATIENT DATA EXCHANGE
 ;;^UTILITY(U,$J,"PRO",510,4)
 ;;=^^^SELECTS ENTRY FOR DISPLAY
 ;;^UTILITY(U,$J,"PRO",510,20)
 ;;=D SEL^VAQDIS12
 ;;^UTILITY(U,$J,"PRO",510,99)
 ;;=55790,59575
 ;;^UTILITY(U,$J,"PRO",511,0)
 ;;=VAQ PDX10 (MENU)^MENU FOR DISPLAY BY REQUESTOR^^M^^^^^^^^PATIENT DATA EXCHANGE
 ;;^UTILITY(U,$J,"PRO",511,1,0)
 ;;=^^1^1^2930930^^^^
 ;;^UTILITY(U,$J,"PRO",511,1,1,0)
 ;;=display custom options to user for display screen PDX9
 ;;^UTILITY(U,$J,"PRO",511,4)
 ;;=26^4^^OPTIONS MENU FOR PDX DISPLAY
 ;;^UTILITY(U,$J,"PRO",511,10,0)
 ;;=^101.01PA^1^23
 ;;^UTILITY(U,$J,"PRO",511,10,23,0)
 ;;=510^SE^11^^^Select Entry
 ;;^UTILITY(U,$J,"PRO",511,10,23,"^")
 ;;=VAQ DISPLAY BY REQUESTOR
 ;;^UTILITY(U,$J,"PRO",511,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",511,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",511,99)
 ;;=55790,60406
