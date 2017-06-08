DGYRO002 ; ; 15-MAR-1995
 ;;5.3;Registration;**45**;Aug 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1285,1,1,0)
 ;;=This allows the user to choose a specific dependent to edit
 ;;^UTILITY(U,$J,"PRO",1285,10,0)
 ;;=^101.01PA^0^0
 ;;^UTILITY(U,$J,"PRO",1285,15)
 ;;=K ^TMP("DGMTEP",$J)
 ;;^UTILITY(U,$J,"PRO",1285,20)
 ;;=D SEL^DGDEPU,RETDEP^DGDEP0,^DGDEPE
 ;;^UTILITY(U,$J,"PRO",1285,99)
 ;;=56315,49557
 ;;^UTILITY(U,$J,"PRO",1285,"MEN","DGMT MEANS TEST DEPENDENT MENU")
 ;;=1285^ED^25
 ;;^UTILITY(U,$J,"PRO",1286,0)
 ;;=DGMT MEANS TEST DEPENDENT EFFECTIVE^Edit Effective Date^^A^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",1286,1,0)
 ;;=^^1^1^2941104^^^
 ;;^UTILITY(U,$J,"PRO",1286,1,1,0)
 ;;=This will allow the user to edit an effective date of a dependent
 ;;^UTILITY(U,$J,"PRO",1286,20)
 ;;=D EN^DGDEP1
 ;;^UTILITY(U,$J,"PRO",1286,99)
 ;;=56315,49557
 ;;^UTILITY(U,$J,"PRO",1286,"MEN","DGMT MEANS TEST DEPENDENT UTIL")
 ;;=1286^EE^11
 ;;^UTILITY(U,$J,"PRO",1287,0)
 ;;=DGMT MEANS TEST DEPENDENT UTIL^Dependent Utilities^^M^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",1287,1,0)
 ;;=^^1^1^2950127^^^^
 ;;^UTILITY(U,$J,"PRO",1287,1,1,0)
 ;;=This is the utilities connected with mean test.
 ;;^UTILITY(U,$J,"PRO",1287,10,0)
 ;;=^101.01PA^0^1
 ;;^UTILITY(U,$J,"PRO",1287,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",1287,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",1287,99)
 ;;=56315,49558
 ;;^UTILITY(U,$J,"PRO",1288,0)
 ;;=DGMT MEANS TEST DEPENDENT REMOVE^Remove from Means/Copay Test^^A^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",1288,1,0)
 ;;=^^1^1^2941108^
 ;;^UTILITY(U,$J,"PRO",1288,1,1,0)
 ;;=This will allow the user to remove a dependent from the means test
 ;;^UTILITY(U,$J,"PRO",1288,20)
 ;;=D EN2^DGDEP2
 ;;^UTILITY(U,$J,"PRO",1288,99)
 ;;=56321,30645
 ;;^UTILITY(U,$J,"PRO",1288,"MEN","DGMT MEANS TEST DEPENDENT MENU")
 ;;=1288^RE^23
 ;;^UTILITY(U,$J,"PRO",1289,0)
 ;;=DGMT MEANS TEST DEPENDENT SPOUSE DEMO^Spouse Demographic^^A^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",1289,1,0)
 ;;=^^1^1^2941130^^
 ;;^UTILITY(U,$J,"PRO",1289,1,1,0)
 ;;=This protocol will allow the user to edit spouse's demographics
 ;;^UTILITY(U,$J,"PRO",1289,15)
 ;;=S VALMBCK="R"
 ;;^UTILITY(U,$J,"PRO",1289,20)
 ;;=D EN^DGDEP4
 ;;^UTILITY(U,$J,"PRO",1289,99)
 ;;=56315,49558
 ;;^UTILITY(U,$J,"PRO",1289,"MEN","DGMT MEANS TEST DEPENDENT MENU")
 ;;=1289^ES^12
 ;;^UTILITY(U,$J,"PRO",1290,0)
 ;;=DGMT MEANS TEST DEPENDENT DELETE^Delete Dependent^^A^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",1290,1,0)
 ;;=^^1^1^2950210^^
 ;;^UTILITY(U,$J,"PRO",1290,1,1,0)
 ;;=This allows a user to delete a dependent.
 ;;^UTILITY(U,$J,"PRO",1290,20)
 ;;=D EN^DGDEP5
 ;;^UTILITY(U,$J,"PRO",1290,99)
 ;;=56315,49557
 ;;^UTILITY(U,$J,"PRO",1290,"MEN","DGMT MEANS TEST DEPENDENT MENU")
 ;;=1290^DP^14
