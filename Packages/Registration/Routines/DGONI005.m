DGONI005 ; ; 13-AUG-1993
 ;;5.3;Registration;;Aug 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",602,10,20,0)
 ;;=700^CE^31
 ;;^UTILITY(U,$J,"PRO",602,10,20,"^")
 ;;=DGJ EDIT COMP IRT SUPER
 ;;^UTILITY(U,$J,"PRO",602,10,21,0)
 ;;=702^DL^23
 ;;^UTILITY(U,$J,"PRO",602,10,21,"^")
 ;;=DGJ DELETE SUPER
 ;;^UTILITY(U,$J,"PRO",602,10,22,0)
 ;;=704^JC^29
 ;;^UTILITY(U,$J,"PRO",602,10,22,"^")
 ;;=DGJ JUMP CATEG
 ;;^UTILITY(U,$J,"PRO",602,24)
 ;;=I 1 X:$D(^ORD(101,+$P(^ORD(101,DA(1),10,DA,0),"^",1),24)) ^(24)
 ;;^UTILITY(U,$J,"PRO",602,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",602,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",602,99)
 ;;=55588,43603
 ;;^UTILITY(U,$J,"PRO",603,0)
 ;;=DGJ IRT ENTER RECORD^Enter IRT Record^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",603,.1)
 ;;=EN
 ;;^UTILITY(U,$J,"PRO",603,1,0)
 ;;=^^2^2^2921008^^
 ;;^UTILITY(U,$J,"PRO",603,1,1,0)
 ;;=This protocol is the action to enter a new IRT record.  It is an action
 ;;^UTILITY(U,$J,"PRO",603,1,2,0)
 ;;=under the Enter/Edit a Record protocol menu.
 ;;^UTILITY(U,$J,"PRO",603,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",603,2,1,0)
 ;;=EN
 ;;^UTILITY(U,$J,"PRO",603,2,"B","EN",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",603,4)
 ;;=^^^EN
 ;;^UTILITY(U,$J,"PRO",603,20)
 ;;=D NEW1^DGJTEE
 ;;^UTILITY(U,$J,"PRO",603,26)
 ;;=D HDR^DGJTEE
 ;;^UTILITY(U,$J,"PRO",603,99)
 ;;=55397,48237
 ;;^UTILITY(U,$J,"PRO",604,0)
 ;;=DGJ IRT EDIT RECORD^Edit IRT Record^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",604,1,0)
 ;;=^^2^2^2921008^^
 ;;^UTILITY(U,$J,"PRO",604,1,1,0)
 ;;=This protocol is the action to edit an IRT record under the Enter/Edit an
 ;;^UTILITY(U,$J,"PRO",604,1,2,0)
 ;;=IRT Record protocol menu.
 ;;^UTILITY(U,$J,"PRO",604,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",604,2,1,0)
 ;;=DE
 ;;^UTILITY(U,$J,"PRO",604,2,"B","DE",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",604,4)
 ;;=^^^DE
 ;;^UTILITY(U,$J,"PRO",604,20)
 ;;=D NEW^DGJTEE
 ;;^UTILITY(U,$J,"PRO",604,26)
 ;;=D HDR^DGJTEE
 ;;^UTILITY(U,$J,"PRO",604,99)
 ;;=55397,48141
 ;;^UTILITY(U,$J,"PRO",606,0)
 ;;=DGPT A/P EDIT TMP^PTF ARCHIVE/PURGE^^M^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",606,1,0)
 ;;=^^2^2^2930312^^^^
 ;;^UTILITY(U,$J,"PRO",606,1,1,0)
 ;;=This protocol is used to implement PTF Archive/Purge functions.
 ;;^UTILITY(U,$J,"PRO",606,1,2,0)
 ;;=It is used in conjuction with the List Manager utility.
 ;;^UTILITY(U,$J,"PRO",606,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",606,2,1,0)
 ;;=AP
 ;;^UTILITY(U,$J,"PRO",606,2,"B","AP",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",606,4)
 ;;=26^4^^
 ;;^UTILITY(U,$J,"PRO",606,10,0)
 ;;=^101.01PA^3^24
 ;;^UTILITY(U,$J,"PRO",606,10,22,0)
 ;;=607^RP^10
 ;;^UTILITY(U,$J,"PRO",606,10,22,"^")
 ;;=DGPT REMOVE A/P
 ;;^UTILITY(U,$J,"PRO",606,10,23,0)
 ;;=608^SP^11
 ;;^UTILITY(U,$J,"PRO",606,10,23,"^")
 ;;=DGPT SELECT A/P
 ;;^UTILITY(U,$J,"PRO",606,10,24,0)
 ;;=613^DI^12
 ;;^UTILITY(U,$J,"PRO",606,10,24,"^")
 ;;=DGPT DETAILED INQUIRY
 ;;^UTILITY(U,$J,"PRO",606,24)
 ;;=I 1 X:$D(^ORD(101,+$P(^ORD(101,DA(1),10,DA,0),"^",1),24)) ^(24)
 ;;^UTILITY(U,$J,"PRO",606,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",606,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",606,99)
 ;;=55640,53192
 ;;^UTILITY(U,$J,"PRO",607,0)
 ;;=DGPT REMOVE A/P^Remove PTF Record(s)^^A^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",607,1,0)
 ;;=^^3^3^2930503^^^^
 ;;^UTILITY(U,$J,"PRO",607,1,1,0)
 ;;=This function will remove the selcted PTF records from the entries
 ;;^UTILITY(U,$J,"PRO",607,1,2,0)
 ;;=selected for the Archive and Purge process. The entries removed will
 ;;^UTILITY(U,$J,"PRO",607,1,3,0)
 ;;=NOT be Archived or Purged.
 ;;^UTILITY(U,$J,"PRO",607,4)
 ;;=^^^RP
 ;;^UTILITY(U,$J,"PRO",607,20)
 ;;=D DELEX^DGPTLMU1
 ;;^UTILITY(U,$J,"PRO",607,24)
 ;;=D CHECK^DGPTAPA I Y=""
 ;;^UTILITY(U,$J,"PRO",607,99)
 ;;=55640,52363
 ;;^UTILITY(U,$J,"PRO",608,0)
 ;;=DGPT SELECT A/P^Select PTF Record(s)^^A^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",608,1,0)
 ;;=^^3^3^2930503^^^
 ;;^UTILITY(U,$J,"PRO",608,1,1,0)
 ;;=This function will select a PTF record previously de-selected
 ;;^UTILITY(U,$J,"PRO",608,1,2,0)
 ;;=from the A/P process. Once the record(s) have been selected they
 ;;^UTILITY(U,$J,"PRO",608,1,3,0)
 ;;=will be Archived and Purged.
 ;;^UTILITY(U,$J,"PRO",608,4)
 ;;=^^^SP
 ;;^UTILITY(U,$J,"PRO",608,20)
 ;;=D ADDEX^DGPTLMU1
 ;;^UTILITY(U,$J,"PRO",608,24)
 ;;=D CHECK^DGPTAPA I Y=""
 ;;^UTILITY(U,$J,"PRO",608,99)
 ;;=55640,53168
 ;;^UTILITY(U,$J,"PRO",608,101.0431,0)
 ;;=^^1^1^2930312^
 ;;^UTILITY(U,$J,"PRO",608,101.0431,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",609,0)
 ;;=DGPT A/P MAIN^Main A/P Menu Items^^M^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",609,1,0)
 ;;=^^2^2^2930402^^^^
 ;;^UTILITY(U,$J,"PRO",609,1,1,0)
 ;;=This protocol is the default protocol for the List Manager
