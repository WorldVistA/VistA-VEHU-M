IBDEI0CT ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5743,1,4,0)
 ;;=4^ADRENAL NEOPLASM,MALIGNANT
 ;;^UTILITY(U,$J,358.3,5743,2)
 ;;=^267298
 ;;^UTILITY(U,$J,358.3,5744,0)
 ;;=255.10^^28^379^3
 ;;^UTILITY(U,$J,358.3,5744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5744,1,3,0)
 ;;=3^255.10
 ;;^UTILITY(U,$J,358.3,5744,1,4,0)
 ;;=4^ALDOSTERONISM
 ;;^UTILITY(U,$J,358.3,5744,2)
 ;;=^330019
 ;;^UTILITY(U,$J,358.3,5745,0)
 ;;=255.0^^28^379^4
 ;;^UTILITY(U,$J,358.3,5745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5745,1,3,0)
 ;;=3^255.0
 ;;^UTILITY(U,$J,358.3,5745,1,4,0)
 ;;=4^CUSHING'S SYNDROME
 ;;^UTILITY(U,$J,358.3,5745,2)
 ;;=^29802
 ;;^UTILITY(U,$J,358.3,5746,0)
 ;;=403.90^^28^379^6
 ;;^UTILITY(U,$J,358.3,5746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5746,1,3,0)
 ;;=3^403.90
 ;;^UTILITY(U,$J,358.3,5746,1,4,0)
 ;;=4^HTN RENAL w/o RENAL FAILURE NOS
 ;;^UTILITY(U,$J,358.3,5746,2)
 ;;=^334272
 ;;^UTILITY(U,$J,358.3,5747,0)
 ;;=403.91^^28^379^5
 ;;^UTILITY(U,$J,358.3,5747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5747,1,3,0)
 ;;=3^403.91
 ;;^UTILITY(U,$J,358.3,5747,1,4,0)
 ;;=4^HTN RENAL w/ RENAL FAILURE NOS
 ;;^UTILITY(U,$J,358.3,5747,2)
 ;;=^334242
 ;;^UTILITY(U,$J,358.3,5748,0)
 ;;=405.91^^28^379^7
 ;;^UTILITY(U,$J,358.3,5748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5748,1,3,0)
 ;;=3^405.91
 ;;^UTILITY(U,$J,358.3,5748,1,4,0)
 ;;=4^HTN RENOVASCULAR NOS
 ;;^UTILITY(U,$J,358.3,5748,2)
 ;;=^269634
 ;;^UTILITY(U,$J,358.3,5749,0)
 ;;=403.00^^28^379^9
 ;;^UTILITY(U,$J,358.3,5749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5749,1,3,0)
 ;;=3^403.00
 ;;^UTILITY(U,$J,358.3,5749,1,4,0)
 ;;=4^MAL HTN RENAL w/o RENAL FAILURE
 ;;^UTILITY(U,$J,358.3,5749,2)
 ;;=^334270
 ;;^UTILITY(U,$J,358.3,5750,0)
 ;;=403.01^^28^379^8
 ;;^UTILITY(U,$J,358.3,5750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5750,1,3,0)
 ;;=3^403.01
 ;;^UTILITY(U,$J,358.3,5750,1,4,0)
 ;;=4^MAL HTN RENAL w/ RENAL FAILURE
 ;;^UTILITY(U,$J,358.3,5750,2)
 ;;=^334240
 ;;^UTILITY(U,$J,358.3,5751,0)
 ;;=405.01^^28^379^10
 ;;^UTILITY(U,$J,358.3,5751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5751,1,3,0)
 ;;=3^405.01
 ;;^UTILITY(U,$J,358.3,5751,1,4,0)
 ;;=4^MAL HTN RENOVASCULAR
 ;;^UTILITY(U,$J,358.3,5751,2)
 ;;=^269628
 ;;^UTILITY(U,$J,358.3,5752,0)
 ;;=404.91^^28^380^1
 ;;^UTILITY(U,$J,358.3,5752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5752,1,3,0)
 ;;=3^404.91
 ;;^UTILITY(U,$J,358.3,5752,1,4,0)
 ;;=4^HTN HRT/REN w/ CHF,NOS
 ;;^UTILITY(U,$J,358.3,5752,2)
 ;;=^334249
 ;;^UTILITY(U,$J,358.3,5753,0)
 ;;=404.93^^28^380^2
 ;;^UTILITY(U,$J,358.3,5753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5753,1,3,0)
 ;;=3^404.93
 ;;^UTILITY(U,$J,358.3,5753,1,4,0)
 ;;=4^HTN HRT/REN w/ CHR&RF,NOS
 ;;^UTILITY(U,$J,358.3,5753,2)
 ;;=^334251
 ;;^UTILITY(U,$J,358.3,5754,0)
 ;;=404.90^^28^380^4
 ;;^UTILITY(U,$J,358.3,5754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5754,1,3,0)
 ;;=3^404.90
 ;;^UTILITY(U,$J,358.3,5754,1,4,0)
 ;;=4^HTN HRT/REN w/o CHF/RF,NOS
 ;;^UTILITY(U,$J,358.3,5754,2)
 ;;=^334275
 ;;^UTILITY(U,$J,358.3,5755,0)
 ;;=404.92^^28^380^3
 ;;^UTILITY(U,$J,358.3,5755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5755,1,3,0)
 ;;=3^404.92
 ;;^UTILITY(U,$J,358.3,5755,1,4,0)
 ;;=4^HTN HRT/REN w/ RENAL FAILURE,NOS
 ;;^UTILITY(U,$J,358.3,5755,2)
 ;;=^334250
 ;;^UTILITY(U,$J,358.3,5756,0)
 ;;=404.01^^28^380^5
 ;;^UTILITY(U,$J,358.3,5756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5756,1,3,0)
 ;;=3^404.01
 ;;^UTILITY(U,$J,358.3,5756,1,4,0)
 ;;=4^MAL HTN HRT/REN w/ CHF
 ;;^UTILITY(U,$J,358.3,5756,2)
 ;;=^334243
 ;;^UTILITY(U,$J,358.3,5757,0)
 ;;=404.03^^28^380^6
 ;;^UTILITY(U,$J,358.3,5757,1,0)
 ;;=^358.31IA^4^2
 ;;
 ;;$END ROU IBDEI0CT
