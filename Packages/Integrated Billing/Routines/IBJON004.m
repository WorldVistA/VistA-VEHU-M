IBJON004 ; ; 04-JAN-1996
 ;;Version 2.0 ; INTEGRATED BILLING ;**39**; 21-MAR-94
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1268,99)
 ;;=56406,43699
 ;;^UTILITY(U,$J,"PRO",1301,0)
 ;;=IBJT CLAIM SCREEN ACTIVE^Claim Information^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1301,20)
 ;;=D NX^IBJTLA("IBJT CLAIM INFO")
 ;;^UTILITY(U,$J,"PRO",1301,99)
 ;;=56377,49427
 ;;^UTILITY(U,$J,"PRO",1314,0)
 ;;=IBJT NS VIEW INS CO SCREEN^Insurance Company^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1314,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1314,20)
 ;;=I '$$PRVSCR^IBJTU1("IBCNSC") D VI^IBJTNA(0)
 ;;^UTILITY(U,$J,"PRO",1314,99)
 ;;=56389,40085
 ;;^UTILITY(U,$J,"PRO",1316,0)
 ;;=IBJT NS VIEW EXP POL SCREEN^Policy^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1316,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1316,20)
 ;;=I '$$PRVSCR^IBJTU1("IBCNSVP") D VP^IBJTNB(0)
 ;;^UTILITY(U,$J,"PRO",1316,99)
 ;;=56349,52758
 ;;^UTILITY(U,$J,"PRO",1317,0)
 ;;=IBJT NS VIEW AN BEN SCREEN^Annual Benefits^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1317,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1317,20)
 ;;=I '$$PRVSCR^IBJTU1("IBCNSA") D AB^IBJTNB(0)
 ;;^UTILITY(U,$J,"PRO",1317,99)
 ;;=56312,53070
 ;;^UTILITY(U,$J,"PRO",1318,0)
 ;;=IBJT BILL CHARGES SCREEN^Bill Charges^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1318,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1318,20)
 ;;=I '$$PRVSCR^IBJTU1("IBJTBA") D EN^IBJTBA
 ;;^UTILITY(U,$J,"PRO",1318,99)
 ;;=56312,53072
 ;;^UTILITY(U,$J,"PRO",1321,0)
 ;;=IBJT BILL DX SCREEN^Bill Diagnosis^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1321,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1321,20)
 ;;=I '$$PRVSCR^IBJTU1("IBJTBB") D EN^IBJTBB
 ;;^UTILITY(U,$J,"PRO",1321,99)
 ;;=56312,53072
 ;;^UTILITY(U,$J,"PRO",1326,0)
 ;;=IBJT BILL PROCEDURES SCREEN^Bill Procedures^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1326,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1326,20)
 ;;=I '$$PRVSCR^IBJTU1("IBJTBC") D EN^IBJTBC
 ;;^UTILITY(U,$J,"PRO",1326,99)
 ;;=56349,39508
 ;;^UTILITY(U,$J,"PRO",1334,0)
 ;;=IBJT AR ACCOUNT PROFILE SCREEN^Account Profile^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1334,20)
 ;;=I '$$PRVSCR^IBJTU1("IBJTTA") D EN^IBJTTA
 ;;^UTILITY(U,$J,"PRO",1334,99)
 ;;=56349,39349
 ;;^UTILITY(U,$J,"PRO",1338,0)
 ;;=IBJT CHANGE DATES INACTIVE^Change Dates^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1338,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1338,20)
 ;;=D CDI^IBJTA1
 ;;^UTILITY(U,$J,"PRO",1338,99)
 ;;=56321,41732
 ;;^UTILITY(U,$J,"PRO",1339,0)
 ;;=IBJT CHANGE PATIENT^Change Patient^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1339,20)
 ;;=D CP^IBJTA1
 ;;^UTILITY(U,$J,"PRO",1339,99)
 ;;=56319,53246
 ;;^UTILITY(U,$J,"PRO",1342,0)
 ;;=IBJT ACTIVE LIST SCREEN SKIP^Go to Active List^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1342,20)
 ;;=S IBFASTXT=4
 ;;^UTILITY(U,$J,"PRO",1342,99)
 ;;=56377,48469
 ;;^UTILITY(U,$J,"PRO",1344,0)
 ;;=IBJT AR TRANSACTION PROFILE SCREEN^Transaction Profile^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1344,20)
 ;;=D NX^IBJTTA("IBJT AR TRANSACTION PROFILE")
 ;;^UTILITY(U,$J,"PRO",1344,99)
 ;;=56349,39412
 ;;^UTILITY(U,$J,"PRO",1348,0)
 ;;=IBJT CLAIM SCREEN INACTIVE^Claim Information^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1348,20)
 ;;=D NX^IBJTLB("IBJT CLAIM INFO")
 ;;^UTILITY(U,$J,"PRO",1348,99)
 ;;=56377,49449
 ;;^UTILITY(U,$J,"PRO",1349,0)
 ;;=IBJT CLAIM SCREEN SKIP^Go to Claim Screen^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1349,20)
 ;;=S IBFASTXT=3
 ;;^UTILITY(U,$J,"PRO",1349,99)
 ;;=56349,42901
 ;;^UTILITY(U,$J,"PRO",1350,0)
 ;;=IBJT CHANGE BILL^Change Bill^^A^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1350,20)
 ;;=D CB^IBJTA1
 ;;^UTILITY(U,$J,"PRO",1350,99)
 ;;=56349,46588
 ;;^UTILITY(U,$J,"PRO",1351,0)
 ;;=IBJT CLAIM SCREEN MENU^Claim Information Menu^^M^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1351,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",1351,10,0)
 ;;=^101.01PA^14^15
 ;;^UTILITY(U,$J,"PRO",1351,10,1,0)
 ;;=1318^BC^11
 ;;^UTILITY(U,$J,"PRO",1351,10,1,"^")
 ;;=IBJT BILL CHARGES SCREEN
 ;;^UTILITY(U,$J,"PRO",1351,10,2,0)
 ;;=1321^DX^12
 ;;^UTILITY(U,$J,"PRO",1351,10,2,"^")
 ;;=IBJT BILL DX SCREEN
 ;;^UTILITY(U,$J,"PRO",1351,10,3,0)
 ;;=1326^PR^13
