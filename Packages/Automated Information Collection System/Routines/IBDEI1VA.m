IBDEI1VA ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32857,1,3,0)
 ;;=3^Air Pollution Contact/Exposure
 ;;^UTILITY(U,$J,358.3,32857,1,4,0)
 ;;=4^Z77.110
 ;;^UTILITY(U,$J,358.3,32857,2)
 ;;=^5063314
 ;;^UTILITY(U,$J,358.3,32858,0)
 ;;=Z77.112^^182^1993^125
 ;;^UTILITY(U,$J,358.3,32858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32858,1,3,0)
 ;;=3^Soil Pollution Contact/Exposure
 ;;^UTILITY(U,$J,358.3,32858,1,4,0)
 ;;=4^Z77.112
 ;;^UTILITY(U,$J,358.3,32858,2)
 ;;=^5063316
 ;;^UTILITY(U,$J,358.3,32859,0)
 ;;=Z77.111^^182^1993^130
 ;;^UTILITY(U,$J,358.3,32859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32859,1,3,0)
 ;;=3^Water Pollution Contact/Exposure
 ;;^UTILITY(U,$J,358.3,32859,1,4,0)
 ;;=4^Z77.111
 ;;^UTILITY(U,$J,358.3,32859,2)
 ;;=^5063315
 ;;^UTILITY(U,$J,358.3,32860,0)
 ;;=Z77.128^^182^1993^105
 ;;^UTILITY(U,$J,358.3,32860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32860,1,3,0)
 ;;=3^Physical Environment Hazards Contact/Exposure
 ;;^UTILITY(U,$J,358.3,32860,1,4,0)
 ;;=4^Z77.128
 ;;^UTILITY(U,$J,358.3,32860,2)
 ;;=^5063322
 ;;^UTILITY(U,$J,358.3,32861,0)
 ;;=Z77.123^^182^1993^123
 ;;^UTILITY(U,$J,358.3,32861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32861,1,3,0)
 ;;=3^Radon/Radiation Contact/Exposure
 ;;^UTILITY(U,$J,358.3,32861,1,4,0)
 ;;=4^Z77.123
 ;;^UTILITY(U,$J,358.3,32861,2)
 ;;=^5063321
 ;;^UTILITY(U,$J,358.3,32862,0)
 ;;=Z77.122^^182^1993^53
 ;;^UTILITY(U,$J,358.3,32862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32862,1,3,0)
 ;;=3^Noise Contact/Exposure
 ;;^UTILITY(U,$J,358.3,32862,1,4,0)
 ;;=4^Z77.122
 ;;^UTILITY(U,$J,358.3,32862,2)
 ;;=^5063320
 ;;^UTILITY(U,$J,358.3,32863,0)
 ;;=Z77.118^^182^1993^14
 ;;^UTILITY(U,$J,358.3,32863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32863,1,3,0)
 ;;=3^Environmental Pollution Contact/Exposure
 ;;^UTILITY(U,$J,358.3,32863,1,4,0)
 ;;=4^Z77.118
 ;;^UTILITY(U,$J,358.3,32863,2)
 ;;=^5063317
 ;;^UTILITY(U,$J,358.3,32864,0)
 ;;=Z77.9^^182^1993^43
 ;;^UTILITY(U,$J,358.3,32864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32864,1,3,0)
 ;;=3^Health Hazard Contact/Exposure
 ;;^UTILITY(U,$J,358.3,32864,1,4,0)
 ;;=4^Z77.9
 ;;^UTILITY(U,$J,358.3,32864,2)
 ;;=^5063326
 ;;^UTILITY(U,$J,358.3,32865,0)
 ;;=Z77.22^^182^1993^13
 ;;^UTILITY(U,$J,358.3,32865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32865,1,3,0)
 ;;=3^Environment Tobacco Smoke Contact/Exposure
 ;;^UTILITY(U,$J,358.3,32865,1,4,0)
 ;;=4^Z77.22
 ;;^UTILITY(U,$J,358.3,32865,2)
 ;;=^5063324
 ;;^UTILITY(U,$J,358.3,32866,0)
 ;;=Z80.0^^182^1993^28
 ;;^UTILITY(U,$J,358.3,32866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32866,1,3,0)
 ;;=3^Family Hx of Malig Neop of Digestive Organs
 ;;^UTILITY(U,$J,358.3,32866,1,4,0)
 ;;=4^Z80.0
 ;;^UTILITY(U,$J,358.3,32866,2)
 ;;=^5063344
 ;;^UTILITY(U,$J,358.3,32867,0)
 ;;=Z80.1^^182^1993^33
 ;;^UTILITY(U,$J,358.3,32867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32867,1,3,0)
 ;;=3^Family Hx of Malig Neop of Trachea,Bronc & Lung
 ;;^UTILITY(U,$J,358.3,32867,1,4,0)
 ;;=4^Z80.1
 ;;^UTILITY(U,$J,358.3,32867,2)
 ;;=^5063345
 ;;^UTILITY(U,$J,358.3,32868,0)
 ;;=Z80.3^^182^1993^27
 ;;^UTILITY(U,$J,358.3,32868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32868,1,3,0)
 ;;=3^Family Hx of Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,32868,1,4,0)
 ;;=4^Z80.3
 ;;^UTILITY(U,$J,358.3,32868,2)
 ;;=^5063347
 ;;^UTILITY(U,$J,358.3,32869,0)
 ;;=Z80.41^^182^1993^30
 ;;^UTILITY(U,$J,358.3,32869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32869,1,3,0)
 ;;=3^Family Hx of Malig Neop of Ovary
 ;;^UTILITY(U,$J,358.3,32869,1,4,0)
 ;;=4^Z80.41
 ;;^UTILITY(U,$J,358.3,32869,2)
 ;;=^5063348
 ;;^UTILITY(U,$J,358.3,32870,0)
 ;;=Z80.42^^182^1993^31
 ;;
 ;;$END ROU IBDEI1VA
