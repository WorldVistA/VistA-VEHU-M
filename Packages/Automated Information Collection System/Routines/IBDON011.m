IBDON011 ; ; 03-APR-1996
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;; 3-APR-96
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",859,2,1,0)
 ;;=TEST
 ;;^UTILITY(U,$J,"PRO",859,2,2,0)
 ;;=ADD
 ;;^UTILITY(U,$J,"PRO",859,2,3,0)
 ;;=AW
 ;;^UTILITY(U,$J,"PRO",859,2,"B","ADD",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",859,2,"B","AW",3)
 ;;=
 ;;^UTILITY(U,$J,"PRO",859,2,"B","TEST",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",859,20)
 ;;=D ADD^IBDE1
 ;;^UTILITY(U,$J,"PRO",859,99)
 ;;=56222,29861
 ;;^UTILITY(U,$J,"PRO",860,0)
 ;;=IBDE DELETE FORM FROM IMP/EXP FILES^Delete Entry^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",860,1,0)
 ;;=^^1^1^2930813^
 ;;^UTILITY(U,$J,"PRO",860,1,1,0)
 ;;=Allows the user to select a form in the imp/exp files and deletes it.
 ;;^UTILITY(U,$J,"PRO",860,2,0)
 ;;=^101.02A^2^2
 ;;^UTILITY(U,$J,"PRO",860,2,1,0)
 ;;=DEL
 ;;^UTILITY(U,$J,"PRO",860,2,2,0)
 ;;=DW
 ;;^UTILITY(U,$J,"PRO",860,2,"B","DEL",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",860,2,"B","DW",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",860,20)
 ;;=D DELETE^IBDE1
 ;;^UTILITY(U,$J,"PRO",860,99)
 ;;=56222,29861
 ;;^UTILITY(U,$J,"PRO",861,0)
 ;;=IBDE DELETE IMP/EXP FILES^Clear Work Space^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",861,1,0)
 ;;=^^1^1^2930813^^
 ;;^UTILITY(U,$J,"PRO",861,1,1,0)
 ;;=Deletes all of the imp/exp files (358 range).
 ;;^UTILITY(U,$J,"PRO",861,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",861,2,1,0)
 ;;=CW
 ;;^UTILITY(U,$J,"PRO",861,2,"B","CW",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",861,20)
 ;;=D DLTALL^IBDE2
 ;;^UTILITY(U,$J,"PRO",861,99)
 ;;=56222,29861
 ;;^UTILITY(U,$J,"PRO",862,0)
 ;;=IBDE EDIT FORM'S IMP/EXP NOTES^Edit Imp/Exp Notes^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",862,1,0)
 ;;=^^2^2^2930813^^
 ;;^UTILITY(U,$J,"PRO",862,1,1,0)
 ;;=Allows the user to select a form form from the imp/exp files, then allows
 ;;^UTILITY(U,$J,"PRO",862,1,2,0)
 ;;=the user to edit the imp/exp notes.
 ;;^UTILITY(U,$J,"PRO",862,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",862,2,1,0)
 ;;=EE
 ;;^UTILITY(U,$J,"PRO",862,2,"B","EE",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",862,20)
 ;;=D EDIT^IBDE1
 ;;^UTILITY(U,$J,"PRO",862,99)
 ;;=56222,29861
 ;;^UTILITY(U,$J,"PRO",863,0)
 ;;=IBDE VIEW FORM'S IMP/EXP NOTES^View Imp/Exp Notes^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",863,1,0)
 ;;=^^2^2^2930813^
 ;;^UTILITY(U,$J,"PRO",863,1,1,0)
 ;;=Allows the user to select a form from the IMP/EXP files, then displays
 ;;^UTILITY(U,$J,"PRO",863,1,2,0)
 ;;=the imp/exp notes.
 ;;^UTILITY(U,$J,"PRO",863,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",863,2,1,0)
 ;;=VI
 ;;^UTILITY(U,$J,"PRO",863,2,"B","VI",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",863,20)
 ;;=D VIEW^IBDE1
 ;;^UTILITY(U,$J,"PRO",863,99)
 ;;=56222,29861
 ;;^UTILITY(U,$J,"PRO",864,0)
 ;;=IBDE IMPORT FORM^Import Entry^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",864,1,0)
 ;;=^^1^1^2960105^^^^
 ;;^UTILITY(U,$J,"PRO",864,1,1,0)
 ;;=Allows the user to select a form from the work space, then imports it.
 ;;^UTILITY(U,$J,"PRO",864,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",864,2,1,0)
 ;;=IE
 ;;^UTILITY(U,$J,"PRO",864,2,"B","IE",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",864,20)
 ;;=D IMPORT^IBDE1
 ;;^UTILITY(U,$J,"PRO",864,99)
 ;;=56222,29861
 ;;^UTILITY(U,$J,"PRO",865,0)
 ;;=IBDE IMP/EXP HELP^Help^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",865,1,0)
 ;;=^^2^2^2930813^
 ;;^UTILITY(U,$J,"PRO",865,1,1,0)
 ;;=Displays help information about the import/export procedures that the user
 ;;^UTILITY(U,$J,"PRO",865,1,2,0)
 ;;=must follow.
 ;;^UTILITY(U,$J,"PRO",865,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",865,2,1,0)
 ;;=HE
 ;;^UTILITY(U,$J,"PRO",865,2,"B","HE",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",865,20)
 ;;=D HELP^IBDEHELP
 ;;^UTILITY(U,$J,"PRO",865,99)
 ;;=56222,29861
 ;;^UTILITY(U,$J,"PRO",866,0)
 ;;=IBDE EXECUTE DIFROM^DIFROM^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",866,1,0)
 ;;=^^1^1^2930813^
 ;;^UTILITY(U,$J,"PRO",866,1,1,0)
 ;;=Allows the user to execute ^DIFROM without leaving the imp/exp utility.
 ;;^UTILITY(U,$J,"PRO",866,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",866,2,1,0)
 ;;=DI
 ;;^UTILITY(U,$J,"PRO",866,2,"B","DI",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",866,20)
 ;;=D DIFROM^IBDE1
 ;;^UTILITY(U,$J,"PRO",866,99)
 ;;=56222,29861
 ;;^UTILITY(U,$J,"PRO",867,0)
 ;;=IBDE EXECUTE INITS^Run Inits^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",867,1,0)
 ;;=^^1^1^2930813^
 ;;^UTILITY(U,$J,"PRO",867,1,1,0)
 ;;=Allows the user to execute the inits without leaving the imp/exp utilities.
 ;;^UTILITY(U,$J,"PRO",867,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",867,2,1,0)
 ;;=RI
 ;;^UTILITY(U,$J,"PRO",867,2,"B","RI",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",867,20)
 ;;=D INITS^IBDE1
