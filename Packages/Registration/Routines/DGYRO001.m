DGYRO001 ; ; 15-MAR-1995
 ;;5.3;Registration;**45**;Aug 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",647,0)
 ;;=VALM BLANK 1^^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",647,1,0)
 ;;=^^1^1^2920203^
 ;;^UTILITY(U,$J,"PRO",647,1,1,0)
 ;;=This protocol is used to format spaces in menu lists.
 ;;^UTILITY(U,$J,"PRO",647,10,0)
 ;;=^101.01PA^0^0
 ;;^UTILITY(U,$J,"PRO",647,"MEN","DGMT MEANS TEST DEPENDENT MENU")
 ;;=647^^15
 ;;^UTILITY(U,$J,"PRO",1279,0)
 ;;=DGMT MEANS TEST DEPENDENT ADD^Add to Means/Copay Test^^A^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",1279,1,0)
 ;;=^^1^1^2950315^^^
 ;;^UTILITY(U,$J,"PRO",1279,1,1,0)
 ;;=This protocol is for adding dependents to means test.
 ;;^UTILITY(U,$J,"PRO",1279,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1279,2,1,0)
 ;;=AD
 ;;^UTILITY(U,$J,"PRO",1279,2,"B","AD",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1279,20)
 ;;=D EN1^DGDEP2
 ;;^UTILITY(U,$J,"PRO",1279,99)
 ;;=56321,30581
 ;;^UTILITY(U,$J,"PRO",1279,"MEN","DGMT MEANS TEST DEPENDENT MENU")
 ;;=1279^AD^22
 ;;^UTILITY(U,$J,"PRO",1280,0)
 ;;=DGMT MEANS TEST DEPENDENT MENU^Means/Copay Test Dependents^^M^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",1280,1,0)
 ;;=^^1^1^2950130^^^^
 ;;^UTILITY(U,$J,"PRO",1280,1,1,0)
 ;;=This is used for the Means Test Dependents utility.
 ;;^UTILITY(U,$J,"PRO",1280,4)
 ;;=40^3
 ;;^UTILITY(U,$J,"PRO",1280,10,0)
 ;;=^101.01PA^0^10
 ;;^UTILITY(U,$J,"PRO",1280,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",1280,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",1280,99)
 ;;=56321,30645
 ;;^UTILITY(U,$J,"PRO",1280,101.0431,0)
 ;;=^^1^1^2941215^
 ;;^UTILITY(U,$J,"PRO",1280,101.0431,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",1281,0)
 ;;=DGMT MEANS TEST DEPENDENT CHILD^Marital/Dependent Info^^A^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",1281,1,0)
 ;;=^^3^3^2941108^^
 ;;^UTILITY(U,$J,"PRO",1281,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",1281,1,2,0)
 ;;=This protocol is used to edit the dependent demographic
 ;;^UTILITY(U,$J,"PRO",1281,1,3,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",1281,15)
 ;;=S VALMBCK="R"
 ;;^UTILITY(U,$J,"PRO",1281,20)
 ;;=D EN3^DGDEP2
 ;;^UTILITY(U,$J,"PRO",1281,99)
 ;;=56315,49556
 ;;^UTILITY(U,$J,"PRO",1281,"MEN","DGMT MEANS TEST DEPENDENT MENU")
 ;;=1281^MT^21
 ;;^UTILITY(U,$J,"PRO",1282,0)
 ;;=DGMT MEANS TEST DEPENDENT ADDDEP^Spouse/Dependent Add^^A^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",1282,1,0)
 ;;=^^1^1^2941114^
 ;;^UTILITY(U,$J,"PRO",1282,1,1,0)
 ;;=This will allow the user to add a new dependent.
 ;;^UTILITY(U,$J,"PRO",1282,20)
 ;;=D ADDEP^DGDEP4
 ;;^UTILITY(U,$J,"PRO",1282,99)
 ;;=56315,49556
 ;;^UTILITY(U,$J,"PRO",1282,"MEN","DGMT MEANS TEST DEPENDENT MENU")
 ;;=1282^DA^11
 ;;^UTILITY(U,$J,"PRO",1283,0)
 ;;=DGMT MEANS TEST DEPENDENT COPY^Copy Data^^A^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",1283,1,0)
 ;;=^^1^1^2941123^^
 ;;^UTILITY(U,$J,"PRO",1283,1,1,0)
 ;;=This will allow the user to copy income/dependents data.
 ;;^UTILITY(U,$J,"PRO",1283,20)
 ;;=D COPY^DGDEP4
 ;;^UTILITY(U,$J,"PRO",1283,99)
 ;;=56315,49556
 ;;^UTILITY(U,$J,"PRO",1283,"MEN","DGMT MEANS TEST DEPENDENT MENU")
 ;;=1283^CD^24
 ;;^UTILITY(U,$J,"PRO",1284,0)
 ;;=DGMT MEANS TEST DEPENDENT DEMO^Dependent Demographic^^A^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",1284,1,0)
 ;;=^^1^1^2941122^
 ;;^UTILITY(U,$J,"PRO",1284,1,1,0)
 ;;=This allows the user the edit the dependent demographics.
 ;;^UTILITY(U,$J,"PRO",1284,20)
 ;;=D EDITDEP^DGDEP4
 ;;^UTILITY(U,$J,"PRO",1284,99)
 ;;=56315,49557
 ;;^UTILITY(U,$J,"PRO",1284,"MEN","DGMT MEANS TEST DEPENDENT MENU")
 ;;=1284^DD^13
 ;;^UTILITY(U,$J,"PRO",1285,0)
 ;;=DGMT MEANS TEST DEPENDENT EDIT^Expand Dependent^^A^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",1285,1,0)
 ;;=^^1^1^2941122^^^^
