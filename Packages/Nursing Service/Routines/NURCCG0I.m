NURCCG0I ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;2/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,195,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,195,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,196,0)
 ;;=determine developmental level^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,196,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,196,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,197,0)
 ;;=determine prohibitive factors^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,197,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,197,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,198,0)
 ;;=assess level of anxiety^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,198,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,198,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,199,0)
 ;;=assess support system^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,199,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,199,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,200,0)
 ;;=provide for patient care conferences for mutual goal setting^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,200,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,200,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,201,0)
 ;;=discuss patient's/SO's understanding of treatment regime^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,201,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,201,1,1,0)
 ;;=202^review instructions related to therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,201,1,2,0)
 ;;=204^emphasize positive effects of plan^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,201,1,3,0)
 ;;=205^avoid a judgemental attitude/approach^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,201,1,4,0)
 ;;=206^be receptive to patient/SO's expressions of doubt/concern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,201,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,201,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,201,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,201,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,202,0)
 ;;=review instructions related to therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,203,0)
 ;;=provide information and encourage patient to seek it on own^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,203,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,203,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,204,0)
 ;;=emphasize positive effects of plan^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,205,0)
 ;;=avoid a judgemental attitude/approach^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,206,0)
 ;;=be receptive to patient/SO's expressions of doubt/concern^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,207,0)
 ;;=depression, severe anxiety^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,208,0)
 ;;=intolerance to activity; decreased strength and endurance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,209,0)
 ;;=musculoskeletal impairment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,210,0)
 ;;=neuromuscular impairment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,211,0)
 ;;=pain, discomfort^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,212,0)
 ;;=general self-care deficit outcomes^2^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,212,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,212,1,1,0)
 ;;=216^identifies factors limiting self-care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,212,1,2,0)
 ;;=217^accepts home health care^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,212,1,3,0)
 ;;=218^accepts interventions to modify self-care deficits^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,212,1,4,0)
 ;;=2495^demonstrates adaptive techniques/devices for self-care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,212,1,5,0)
 ;;=2496^achieves independence in self-care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,212,1,6,0)
 ;;=2867^[Extra Goal]^3^NURSC^42^0
 ;;^UTILITY("^GMRD(124.2,",$J,212,1,7,0)
 ;;=15324^communicates an understanding of follow-up care^3^NURSC^1^1
