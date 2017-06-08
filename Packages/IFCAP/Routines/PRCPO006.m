PRCPO006 ; ; 28-FEB-1995
 ;;5.0;GENERIC INVENTORY PACKAGE;;FEB 28, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",107,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",107,99)
 ;;=56064,53646
 ;;^UTILITY(U,$J,"PRO",108,0)
 ;;=PRCP CC/IK CHECK ITEMS EDIT^Enter/Edit Inventory Items^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",108,1,0)
 ;;=^^3^3^2931025^^^
 ;;^UTILITY(U,$J,"PRO",108,1,1,0)
 ;;=This protocol allows the user to enter/edit inventory item data and
 ;;^UTILITY(U,$J,"PRO",108,1,2,0)
 ;;=correct errors on the spot without having to leave the option and
 ;;^UTILITY(U,$J,"PRO",108,1,3,0)
 ;;=return.
 ;;^UTILITY(U,$J,"PRO",108,4)
 ;;=^^^EE
 ;;^UTILITY(U,$J,"PRO",108,20)
 ;;=D EEITEMS^PRCPOPEC
 ;;^UTILITY(U,$J,"PRO",108,99)
 ;;=56064,53643
 ;;^UTILITY(U,$J,"PRO",109,0)
 ;;=PRCP INVENTORY PARAMETERS MENU^E/E Inventory Parameters^^M^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",109,1,0)
 ;;=^^2^2^2940126^
 ;;^UTILITY(U,$J,"PRO",109,1,1,0)
 ;;=This protocol is the main menu for entering and editing the inventory
 ;;^UTILITY(U,$J,"PRO",109,1,2,0)
 ;;=point parameters.
 ;;^UTILITY(U,$J,"PRO",109,4)
 ;;=26
 ;;^UTILITY(U,$J,"PRO",109,10,0)
 ;;=^101.01PA^9^9
 ;;^UTILITY(U,$J,"PRO",109,10,1,0)
 ;;=110^DE^4^^^Descriptive
 ;;^UTILITY(U,$J,"PRO",109,10,1,"^")
 ;;=PRCP INVENTORY EDIT DESCRIPTION
 ;;^UTILITY(U,$J,"PRO",109,10,2,0)
 ;;=111^SP^7^^^Special Parameters
 ;;^UTILITY(U,$J,"PRO",109,10,2,"^")
 ;;=PRCP INVENTORY EDIT SPECIAL
 ;;^UTILITY(U,$J,"PRO",109,10,3,0)
 ;;=112^AF^1^^^All Fields
 ;;^UTILITY(U,$J,"PRO",109,10,3,"^")
 ;;=PRCP INVENTORY EDIT ALL FIELDS
 ;;^UTILITY(U,$J,"PRO",109,10,4,0)
 ;;=113^FC^11^^^Fund Control Points
 ;;^UTILITY(U,$J,"PRO",109,10,4,"^")
 ;;=PRCP INVENTORY EDIT FCP
 ;;^UTILITY(U,$J,"PRO",109,10,5,0)
 ;;=114^DP^14^^^Distribution Points
 ;;^UTILITY(U,$J,"PRO",109,10,5,"^")
 ;;=PRCP INVENTORY EDIT DISTRPTS
 ;;^UTILITY(U,$J,"PRO",109,10,6,0)
 ;;=116^AU^24^^^Authorized Users
 ;;^UTILITY(U,$J,"PRO",109,10,6,"^")
 ;;=PRCP INVENTORY EDIT USERS
 ;;^UTILITY(U,$J,"PRO",109,10,7,0)
 ;;=115^MC^27^^^MIS Costing
 ;;^UTILITY(U,$J,"PRO",109,10,7,"^")
 ;;=PRCP INVENTORY EDIT MISCOST
 ;;^UTILITY(U,$J,"PRO",109,10,8,0)
 ;;=117^SB^17^^^Stocked By
 ;;^UTILITY(U,$J,"PRO",109,10,8,"^")
 ;;=PRCP INVENTORY EDIT STOCKEDBY
 ;;^UTILITY(U,$J,"PRO",109,10,9,0)
 ;;=118^FL^21^^^Flags
 ;;^UTILITY(U,$J,"PRO",109,10,9,"^")
 ;;=PRCP INVENTORY EDIT FLAGS
 ;;^UTILITY(U,$J,"PRO",109,24)
 ;;=I 1 X:$D(^ORD(101,+$P(^ORD(101,DA(1),10,DA,0),"^"),24)) ^(24)
 ;;^UTILITY(U,$J,"PRO",109,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",109,99)
 ;;=56306,29729
 ;;^UTILITY(U,$J,"PRO",110,0)
 ;;=PRCP INVENTORY EDIT DESCRIPTION^Inventory Edit Description^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",110,1,0)
 ;;=^^2^2^2940105^^^
 ;;^UTILITY(U,$J,"PRO",110,1,1,0)
 ;;=This protocol allows the user to edit the inventory descriptive
 ;;^UTILITY(U,$J,"PRO",110,1,2,0)
 ;;=parameters.
 ;;^UTILITY(U,$J,"PRO",110,4)
 ;;=^^^DE
 ;;^UTILITY(U,$J,"PRO",110,20)
 ;;=D DESCRIP^PRCPENE1
 ;;^UTILITY(U,$J,"PRO",110,99)
 ;;=56302,44710
 ;;^UTILITY(U,$J,"PRO",111,0)
 ;;=PRCP INVENTORY EDIT SPECIAL^Special Parameters^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",111,1,0)
 ;;=^^1^1^2940105^^
 ;;^UTILITY(U,$J,"PRO",111,1,1,0)
 ;;=This protocol allows the user to edit the inventory special parameters.
 ;;^UTILITY(U,$J,"PRO",111,4)
 ;;=^^^SP
 ;;^UTILITY(U,$J,"PRO",111,20)
 ;;=D SPECIAL^PRCPENE1
 ;;^UTILITY(U,$J,"PRO",111,99)
 ;;=56064,53699
 ;;^UTILITY(U,$J,"PRO",112,0)
 ;;=PRCP INVENTORY EDIT ALL FIELDS^All Fields^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",112,1,0)
 ;;=^^2^2^2940105^
 ;;^UTILITY(U,$J,"PRO",112,1,1,0)
 ;;=This protocol allows the user to edit the descriptive, special parameters,
 ;;^UTILITY(U,$J,"PRO",112,1,2,0)
 ;;=inventory user, and mis costing section fields.
 ;;^UTILITY(U,$J,"PRO",112,4)
 ;;=^^^AF
 ;;^UTILITY(U,$J,"PRO",112,20)
 ;;=D ALL^PRCPENE1
 ;;^UTILITY(U,$J,"PRO",112,99)
 ;;=56064,53696
 ;;^UTILITY(U,$J,"PRO",113,0)
 ;;=PRCP INVENTORY EDIT FCP^Fund Control Point^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",113,1,0)
 ;;=^^2^2^2940105^
 ;;^UTILITY(U,$J,"PRO",113,1,1,0)
 ;;=This protocol allows the user to edit the fund control points assigned
