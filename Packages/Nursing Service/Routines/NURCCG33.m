NURCCG33 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1029,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^20^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,0)
 ;;=^124.21PI^16^16
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,1,0)
 ;;=994^assess for impaction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,2,0)
 ;;=1123^evaluate diet^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,3,0)
 ;;=998^record color, odor, amt., consistency, frequency of stool^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,4,0)
 ;;=1124^observe for behaviors indicating a desire to defecate^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,5,0)
 ;;=937^provide privacy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,6,0)
 ;;=1125^provide for regular evacuations at [times]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,7,0)
 ;;=1126^toilet 1/2 hour after eating^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,8,0)
 ;;=1127^toilet prior to periods of increased activity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,9,0)
 ;;=1128^provide access to or keep equipment in a convenient place^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,10,0)
 ;;=1129^initiate a specific bowel program^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,11,0)
 ;;=939^encourage fluids [ ]cc/day, roughage; discuss rationale ^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,12,0)
 ;;=1016^maintain good hygiene of perineal area:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,13,0)
 ;;=1130^teach patient and S/O in underlying cause(s)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,14,0)
 ;;=1131^teach muscle tone/strength exercises as individually able^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,15,0)
 ;;=1132^teach patient and/or S/O in assistive devices available^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,1,16,0)
 ;;=2975^[Extra Order]^3^NURSC^58^0
 ;;^UTILITY("^GMRD(124.2,",$J,1029,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1029,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1030,0)
 ;;=Related Problems^2^NURSC^7^20^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1030,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1030,1,1,0)
 ;;=1404^Diarrhea^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1030,1,2,0)
 ;;=1401^Skin Integrity, Impairment Of (Actual)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1030,1,3,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1030,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1031,0)
 ;;=calcium channel blockers [agent] as indicated^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1032,0)
 ;;=assess enzyme and iso-enzyme levels^3^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1032,5)
 ;;=; document and report
 ;;^UTILITY("^GMRD(124.2,",$J,1033,0)
 ;;=perception or cognitive impairment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1034,0)
 ;;=CPK^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1035,0)
 ;;=restrict foods/fluids that percipitate diarrhea [list items]^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1035,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1035,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1036,0)
 ;;=SGOT^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1037,0)
 ;;=lab data and related tests^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1037,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,1037,1,1,0)
 ;;=1034^CPK^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1037,1,2,0)
 ;;=1053^LDH1 - LDH2^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1037,1,3,0)
 ;;=1036^SGOT^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1037,1,4,0)
 ;;=1055^SMA-6^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1037,1,5,0)
 ;;=1056^SMA-12^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1037,1,6,0)
 ;;=1058^x-ray^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1037,1,7,0)
 ;;=2937^ABGs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1037,1,8,0)
 ;;=2944^PT/PTT^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1037,4)
 ;;=assess, monitor, and document
