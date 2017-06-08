IBDON010 ; ; 03-APR-1996
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;; 3-APR-96
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",845,2,"B","CB",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",845,20)
 ;;=D COPYBLK^IBDF13
 ;;^UTILITY(U,$J,"PRO",845,99)
 ;;=56301,49960
 ;;^UTILITY(U,$J,"PRO",846,0)
 ;;=IBDF COPY FORM BLOCK^Copy From Other Form^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",846,.1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",846,1,0)
 ;;=^^2^2^2941206^^^
 ;;^UTILITY(U,$J,"PRO",846,1,1,0)
 ;;=Allows a block or page from any form to be selected and pasted to the
 ;;^UTILITY(U,$J,"PRO",846,1,2,0)
 ;;=current form.
 ;;^UTILITY(U,$J,"PRO",846,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",846,2,1,0)
 ;;=CF
 ;;^UTILITY(U,$J,"PRO",846,2,"B","CF",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",846,20)
 ;;=D COPY^IBDF5D
 ;;^UTILITY(U,$J,"PRO",846,99)
 ;;=56301,49960
 ;;^UTILITY(U,$J,"PRO",852,0)
 ;;=IBDF SHIFT BLOCKS^Shift Blocks^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",852,1,0)
 ;;=^^3^3^2930716^
 ;;^UTILITY(U,$J,"PRO",852,1,1,0)
 ;;=Allows the user to shift a group of blocks. The user is asked to specify
 ;;^UTILITY(U,$J,"PRO",852,1,2,0)
 ;;=a rectangular region where the shift should occur, the direction of movement
 ;;^UTILITY(U,$J,"PRO",852,1,3,0)
 ;;=and distance.
 ;;^UTILITY(U,$J,"PRO",852,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",852,2,1,0)
 ;;=SB
 ;;^UTILITY(U,$J,"PRO",852,2,"B","SB",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",852,20)
 ;;=D SHIFT^IBDF5
 ;;^UTILITY(U,$J,"PRO",852,99)
 ;;=56301,49966
 ;;^UTILITY(U,$J,"PRO",853,0)
 ;;=IBDF SAVE/DISCARD BLOCK CHANGES^Save/Discard Changes^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",853,1,0)
 ;;=^^1^1^2930728^^
 ;;^UTILITY(U,$J,"PRO",853,1,1,0)
 ;;=Allows the user to save the changes to the block he is currently editing.
 ;;^UTILITY(U,$J,"PRO",853,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",853,2,1,0)
 ;;=SD
 ;;^UTILITY(U,$J,"PRO",853,2,"B","SD",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",853,20)
 ;;=D DECIDE^IBDF5B
 ;;^UTILITY(U,$J,"PRO",853,99)
 ;;=56301,49966
 ;;^UTILITY(U,$J,"PRO",854,0)
 ;;=IBDF QUIT^Exit^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",854,1,0)
 ;;=^^1^1^2930729^^
 ;;^UTILITY(U,$J,"PRO",854,1,1,0)
 ;;=Quits to the prior level.
 ;;^UTILITY(U,$J,"PRO",854,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",854,2,1,0)
 ;;=Ex
 ;;^UTILITY(U,$J,"PRO",854,2,"B","Ex",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",854,15)
 ;;=S VALMBCK="Q"
 ;;^UTILITY(U,$J,"PRO",854,99)
 ;;=56301,49966
 ;;^UTILITY(U,$J,"PRO",858,0)
 ;;=IBDE IMP/EXP MENU FOR FORMS^List Forms^^M^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",858,1,0)
 ;;=^^2^2^2930813^^^^
 ;;^UTILITY(U,$J,"PRO",858,1,1,0)
 ;;=The main menu of the import/export utility, which allows forms and
 ;;^UTILITY(U,$J,"PRO",858,1,2,0)
 ;;=tool kit blocks to be transferred between sites.
 ;;^UTILITY(U,$J,"PRO",858,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",858,10,0)
 ;;=^101.01PA^10^11
 ;;^UTILITY(U,$J,"PRO",858,10,2,0)
 ;;=859^AE^6^^^Add Entry
 ;;^UTILITY(U,$J,"PRO",858,10,2,"^")
 ;;=IBDE ADD FORM TO IMP/EXP WS
 ;;^UTILITY(U,$J,"PRO",858,10,3,0)
 ;;=860^DE^5^^^Delete Entry
 ;;^UTILITY(U,$J,"PRO",858,10,3,"^")
 ;;=IBDE DELETE FORM FROM IMP/EXP FILES
 ;;^UTILITY(U,$J,"PRO",858,10,4,0)
 ;;=861^CW^4^^^Clear Work Space
 ;;^UTILITY(U,$J,"PRO",858,10,4,"^")
 ;;=IBDE DELETE IMP/EXP FILES
 ;;^UTILITY(U,$J,"PRO",858,10,5,0)
 ;;=862^EI^8^^^Edit Imp/Exp Notes
 ;;^UTILITY(U,$J,"PRO",858,10,5,"^")
 ;;=IBDE EDIT FORM'S IMP/EXP NOTES
 ;;^UTILITY(U,$J,"PRO",858,10,6,0)
 ;;=863^VI^7^^^View Imp/Exp Notes
 ;;^UTILITY(U,$J,"PRO",858,10,6,"^")
 ;;=IBDE VIEW FORM'S IMP/EXP NOTES
 ;;^UTILITY(U,$J,"PRO",858,10,7,0)
 ;;=864^IE^3^^^Import Entry
 ;;^UTILITY(U,$J,"PRO",858,10,7,"^")
 ;;=IBDE IMPORT FORM
 ;;^UTILITY(U,$J,"PRO",858,10,8,0)
 ;;=865^HE^1^^^Help
 ;;^UTILITY(U,$J,"PRO",858,10,8,"^")
 ;;=IBDE IMP/EXP HELP
 ;;^UTILITY(U,$J,"PRO",858,10,9,0)
 ;;=866^DI^9^^^DIFROM
 ;;^UTILITY(U,$J,"PRO",858,10,9,"^")
 ;;=IBDE EXECUTE DIFROM
 ;;^UTILITY(U,$J,"PRO",858,10,10,0)
 ;;=867^RI^10^^^Run Inits
 ;;^UTILITY(U,$J,"PRO",858,10,10,"^")
 ;;=IBDE EXECUTE INITS
 ;;^UTILITY(U,$J,"PRO",858,10,11,0)
 ;;=869^LB^2^^^List TK Blocks
 ;;^UTILITY(U,$J,"PRO",858,10,11,"^")
 ;;=IBDE DISPLAY TK BLOCKS
 ;;^UTILITY(U,$J,"PRO",858,20)
 ;;=
 ;;^UTILITY(U,$J,"PRO",858,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",858,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",858,99)
 ;;=56309,52661
 ;;^UTILITY(U,$J,"PRO",859,0)
 ;;=IBDE ADD FORM TO IMP/EXP WS^Add Entry^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",859,.1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",859,1,0)
 ;;=^^1^1^2960205^^^
 ;;^UTILITY(U,$J,"PRO",859,1,1,0)
 ;;=Allows the user to add a form to the IMP/EXP files.
 ;;^UTILITY(U,$J,"PRO",859,2,0)
 ;;=^101.02A^3^3
