DGONI002 ; ; 13-AUG-1993
 ;;5.3;Registration;;Aug 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",101,1,8,0)
 ;;=    for admissions and 'outpatient' for discharges.  Admissions
 ;;^UTILITY(U,$J,"PRO",101,1,9,0)
 ;;=    to the domicilliary have an 'outpatient' appointment status.
 ;;^UTILITY(U,$J,"PRO",101,1,10,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",101,1,11,0)
 ;;= 3. When a patient is admitted, dietetics creates a dietetic
 ;;^UTILITY(U,$J,"PRO",101,1,12,0)
 ;;=    patient file entry and creates an admission diet order.
 ;;^UTILITY(U,$J,"PRO",101,1,13,0)
 ;;=    When a patient is discharged, all active diet
 ;;^UTILITY(U,$J,"PRO",101,1,14,0)
 ;;=    orders are discontinued.  If a patient is absent or on
 ;;^UTILITY(U,$J,"PRO",101,1,15,0)
 ;;=    pass, the diet orders are suspended.
 ;;^UTILITY(U,$J,"PRO",101,1,16,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",101,1,17,0)
 ;;= 4. Inpatient Pharmacy cancels all active orders when a
 ;;^UTILITY(U,$J,"PRO",101,1,18,0)
 ;;=    patient is admitted, discharged or on unauthorized absence.
 ;;^UTILITY(U,$J,"PRO",101,1,19,0)
 ;;=    A patient can not be given Unit Dose meds unless s/he is
 ;;^UTILITY(U,$J,"PRO",101,1,20,0)
 ;;=    admitted to a ward.  The patient can receive IV meds; however.
 ;;^UTILITY(U,$J,"PRO",101,1,21,0)
 ;;=    When a patient is transferred, an inpatient system parameter
 ;;^UTILITY(U,$J,"PRO",101,1,22,0)
 ;;=    is used to determine whether or not the orders should be
 ;;^UTILITY(U,$J,"PRO",101,1,23,0)
 ;;=    cancelled.  When a patient goes on authorized absence, the
 ;;^UTILITY(U,$J,"PRO",101,1,24,0)
 ;;=    inpatient system parameter is used to determine whether the
 ;;^UTILITY(U,$J,"PRO",101,1,25,0)
 ;;=    orders should be cancelled, placed on hold or no action taken.
 ;;^UTILITY(U,$J,"PRO",101,1,26,0)
 ;;=    When a patient returns from authorized absence any orders
 ;;^UTILITY(U,$J,"PRO",101,1,27,0)
 ;;=    placed on hold will no longer be on hold.
 ;;^UTILITY(U,$J,"PRO",101,1,28,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",101,1,29,0)
 ;;= 5. With ORDER ENTRY/RESULTS REPORTING v2.2, 
 ;;^UTILITY(U,$J,"PRO",101,1,30,0)
 ;;=    MAS OE/RR NOTIFICATIONS may be displayed to
 ;;^UTILITY(U,$J,"PRO",101,1,31,0)
 ;;=    USERS defined in an OE/RR LIST for the patient. These notifications are
 ;;^UTILITY(U,$J,"PRO",101,1,32,0)
 ;;=    displayed for admissions and death discharges.
 ;;^UTILITY(U,$J,"PRO",101,5)
 ;;=DGPM MOVEMENT EVENTS;DIC(19,
 ;;^UTILITY(U,$J,"PRO",101,10,0)
 ;;=^101.01PA^4^13
 ;;^UTILITY(U,$J,"PRO",101,10,1,0)
 ;;=102^^1
 ;;^UTILITY(U,$J,"PRO",101,10,1,"^")
 ;;=DGPM TREATING SPECIALTY EVENT
 ;;^UTILITY(U,$J,"PRO",101,10,3,0)
 ;;=104^^6
 ;;^UTILITY(U,$J,"PRO",101,10,3,"^")
 ;;=DGJ INCOMPLETE EVENT
 ;;^UTILITY(U,$J,"PRO",101,10,5,0)
 ;;=112^^7
 ;;^UTILITY(U,$J,"PRO",101,10,5,"^")
 ;;=DGOERR NOTE
 ;;^UTILITY(U,$J,"PRO",101,10,9,0)
 ;;=565^^8
 ;;^UTILITY(U,$J,"PRO",101,10,9,"^")
 ;;=DG MEANS TEST DOM
 ;;^UTILITY(U,$J,"PRO",101,99)
 ;;=55717,60551
 ;;^UTILITY(U,$J,"PRO",102,0)
 ;;=DGPM TREATING SPECIALTY EVENT^TREATING SPECIALTY EVENT^^X^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",102,1,0)
 ;;=^^1^1^2901217^^
 ;;^UTILITY(U,$J,"PRO",102,1,1,0)
 ;;=VERSION 5.0 TREATING SPECIALTY EVENT
 ;;^UTILITY(U,$J,"PRO",102,5)
 ;;=DGPM TREATING SPECIALTY EVENT;DIC(19,
 ;;^UTILITY(U,$J,"PRO",102,20)
 ;;=D EV^DGPTTS
 ;;^UTILITY(U,$J,"PRO",102,99)
 ;;=55028,26890
 ;;^UTILITY(U,$J,"PRO",102,"MEN","DGPM MOVEMENT EVENTS")
 ;;=102^^1
 ;;^UTILITY(U,$J,"PRO",104,0)
 ;;=DGJ INCOMPLETE EVENT^Incomplete Records Event Driver^^X^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",104,1,0)
 ;;=^^3^3^2910813^^^^
 ;;^UTILITY(U,$J,"PRO",104,1,1,0)
 ;;=This option adds a record to the Incomplete Records file
 ;;^UTILITY(U,$J,"PRO",104,1,2,0)
 ;;=upon discharge of a patient. It will stuff in all the
 ;;^UTILITY(U,$J,"PRO",104,1,3,0)
 ;;=pertinant data that is needed for this file.
 ;;^UTILITY(U,$J,"PRO",104,5)
 ;;=DGJ INCOMPLETE EVENT;DIC(19,
 ;;^UTILITY(U,$J,"PRO",104,20)
 ;;=D ^DGJTEVT
 ;;^UTILITY(U,$J,"PRO",104,99)
 ;;=55028,26891
 ;;^UTILITY(U,$J,"PRO",104,"MEN","DGPM MOVEMENT EVENTS")
 ;;=104^^6
 ;;^UTILITY(U,$J,"PRO",112,0)
 ;;=DGOERR NOTE^MAS Notifications^^X^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",112,1,0)
 ;;=^^5^5^2910711^^^
 ;;^UTILITY(U,$J,"PRO",112,1,1,0)
 ;;=     This option is used to send ADMISSION and DECEASED MAS NOTIFICATIONS
 ;;^UTILITY(U,$J,"PRO",112,1,2,0)
 ;;=in ORDER ENTRY/RESULTS REPORTING. It must be an item in the DGPM
 ;;^UTILITY(U,$J,"PRO",112,1,3,0)
 ;;=MOVEMENT EVENTS option in order for the notifications to be sent. The
 ;;^UTILITY(U,$J,"PRO",112,1,4,0)
 ;;=notifications will be sent for admissions and death discharges.
 ;;^UTILITY(U,$J,"PRO",112,1,5,0)
 ;;=This will only work with OE/RR v2.09 or higher.
