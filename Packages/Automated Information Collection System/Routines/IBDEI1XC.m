IBDEI1XC ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33811,1,4,0)
 ;;=4^W13.8XXD
 ;;^UTILITY(U,$J,358.3,33811,2)
 ;;=^5059617
 ;;^UTILITY(U,$J,358.3,33812,0)
 ;;=W13.9XXA^^182^2011^31
 ;;^UTILITY(U,$J,358.3,33812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33812,1,3,0)
 ;;=3^Fall from Building NOS,Init Encntr
 ;;^UTILITY(U,$J,358.3,33812,1,4,0)
 ;;=4^W13.9XXA
 ;;^UTILITY(U,$J,358.3,33812,2)
 ;;=^5059619
 ;;^UTILITY(U,$J,358.3,33813,0)
 ;;=W13.9XXD^^182^2011^32
 ;;^UTILITY(U,$J,358.3,33813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33813,1,3,0)
 ;;=3^Fall from Building NOS,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33813,1,4,0)
 ;;=4^W13.9XXD
 ;;^UTILITY(U,$J,358.3,33813,2)
 ;;=^5059620
 ;;^UTILITY(U,$J,358.3,33814,0)
 ;;=W14.XXXA^^182^2011^65
 ;;^UTILITY(U,$J,358.3,33814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33814,1,3,0)
 ;;=3^Fall from Tree,Init Encntr
 ;;^UTILITY(U,$J,358.3,33814,1,4,0)
 ;;=4^W14.XXXA
 ;;^UTILITY(U,$J,358.3,33814,2)
 ;;=^5059622
 ;;^UTILITY(U,$J,358.3,33815,0)
 ;;=W14.XXXD^^182^2011^66
 ;;^UTILITY(U,$J,358.3,33815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33815,1,3,0)
 ;;=3^Fall from Tree,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33815,1,4,0)
 ;;=4^W14.XXXD
 ;;^UTILITY(U,$J,358.3,33815,2)
 ;;=^5059623
 ;;^UTILITY(U,$J,358.3,33816,0)
 ;;=W17.2XXA^^182^2011^73
 ;;^UTILITY(U,$J,358.3,33816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33816,1,3,0)
 ;;=3^Fall into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,33816,1,4,0)
 ;;=4^W17.2XXA
 ;;^UTILITY(U,$J,358.3,33816,2)
 ;;=^5059772
 ;;^UTILITY(U,$J,358.3,33817,0)
 ;;=W17.2XXD^^182^2011^74
 ;;^UTILITY(U,$J,358.3,33817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33817,1,3,0)
 ;;=3^Fall into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33817,1,4,0)
 ;;=4^W17.2XXD
 ;;^UTILITY(U,$J,358.3,33817,2)
 ;;=^5059773
 ;;^UTILITY(U,$J,358.3,33818,0)
 ;;=W17.3XXA^^182^2011^71
 ;;^UTILITY(U,$J,358.3,33818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33818,1,3,0)
 ;;=3^Fall into Empty Swimming Pool,Init Encntr
 ;;^UTILITY(U,$J,358.3,33818,1,4,0)
 ;;=4^W17.3XXA
 ;;^UTILITY(U,$J,358.3,33818,2)
 ;;=^5059775
 ;;^UTILITY(U,$J,358.3,33819,0)
 ;;=W17.3XXD^^182^2011^72
 ;;^UTILITY(U,$J,358.3,33819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33819,1,3,0)
 ;;=3^Fall into Empty Swimming Pool,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33819,1,4,0)
 ;;=4^W17.3XXD
 ;;^UTILITY(U,$J,358.3,33819,2)
 ;;=^5059776
 ;;^UTILITY(U,$J,358.3,33820,0)
 ;;=W17.4XXA^^182^2011^37
 ;;^UTILITY(U,$J,358.3,33820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33820,1,3,0)
 ;;=3^Fall from Dock,Init Encntr
 ;;^UTILITY(U,$J,358.3,33820,1,4,0)
 ;;=4^W17.4XXA
 ;;^UTILITY(U,$J,358.3,33820,2)
 ;;=^5059778
 ;;^UTILITY(U,$J,358.3,33821,0)
 ;;=W17.4XXD^^182^2011^38
 ;;^UTILITY(U,$J,358.3,33821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33821,1,3,0)
 ;;=3^Fall from Dock,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33821,1,4,0)
 ;;=4^W17.4XXD
 ;;^UTILITY(U,$J,358.3,33821,2)
 ;;=^5059779
 ;;^UTILITY(U,$J,358.3,33822,0)
 ;;=W17.81XA^^182^2011^23
 ;;^UTILITY(U,$J,358.3,33822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33822,1,3,0)
 ;;=3^Fall down Embankment,Init Encntr
 ;;^UTILITY(U,$J,358.3,33822,1,4,0)
 ;;=4^W17.81XA
 ;;^UTILITY(U,$J,358.3,33822,2)
 ;;=^5059781
 ;;^UTILITY(U,$J,358.3,33823,0)
 ;;=W17.81XD^^182^2011^24
 ;;^UTILITY(U,$J,358.3,33823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33823,1,3,0)
 ;;=3^Fall down Embankment,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33823,1,4,0)
 ;;=4^W17.81XD
 ;;^UTILITY(U,$J,358.3,33823,2)
 ;;=^5059782
 ;;^UTILITY(U,$J,358.3,33824,0)
 ;;=W17.89XA^^182^2011^53
 ;;^UTILITY(U,$J,358.3,33824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33824,1,3,0)
 ;;=3^Fall from One level to Another,Init Encntr
 ;;
 ;;$END ROU IBDEI1XC
