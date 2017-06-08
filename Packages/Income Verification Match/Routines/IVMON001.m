IVMON001 ; ; 21-OCT-1994
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",855,0)
 ;;=IVM MEANS TEST EVENT^IVM MEANS TEST EVENT^^X^^^^^^^^INCOME VERIFICATION MATCH
 ;;^UTILITY(U,$J,"PRO",855,1,0)
 ;;=^^10^10^2940501^^^^
 ;;^UTILITY(U,$J,"PRO",855,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",855,1,2,0)
 ;;=This event will be called each time a means test is added, edited, or
 ;;^UTILITY(U,$J,"PRO",855,1,3,0)
 ;;=deleted.  It will check two things:
 ;;^UTILITY(U,$J,"PRO",855,1,4,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",855,1,5,0)
 ;;=  1)  If the means test meets IVM criteria for tranmsission, it will
 ;;^UTILITY(U,$J,"PRO",855,1,6,0)
 ;;=      send demographic and income information to the IVM Center.
 ;;^UTILITY(U,$J,"PRO",855,1,7,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",855,1,8,0)
 ;;=  2)  If the IVM Center has already received data about the patient for
 ;;^UTILITY(U,$J,"PRO",855,1,9,0)
 ;;=      the means test year, updated information will be sent to the IVM
 ;;^UTILITY(U,$J,"PRO",855,1,10,0)
 ;;=      Center.
 ;;^UTILITY(U,$J,"PRO",855,5)
 ;;=
 ;;^UTILITY(U,$J,"PRO",855,20)
 ;;=D ^IVMPMTE
 ;;^UTILITY(U,$J,"PRO",855,99)
 ;;=56056,53765
 ;;^UTILITY(U,$J,"PRO",855,"MEN","DG MEANS TEST EVENTS")
 ;;=855
 ;;^UTILITY(U,$J,"PRO",1111,0)
 ;;=IVMLS PURGE SSN^Purge Entry^^A^^^^^^^^INCOME VERIFICATION MATCH
 ;;^UTILITY(U,$J,"PRO",1111,1,0)
 ;;=^^3^3^2940203^^^^
 ;;^UTILITY(U,$J,"PRO",1111,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",1111,1,2,0)
 ;;=This protocol will be used by the IVM SSN Update utility to purge an entry
 ;;^UTILITY(U,$J,"PRO",1111,1,3,0)
 ;;=on the list if the user feels it is not appropriate.
 ;;^UTILITY(U,$J,"PRO",1111,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1111,2,1,0)
 ;;=PU
 ;;^UTILITY(U,$J,"PRO",1111,2,"B","PU",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1111,20)
 ;;=D PU^IVMLSU2
 ;;^UTILITY(U,$J,"PRO",1111,99)
 ;;=56056,53766
 ;;^UTILITY(U,$J,"PRO",1112,0)
 ;;=IVMLS UPLOAD SSN^Update SSN^^A^^^^^^^^INCOME VERIFICATION MATCH
 ;;^UTILITY(U,$J,"PRO",1112,1,0)
 ;;=^^3^3^2940125^^^
 ;;^UTILITY(U,$J,"PRO",1112,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",1112,1,2,0)
 ;;=This protocol may be used to upload an SSN from the list of suggested SSN
 ;;^UTILITY(U,$J,"PRO",1112,1,3,0)
 ;;=received back from the Social Security Administration (SSA).
 ;;^UTILITY(U,$J,"PRO",1112,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1112,2,1,0)
 ;;=UP
 ;;^UTILITY(U,$J,"PRO",1112,2,"B","UP",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1112,10,0)
 ;;=^101.01PA^0^0
 ;;^UTILITY(U,$J,"PRO",1112,20)
 ;;=D UP^IVMLSU2
 ;;^UTILITY(U,$J,"PRO",1112,99)
 ;;=56056,53767
 ;;^UTILITY(U,$J,"PRO",1113,0)
 ;;=IVMLS SSN UPLOAD^Upload IVM Information^^M^^^^^^^^INCOME VERIFICATION MATCH
 ;;^UTILITY(U,$J,"PRO",1113,1,0)
 ;;=^^3^3^2940126^
 ;;^UTILITY(U,$J,"PRO",1113,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",1113,1,2,0)
 ;;=This menu contains all the activities allowed when updating IVM information
 ;;^UTILITY(U,$J,"PRO",1113,1,3,0)
 ;;=using the Upload IVM Data option.
 ;;^UTILITY(U,$J,"PRO",1113,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",1113,10,0)
 ;;=^101.01PA^2^2
 ;;^UTILITY(U,$J,"PRO",1113,10,1,0)
 ;;=1111^PU^2
 ;;^UTILITY(U,$J,"PRO",1113,10,1,"^")
 ;;=IVMLS PURGE SSN
 ;;^UTILITY(U,$J,"PRO",1113,10,2,0)
 ;;=1112^UP^1
 ;;^UTILITY(U,$J,"PRO",1113,10,2,"^")
 ;;=IVMLS UPLOAD SSN
 ;;^UTILITY(U,$J,"PRO",1113,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",1113,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",1113,99)
 ;;=56056,53767
 ;;^UTILITY(U,$J,"PRO",1114,0)
 ;;=IVMLI DISPLAY ENTRY^Display Entry^^A^^^^^^^^INCOME VERIFICATION MATCH
 ;;^UTILITY(U,$J,"PRO",1114,2,0)
 ;;=^101.02A^2^2
 ;;^UTILITY(U,$J,"PRO",1114,2,1,0)
 ;;=EP
 ;;^UTILITY(U,$J,"PRO",1114,2,2,0)
 ;;=DE
