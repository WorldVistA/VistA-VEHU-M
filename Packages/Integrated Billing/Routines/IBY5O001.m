IBY5O001 ; ; 17-MAY-1994
 ;;Version 2.0 ; INTEGRATED BILLING ;**6**; 21-MAR-94
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1139,0)
 ;;=IBCN NEW INSURANCE EVENTS^IB New Insurance Event Driver^^X^^^^^^^^INTEGRATED BILLING
 ;;^UTILITY(U,$J,"PRO",1139,1,0)
 ;;=^^3^3^2940428^^^^
 ;;^UTILITY(U,$J,"PRO",1139,1,1,0)
 ;;=This event driver will be invoked whenever a new insurance type entry is
 ;;^UTILITY(U,$J,"PRO",1139,1,2,0)
 ;;=created in the patient file.  This is so that necessary actions can take
 ;;^UTILITY(U,$J,"PRO",1139,1,3,0)
 ;;=place when a new insurance policy is added for a patient.
 ;;^UTILITY(U,$J,"PRO",1139,4)
 ;;=^^^IBCNS
 ;;^UTILITY(U,$J,"PRO",1139,10,0)
 ;;=^101.01PA^0^2
 ;;^UTILITY(U,$J,"PRO",1139,99)
 ;;=56019,57266
