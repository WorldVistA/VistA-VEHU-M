DGONI001 ; ; 13-AUG-1993
 ;;5.3;Registration;;Aug 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",28,0)
 ;;=DGOERR ADMIT^ADMIT PATIENT^^O^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",28,1,0)
 ;;=^^1^1^2911101^^^^
 ;;^UTILITY(U,$J,"PRO",28,1,1,0)
 ;;=This is the admission option associated with order entry/results reporting.
 ;;^UTILITY(U,$J,"PRO",28,1,"B","This is the admission option a",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",28,5)
 ;;=DGOERR ADMIT;DIC(19,
 ;;^UTILITY(U,$J,"PRO",28,20)
 ;;=S DGPMT=1 D LO^DGUTL,OREN^DGPMV K VAINDT D INP^VADPT,READ^ORUTL
 ;;^UTILITY(U,$J,"PRO",28,99)
 ;;=55028,26856
 ;;^UTILITY(U,$J,"PRO",29,0)
 ;;=DGOERR BED SWITCH^SWITCH BED^^O^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",29,1,0)
 ;;=^^2^2^2880719^
 ;;^UTILITY(U,$J,"PRO",29,1,1,0)
 ;;=This is the bed switch option associated with oreder entry/results
 ;;^UTILITY(U,$J,"PRO",29,1,2,0)
 ;;=reporting.
 ;;^UTILITY(U,$J,"PRO",29,1,"B","This is the bed switch option ",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",29,1,"B","reporting.",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",29,5)
 ;;=DGOERR BED SWITCH;DIC(19,
 ;;^UTILITY(U,$J,"PRO",29,20)
 ;;=D LO^DGUTL,OREN^DGSWITCH K VAINDT D INP^VADPT,READ^ORUTL
 ;;^UTILITY(U,$J,"PRO",29,99)
 ;;=55028,26856
 ;;^UTILITY(U,$J,"PRO",30,0)
 ;;=DGOERR DISCHARGE^DISCHARGE PATIENT^^O^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",30,1,0)
 ;;=^^1^1^2910129^^
 ;;^UTILITY(U,$J,"PRO",30,1,1,0)
 ;;=This is the discharge option assocaited with order entry/result reporting.
 ;;^UTILITY(U,$J,"PRO",30,1,"B","This is the discharge option a",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",30,5)
 ;;=DGOERR DISCHARGE;DIC(19,
 ;;^UTILITY(U,$J,"PRO",30,20)
 ;;=S DGPMT=3 D LO^DGUTL,OREN^DGPMV K VAINDT D INP^VADPT,READ^ORUTL
 ;;^UTILITY(U,$J,"PRO",30,99)
 ;;=55028,26857
 ;;^UTILITY(U,$J,"PRO",31,0)
 ;;=DGOERR PATIENT INQUIRY^PATIENT INQUIRY^^O^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",31,1,0)
 ;;=^^1^1^2880719^
 ;;^UTILITY(U,$J,"PRO",31,1,1,0)
 ;;=This is the inquiry option associated with order entry/results reporting.
 ;;^UTILITY(U,$J,"PRO",31,1,"B","This is the inquiry option ass",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",31,5)
 ;;=DGOERR PATIENT INQUIRY;DIC(19,
 ;;^UTILITY(U,$J,"PRO",31,20)
 ;;=D OREN^DGRPD
 ;;^UTILITY(U,$J,"PRO",31,99)
 ;;=55028,26857
 ;;^UTILITY(U,$J,"PRO",32,0)
 ;;=DGOERR SCHED ADMIT^SCHEDULE ADMISSION^^O^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",32,1,0)
 ;;=^^2^2^2880719^
 ;;^UTILITY(U,$J,"PRO",32,1,1,0)
 ;;=This is the scheduled admission option associated with order entry/
 ;;^UTILITY(U,$J,"PRO",32,1,2,0)
 ;;=results reporting.
 ;;^UTILITY(U,$J,"PRO",32,1,"B","This is the scheduled admissio",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",32,1,"B","results reporting.",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",32,5)
 ;;=DGOERR SCHED ADMIT;DIC(19,
 ;;^UTILITY(U,$J,"PRO",32,20)
 ;;=D OREN^DGSCHAD,READ^ORUTL
 ;;^UTILITY(U,$J,"PRO",32,99)
 ;;=55028,26857
 ;;^UTILITY(U,$J,"PRO",33,0)
 ;;=DGOERR TRANSFER^TRANSFER PATIENT^^O^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",33,1,0)
 ;;=^^1^1^2880719^
 ;;^UTILITY(U,$J,"PRO",33,1,1,0)
 ;;=This is the transfer option associated with order entry/result reporting.
 ;;^UTILITY(U,$J,"PRO",33,1,"B","This is the transfer option as",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",33,5)
 ;;=DGOERR TRANSFER;DIC(19,
 ;;^UTILITY(U,$J,"PRO",33,15)
 ;;=K DGPMASIH
 ;;^UTILITY(U,$J,"PRO",33,20)
 ;;=S DGPMT=2 D LO^DGUTL,OREN^DGPMV K VAINDT D INP^VADPT,READ^ORUTL
 ;;^UTILITY(U,$J,"PRO",33,99)
 ;;=55028,26858
 ;;^UTILITY(U,$J,"PRO",34,0)
 ;;=DG OERR TREATING TRANSFER^TRANSFER SPECIALTY^^O^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",34,1,0)
 ;;=^^2^2^2910129^^^^
 ;;^UTILITY(U,$J,"PRO",34,1,1,0)
 ;;=This is the treating specialty transfer option associated with order entry/
 ;;^UTILITY(U,$J,"PRO",34,1,2,0)
 ;;=results reporting.
 ;;^UTILITY(U,$J,"PRO",34,1,"B","This is the treating specialty",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",34,1,"B","results reporting.",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",34,5)
 ;;=DG OERR TREATING TRANSFER;DIC(19,
 ;;^UTILITY(U,$J,"PRO",34,20)
 ;;=S DGPMT=6 D LO^DGUTL,OREN^DGPMV K VAINDT D INP^VADPT,READ^ORUTL
 ;;^UTILITY(U,$J,"PRO",34,99)
 ;;=55028,26858
 ;;^UTILITY(U,$J,"PRO",101,0)
 ;;=DGPM MOVEMENT EVENTS^MOVEMENT EVENTS v 5.0^^X^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",101,1,0)
 ;;=32^^32^32^2930813^
 ;;^UTILITY(U,$J,"PRO",101,1,1,0)
 ;;= At the completion of a patient movement the following events
 ;;^UTILITY(U,$J,"PRO",101,1,2,0)
 ;;= take place through this option:
 ;;^UTILITY(U,$J,"PRO",101,1,3,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",101,1,4,0)
 ;;= 1. The PTF record is updated when a patient is admitted,
 ;;^UTILITY(U,$J,"PRO",101,1,5,0)
 ;;=    discharged or transfered.
 ;;^UTILITY(U,$J,"PRO",101,1,6,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",101,1,7,0)
 ;;= 2. The appointment status for a patient is updated to 'inpatient'
