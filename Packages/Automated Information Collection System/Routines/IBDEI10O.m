IBDEI10O ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17907,1,2,0)
 ;;=2^305.71
 ;;^UTILITY(U,$J,358.3,17907,1,5,0)
 ;;=5^Amphetamine Abuse, Continuous
 ;;^UTILITY(U,$J,358.3,17907,2)
 ;;=^268251
 ;;^UTILITY(U,$J,358.3,17908,0)
 ;;=305.72^^94^1137^17
 ;;^UTILITY(U,$J,358.3,17908,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17908,1,2,0)
 ;;=2^305.72
 ;;^UTILITY(U,$J,358.3,17908,1,5,0)
 ;;=5^Amphetamine Abuse, Episodic
 ;;^UTILITY(U,$J,358.3,17908,2)
 ;;=^268252
 ;;^UTILITY(U,$J,358.3,17909,0)
 ;;=305.91^^94^1137^77
 ;;^UTILITY(U,$J,358.3,17909,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17909,1,2,0)
 ;;=2^305.91
 ;;^UTILITY(U,$J,358.3,17909,1,5,0)
 ;;=5^Other Drug Abuse, Continuous
 ;;^UTILITY(U,$J,358.3,17909,2)
 ;;=^268259
 ;;^UTILITY(U,$J,358.3,17910,0)
 ;;=305.92^^94^1137^78
 ;;^UTILITY(U,$J,358.3,17910,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17910,1,2,0)
 ;;=2^305.92
 ;;^UTILITY(U,$J,358.3,17910,1,5,0)
 ;;=5^Other Drug Abuse, Episodic
 ;;^UTILITY(U,$J,358.3,17910,2)
 ;;=^268260
 ;;^UTILITY(U,$J,358.3,17911,0)
 ;;=304.03^^94^1137^72
 ;;^UTILITY(U,$J,358.3,17911,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17911,1,2,0)
 ;;=2^304.03
 ;;^UTILITY(U,$J,358.3,17911,1,5,0)
 ;;=5^Opioid Dep-Remission
 ;;^UTILITY(U,$J,358.3,17911,2)
 ;;=^268193
 ;;^UTILITY(U,$J,358.3,17912,0)
 ;;=V65.2^^94^1138^35
 ;;^UTILITY(U,$J,358.3,17912,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17912,1,2,0)
 ;;=2^V65.2
 ;;^UTILITY(U,$J,358.3,17912,1,5,0)
 ;;=5^Malingering
 ;;^UTILITY(U,$J,358.3,17912,2)
 ;;=^92393
 ;;^UTILITY(U,$J,358.3,17913,0)
 ;;=V65.49^^94^1138^3
 ;;^UTILITY(U,$J,358.3,17913,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17913,1,2,0)
 ;;=2^V65.49
 ;;^UTILITY(U,$J,358.3,17913,1,5,0)
 ;;=5^Counseling,Oth Specified
 ;;^UTILITY(U,$J,358.3,17913,2)
 ;;=^303471
 ;;^UTILITY(U,$J,358.3,17914,0)
 ;;=V61.10^^94^1138^43
 ;;^UTILITY(U,$J,358.3,17914,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17914,1,2,0)
 ;;=2^V61.10
 ;;^UTILITY(U,$J,358.3,17914,1,5,0)
 ;;=5^Partner Relational Problem
 ;;^UTILITY(U,$J,358.3,17914,2)
 ;;=^74110
 ;;^UTILITY(U,$J,358.3,17915,0)
 ;;=V61.20^^94^1138^41
 ;;^UTILITY(U,$J,358.3,17915,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17915,1,2,0)
 ;;=2^V61.20
 ;;^UTILITY(U,$J,358.3,17915,1,5,0)
 ;;=5^Parent-Child Problem NOS
 ;;^UTILITY(U,$J,358.3,17915,2)
 ;;=^304300
 ;;^UTILITY(U,$J,358.3,17916,0)
 ;;=V61.12^^94^1138^5
 ;;^UTILITY(U,$J,358.3,17916,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17916,1,2,0)
 ;;=2^V61.12
 ;;^UTILITY(U,$J,358.3,17916,1,5,0)
 ;;=5^Domestic Violence/Perpet
 ;;^UTILITY(U,$J,358.3,17916,2)
 ;;=^304356
 ;;^UTILITY(U,$J,358.3,17917,0)
 ;;=V61.11^^94^1138^6
 ;;^UTILITY(U,$J,358.3,17917,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17917,1,2,0)
 ;;=2^V61.11
 ;;^UTILITY(U,$J,358.3,17917,1,5,0)
 ;;=5^Domestic Violence/Victim
 ;;^UTILITY(U,$J,358.3,17917,2)
 ;;=^304357
 ;;^UTILITY(U,$J,358.3,17918,0)
 ;;=V62.0^^94^1138^51
 ;;^UTILITY(U,$J,358.3,17918,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17918,1,2,0)
 ;;=2^V62.0
 ;;^UTILITY(U,$J,358.3,17918,1,5,0)
 ;;=5^Unemployment
 ;;^UTILITY(U,$J,358.3,17918,2)
 ;;=^123545
 ;;^UTILITY(U,$J,358.3,17919,0)
 ;;=V69.2^^94^1138^17
 ;;^UTILITY(U,$J,358.3,17919,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17919,1,2,0)
 ;;=2^V69.2
 ;;^UTILITY(U,$J,358.3,17919,1,5,0)
 ;;=5^Hi-Risk Sexual Behavior
 ;;^UTILITY(U,$J,358.3,17919,2)
 ;;=^303474
 ;;^UTILITY(U,$J,358.3,17920,0)
 ;;=V62.82^^94^1138^2
 ;;^UTILITY(U,$J,358.3,17920,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17920,1,2,0)
 ;;=2^V62.82
 ;;^UTILITY(U,$J,358.3,17920,1,5,0)
 ;;=5^Bereavement/Uncomplicated
 ;;^UTILITY(U,$J,358.3,17920,2)
 ;;=^123500
 ;;
 ;;$END ROU IBDEI10O
