IBDEI0OB ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11590,1,5,0)
 ;;=5^Opioid Dependence
 ;;^UTILITY(U,$J,358.3,11590,2)
 ;;=^81364
 ;;^UTILITY(U,$J,358.3,11591,0)
 ;;=304.23^^53^668^43
 ;;^UTILITY(U,$J,358.3,11591,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11591,1,2,0)
 ;;=2^304.23
 ;;^UTILITY(U,$J,358.3,11591,1,5,0)
 ;;=5^Cocaine Dep-Remission
 ;;^UTILITY(U,$J,358.3,11591,2)
 ;;=^268200
 ;;^UTILITY(U,$J,358.3,11592,0)
 ;;=305.50^^53^668^68
 ;;^UTILITY(U,$J,358.3,11592,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11592,1,2,0)
 ;;=2^305.50
 ;;^UTILITY(U,$J,358.3,11592,1,5,0)
 ;;=5^Opioid Abuse
 ;;^UTILITY(U,$J,358.3,11592,2)
 ;;=^85868
 ;;^UTILITY(U,$J,358.3,11593,0)
 ;;=305.53^^53^668^71
 ;;^UTILITY(U,$J,358.3,11593,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11593,1,2,0)
 ;;=2^305.53
 ;;^UTILITY(U,$J,358.3,11593,1,5,0)
 ;;=5^Opioid Abuse-Remission
 ;;^UTILITY(U,$J,358.3,11593,2)
 ;;=^268246
 ;;^UTILITY(U,$J,358.3,11594,0)
 ;;=304.10^^53^668^30
 ;;^UTILITY(U,$J,358.3,11594,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11594,1,2,0)
 ;;=2^304.10
 ;;^UTILITY(U,$J,358.3,11594,1,5,0)
 ;;=5^Anxiolytic Dependence
 ;;^UTILITY(U,$J,358.3,11594,2)
 ;;=^268194
 ;;^UTILITY(U,$J,358.3,11595,0)
 ;;=304.13^^53^668^27
 ;;^UTILITY(U,$J,358.3,11595,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11595,1,2,0)
 ;;=2^304.13
 ;;^UTILITY(U,$J,358.3,11595,1,5,0)
 ;;=5^Anxiolytic Dep-Remis
 ;;^UTILITY(U,$J,358.3,11595,2)
 ;;=^268197
 ;;^UTILITY(U,$J,358.3,11596,0)
 ;;=305.40^^53^668^23
 ;;^UTILITY(U,$J,358.3,11596,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11596,1,2,0)
 ;;=2^305.40
 ;;^UTILITY(U,$J,358.3,11596,1,5,0)
 ;;=5^Anxiolytic Abuse
 ;;^UTILITY(U,$J,358.3,11596,2)
 ;;=^268240
 ;;^UTILITY(U,$J,358.3,11597,0)
 ;;=305.43^^53^668^26
 ;;^UTILITY(U,$J,358.3,11597,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11597,1,2,0)
 ;;=2^305.43
 ;;^UTILITY(U,$J,358.3,11597,1,5,0)
 ;;=5^Anxiolytic Abuse-Remission
 ;;^UTILITY(U,$J,358.3,11597,2)
 ;;=^268243
 ;;^UTILITY(U,$J,358.3,11598,0)
 ;;=304.20^^53^668^46
 ;;^UTILITY(U,$J,358.3,11598,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11598,1,2,0)
 ;;=2^304.20
 ;;^UTILITY(U,$J,358.3,11598,1,5,0)
 ;;=5^Cocaine Dependence
 ;;^UTILITY(U,$J,358.3,11598,2)
 ;;=^25599
 ;;^UTILITY(U,$J,358.3,11599,0)
 ;;=305.60^^53^668^39
 ;;^UTILITY(U,$J,358.3,11599,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11599,1,2,0)
 ;;=2^305.60
 ;;^UTILITY(U,$J,358.3,11599,1,5,0)
 ;;=5^Cocaine Abuse   
 ;;^UTILITY(U,$J,358.3,11599,2)
 ;;=^25596
 ;;^UTILITY(U,$J,358.3,11600,0)
 ;;=305.63^^53^668^42
 ;;^UTILITY(U,$J,358.3,11600,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11600,1,2,0)
 ;;=2^305.63
 ;;^UTILITY(U,$J,358.3,11600,1,5,0)
 ;;=5^Cocaine Abuse-Remission
 ;;^UTILITY(U,$J,358.3,11600,2)
 ;;=^268249
 ;;^UTILITY(U,$J,358.3,11601,0)
 ;;=304.30^^53^668^38
 ;;^UTILITY(U,$J,358.3,11601,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11601,1,2,0)
 ;;=2^304.30
 ;;^UTILITY(U,$J,358.3,11601,1,5,0)
 ;;=5^Cannabis Dependence
 ;;^UTILITY(U,$J,358.3,11601,2)
 ;;=^18670
 ;;^UTILITY(U,$J,358.3,11602,0)
 ;;=304.33^^53^668^35
 ;;^UTILITY(U,$J,358.3,11602,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11602,1,2,0)
 ;;=2^304.33
 ;;^UTILITY(U,$J,358.3,11602,1,5,0)
 ;;=5^Cannabis Dep-Remission
 ;;^UTILITY(U,$J,358.3,11602,2)
 ;;=^268203
 ;;^UTILITY(U,$J,358.3,11603,0)
 ;;=305.20^^53^668^31
 ;;^UTILITY(U,$J,358.3,11603,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11603,1,2,0)
 ;;=2^305.20
 ;;^UTILITY(U,$J,358.3,11603,1,5,0)
 ;;=5^Cannabis Abuse
 ;;^UTILITY(U,$J,358.3,11603,2)
 ;;=^18664
 ;;^UTILITY(U,$J,358.3,11604,0)
 ;;=305.23^^53^668^34
 ;;^UTILITY(U,$J,358.3,11604,1,0)
 ;;=^358.31IA^5^2
 ;;
 ;;$END ROU IBDEI0OB
