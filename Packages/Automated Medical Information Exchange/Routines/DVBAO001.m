DVBAO001 ; ; 10-APR-1995
 ;;2.7;AMIE;;Apr 10, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",634,0)
 ;;=VALM NEXT SCREEN^Next Screen^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",634,1,0)
 ;;=^^2^2^2920519^^^
 ;;^UTILITY(U,$J,"PRO",634,1,1,0)
 ;;=This action will allow the user to view the next screen
 ;;^UTILITY(U,$J,"PRO",634,1,2,0)
 ;;=of entries, if any exist.
 ;;^UTILITY(U,$J,"PRO",634,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",634,2,1,0)
 ;;=NX
 ;;^UTILITY(U,$J,"PRO",634,2,"B","NX",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",634,20)
 ;;=D NEXT^VALM4
 ;;^UTILITY(U,$J,"PRO",634,99)
 ;;=56328,39808
 ;;^UTILITY(U,$J,"PRO",634,"MEN","DVBA C VIEW EXAMS (MENU)")
 ;;=634^NX^11
 ;;^UTILITY(U,$J,"PRO",635,0)
 ;;=VALM PREVIOUS SCREEN^Previous Screen^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",635,1,0)
 ;;=^^2^2^2920113^^
 ;;^UTILITY(U,$J,"PRO",635,1,1,0)
 ;;=This action will allow the user to view the previous screen
 ;;^UTILITY(U,$J,"PRO",635,1,2,0)
 ;;=of entries, if any exist.
 ;;^UTILITY(U,$J,"PRO",635,2,0)
 ;;=^101.02A^3^2
 ;;^UTILITY(U,$J,"PRO",635,2,1,0)
 ;;=PR
 ;;^UTILITY(U,$J,"PRO",635,2,2,0)
 ;;=BK
 ;;^UTILITY(U,$J,"PRO",635,2,3,0)
 ;;=PR
 ;;^UTILITY(U,$J,"PRO",635,2,"B","BK",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",635,2,"B","PR",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",635,2,"B","PR",3)
 ;;=
 ;;^UTILITY(U,$J,"PRO",635,20)
 ;;=D PREV^VALM4
 ;;^UTILITY(U,$J,"PRO",635,99)
 ;;=56328,39808
 ;;^UTILITY(U,$J,"PRO",635,"MEN","DVBA C VIEW EXAMS (MENU)")
 ;;=635^BU^12
 ;;^UTILITY(U,$J,"PRO",642,0)
 ;;=VALM QUIT^Quit^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",642,.1)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",642,1,0)
 ;;=^^1^1^2911105^
 ;;^UTILITY(U,$J,"PRO",642,1,1,0)
 ;;=This protocol can be used as a generic 'quit' action.
 ;;^UTILITY(U,$J,"PRO",642,2,0)
 ;;=^101.02A^2^2
 ;;^UTILITY(U,$J,"PRO",642,2,1,0)
 ;;=EXIT
 ;;^UTILITY(U,$J,"PRO",642,2,2,0)
 ;;=QUIT
 ;;^UTILITY(U,$J,"PRO",642,2,"B","EXIT",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",642,2,"B","QUIT",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",642,20)
 ;;=Q
 ;;^UTILITY(U,$J,"PRO",642,99)
 ;;=56328,39808
 ;;^UTILITY(U,$J,"PRO",642,"MEN","DVBA C VIEW EXAMS (MENU)")
 ;;=642^QU^31
 ;;^UTILITY(U,$J,"PRO",642,"MEN","DVBA DISCHARGE TYPES (MENU)")
 ;;=642^QU^5
 ;;^UTILITY(U,$J,"PRO",644,0)
 ;;=VALM PRINT LIST^Print List^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",644,1,0)
 ;;=^^2^2^2920113^
 ;;^UTILITY(U,$J,"PRO",644,1,1,0)
 ;;=This action allws the user to print the entire list of
 ;;^UTILITY(U,$J,"PRO",644,1,2,0)
 ;;=entries currently being displayed.
 ;;^UTILITY(U,$J,"PRO",644,20)
 ;;=D PRTL^VALM1
 ;;^UTILITY(U,$J,"PRO",644,99)
 ;;=56328,39808
 ;;^UTILITY(U,$J,"PRO",644,"MEN","DVBA C VIEW EXAMS (MENU)")
 ;;=644^PL^22
 ;;^UTILITY(U,$J,"PRO",1106,0)
 ;;=DVBA C VIEW EXAMS (MENU)^View Exams^^M^^^^^^^^AUTOMATED MED INFO EXCHANGE
 ;;^UTILITY(U,$J,"PRO",1106,1,0)
 ;;=^^1^1^2940321^^
 ;;^UTILITY(U,$J,"PRO",1106,1,1,0)
 ;;=View exams protocol for displaying Physician's Guide
 ;;^UTILITY(U,$J,"PRO",1106,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",1106,10,0)
 ;;=^101.01PA^2^6
 ;;^UTILITY(U,$J,"PRO",1106,10,1,0)
 ;;=1108^SQ^32
 ;;^UTILITY(U,$J,"PRO",1106,10,1,"^")
 ;;=DVBA C SUPER QUIT
 ;;^UTILITY(U,$J,"PRO",1106,10,2,0)
 ;;=1107^JMP^21
 ;;^UTILITY(U,$J,"PRO",1106,10,2,"^")
 ;;=DVBA C VIEW JUMP (ACTION)
 ;;^UTILITY(U,$J,"PRO",1106,24)
 ;;=I 1 X:$D(^ORD(101,+$P(^ORD(101,DA(1),10,DA,0),"^",1),24)) ^(24)
 ;;^UTILITY(U,$J,"PRO",1106,26)
 ;;=D SHOW^VALM,KEYSET^DVBCVW2
 ;;^UTILITY(U,$J,"PRO",1106,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",1106,99)
 ;;=56340,37314
 ;;^UTILITY(U,$J,"PRO",1107,0)
 ;;=DVBA C VIEW JUMP (ACTION)^Jump to New Exam^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",1107,20)
 ;;=D INIT^DVBCLMU5
 ;;^UTILITY(U,$J,"PRO",1107,24)
 ;;=I DVBAC'="O"&(DVBAC'="E")
 ;;^UTILITY(U,$J,"PRO",1107,99)
 ;;=56328,39807
 ;;^UTILITY(U,$J,"PRO",1108,0)
 ;;=DVBA C SUPER QUIT^Super Quit^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",1108,20)
 ;;=D QUIT^DVBCLMU5
 ;;^UTILITY(U,$J,"PRO",1108,99)
 ;;=56328,39807
 ;;^UTILITY(U,$J,"PRO",1155,0)
 ;;=DVBA ADD DISCHARGE TYPE^ADD TYPES^^A^^^^^^^^AUTOMATED MED INFO EXCHANGE
 ;;^UTILITY(U,$J,"PRO",1155,4)
 ;;=^^^IDENTIFIRE
 ;;^UTILITY(U,$J,"PRO",1155,10,0)
 ;;=^101.01PA^0^0
 ;;^UTILITY(U,$J,"PRO",1155,20)
 ;;=D ADD^DVBALD
 ;;^UTILITY(U,$J,"PRO",1155,26)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1155,99)
 ;;=56328,39806
 ;;^UTILITY(U,$J,"PRO",1156,0)
 ;;=DVBA DISCHARGE TYPES (MENU)^DISCHARGE TYPES MENU^^M^^^^^^^^AUTOMATED MED INFO EXCHANGE
 ;;^UTILITY(U,$J,"PRO",1156,1,0)
 ;;=^^1^1^2941109^
 ;;^UTILITY(U,$J,"PRO",1156,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",1156,4)
 ;;=26^3^^TEST MENU ID
 ;;^UTILITY(U,$J,"PRO",1156,10,0)
 ;;=^101.01PA^4^5
 ;;^UTILITY(U,$J,"PRO",1156,10,1,0)
 ;;=1159^AL^1
 ;;^UTILITY(U,$J,"PRO",1156,10,1,"^")
 ;;=DVBA ACCEPT DISCHARGE TYPES
