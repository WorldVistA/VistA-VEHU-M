IBDEI0NU ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11362,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11362,1,2,0)
 ;;=2^V66.7
 ;;^UTILITY(U,$J,358.3,11362,1,5,0)
 ;;=5^Encounter for Palliative Care
 ;;^UTILITY(U,$J,358.3,11362,2)
 ;;=^89209
 ;;^UTILITY(U,$J,358.3,11363,0)
 ;;=V11.4^^50^642^20
 ;;^UTILITY(U,$J,358.3,11363,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11363,1,2,0)
 ;;=2^V11.4
 ;;^UTILITY(U,$J,358.3,11363,1,5,0)
 ;;=5^Hx Combat/Operational Stress
 ;;^UTILITY(U,$J,358.3,11363,2)
 ;;=^339674
 ;;^UTILITY(U,$J,358.3,11364,0)
 ;;=V60.1^^50^642^22
 ;;^UTILITY(U,$J,358.3,11364,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11364,1,2,0)
 ;;=2^V60.1
 ;;^UTILITY(U,$J,358.3,11364,1,5,0)
 ;;=5^Inadequate Housing
 ;;^UTILITY(U,$J,358.3,11364,2)
 ;;=^295540
 ;;^UTILITY(U,$J,358.3,11365,0)
 ;;=V62.84^^50^642^49
 ;;^UTILITY(U,$J,358.3,11365,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11365,1,2,0)
 ;;=2^V62.84
 ;;^UTILITY(U,$J,358.3,11365,1,5,0)
 ;;=5^Suicidal Ideation
 ;;^UTILITY(U,$J,358.3,11365,2)
 ;;=^332876
 ;;^UTILITY(U,$J,358.3,11366,0)
 ;;=V62.85^^50^642^18
 ;;^UTILITY(U,$J,358.3,11366,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11366,1,2,0)
 ;;=2^V62.85
 ;;^UTILITY(U,$J,358.3,11366,1,5,0)
 ;;=5^Homicidal Ideation
 ;;^UTILITY(U,$J,358.3,11366,2)
 ;;=^339690
 ;;^UTILITY(U,$J,358.3,11367,0)
 ;;=V58.61^^50^642^25
 ;;^UTILITY(U,$J,358.3,11367,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11367,1,2,0)
 ;;=2^V58.61
 ;;^UTILITY(U,$J,358.3,11367,1,5,0)
 ;;=5^L/T (Current) Anticoagulant Use
 ;;^UTILITY(U,$J,358.3,11367,2)
 ;;=^303459
 ;;^UTILITY(U,$J,358.3,11368,0)
 ;;=V58.62^^50^642^24
 ;;^UTILITY(U,$J,358.3,11368,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11368,1,2,0)
 ;;=2^V58.62
 ;;^UTILITY(U,$J,358.3,11368,1,5,0)
 ;;=5^L/T (Current) Antibiotics Use
 ;;^UTILITY(U,$J,358.3,11368,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,11369,0)
 ;;=V58.63^^50^642^26
 ;;^UTILITY(U,$J,358.3,11369,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11369,1,2,0)
 ;;=2^V58.63
 ;;^UTILITY(U,$J,358.3,11369,1,5,0)
 ;;=5^L/T (Current) Antiplts/Antithrmbtcs
 ;;^UTILITY(U,$J,358.3,11369,2)
 ;;=^329978
 ;;^UTILITY(U,$J,358.3,11370,0)
 ;;=V58.64^^50^642^30
 ;;^UTILITY(U,$J,358.3,11370,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11370,1,2,0)
 ;;=2^V58.64
 ;;^UTILITY(U,$J,358.3,11370,1,5,0)
 ;;=5^L/T (Current) NSAIDS Use
 ;;^UTILITY(U,$J,358.3,11370,2)
 ;;=^329979
 ;;^UTILITY(U,$J,358.3,11371,0)
 ;;=V58.65^^50^642^32
 ;;^UTILITY(U,$J,358.3,11371,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11371,1,2,0)
 ;;=2^V58.65
 ;;^UTILITY(U,$J,358.3,11371,1,5,0)
 ;;=5^L/T (Current) Steroids Use
 ;;^UTILITY(U,$J,358.3,11371,2)
 ;;=^329980
 ;;^UTILITY(U,$J,358.3,11372,0)
 ;;=V58.66^^50^642^27
 ;;^UTILITY(U,$J,358.3,11372,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11372,1,2,0)
 ;;=2^V58.66
 ;;^UTILITY(U,$J,358.3,11372,1,5,0)
 ;;=5^L/T (Current) Aspirin Use
 ;;^UTILITY(U,$J,358.3,11372,2)
 ;;=^331584
 ;;^UTILITY(U,$J,358.3,11373,0)
 ;;=V58.67^^50^642^29
 ;;^UTILITY(U,$J,358.3,11373,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11373,1,2,0)
 ;;=2^V58.67
 ;;^UTILITY(U,$J,358.3,11373,1,5,0)
 ;;=5^L/T (Current) Insulin Use
 ;;^UTILITY(U,$J,358.3,11373,2)
 ;;=^331585
 ;;^UTILITY(U,$J,358.3,11374,0)
 ;;=V58.68^^50^642^28
 ;;^UTILITY(U,$J,358.3,11374,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11374,1,2,0)
 ;;=2^V58.68
 ;;^UTILITY(U,$J,358.3,11374,1,5,0)
 ;;=5^L/T (Current) Bisphos Use
 ;;^UTILITY(U,$J,358.3,11374,2)
 ;;=^340624
 ;;^UTILITY(U,$J,358.3,11375,0)
 ;;=V58.69^^50^642^31
 ;;^UTILITY(U,$J,358.3,11375,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11375,1,2,0)
 ;;=2^V58.69
 ;;
 ;;$END ROU IBDEI0NU
