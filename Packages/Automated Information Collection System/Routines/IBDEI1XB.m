IBDEI1XB ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33798,1,4,0)
 ;;=4^W11.XXXA
 ;;^UTILITY(U,$J,358.3,33798,2)
 ;;=^5059595
 ;;^UTILITY(U,$J,358.3,33799,0)
 ;;=W11.XXXD^^182^2011^40
 ;;^UTILITY(U,$J,358.3,33799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33799,1,3,0)
 ;;=3^Fall from Ladder,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33799,1,4,0)
 ;;=4^W11.XXXD
 ;;^UTILITY(U,$J,358.3,33799,2)
 ;;=^5059596
 ;;^UTILITY(U,$J,358.3,33800,0)
 ;;=W13.0XXA^^182^2011^25
 ;;^UTILITY(U,$J,358.3,33800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33800,1,3,0)
 ;;=3^Fall from Balcony,Init Encntr
 ;;^UTILITY(U,$J,358.3,33800,1,4,0)
 ;;=4^W13.0XXA
 ;;^UTILITY(U,$J,358.3,33800,2)
 ;;=^5059601
 ;;^UTILITY(U,$J,358.3,33801,0)
 ;;=W13.0XXD^^182^2011^26
 ;;^UTILITY(U,$J,358.3,33801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33801,1,3,0)
 ;;=3^Fall from Balcony,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33801,1,4,0)
 ;;=4^W13.0XXD
 ;;^UTILITY(U,$J,358.3,33801,2)
 ;;=^5059602
 ;;^UTILITY(U,$J,358.3,33802,0)
 ;;=W13.1XXA^^182^2011^29
 ;;^UTILITY(U,$J,358.3,33802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33802,1,3,0)
 ;;=3^Fall from Bridge,Init Encntr
 ;;^UTILITY(U,$J,358.3,33802,1,4,0)
 ;;=4^W13.1XXA
 ;;^UTILITY(U,$J,358.3,33802,2)
 ;;=^5059604
 ;;^UTILITY(U,$J,358.3,33803,0)
 ;;=W13.1XXD^^182^2011^30
 ;;^UTILITY(U,$J,358.3,33803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33803,1,3,0)
 ;;=3^Fall from Bridge,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33803,1,4,0)
 ;;=4^W13.1XXD
 ;;^UTILITY(U,$J,358.3,33803,2)
 ;;=^5059605
 ;;^UTILITY(U,$J,358.3,33804,0)
 ;;=W13.2XXA^^182^2011^57
 ;;^UTILITY(U,$J,358.3,33804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33804,1,3,0)
 ;;=3^Fall from Roof,Init Encntr
 ;;^UTILITY(U,$J,358.3,33804,1,4,0)
 ;;=4^W13.2XXA
 ;;^UTILITY(U,$J,358.3,33804,2)
 ;;=^5059607
 ;;^UTILITY(U,$J,358.3,33805,0)
 ;;=W13.2XXD^^182^2011^58
 ;;^UTILITY(U,$J,358.3,33805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33805,1,3,0)
 ;;=3^Fall from Roof,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33805,1,4,0)
 ;;=4^W13.2XXD
 ;;^UTILITY(U,$J,358.3,33805,2)
 ;;=^5059608
 ;;^UTILITY(U,$J,358.3,33806,0)
 ;;=W13.3XXA^^182^2011^79
 ;;^UTILITY(U,$J,358.3,33806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33806,1,3,0)
 ;;=3^Fall through Floor,Init Encntr
 ;;^UTILITY(U,$J,358.3,33806,1,4,0)
 ;;=4^W13.3XXA
 ;;^UTILITY(U,$J,358.3,33806,2)
 ;;=^5059610
 ;;^UTILITY(U,$J,358.3,33807,0)
 ;;=W13.3XXD^^182^2011^80
 ;;^UTILITY(U,$J,358.3,33807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33807,1,3,0)
 ;;=3^Fall through Floor,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33807,1,4,0)
 ;;=4^W13.3XXD
 ;;^UTILITY(U,$J,358.3,33807,2)
 ;;=^5059611
 ;;^UTILITY(U,$J,358.3,33808,0)
 ;;=W13.4XXA^^182^2011^67
 ;;^UTILITY(U,$J,358.3,33808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33808,1,3,0)
 ;;=3^Fall from Window,Init Encntr
 ;;^UTILITY(U,$J,358.3,33808,1,4,0)
 ;;=4^W13.4XXA
 ;;^UTILITY(U,$J,358.3,33808,2)
 ;;=^5059613
 ;;^UTILITY(U,$J,358.3,33809,0)
 ;;=W13.4XXD^^182^2011^68
 ;;^UTILITY(U,$J,358.3,33809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33809,1,3,0)
 ;;=3^Fall from Window,Subs Encntr
 ;;^UTILITY(U,$J,358.3,33809,1,4,0)
 ;;=4^W13.4XXD
 ;;^UTILITY(U,$J,358.3,33809,2)
 ;;=^5059614
 ;;^UTILITY(U,$J,358.3,33810,0)
 ;;=W13.8XXA^^182^2011^33
 ;;^UTILITY(U,$J,358.3,33810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33810,1,3,0)
 ;;=3^Fall from Building/Structure,Init Encntr
 ;;^UTILITY(U,$J,358.3,33810,1,4,0)
 ;;=4^W13.8XXA
 ;;^UTILITY(U,$J,358.3,33810,2)
 ;;=^5059616
 ;;^UTILITY(U,$J,358.3,33811,0)
 ;;=W13.8XXD^^182^2011^34
 ;;^UTILITY(U,$J,358.3,33811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33811,1,3,0)
 ;;=3^Fall from Building/Structure,Subs Encntr
 ;;
 ;;$END ROU IBDEI1XB
