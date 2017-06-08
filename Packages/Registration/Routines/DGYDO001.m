DGYDO001 ; ; 20-JAN-1994
 ;;5.3;Registration;**9**;Aug 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1508,0)
 ;;=VALM PRINT LIST^Print List^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",1508,1,0)
 ;;=^^2^2^2920113^
 ;;^UTILITY(U,$J,"PRO",1508,1,1,0)
 ;;=This action allws the user to print the entire list of
 ;;^UTILITY(U,$J,"PRO",1508,1,2,0)
 ;;=entries currently being displayed.
 ;;^UTILITY(U,$J,"PRO",1508,20)
 ;;=D PRTL^VALM1
 ;;^UTILITY(U,$J,"PRO",1508,99)
 ;;=55879,46139
 ;;^UTILITY(U,$J,"PRO",1508,"MEN","DGJ IRT VIEW MENU")
 ;;=1508^PL^12
 ;;^UTILITY(U,$J,"PRO",1511,0)
 ;;=VALM BLANK 1^^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",1511,1,0)
 ;;=^^1^1^2920203^
 ;;^UTILITY(U,$J,"PRO",1511,1,1,0)
 ;;=This protocol is used to format spaces in menu lists.
 ;;^UTILITY(U,$J,"PRO",1511,"MEN","DGJ IRT VIEW MENU")
 ;;=1511^^22
 ;;^UTILITY(U,$J,"PRO",1513,0)
 ;;=VALM BLANK 2^^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",1513,1,0)
 ;;=^^1^1^2920203^
 ;;^UTILITY(U,$J,"PRO",1513,1,1,0)
 ;;=This protocol is used to format spaces in menu lists.
 ;;^UTILITY(U,$J,"PRO",1513,"MEN","DGJ IRT VIEW MENU")
 ;;=1513^^32
 ;;^UTILITY(U,$J,"PRO",1541,0)
 ;;=DGJ ENTER/EDIT DEFICIENCY MENU^Records Deficiencies Menu^^M^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",1541,1,0)
 ;;=^^1^1^2940119^^^^
 ;;^UTILITY(U,$J,"PRO",1541,1,1,0)
 ;;=This menu contains all the activities for the IRT DEFICIENCY TRACKING option
 ;;^UTILITY(U,$J,"PRO",1541,4)
 ;;=26^4^^RD
 ;;^UTILITY(U,$J,"PRO",1541,10,0)
 ;;=^101.01PA^0^13
 ;;^UTILITY(U,$J,"PRO",1541,15)
 ;;=K DGJTHFLG
 ;;^UTILITY(U,$J,"PRO",1541,20)
 ;;=S DGJTHFLG="EN"
 ;;^UTILITY(U,$J,"PRO",1541,24)
 ;;=I 1 X:$D(^ORD(101,+$P(^ORD(101,DA(1),10,DA,0),"^",1),24)) ^(24)
 ;;^UTILITY(U,$J,"PRO",1541,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",1541,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",1541,99)
 ;;=55826,29519
 ;;^UTILITY(U,$J,"PRO",1546,0)
 ;;=DGJ IRT EXP^Expand Deficiency^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",1546,1,0)
 ;;=^^4^4^2921008^^
 ;;^UTILITY(U,$J,"PRO",1546,1,1,0)
 ;;=This protocol is the action to expand a selection.  When a selection is
 ;;^UTILITY(U,$J,"PRO",1546,1,2,0)
 ;;=chosen this action will display all the data in the file. If the selection
 ;;^UTILITY(U,$J,"PRO",1546,1,3,0)
 ;;=is an OP report, interim summary,  or discharge summary, the IRT record
 ;;^UTILITY(U,$J,"PRO",1546,1,4,0)
 ;;=associated with that selection will be displayed also.
 ;;^UTILITY(U,$J,"PRO",1546,2,0)
 ;;=^101.02A^2^2
 ;;^UTILITY(U,$J,"PRO",1546,2,1,0)
 ;;=EX
 ;;^UTILITY(U,$J,"PRO",1546,2,2,0)
 ;;=EP
 ;;^UTILITY(U,$J,"PRO",1546,2,"B","EP",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1546,2,"B","EX",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1546,4)
 ;;=^^^ED
 ;;^UTILITY(U,$J,"PRO",1546,20)
 ;;=D EXP^DGJTEE1
 ;;^UTILITY(U,$J,"PRO",1546,99)
 ;;=55742,56543
 ;;^UTILITY(U,$J,"PRO",1546,"MEN","DGJ IRT VIEW MENU")
 ;;=1546^EP^11
 ;;^UTILITY(U,$J,"PRO",1547,0)
 ;;=DGJ CHNG PAT^Change Patient^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",1547,1,0)
 ;;=^^1^1^2921008^^
 ;;^UTILITY(U,$J,"PRO",1547,1,1,0)
 ;;=This protocol is the action to change a patient.
 ;;^UTILITY(U,$J,"PRO",1547,4)
 ;;=^^^CD
 ;;^UTILITY(U,$J,"PRO",1547,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1547,20)
 ;;=D PAT1^DGJTEE1
 ;;^UTILITY(U,$J,"PRO",1547,26)
 ;;=D HDR^DGJTEE
 ;;^UTILITY(U,$J,"PRO",1547,99)
 ;;=55742,56539
 ;;^UTILITY(U,$J,"PRO",1547,"MEN","DGJ IRT VIEW MENU")
 ;;=1547^PT^21
 ;;^UTILITY(U,$J,"PRO",1557,0)
 ;;=DGJ DELETE MENU^Delete a Record Menu^^M^^^^^^^^INCOMPLETE RECORD TRACKING
 ;;^UTILITY(U,$J,"PRO",1557,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",1557,10,0)
 ;;=^101.01PA^0^2
 ;;^UTILITY(U,$J,"PRO",1557,15)
 ;;=K DGJTHFLG
 ;;^UTILITY(U,$J,"PRO",1557,20)
 ;;=S DGJTHFLG="DL"
