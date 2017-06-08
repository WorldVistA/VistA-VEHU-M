IBDON019 ; ; 03-APR-1996
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;; 3-APR-96
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1634,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",1634,10,0)
 ;;=^101.01PA^0^1
 ;;^UTILITY(U,$J,"PRO",1634,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",1634,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",1634,99)
 ;;=56448,48414
 ;;^UTILITY(U,$J,"PRO",1643,0)
 ;;=IBDF QUICK GRP COPY^Group Copy^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1643,15)
 ;;=D INIT^IBDFQSL1 S VALMBCK="R"
 ;;^UTILITY(U,$J,"PRO",1643,20)
 ;;=D ^IBDFGRP
 ;;^UTILITY(U,$J,"PRO",1643,99)
 ;;=56454,36624
 ;;^UTILITY(U,$J,"PRO",1644,0)
 ;;=IBDF QUICK GRP MENU^Group Copy Menu^^M^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1644,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",1644,10,0)
 ;;=^101.01PA^1^1
 ;;^UTILITY(U,$J,"PRO",1644,10,1,0)
 ;;=1645^GC^1
 ;;^UTILITY(U,$J,"PRO",1644,10,1,"^")
 ;;=IBDF QUICK GROUP COPY SELECTION
 ;;^UTILITY(U,$J,"PRO",1644,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",1644,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",1644,99)
 ;;=56455,30838
 ;;^UTILITY(U,$J,"PRO",1645,0)
 ;;=IBDF QUICK GROUP COPY SELECTION^Group Copy Selection^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1645,20)
 ;;=D GRPCOPY^IBDFGRP
 ;;^UTILITY(U,$J,"PRO",1645,99)
 ;;=56455,30711
 ;;^UTILITY(U,$J,"PRO",1646,0)
 ;;=IBDF QUICK GRP DELETE^Group Delete^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1646,20)
 ;;=D GRPDEL^IBDFQEA
 ;;^UTILITY(U,$J,"PRO",1646,99)
 ;;=56460,50794
 ;;^UTILITY(U,$J,"PRO",1647,0)
 ;;=IBDF FT CHANGE LIST^Change List^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1647,15)
 ;;=K IBDF1
 ;;^UTILITY(U,$J,"PRO",1647,20)
 ;;=S IBDF1=1 D CHGLST^IBDFFT
 ;;^UTILITY(U,$J,"PRO",1647,99)
 ;;=56467,48515
 ;;^UTILITY(U,$J,"PRO",1656,0)
 ;;=IBDF QUICK EDIT GRP^Group Edit^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1656,20)
 ;;=D GRPEDIT^IBDFQEA
 ;;^UTILITY(U,$J,"PRO",1656,99)
 ;;=56545,39596
 ;;^UTILITY(U,$J,"PRO",1665,0)
 ;;=IBDF PCE EVENT^Process events from PCE^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1665,1,0)
 ;;=^^14^14^2951214^
 ;;^UTILITY(U,$J,"PRO",1665,1,1,0)
 ;;=This protocol is the event handler attached
 ;;^UTILITY(U,$J,"PRO",1665,1,2,0)
 ;;=to the PXK VISIT DATA EVENT protocol.
 ;;^UTILITY(U,$J,"PRO",1665,1,3,0)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1665,1,4,0)
 ;;=In order to determine if all data from encounter
 ;;^UTILITY(U,$J,"PRO",1665,1,5,0)
 ;;=forms has been collected it is necessary to flag
 ;;^UTILITY(U,$J,"PRO",1665,1,6,0)
 ;;=all printed forms as having data input.  If the
 ;;^UTILITY(U,$J,"PRO",1665,1,7,0)
 ;;=input is from AICS then the Form Tracking file is
 ;;^UTILITY(U,$J,"PRO",1665,1,8,0)
 ;;=automatically updated.  If data entry is done through
 ;;^UTILITY(U,$J,"PRO",1665,1,9,0)
 ;;=Scheduling or PCE then the form tracking file is not
 ;;^UTILITY(U,$J,"PRO",1665,1,10,0)
 ;;=updated.
 ;;^UTILITY(U,$J,"PRO",1665,1,11,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",1665,1,12,0)
 ;;=This protocol ensures that data during data entry
 ;;^UTILITY(U,$J,"PRO",1665,1,13,0)
 ;;=through PCE or scheduling flags a manual data entry
 ;;^UTILITY(U,$J,"PRO",1665,1,14,0)
 ;;=field in the Form Tracking file.
 ;;^UTILITY(U,$J,"PRO",1665,20)
 ;;=D MAN^IBDFPCE
 ;;^UTILITY(U,$J,"PRO",1665,99)
 ;;=56595,34005
 ;;^UTILITY(U,$J,"PRO",1665,"MEN","PXCA DATA EVENT")
 ;;=1665
 ;;^UTILITY(U,$J,"PRO",1665,"MEN","PXK VISIT DATA EVENT")
 ;;=1665
 ;;^UTILITY(U,$J,"PRO",1730,0)
 ;;=IBDF EF CLINIC GROUP DELETE^Delete Clinic Grp^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1730,20)
 ;;=D DEL^IBDFCG
 ;;^UTILITY(U,$J,"PRO",1730,99)
 ;;=56663,40648
 ;;^UTILITY(U,$J,"PRO",1758,0)
 ;;=IBDF EF DELETE QUEUE PARMS^Delete Param Grp^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1758,20)
 ;;=D DEL^IBDFPE1
 ;;^UTILITY(U,$J,"PRO",1758,99)
 ;;=56666,34654
