DGONI008 ; ; 13-AUG-1993
 ;;5.3;Registration;;Aug 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",698,15)
 ;;=K DGJTCOM
 ;;^UTILITY(U,$J,"PRO",698,20)
 ;;=S DGJTCOM=1
 ;;^UTILITY(U,$J,"PRO",698,24)
 ;;=
 ;;^UTILITY(U,$J,"PRO",698,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",698,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",698,99)
 ;;=55566,42340
 ;;^UTILITY(U,$J,"PRO",699,0)
 ;;=DGJ EDIT COMP IRT SINGLE^Edit a Completed IRT^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",699,4)
 ;;=^^^Edit a Complete IRt
 ;;^UTILITY(U,$J,"PRO",699,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",699,20)
 ;;=D NEW^DGJTEE
 ;;^UTILITY(U,$J,"PRO",699,99)
 ;;=55564,56247
 ;;^UTILITY(U,$J,"PRO",700,0)
 ;;=DGJ EDIT COMP IRT SUPER^Complete IRT Edit Menu^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",700,4)
 ;;=80^^^EC
 ;;^UTILITY(U,$J,"PRO",700,15)
 ;;=K DGJTCOM D REP^DGJTEE
 ;;^UTILITY(U,$J,"PRO",700,20)
 ;;=S DGJTCOM=1 D START4^DGJTEE
 ;;^UTILITY(U,$J,"PRO",700,24)
 ;;=I $D(^XUSEC("DGJ SUPER",DUZ))
 ;;^UTILITY(U,$J,"PRO",700,99)
 ;;=55566,42468
 ;;^UTILITY(U,$J,"PRO",701,0)
 ;;=DGJ EDIT COMP SUPER2^Complete IRT Edit^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",701,4)
 ;;=^^^CE
 ;;^UTILITY(U,$J,"PRO",701,15)
 ;;=K DGJTCOM
 ;;^UTILITY(U,$J,"PRO",701,20)
 ;;=D NEW^DGJTEE
 ;;^UTILITY(U,$J,"PRO",701,99)
 ;;=55565,45081
 ;;^UTILITY(U,$J,"PRO",702,0)
 ;;=DGJ DELETE SUPER^IRT Delete Menu^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",702,4)
 ;;=^^^LD
 ;;^UTILITY(U,$J,"PRO",702,15)
 ;;=K DGJTDLT D REP^DGJTEE
 ;;^UTILITY(U,$J,"PRO",702,20)
 ;;=S DGJTDLT=1 D START5^DGJTEE
 ;;^UTILITY(U,$J,"PRO",702,24)
 ;;=I $D(^XUSEC("DGJ SUPER",DUZ))
 ;;^UTILITY(U,$J,"PRO",702,99)
 ;;=55581,30990
 ;;^UTILITY(U,$J,"PRO",703,0)
 ;;=DGJ DELETE SUPER2^Delete an IRT^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",703,4)
 ;;=80^^^LD
 ;;^UTILITY(U,$J,"PRO",703,20)
 ;;=D OKD^DGJTDEL
 ;;^UTILITY(U,$J,"PRO",703,99)
 ;;=55566,41835
 ;;^UTILITY(U,$J,"PRO",704,0)
 ;;=DGJ JUMP CATEG^Jump to a Category^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",704,4)
 ;;=^^^JC
 ;;^UTILITY(U,$J,"PRO",704,20)
 ;;=D JUMP^DGJTEE3
 ;;^UTILITY(U,$J,"PRO",704,99)
 ;;=55566,56274
 ;;^UTILITY(U,$J,"PRO",781,0)
 ;;=DG MEANS TEST REQUIRED^Means Test Required Event^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",781,1,0)
 ;;=^^3^3^2930625^^
 ;;^UTILITY(U,$J,"PRO",781,1,1,0)
 ;;=This event is evoked off the scheduling event driver.  If a patient's
 ;;^UTILITY(U,$J,"PRO",781,1,2,0)
 ;;=means test has a required status and an appointment is made it will
 ;;^UTILITY(U,$J,"PRO",781,1,3,0)
 ;;=send a bulletin to the DG MEANS TEST REQUIRED group.
 ;;^UTILITY(U,$J,"PRO",781,15)
 ;;=K DGREQF,DGMSGF,DGMTYPT
 ;;^UTILITY(U,$J,"PRO",781,20)
 ;;=D EN^DGMTREQB
 ;;^UTILITY(U,$J,"PRO",781,99)
 ;;=55634,35729
 ;;^UTILITY(U,$J,"PRO",781,"MEN","SDAM APPOINTMENT EVENTS")
 ;;=781
 ;;^UTILITY(U,$J,"PRO",787,0)
 ;;=DGJ IRT COMPLETE DEF^Quick Complete of Def.^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",787,4)
 ;;=^^^QC
 ;;^UTILITY(U,$J,"PRO",787,20)
 ;;=D QUICMP^DGJTEE2
 ;;^UTILITY(U,$J,"PRO",787,99)
 ;;=55657,55123
 ;;^UTILITY(U,$J,"PRO",788,0)
 ;;=DGJ IRT PARM ENTER/EDIT MENU^Enter/Edit IRT Def. Parameters^^M^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",788,1,0)
 ;;=^^3^3^2921008^^^^
 ;;^UTILITY(U,$J,"PRO",788,1,1,0)
 ;;=This menu contains all the actions for the IRT Record Summary Tracking
 ;;^UTILITY(U,$J,"PRO",788,1,2,0)
 ;;=option.  This is the protocol menu that controls the actions for entering a
 ;;^UTILITY(U,$J,"PRO",788,1,3,0)
 ;;=new IRT record and editing an already existing IRT record.
 ;;^UTILITY(U,$J,"PRO",788,4)
 ;;=26^4^^DP
 ;;^UTILITY(U,$J,"PRO",788,10,0)
 ;;=^101.01PA^3^5
 ;;^UTILITY(U,$J,"PRO",788,10,14,0)
 ;;=790^EN^11
 ;;^UTILITY(U,$J,"PRO",788,10,14,"^")
 ;;=DGJ IRT ADD DEF. PARMS
 ;;^UTILITY(U,$J,"PRO",788,10,15,0)
 ;;=789^DE^12
 ;;^UTILITY(U,$J,"PRO",788,10,15,"^")
 ;;=DGJ IRT EDIT PARMS
 ;;^UTILITY(U,$J,"PRO",788,10,22,0)
 ;;=704^JC^21
 ;;^UTILITY(U,$J,"PRO",788,10,22,"^")
 ;;=DGJ JUMP CATEG
 ;;^UTILITY(U,$J,"PRO",788,24)
 ;;=I 1 X:$D(^ORD(101,+$P(^ORD(101,DA(1),10,DA,0),"^",1),24)) ^(24)
 ;;^UTILITY(U,$J,"PRO",788,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",788,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",788,99)
 ;;=55663,41856
 ;;^UTILITY(U,$J,"PRO",789,0)
 ;;=DGJ IRT EDIT PARMS^Edit Def. Parms.^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",789,4)
 ;;=^^^DE
 ;;^UTILITY(U,$J,"PRO",789,20)
 ;;=D EDIT^DGJPAR1
 ;;^UTILITY(U,$J,"PRO",789,99)
 ;;=55661,30389
 ;;^UTILITY(U,$J,"PRO",790,0)
 ;;=DGJ IRT ADD DEF. PARMS^Add Def. Parms.^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",790,4)
 ;;=^^^EN
 ;;^UTILITY(U,$J,"PRO",790,20)
 ;;=D EN^DGJTADD
 ;;^UTILITY(U,$J,"PRO",790,99)
 ;;=55661,30266
 ;;^UTILITY(U,$J,"PRO",796,0)
 ;;=IBDF DELETE GROUP^Delete a Group^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",796,1,0)
 ;;=^^3^3^2930510^
 ;;^UTILITY(U,$J,"PRO",796,1,1,0)
 ;;= 
