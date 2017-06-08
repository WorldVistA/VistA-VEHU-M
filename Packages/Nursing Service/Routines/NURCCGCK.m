NURCCGCK ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,18,0)
 ;;=774^unfamiliar setting^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,19,0)
 ;;=775^physical restraints/barriers^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,1,20,0)
 ;;=798^medical protocols^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9899,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9900,0)
 ;;=Defining Characteristics^2^NURSC^12^116^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9900,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,9900,1,1,0)
 ;;=4263^cognitive, effective, and psychomotor factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9900,1,2,0)
 ;;=4265^integrative dysfunction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9900,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9908,0)
 ;;=stable vital signs WNL for patient^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9920,0)
 ;;=high glucose level^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9925,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^133^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9925,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,9925,1,1,0)
 ;;=776^remains free from injuries^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9925,1,2,0)
 ;;=777^verbalizes how to prevent injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9925,1,3,0)
 ;;=9991^[Extra Goal]^3^NURSC^166
 ;;^UTILITY("^GMRD(124.2,",$J,9925,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9928,0)
 ;;=[Extra Goal]^3^NURSC^9^165^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9928,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9928,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9929,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^114^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9929,1,0)
 ;;=^124.21PI^12^8
 ;;^UTILITY("^GMRD(124.2,",$J,9929,1,2,0)
 ;;=779^observe for adverse effects of chemical agents/treatments^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9929,1,3,0)
 ;;=780^identify and eliminate potential sources of injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9929,1,4,0)
 ;;=9933^provide physically safe environment^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,9929,1,5,0)
 ;;=782^protect with restraints [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9929,1,6,0)
 ;;=783^provide restraint care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9929,1,9,0)
 ;;=786^assure understanding of informed consent^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9929,1,11,0)
 ;;=10284^[Extra Order]^3^NURSC^172
 ;;^UTILITY("^GMRD(124.2,",$J,9929,1,12,0)
 ;;=15921^encourage use of soft toothbrush & floss only if necessary^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9929,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9929,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9933,0)
 ;;=provide physically safe environment^2^NURSC^11^6^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9933,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,9933,1,1,0)
 ;;=787^bedrails^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9933,1,2,0)
 ;;=788^call light^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9933,1,3,0)
 ;;=789^prosthetic devices^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9933,1,4,0)
 ;;=790^night light^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9933,1,5,0)
 ;;=791^safety restraints^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9933,1,6,0)
 ;;=792^isolation^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,9933,1,7,0)
 ;;=793^remove constrictive clothing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9933,1,8,0)
 ;;=794^eliminate source of infestation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9933,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,9933,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9933,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9933,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9956,0)
 ;;=[Extra Order]^3^NURSC^11^168^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9956,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9956,10)
 ;;=D EN1^NURCCPU3
