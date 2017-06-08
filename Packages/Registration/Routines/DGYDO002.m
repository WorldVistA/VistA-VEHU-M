DGYDO002 ; ; 20-JAN-1994
 ;;5.3;Registration;**9**;Aug 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1557,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",1557,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",1557,99)
 ;;=55757,47264
 ;;^UTILITY(U,$J,"PRO",1558,0)
 ;;=DGJ COMPLETE EDIT MENU^Edit a Completed IRT Menu^^M^^^^^^^^INCOMPLETE RECORD TRACKING
 ;;^UTILITY(U,$J,"PRO",1558,4)
 ;;=26^4^^Completed IRT Entry
 ;;^UTILITY(U,$J,"PRO",1558,10,0)
 ;;=^101.01PA^0^2
 ;;^UTILITY(U,$J,"PRO",1558,15)
 ;;=K DGJTCOM,DGJTHFLG
 ;;^UTILITY(U,$J,"PRO",1558,20)
 ;;=S DGJTCOM=1,DGJTHFLG="CE"
 ;;^UTILITY(U,$J,"PRO",1558,24)
 ;;=I 1 X:$D(^ORD(101,+$P(^ORD(101,DA(1),10,DA,0),"^",1),24)) ^(24)
 ;;^UTILITY(U,$J,"PRO",1558,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",1558,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",1558,99)
 ;;=55888,42785
 ;;^UTILITY(U,$J,"PRO",1561,0)
 ;;=DGJ EDIT COMP SUPER2^Complete IRT Edit^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",1561,4)
 ;;=^^^CE
 ;;^UTILITY(U,$J,"PRO",1561,15)
 ;;=K DGJTCOM
 ;;^UTILITY(U,$J,"PRO",1561,20)
 ;;=D NEW^DGJTEE
 ;;^UTILITY(U,$J,"PRO",1561,24)
 ;;=I $D(^XUSEC("DGJ SUPER",DUZ))!$D(DGJTOPT)
 ;;^UTILITY(U,$J,"PRO",1561,99)
 ;;=55816,52326
 ;;^UTILITY(U,$J,"PRO",1564,0)
 ;;=DGJ JUMP CATEG^Jump to a Category^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",1564,4)
 ;;=^^^JC
 ;;^UTILITY(U,$J,"PRO",1564,20)
 ;;=D JUMP^DGJTEE3
 ;;^UTILITY(U,$J,"PRO",1564,99)
 ;;=55742,56543
 ;;^UTILITY(U,$J,"PRO",1564,"MEN","DGJ IRT VIEW MENU")
 ;;=1564^JC^31
 ;;^UTILITY(U,$J,"PRO",1896,0)
 ;;=DGJ IRT PARM ENTER/EDIT MENU^Enter/Edit IRT Def. Parameters^^M^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",1896,1,0)
 ;;=^^3^3^2940119^^^^
 ;;^UTILITY(U,$J,"PRO",1896,1,1,0)
 ;;=This menu contains all the actions for the IRT Record Summary Tracking
 ;;^UTILITY(U,$J,"PRO",1896,1,2,0)
 ;;=option.  This is the protocol menu that controls the actions for entering a
 ;;^UTILITY(U,$J,"PRO",1896,1,3,0)
 ;;=new IRT record and editing an already existing IRT record.
 ;;^UTILITY(U,$J,"PRO",1896,4)
 ;;=26^4^^DP
 ;;^UTILITY(U,$J,"PRO",1896,10,0)
 ;;=^101.01PA^0^6
 ;;^UTILITY(U,$J,"PRO",1896,15)
 ;;=K DGJTHFLG
 ;;^UTILITY(U,$J,"PRO",1896,20)
 ;;=S DGJTHFLG="AD"
 ;;^UTILITY(U,$J,"PRO",1896,24)
 ;;=I 1 X:$D(^ORD(101,+$P(^ORD(101,DA(1),10,DA,0),"^",1),24)) ^(24)
 ;;^UTILITY(U,$J,"PRO",1896,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",1896,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",1896,99)
 ;;=55742,56543
 ;;^UTILITY(U,$J,"PRO",2385,0)
 ;;=DGJ IRT VIEW MENU^View an IRT Record Menu^^M^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",2385,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",2385,10,0)
 ;;=^101.01PA^0^6
 ;;^UTILITY(U,$J,"PRO",2385,15)
 ;;=K DGJTHFLG
 ;;^UTILITY(U,$J,"PRO",2385,20)
 ;;=S DGJTHFLG="VW"
 ;;^UTILITY(U,$J,"PRO",2385,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",2385,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",2385,99)
 ;;=55901,38261
