IBDEI0PY ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12431,0)
 ;;=642.23^^62^741^9
 ;;^UTILITY(U,$J,358.3,12431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12431,1,3,0)
 ;;=3^642.23
 ;;^UTILITY(U,$J,358.3,12431,1,4,0)
 ;;=4^Renal HTN-Antepartum
 ;;^UTILITY(U,$J,358.3,12431,2)
 ;;=^270831
 ;;^UTILITY(U,$J,358.3,12432,0)
 ;;=642.14^^62^741^10
 ;;^UTILITY(U,$J,358.3,12432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12432,1,3,0)
 ;;=3^642.14
 ;;^UTILITY(U,$J,358.3,12432,1,4,0)
 ;;=4^Renal HTN-Postpartum
 ;;^UTILITY(U,$J,358.3,12432,2)
 ;;=^270826
 ;;^UTILITY(U,$J,358.3,12433,0)
 ;;=642.24^^62^741^7
 ;;^UTILITY(U,$J,358.3,12433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12433,1,3,0)
 ;;=3^642.24
 ;;^UTILITY(U,$J,358.3,12433,1,4,0)
 ;;=4^Old HTN NEC-Antepartum
 ;;^UTILITY(U,$J,358.3,12433,2)
 ;;=^270832
 ;;^UTILITY(U,$J,358.3,12434,0)
 ;;=642.33^^62^741^15
 ;;^UTILITY(U,$J,358.3,12434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12434,1,3,0)
 ;;=3^642.33
 ;;^UTILITY(U,$J,358.3,12434,1,4,0)
 ;;=4^Trans HTN-Antepartum
 ;;^UTILITY(U,$J,358.3,12434,2)
 ;;=^270836
 ;;^UTILITY(U,$J,358.3,12435,0)
 ;;=642.34^^62^741^16
 ;;^UTILITY(U,$J,358.3,12435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12435,1,3,0)
 ;;=3^642.34
 ;;^UTILITY(U,$J,358.3,12435,1,4,0)
 ;;=4^Trans HTN-Postpartum
 ;;^UTILITY(U,$J,358.3,12435,2)
 ;;=^270837
 ;;^UTILITY(U,$J,358.3,12436,0)
 ;;=642.43^^62^741^5
 ;;^UTILITY(U,$J,358.3,12436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12436,1,3,0)
 ;;=3^642.43
 ;;^UTILITY(U,$J,358.3,12436,1,4,0)
 ;;=4^Mild/NOS Preeclamp-Antepartum
 ;;^UTILITY(U,$J,358.3,12436,2)
 ;;=^270841
 ;;^UTILITY(U,$J,358.3,12437,0)
 ;;=642.44^^62^741^6
 ;;^UTILITY(U,$J,358.3,12437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12437,1,3,0)
 ;;=3^642.44
 ;;^UTILITY(U,$J,358.3,12437,1,4,0)
 ;;=4^Mild/NOS Preeclamp-Postpartum
 ;;^UTILITY(U,$J,358.3,12437,2)
 ;;=^270842
 ;;^UTILITY(U,$J,358.3,12438,0)
 ;;=642.53^^62^741^11
 ;;^UTILITY(U,$J,358.3,12438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12438,1,3,0)
 ;;=3^642.53
 ;;^UTILITY(U,$J,358.3,12438,1,4,0)
 ;;=4^Sev Preeclamp-Antepartum
 ;;^UTILITY(U,$J,358.3,12438,2)
 ;;=^270846
 ;;^UTILITY(U,$J,358.3,12439,0)
 ;;=642.54^^62^741^12
 ;;^UTILITY(U,$J,358.3,12439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12439,1,3,0)
 ;;=3^642.54
 ;;^UTILITY(U,$J,358.3,12439,1,4,0)
 ;;=4^Sev Preeclamp-Postpartum
 ;;^UTILITY(U,$J,358.3,12439,2)
 ;;=^270847
 ;;^UTILITY(U,$J,358.3,12440,0)
 ;;=642.63^^62^741^3
 ;;^UTILITY(U,$J,358.3,12440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12440,1,3,0)
 ;;=3^642.63
 ;;^UTILITY(U,$J,358.3,12440,1,4,0)
 ;;=4^Eclampsia-Antepartum
 ;;^UTILITY(U,$J,358.3,12440,2)
 ;;=^270851
 ;;^UTILITY(U,$J,358.3,12441,0)
 ;;=642.64^^62^741^4
 ;;^UTILITY(U,$J,358.3,12441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12441,1,3,0)
 ;;=3^642.64
 ;;^UTILITY(U,$J,358.3,12441,1,4,0)
 ;;=4^Eclampsia-Postpartum
 ;;^UTILITY(U,$J,358.3,12441,2)
 ;;=^270852
 ;;^UTILITY(U,$J,358.3,12442,0)
 ;;=642.73^^62^741^13
 ;;^UTILITY(U,$J,358.3,12442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12442,1,3,0)
 ;;=3^642.73
 ;;^UTILITY(U,$J,358.3,12442,1,4,0)
 ;;=4^Tox w old HTN-Antepartum
 ;;^UTILITY(U,$J,358.3,12442,2)
 ;;=^270857
 ;;^UTILITY(U,$J,358.3,12443,0)
 ;;=642.74^^62^741^14
 ;;^UTILITY(U,$J,358.3,12443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12443,1,3,0)
 ;;=3^642.74
 ;;^UTILITY(U,$J,358.3,12443,1,4,0)
 ;;=4^Tox w old HTN-Postpartum
 ;;^UTILITY(U,$J,358.3,12443,2)
 ;;=^270858
 ;;^UTILITY(U,$J,358.3,12444,0)
 ;;=675.03^^62^742^11
 ;;^UTILITY(U,$J,358.3,12444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12444,1,3,0)
 ;;=3^675.03
 ;;
 ;;$END ROU IBDEI0PY
