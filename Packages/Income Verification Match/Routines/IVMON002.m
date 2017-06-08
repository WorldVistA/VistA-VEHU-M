IVMON002 ; ; 21-OCT-1994
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1114,2,"B","DE",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1114,2,"B","EP",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1114,10,0)
 ;;=^101.01PA^0^0
 ;;^UTILITY(U,$J,"PRO",1114,20)
 ;;=D DE^IVMLINS1
 ;;^UTILITY(U,$J,"PRO",1114,99)
 ;;=56056,53766
 ;;^UTILITY(U,$J,"PRO",1115,0)
 ;;=IVMLI INSURANCE UPLOAD^IVM Insurance Upload^^M^^^^^^^^INCOME VERIFICATION MATCH
 ;;^UTILITY(U,$J,"PRO",1115,4)
 ;;=26^3
 ;;^UTILITY(U,$J,"PRO",1115,10,0)
 ;;=^101.01PA^2^2
 ;;^UTILITY(U,$J,"PRO",1115,10,1,0)
 ;;=1114^DE^1
 ;;^UTILITY(U,$J,"PRO",1115,10,1,"^")
 ;;=IVMLI DISPLAY ENTRY
 ;;^UTILITY(U,$J,"PRO",1115,10,2,0)
 ;;=1130^EH^21
 ;;^UTILITY(U,$J,"PRO",1115,10,2,"^")
 ;;=IVMLI SELECT HELP
 ;;^UTILITY(U,$J,"PRO",1115,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",1115,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",1115,99)
 ;;=56056,53766
 ;;^UTILITY(U,$J,"PRO",1116,0)
 ;;=IVMLD SELECT UPLOADABLE^Display Uploadable^^A^^^^^^^^INCOME VERIFICATION MATCH
 ;;^UTILITY(U,$J,"PRO",1116,4)
 ;;=^3
 ;;^UTILITY(U,$J,"PRO",1116,20)
 ;;=D UD^IVMLDEM1
 ;;^UTILITY(U,$J,"PRO",1116,99)
 ;;=56056,53766
 ;;^UTILITY(U,$J,"PRO",1117,0)
 ;;=IVMLD DEMO UPLOAD^Upload IVM Demographic Information^^M^^^^^^^^INCOME VERIFICATION MATCH
 ;;^UTILITY(U,$J,"PRO",1117,4)
 ;;=25^3
 ;;^UTILITY(U,$J,"PRO",1117,10,0)
 ;;=^101.01PA^3^3
 ;;^UTILITY(U,$J,"PRO",1117,10,1,0)
 ;;=1116^DU^1
 ;;^UTILITY(U,$J,"PRO",1117,10,1,"^")
 ;;=IVMLD SELECT UPLOADABLE
 ;;^UTILITY(U,$J,"PRO",1117,10,2,0)
 ;;=1120^VN^21
 ;;^UTILITY(U,$J,"PRO",1117,10,2,"^")
 ;;=IVMLD SELECT NON-UPLOADABLE
 ;;^UTILITY(U,$J,"PRO",1117,10,3,0)
 ;;=1123^EH^31
 ;;^UTILITY(U,$J,"PRO",1117,10,3,"^")
 ;;=IVMLD SELECT HELP
 ;;^UTILITY(U,$J,"PRO",1117,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",1117,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",1117,99)
 ;;=56062,52486
 ;;^UTILITY(U,$J,"PRO",1118,0)
 ;;=IVMLD UPLOADABLE DEMO^Uploadable Demographic Fields^^M^^^^^^^^INCOME VERIFICATION MATCH
 ;;^UTILITY(U,$J,"PRO",1118,4)
 ;;=30^4
 ;;^UTILITY(U,$J,"PRO",1118,10,0)
 ;;=^101.01PA^2^2
 ;;^UTILITY(U,$J,"PRO",1118,10,1,0)
 ;;=1119^UF^1
 ;;^UTILITY(U,$J,"PRO",1118,10,1,"^")
 ;;=IVMLD UPLOAD FIELDS
 ;;^UTILITY(U,$J,"PRO",1118,10,2,0)
 ;;=1122^DF^21
 ;;^UTILITY(U,$J,"PRO",1118,10,2,"^")
 ;;=IVMLD DELETE FIELDS
 ;;^UTILITY(U,$J,"PRO",1118,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",1118,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",1118,99)
 ;;=56056,53766
 ;;^UTILITY(U,$J,"PRO",1119,0)
 ;;=IVMLD UPLOAD FIELDS^Upload Demographic Fields^^A^^^^^^^^INCOME VERIFICATION MATCH
 ;;^UTILITY(U,$J,"PRO",1119,4)
 ;;=^2
 ;;^UTILITY(U,$J,"PRO",1119,20)
 ;;=D UF^IVMLDEM4
 ;;^UTILITY(U,$J,"PRO",1119,99)
 ;;=56056,53766
 ;;^UTILITY(U,$J,"PRO",1120,0)
 ;;=IVMLD SELECT NON-UPLOADABLE^View Non Uploadable^^A^^^^^^^^INCOME VERIFICATION MATCH
 ;;^UTILITY(U,$J,"PRO",1120,4)
 ;;=^3
 ;;^UTILITY(U,$J,"PRO",1120,20)
 ;;=D ND^IVMLDEM1
 ;;^UTILITY(U,$J,"PRO",1120,99)
 ;;=56056,53766
 ;;^UTILITY(U,$J,"PRO",1121,0)
 ;;=IVM INSURANCE EVENT^IVM INSURANCE EVENT^^X^^^^^^^^INCOME VERIFICATION MATCH
 ;;^UTILITY(U,$J,"PRO",1121,1,0)
 ;;=^^10^10^2940501^
 ;;^UTILITY(U,$J,"PRO",1121,1,1,0)
 ;;=This event will be called when patient insurance policy data is added,
 ;;^UTILITY(U,$J,"PRO",1121,1,2,0)
 ;;=edited, or deleted.  Two checks are performed:
 ;;^UTILITY(U,$J,"PRO",1121,1,3,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",1121,1,4,0)
 ;;=  1)  If the insurance status of an active IVM patient has changed
 ;;^UTILITY(U,$J,"PRO",1121,1,5,0)
 ;;=      since that patient's Means Test data was last transmitted to
 ;;^UTILITY(U,$J,"PRO",1121,1,6,0)
 ;;=      the IVM Center, the data will be queued for re-transmission.
