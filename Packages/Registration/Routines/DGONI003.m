DGONI003 ; ; 13-AUG-1993
 ;;5.3;Registration;;Aug 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",112,5)
 ;;=DGOERR NOTE;DIC(19,
 ;;^UTILITY(U,$J,"PRO",112,20)
 ;;=D EN^DGOERNOT
 ;;^UTILITY(U,$J,"PRO",112,99)
 ;;=55028,26897
 ;;^UTILITY(U,$J,"PRO",112,"MEN","DGPM MOVEMENT EVENTS")
 ;;=112^^7
 ;;^UTILITY(U,$J,"PRO",457,0)
 ;;=DG MEANS TEST EVENTS^Means Test Event Driver^^X^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",457,1,0)
 ;;=^^1^1^2920403^^^
 ;;^UTILITY(U,$J,"PRO",457,1,1,0)
 ;;=This option is the means test event protocol.
 ;;^UTILITY(U,$J,"PRO",457,5)
 ;;=DG MEANS TEST EVENTS;DIC(19,
 ;;^UTILITY(U,$J,"PRO",457,10,0)
 ;;=^101.01PA^1^4
 ;;^UTILITY(U,$J,"PRO",457,10,2,0)
 ;;=482^^1
 ;;^UTILITY(U,$J,"PRO",457,10,2,"^")
 ;;=DG MEANS TEST AUDIT
 ;;^UTILITY(U,$J,"PRO",457,99)
 ;;=55728,31462
 ;;^UTILITY(U,$J,"PRO",482,0)
 ;;=DG MEANS TEST AUDIT^Means Test Audit Event^^X^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",482,1,0)
 ;;=^^2^2^2930427^^
 ;;^UTILITY(U,$J,"PRO",482,1,1,0)
 ;;=The event is invoked off of the Means Test event driver.  Based upon the
 ;;^UTILITY(U,$J,"PRO",482,1,2,0)
 ;;=action taken the Means Test Change file will be updated.
 ;;^UTILITY(U,$J,"PRO",482,20)
 ;;=D EN^DGMTAUD
 ;;^UTILITY(U,$J,"PRO",482,99)
 ;;=55243,77498
 ;;^UTILITY(U,$J,"PRO",482,"MEN","DG MEANS TEST EVENTS")
 ;;=482^^1
 ;;^UTILITY(U,$J,"PRO",565,0)
 ;;=DG MEANS TEST DOM^Means Test Check for DOM Patients^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",565,1,0)
 ;;=^^1^1^2921029^^
 ;;^UTILITY(U,$J,"PRO",565,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",565,20)
 ;;=D EN^DGMTDOM
 ;;^UTILITY(U,$J,"PRO",565,99)
 ;;=55462,26563
 ;;^UTILITY(U,$J,"PRO",565,"MEN","DGPM MOVEMENT EVENTS")
 ;;=565^^8
 ;;^UTILITY(U,$J,"PRO",582,0)
 ;;=DGJ ENTER/EDIT DEFICIENCY MENU^Records Deficiencies Menu^^M^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",582,1,0)
 ;;=^^1^1^2930217^^^^
 ;;^UTILITY(U,$J,"PRO",582,1,1,0)
 ;;=This menu contains all the activities for the IRT DEFICIENCY TRACKING option
 ;;^UTILITY(U,$J,"PRO",582,4)
 ;;=26^4^^RD
 ;;^UTILITY(U,$J,"PRO",582,10,0)
 ;;=^101.01PA^9^19
 ;;^UTILITY(U,$J,"PRO",582,10,10,0)
 ;;=592^DE^12
 ;;^UTILITY(U,$J,"PRO",582,10,10,"^")
 ;;=DGJ IRT EDIT DEFICIENCY
 ;;^UTILITY(U,$J,"PRO",582,10,11,0)
 ;;=593^EN^11
 ;;^UTILITY(U,$J,"PRO",582,10,11,"^")
 ;;=DGJ IRT ENTER DEFICIENCY
 ;;^UTILITY(U,$J,"PRO",582,10,12,0)
 ;;=596^EP^13
 ;;^UTILITY(U,$J,"PRO",582,10,12,"^")
 ;;=DGJ IRT EXP
 ;;^UTILITY(U,$J,"PRO",582,10,13,0)
 ;;=597^PT^22
 ;;^UTILITY(U,$J,"PRO",582,10,13,"^")
 ;;=DGJ CHNG PAT
 ;;^UTILITY(U,$J,"PRO",582,10,16,0)
 ;;=632^TS^21
 ;;^UTILITY(U,$J,"PRO",582,10,16,"^")
 ;;=DGJ TS UPDATE
 ;;^UTILITY(U,$J,"PRO",582,10,27,0)
 ;;=700^CE^31
 ;;^UTILITY(U,$J,"PRO",582,10,27,"^")
 ;;=DGJ EDIT COMP IRT SUPER
 ;;^UTILITY(U,$J,"PRO",582,10,28,0)
 ;;=702^DL^23
 ;;^UTILITY(U,$J,"PRO",582,10,28,"^")
 ;;=DGJ DELETE SUPER
 ;;^UTILITY(U,$J,"PRO",582,10,29,0)
 ;;=704^JC^29
 ;;^UTILITY(U,$J,"PRO",582,10,29,"^")
 ;;=DGJ JUMP CATEG
 ;;^UTILITY(U,$J,"PRO",582,10,30,0)
 ;;=787^QC^30
 ;;^UTILITY(U,$J,"PRO",582,10,30,"^")
 ;;=DGJ IRT COMPLETE DEF
 ;;^UTILITY(U,$J,"PRO",582,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",582,24)
 ;;=I 1 X:$D(^ORD(101,+$P(^ORD(101,DA(1),10,DA,0),"^",1),24)) ^(24)
 ;;^UTILITY(U,$J,"PRO",582,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",582,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",582,99)
 ;;=55662,29449
 ;;^UTILITY(U,$J,"PRO",592,0)
 ;;=DGJ IRT EDIT DEFICIENCY^Edit Deficiencies^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",592,1,0)
 ;;=^^3^3^2921008^^
 ;;^UTILITY(U,$J,"PRO",592,1,1,0)
 ;;=This protocol is the action to edit a record deficiency.  This action is
 ;;^UTILITY(U,$J,"PRO",592,1,2,0)
 ;;=associated with the protocol menu for entering and editing all deficiencies
 ;;^UTILITY(U,$J,"PRO",592,1,3,0)
 ;;=for a patients record.
 ;;^UTILITY(U,$J,"PRO",592,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",592,20)
 ;;=D NEW^DGJTEE
 ;;^UTILITY(U,$J,"PRO",592,99)
 ;;=55319,58108
 ;;^UTILITY(U,$J,"PRO",593,0)
 ;;=DGJ IRT ENTER DEFICIENCY^Enter a Deficiency^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",593,1,0)
 ;;=^^2^2^2921008^^
 ;;^UTILITY(U,$J,"PRO",593,1,1,0)
 ;;=This protocol is the action to enter a record deficiency. It is an action
 ;;^UTILITY(U,$J,"PRO",593,1,2,0)
 ;;=under the Enter/Edit Deficiencies protocol menu.
 ;;^UTILITY(U,$J,"PRO",593,4)
 ;;=^^^EN
 ;;^UTILITY(U,$J,"PRO",593,20)
 ;;=D NEW1^DGJTEE
 ;;^UTILITY(U,$J,"PRO",593,99)
 ;;=55320,38895
 ;;^UTILITY(U,$J,"PRO",594,0)
 ;;=DGJ IRT SUMMARIES^IRT Summary/Report Edit Menu^^M^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",594,1,0)
 ;;=^^3^3^2921202^^^^
 ;;^UTILITY(U,$J,"PRO",594,1,1,0)
 ;;=This menu contains all the activities for updating an IRT record if it
 ;;^UTILITY(U,$J,"PRO",594,1,2,0)
 ;;=is an op report, interim or discharge summary.  This menu is called by the
