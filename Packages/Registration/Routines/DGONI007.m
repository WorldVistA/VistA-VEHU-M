DGONI007 ; ; 13-AUG-1993
 ;;5.3;Registration;;Aug 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",627,1,2,0)
 ;;=the Incomplete Records screen when editing an IRT report.
 ;;^UTILITY(U,$J,"PRO",627,4)
 ;;=^^^G4
 ;;^UTILITY(U,$J,"PRO",627,20)
 ;;=S (X,DGJTNUM)=4 D EDIT^DGJTVW1
 ;;^UTILITY(U,$J,"PRO",627,99)
 ;;=55487,58395
 ;;^UTILITY(U,$J,"PRO",629,0)
 ;;=DGJ ALL GROUP EDIT^Edit All^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",629,1,0)
 ;;=^^2^2^2930113^^^^
 ;;^UTILITY(U,$J,"PRO",629,1,1,0)
 ;;=This protocol is an action that allows the editing of the data in all groups
 ;;^UTILITY(U,$J,"PRO",629,1,2,0)
 ;;=on the Incomplete Records screen when editing an IRT report.
 ;;^UTILITY(U,$J,"PRO",629,4)
 ;;=^^^EA
 ;;^UTILITY(U,$J,"PRO",629,20)
 ;;=D ALLEDIT^DGJTVW1
 ;;^UTILITY(U,$J,"PRO",629,21,0)
 ;;=^101.021A
 ;;^UTILITY(U,$J,"PRO",629,99)
 ;;=55523,42429
 ;;^UTILITY(U,$J,"PRO",632,0)
 ;;=DGJ TS UPDATE^Treating Spec. Update^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",632,1,0)
 ;;=^^3^3^2930113^^^
 ;;^UTILITY(U,$J,"PRO",632,1,1,0)
 ;;=This protocol is the action to update the Treating Specialty and Primary and 
 ;;^UTILITY(U,$J,"PRO",632,1,2,0)
 ;;=Attending physicians for the IRT package and ADT without exiting the IRT
 ;;^UTILITY(U,$J,"PRO",632,1,3,0)
 ;;=enter/edit option.
 ;;^UTILITY(U,$J,"PRO",632,4)
 ;;=^^^TS
 ;;^UTILITY(U,$J,"PRO",632,15)
 ;;=K DGJTSEDT
 ;;^UTILITY(U,$J,"PRO",632,20)
 ;;=S DGJTSEDT=1 D TS^DGJTUTL
 ;;^UTILITY(U,$J,"PRO",632,24)
 ;;=I DGJTSR1=1
 ;;^UTILITY(U,$J,"PRO",632,26)
 ;;=D HDR^DGJTEE
 ;;^UTILITY(U,$J,"PRO",632,99)
 ;;=55531,30236
 ;;^UTILITY(U,$J,"PRO",647,0)
 ;;=VALM BLANK 1^^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",647,1,0)
 ;;=^^1^1^2920203^
 ;;^UTILITY(U,$J,"PRO",647,1,1,0)
 ;;=This protocol is used to format spaces in menu lists.
 ;;^UTILITY(U,$J,"PRO",647,"MEN","DGJ ENTER/EDIT RECORDS MENU")
 ;;=647^^23
 ;;^UTILITY(U,$J,"PRO",647,"MEN","DGJ IRT PARM ENTER/EDIT MENU")
 ;;=647^^23
 ;;^UTILITY(U,$J,"PRO",647,"MEN","DGJ IRT SUMMARIES")
 ;;=647^^23
 ;;^UTILITY(U,$J,"PRO",649,0)
 ;;=VALM BLANK 2^^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",649,1,0)
 ;;=^^1^1^2920203^
 ;;^UTILITY(U,$J,"PRO",649,1,1,0)
 ;;=This protocol is used to format spaces in menu lists.
 ;;^UTILITY(U,$J,"PRO",649,"MEN","DGJ ENTER/EDIT DEFICIENCY MENU")
 ;;=649^^15
 ;;^UTILITY(U,$J,"PRO",649,"MEN","DGJ ENTER/EDIT RECORDS MENU")
 ;;=649^^24
 ;;^UTILITY(U,$J,"PRO",649,"MEN","DGJ IRT PARM ENTER/EDIT MENU")
 ;;=649^^24
 ;;^UTILITY(U,$J,"PRO",649,"MEN","DGJ IRT SUMMARIES")
 ;;=649^^24
 ;;^UTILITY(U,$J,"PRO",650,0)
 ;;=VALM BLANK 3^^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",650,1,0)
 ;;=^^1^1^2920203^
 ;;^UTILITY(U,$J,"PRO",650,1,1,0)
 ;;=This protocol is used to format spaces in menu lists.
 ;;^UTILITY(U,$J,"PRO",650,"MEN","DGJ ENTER/EDIT DEFICIENCY MENU")
 ;;=650^^25
 ;;^UTILITY(U,$J,"PRO",650,"MEN","DGJ ENTER/EDIT RECORDS MENU")
 ;;=650^^25
 ;;^UTILITY(U,$J,"PRO",650,"MEN","DGJ IRT PARM ENTER/EDIT MENU")
 ;;=650^^25
 ;;^UTILITY(U,$J,"PRO",650,"MEN","DGJ IRT SUMMARIES")
 ;;=650^^25
 ;;^UTILITY(U,$J,"PRO",677,0)
 ;;=DG CO-PAY TEST STATUS^Update Co-Pay Status^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",677,1,0)
 ;;=^^2^2^2930121^
 ;;^UTILITY(U,$J,"PRO",677,1,1,0)
 ;;=This protocol is intended to update the co-pay status when changed
 ;;^UTILITY(U,$J,"PRO",677,1,2,0)
 ;;=in billing.
 ;;^UTILITY(U,$J,"PRO",677,4)
 ;;=^^^MT
 ;;^UTILITY(U,$J,"PRO",677,20)
 ;;=D ^DGMTCOST
 ;;^UTILITY(U,$J,"PRO",677,99)
 ;;=55733,49472
 ;;^UTILITY(U,$J,"PRO",679,0)
 ;;=DGJ DELETE DEFICIENCY^Delete a Deficiency^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",679,15)
 ;;=K DGJTDELE
 ;;^UTILITY(U,$J,"PRO",679,20)
 ;;=S DGJTDELE=1 D OKD^DGJTDEL
 ;;^UTILITY(U,$J,"PRO",679,99)
 ;;=55539,38052
 ;;^UTILITY(U,$J,"PRO",693,0)
 ;;=DGJ DELETE MENU^Delete a Record Menu^^M^^^^^^^^INCOMPLETE RECORD TRACKING
 ;;^UTILITY(U,$J,"PRO",693,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",693,10,0)
 ;;=^101.01PA^2^3
 ;;^UTILITY(U,$J,"PRO",693,10,2,0)
 ;;=596^EP^14
 ;;^UTILITY(U,$J,"PRO",693,10,2,"^")
 ;;=DGJ IRT EXP
 ;;^UTILITY(U,$J,"PRO",693,10,3,0)
 ;;=703^DL^11
 ;;^UTILITY(U,$J,"PRO",693,10,3,"^")
 ;;=DGJ DELETE SUPER2
 ;;^UTILITY(U,$J,"PRO",693,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",693,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",693,99)
 ;;=55567,34719
 ;;^UTILITY(U,$J,"PRO",698,0)
 ;;=DGJ COMPLETE EDIT MENU^Edit a Completed IRT Menu^^M^^^^^^^^INCOMPLETE RECORD TRACKING
 ;;^UTILITY(U,$J,"PRO",698,4)
 ;;=26^4^^Completed IRT Entry
 ;;^UTILITY(U,$J,"PRO",698,10,0)
 ;;=^101.01PA^2^3
 ;;^UTILITY(U,$J,"PRO",698,10,2,0)
 ;;=596^EP^14
 ;;^UTILITY(U,$J,"PRO",698,10,2,"^")
 ;;=DGJ IRT EXP
 ;;^UTILITY(U,$J,"PRO",698,10,3,0)
 ;;=701^CE^11
 ;;^UTILITY(U,$J,"PRO",698,10,3,"^")
 ;;=DGJ EDIT COMP SUPER2
