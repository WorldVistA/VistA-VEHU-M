IBDEI11E ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18263,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18263,1,2,0)
 ;;=2^90887
 ;;^UTILITY(U,$J,358.3,18263,1,3,0)
 ;;=3^Consultation w/Family
 ;;^UTILITY(U,$J,358.3,18264,0)
 ;;=90791^^97^1160^10^^^^1
 ;;^UTILITY(U,$J,358.3,18264,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18264,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,18264,1,3,0)
 ;;=3^Psych Diagnostic Interview
 ;;^UTILITY(U,$J,358.3,18265,0)
 ;;=90846^^97^1160^3^^^^1
 ;;^UTILITY(U,$J,358.3,18265,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18265,1,2,0)
 ;;=2^90846
 ;;^UTILITY(U,$J,358.3,18265,1,3,0)
 ;;=3^Family Psytx w/o Patient
 ;;^UTILITY(U,$J,358.3,18266,0)
 ;;=99401^^97^1160^6^^^^1
 ;;^UTILITY(U,$J,358.3,18266,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18266,1,2,0)
 ;;=2^99401
 ;;^UTILITY(U,$J,358.3,18266,1,3,0)
 ;;=3^Preventive Counseling, IND 15Min
 ;;^UTILITY(U,$J,358.3,18267,0)
 ;;=99402^^97^1160^7^^^^1
 ;;^UTILITY(U,$J,358.3,18267,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18267,1,2,0)
 ;;=2^99402
 ;;^UTILITY(U,$J,358.3,18267,1,3,0)
 ;;=3^Preventive Counseling, IND 30Min
 ;;^UTILITY(U,$J,358.3,18268,0)
 ;;=99403^^97^1160^8^^^^1
 ;;^UTILITY(U,$J,358.3,18268,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18268,1,2,0)
 ;;=2^99403
 ;;^UTILITY(U,$J,358.3,18268,1,3,0)
 ;;=3^Preventive Counseling, IND 45Min
 ;;^UTILITY(U,$J,358.3,18269,0)
 ;;=99404^^97^1160^9^^^^1
 ;;^UTILITY(U,$J,358.3,18269,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18269,1,2,0)
 ;;=2^99404
 ;;^UTILITY(U,$J,358.3,18269,1,3,0)
 ;;=3^Preventive Counseling, IND 60Min
 ;;^UTILITY(U,$J,358.3,18270,0)
 ;;=99411^^97^1160^4^^^^1
 ;;^UTILITY(U,$J,358.3,18270,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18270,1,2,0)
 ;;=2^99411
 ;;^UTILITY(U,$J,358.3,18270,1,3,0)
 ;;=3^Preventive Counseling, Group 30Min
 ;;^UTILITY(U,$J,358.3,18271,0)
 ;;=99412^^97^1160^5^^^^1
 ;;^UTILITY(U,$J,358.3,18271,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18271,1,2,0)
 ;;=2^99412
 ;;^UTILITY(U,$J,358.3,18271,1,3,0)
 ;;=3^Preventive Counseling, Group 60Min
 ;;^UTILITY(U,$J,358.3,18272,0)
 ;;=99366^^97^1160^11^^^^1
 ;;^UTILITY(U,$J,358.3,18272,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18272,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,18272,1,3,0)
 ;;=3^Team Conf w/ Pat by HC Pro 30Min
 ;;^UTILITY(U,$J,358.3,18273,0)
 ;;=99367^^97^1160^13^^^^1
 ;;^UTILITY(U,$J,358.3,18273,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18273,1,2,0)
 ;;=2^99367
 ;;^UTILITY(U,$J,358.3,18273,1,3,0)
 ;;=3^Team Conf w/o Pat by Phys 30Min
 ;;^UTILITY(U,$J,358.3,18274,0)
 ;;=99368^^97^1160^12^^^^1
 ;;^UTILITY(U,$J,358.3,18274,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18274,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,18274,1,3,0)
 ;;=3^Team Conf w/o Pat by HC Pro 30Min
 ;;^UTILITY(U,$J,358.3,18275,0)
 ;;=90847^^97^1160^2^^^^1
 ;;^UTILITY(U,$J,358.3,18275,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18275,1,2,0)
 ;;=2^90847
 ;;^UTILITY(U,$J,358.3,18275,1,3,0)
 ;;=3^Family Psytx w/ Patient
 ;;^UTILITY(U,$J,358.3,18276,0)
 ;;=99078^^97^1161^1^^^^1
 ;;^UTILITY(U,$J,358.3,18276,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18276,1,2,0)
 ;;=2^99078
 ;;^UTILITY(U,$J,358.3,18276,1,3,0)
 ;;=3^Group Health Education
 ;;^UTILITY(U,$J,358.3,18277,0)
 ;;=98960^^97^1161^2^^^^1
 ;;^UTILITY(U,$J,358.3,18277,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18277,1,2,0)
 ;;=2^98960
 ;;^UTILITY(U,$J,358.3,18277,1,3,0)
 ;;=3^Self-Mgmt Educ/Train,1 Pt,Ea 30Min
 ;;^UTILITY(U,$J,358.3,18278,0)
 ;;=98961^^97^1161^3^^^^1
 ;;^UTILITY(U,$J,358.3,18278,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18278,1,2,0)
 ;;=2^98961
 ;;
 ;;$END ROU IBDEI11E
