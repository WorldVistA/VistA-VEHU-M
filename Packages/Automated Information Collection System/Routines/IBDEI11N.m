IBDEI11N ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18400,1,4,0)
 ;;=4^48550
 ;;^UTILITY(U,$J,358.3,18401,0)
 ;;=48551^^101^1178^3^^^^1
 ;;^UTILITY(U,$J,358.3,18401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18401,1,2,0)
 ;;=2^PREP DONOR PANCREAS
 ;;^UTILITY(U,$J,358.3,18401,1,4,0)
 ;;=4^48551
 ;;^UTILITY(U,$J,358.3,18402,0)
 ;;=48552^^101^1178^4^^^^1
 ;;^UTILITY(U,$J,358.3,18402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18402,1,2,0)
 ;;=2^PREP DONOR PANCREAS/VENOUS
 ;;^UTILITY(U,$J,358.3,18402,1,4,0)
 ;;=4^48552
 ;;^UTILITY(U,$J,358.3,18403,0)
 ;;=50360^^101^1179^13^^^^1
 ;;^UTILITY(U,$J,358.3,18403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18403,1,2,0)
 ;;=2^TRANSPLANTATION OF KIDNEY
 ;;^UTILITY(U,$J,358.3,18403,1,4,0)
 ;;=4^50360
 ;;^UTILITY(U,$J,358.3,18404,0)
 ;;=50365^^101^1179^1^^^^1
 ;;^UTILITY(U,$J,358.3,18404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18404,1,2,0)
 ;;=2^KIDNEY TRANS W/RECP NEPHRECTOMY
 ;;^UTILITY(U,$J,358.3,18404,1,4,0)
 ;;=4^50365
 ;;^UTILITY(U,$J,358.3,18405,0)
 ;;=50380^^101^1179^8^^^^1
 ;;^UTILITY(U,$J,358.3,18405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18405,1,2,0)
 ;;=2^REIMPLANTATION OF KIDNEY
 ;;^UTILITY(U,$J,358.3,18405,1,4,0)
 ;;=4^50380
 ;;^UTILITY(U,$J,358.3,18406,0)
 ;;=50300^^101^1179^11^^^^1
 ;;^UTILITY(U,$J,358.3,18406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18406,1,2,0)
 ;;=2^REMOVE CADAVER DONOR KIDNEY
 ;;^UTILITY(U,$J,358.3,18406,1,4,0)
 ;;=4^50300
 ;;^UTILITY(U,$J,358.3,18407,0)
 ;;=50320^^101^1179^12^^^^1
 ;;^UTILITY(U,$J,358.3,18407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18407,1,2,0)
 ;;=2^REMOVE KIDNEY LIVING DONOR
 ;;^UTILITY(U,$J,358.3,18407,1,4,0)
 ;;=4^50320
 ;;^UTILITY(U,$J,358.3,18408,0)
 ;;=50547^^101^1179^2^^^^1
 ;;^UTILITY(U,$J,358.3,18408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18408,1,2,0)
 ;;=2^LAPARO REMOVAL DONOR KIDNEY
 ;;^UTILITY(U,$J,358.3,18408,1,4,0)
 ;;=4^50547
 ;;^UTILITY(U,$J,358.3,18409,0)
 ;;=50340^^101^1179^10^^^^1
 ;;^UTILITY(U,$J,358.3,18409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18409,1,2,0)
 ;;=2^REMOVAL OF KIDNEY
 ;;^UTILITY(U,$J,358.3,18409,1,4,0)
 ;;=4^50340
 ;;^UTILITY(U,$J,358.3,18410,0)
 ;;=50370^^101^1179^9^^^^1
 ;;^UTILITY(U,$J,358.3,18410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18410,1,2,0)
 ;;=2^REM TRANSPLANT KIDNEY ALLOGRAFT
 ;;^UTILITY(U,$J,358.3,18410,1,4,0)
 ;;=4^50370
 ;;^UTILITY(U,$J,358.3,18411,0)
 ;;=50323^^101^1179^3^^^^1
 ;;^UTILITY(U,$J,358.3,18411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18411,1,2,0)
 ;;=2^PREP CADAVER RENAL ALLOGRAFT
 ;;^UTILITY(U,$J,358.3,18411,1,4,0)
 ;;=4^50323
 ;;^UTILITY(U,$J,358.3,18412,0)
 ;;=50325^^101^1179^4^^^^1
 ;;^UTILITY(U,$J,358.3,18412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18412,1,2,0)
 ;;=2^PREP DONOR RENAL GRAFT
 ;;^UTILITY(U,$J,358.3,18412,1,4,0)
 ;;=4^50325
 ;;^UTILITY(U,$J,358.3,18413,0)
 ;;=50327^^101^1179^7^^^^1
 ;;^UTILITY(U,$J,358.3,18413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18413,1,2,0)
 ;;=2^PREP RENAL GRAFT/VENOUS EA
 ;;^UTILITY(U,$J,358.3,18413,1,4,0)
 ;;=4^50327
 ;;^UTILITY(U,$J,358.3,18414,0)
 ;;=50328^^101^1179^5^^^^1
 ;;^UTILITY(U,$J,358.3,18414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18414,1,2,0)
 ;;=2^PREP RENAL GRAFT/ARTERIAL EA
 ;;^UTILITY(U,$J,358.3,18414,1,4,0)
 ;;=4^50328
 ;;^UTILITY(U,$J,358.3,18415,0)
 ;;=50329^^101^1179^6^^^^1
 ;;^UTILITY(U,$J,358.3,18415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18415,1,2,0)
 ;;=2^PREP RENAL GRAFT/URETERAL EA
 ;;^UTILITY(U,$J,358.3,18415,1,4,0)
 ;;=4^50329
 ;;^UTILITY(U,$J,358.3,18416,0)
 ;;=33300^^101^1180^9^^^^1
 ;;^UTILITY(U,$J,358.3,18416,1,0)
 ;;=^358.31IA^4^2
 ;;
 ;;$END ROU IBDEI11N
