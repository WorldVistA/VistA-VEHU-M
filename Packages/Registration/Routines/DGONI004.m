DGONI004 ; ; 13-AUG-1993
 ;;5.3;Registration;;Aug 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",594,1,3,0)
 ;;=protocol action of editing a deficiency.
 ;;^UTILITY(U,$J,"PRO",594,2,0)
 ;;=^101.02A^2^2
 ;;^UTILITY(U,$J,"PRO",594,2,1,0)
 ;;=IRT Reports Edit Menu
 ;;^UTILITY(U,$J,"PRO",594,2,2,0)
 ;;=IRT Records Edit
 ;;^UTILITY(U,$J,"PRO",594,2,"B","IRT Records Edit",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",594,2,"B","IRT Reports Edit Menu",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",594,4)
 ;;=26^4^^RD
 ;;^UTILITY(U,$J,"PRO",594,10,0)
 ;;=^101.01PA^5^6
 ;;^UTILITY(U,$J,"PRO",594,10,1,0)
 ;;=595^1G^12^
 ;;^UTILITY(U,$J,"PRO",594,10,1,"^")
 ;;=DGJ EDIT SUMMARY/REPORT
 ;;^UTILITY(U,$J,"PRO",594,10,16,0)
 ;;=625^2G^12
 ;;^UTILITY(U,$J,"PRO",594,10,16,"^")
 ;;=DGJ GROUP 2 EDIT
 ;;^UTILITY(U,$J,"PRO",594,10,17,0)
 ;;=626^3G^13
 ;;^UTILITY(U,$J,"PRO",594,10,17,"^")
 ;;=DGJ GROUP 3 EDIT
 ;;^UTILITY(U,$J,"PRO",594,10,18,0)
 ;;=627^4G^14
 ;;^UTILITY(U,$J,"PRO",594,10,18,"^")
 ;;=DGJ GROUP 4 EDIT
 ;;^UTILITY(U,$J,"PRO",594,10,19,0)
 ;;=629^EA^15
 ;;^UTILITY(U,$J,"PRO",594,10,19,"^")
 ;;=DGJ ALL GROUP EDIT
 ;;^UTILITY(U,$J,"PRO",594,20)
 ;;=
 ;;^UTILITY(U,$J,"PRO",594,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",594,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",594,99)
 ;;=55656,49970
 ;;^UTILITY(U,$J,"PRO",595,0)
 ;;=DGJ EDIT SUMMARY/REPORT^IRT Group 1 Edit^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",595,1,0)
 ;;=^^5^5^2930527^^^^
 ;;^UTILITY(U,$J,"PRO",595,1,1,0)
 ;;=This protocol is the action to edit a specific IRT record. This is an action
 ;;^UTILITY(U,$J,"PRO",595,1,2,0)
 ;;=attached to the protocol menu that is called when a record deficiency is
 ;;^UTILITY(U,$J,"PRO",595,1,3,0)
 ;;=an op report, interim summary or discharge summary and the deficiency is 
 ;;^UTILITY(U,$J,"PRO",595,1,4,0)
 ;;=being edited.  This is the action that allows the IRT record to be updated
 ;;^UTILITY(U,$J,"PRO",595,1,5,0)
 ;;=as well as the deficiency.
 ;;^UTILITY(U,$J,"PRO",595,4)
 ;;=^^^RC
 ;;^UTILITY(U,$J,"PRO",595,10,0)
 ;;=^101.01PA^1^1
 ;;^UTILITY(U,$J,"PRO",595,10,1,0)
 ;;=679^^24
 ;;^UTILITY(U,$J,"PRO",595,10,1,"^")
 ;;=DGJ DELETE DEFICIENCY
 ;;^UTILITY(U,$J,"PRO",595,20)
 ;;=S (X,DGJTNUM)=1 D EDIT^DGJTVW1
 ;;^UTILITY(U,$J,"PRO",595,99)
 ;;=55539,38152
 ;;^UTILITY(U,$J,"PRO",596,0)
 ;;=DGJ IRT EXP^Expand Deficiency^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",596,1,0)
 ;;=^^4^4^2921008^^
 ;;^UTILITY(U,$J,"PRO",596,1,1,0)
 ;;=This protocol is the action to expand a selection.  When a selection is
 ;;^UTILITY(U,$J,"PRO",596,1,2,0)
 ;;=chosen this action will display all the data in the file. If the selection
 ;;^UTILITY(U,$J,"PRO",596,1,3,0)
 ;;=is an OP report, interim summary,  or discharge summary, the IRT record
 ;;^UTILITY(U,$J,"PRO",596,1,4,0)
 ;;=associated with that selection will be displayed also.
 ;;^UTILITY(U,$J,"PRO",596,2,0)
 ;;=^101.02A^2^2
 ;;^UTILITY(U,$J,"PRO",596,2,1,0)
 ;;=EX
 ;;^UTILITY(U,$J,"PRO",596,2,2,0)
 ;;=EP
 ;;^UTILITY(U,$J,"PRO",596,2,"B","EP",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",596,2,"B","EX",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",596,4)
 ;;=^^^ED
 ;;^UTILITY(U,$J,"PRO",596,20)
 ;;=D EXP^DGJTEE1
 ;;^UTILITY(U,$J,"PRO",596,99)
 ;;=55326,30794
 ;;^UTILITY(U,$J,"PRO",597,0)
 ;;=DGJ CHNG PAT^Change Patient^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",597,1,0)
 ;;=^^1^1^2921008^^
 ;;^UTILITY(U,$J,"PRO",597,1,1,0)
 ;;=This protocol is the action to change a patient.
 ;;^UTILITY(U,$J,"PRO",597,4)
 ;;=^^^CD
 ;;^UTILITY(U,$J,"PRO",597,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",597,20)
 ;;=D PAT1^DGJTEE1
 ;;^UTILITY(U,$J,"PRO",597,26)
 ;;=D HDR^DGJTEE
 ;;^UTILITY(U,$J,"PRO",597,99)
 ;;=55327,29745
 ;;^UTILITY(U,$J,"PRO",602,0)
 ;;=DGJ ENTER/EDIT RECORDS MENU^Enter/Edit Records Menu^^M^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",602,1,0)
 ;;=^^3^3^2921008^^^^
 ;;^UTILITY(U,$J,"PRO",602,1,1,0)
 ;;=This menu contains all the actions for the IRT Record Summary Tracking
 ;;^UTILITY(U,$J,"PRO",602,1,2,0)
 ;;=option.  This is the protocol menu that controls the actions for entering a
 ;;^UTILITY(U,$J,"PRO",602,1,3,0)
 ;;=new IRT record and editing an already existing IRT record.
 ;;^UTILITY(U,$J,"PRO",602,4)
 ;;=26^4^^ee
 ;;^UTILITY(U,$J,"PRO",602,10,0)
 ;;=^101.01PA^8^5
 ;;^UTILITY(U,$J,"PRO",602,10,12,0)
 ;;=596^EP^13
 ;;^UTILITY(U,$J,"PRO",602,10,12,"^")
 ;;=DGJ IRT EXP
 ;;^UTILITY(U,$J,"PRO",602,10,13,0)
 ;;=597^PT^22
 ;;^UTILITY(U,$J,"PRO",602,10,13,"^")
 ;;=DGJ CHNG PAT
 ;;^UTILITY(U,$J,"PRO",602,10,14,0)
 ;;=603^EN^11
 ;;^UTILITY(U,$J,"PRO",602,10,14,"^")
 ;;=DGJ IRT ENTER RECORD
 ;;^UTILITY(U,$J,"PRO",602,10,15,0)
 ;;=604^DE^12
 ;;^UTILITY(U,$J,"PRO",602,10,15,"^")
 ;;=DGJ IRT EDIT RECORD
 ;;^UTILITY(U,$J,"PRO",602,10,18,0)
 ;;=632^TS^21
 ;;^UTILITY(U,$J,"PRO",602,10,18,"^")
 ;;=DGJ TS UPDATE
