IBDEI21L ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35683,1,3,0)
 ;;=3^Hypomagnesemia
 ;;^UTILITY(U,$J,358.3,35683,1,4,0)
 ;;=4^E83.42
 ;;^UTILITY(U,$J,358.3,35683,2)
 ;;=^5003003
 ;;^UTILITY(U,$J,358.3,35684,0)
 ;;=E83.41^^189^2060^23
 ;;^UTILITY(U,$J,358.3,35684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35684,1,3,0)
 ;;=3^Hypermagnesemia
 ;;^UTILITY(U,$J,358.3,35684,1,4,0)
 ;;=4^E83.41
 ;;^UTILITY(U,$J,358.3,35684,2)
 ;;=^5003002
 ;;^UTILITY(U,$J,358.3,35685,0)
 ;;=E83.40^^189^2060^16
 ;;^UTILITY(U,$J,358.3,35685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35685,1,3,0)
 ;;=3^Disorders of magnesium metabolism, unspecified
 ;;^UTILITY(U,$J,358.3,35685,1,4,0)
 ;;=4^E83.40
 ;;^UTILITY(U,$J,358.3,35685,2)
 ;;=^5003001
 ;;^UTILITY(U,$J,358.3,35686,0)
 ;;=E83.49^^189^2060^28
 ;;^UTILITY(U,$J,358.3,35686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35686,1,3,0)
 ;;=3^Magnesium Metabolism Disorders NEC
 ;;^UTILITY(U,$J,358.3,35686,1,4,0)
 ;;=4^E83.49
 ;;^UTILITY(U,$J,358.3,35686,2)
 ;;=^5003004
 ;;^UTILITY(U,$J,358.3,35687,0)
 ;;=E46.^^189^2060^37
 ;;^UTILITY(U,$J,358.3,35687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35687,1,3,0)
 ;;=3^Protein-Calorie Malnutrition,Unspec
 ;;^UTILITY(U,$J,358.3,35687,1,4,0)
 ;;=4^E46.
 ;;^UTILITY(U,$J,358.3,35687,2)
 ;;=^5002790
 ;;^UTILITY(U,$J,358.3,35688,0)
 ;;=B37.0^^189^2060^11
 ;;^UTILITY(U,$J,358.3,35688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35688,1,3,0)
 ;;=3^Candidal stomatitis
 ;;^UTILITY(U,$J,358.3,35688,1,4,0)
 ;;=4^B37.0
 ;;^UTILITY(U,$J,358.3,35688,2)
 ;;=^5000612
 ;;^UTILITY(U,$J,358.3,35689,0)
 ;;=B37.83^^189^2060^10
 ;;^UTILITY(U,$J,358.3,35689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35689,1,3,0)
 ;;=3^Candidal cheilitis
 ;;^UTILITY(U,$J,358.3,35689,1,4,0)
 ;;=4^B37.83
 ;;^UTILITY(U,$J,358.3,35689,2)
 ;;=^5000622
 ;;^UTILITY(U,$J,358.3,35690,0)
 ;;=A04.7^^189^2060^20
 ;;^UTILITY(U,$J,358.3,35690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35690,1,3,0)
 ;;=3^Enterocolitis due to Clostridium difficile
 ;;^UTILITY(U,$J,358.3,35690,1,4,0)
 ;;=4^A04.7
 ;;^UTILITY(U,$J,358.3,35690,2)
 ;;=^5000029
 ;;^UTILITY(U,$J,358.3,35691,0)
 ;;=R73.09^^189^2060^3
 ;;^UTILITY(U,$J,358.3,35691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35691,1,3,0)
 ;;=3^Abnormal glucose NEC
 ;;^UTILITY(U,$J,358.3,35691,1,4,0)
 ;;=4^R73.09
 ;;^UTILITY(U,$J,358.3,35691,2)
 ;;=^5019563
 ;;^UTILITY(U,$J,358.3,35692,0)
 ;;=R80.9^^189^2060^38
 ;;^UTILITY(U,$J,358.3,35692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35692,1,3,0)
 ;;=3^Proteinuria, unspecified
 ;;^UTILITY(U,$J,358.3,35692,1,4,0)
 ;;=4^R80.9
 ;;^UTILITY(U,$J,358.3,35692,2)
 ;;=^5019599
 ;;^UTILITY(U,$J,358.3,35693,0)
 ;;=R94.5^^189^2060^4
 ;;^UTILITY(U,$J,358.3,35693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35693,1,3,0)
 ;;=3^Abnormal results of liver function studies
 ;;^UTILITY(U,$J,358.3,35693,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,35693,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,35694,0)
 ;;=Z55.9^^189^2060^35
 ;;^UTILITY(U,$J,358.3,35694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35694,1,3,0)
 ;;=3^Problems related to education and literacy, unspecified
 ;;^UTILITY(U,$J,358.3,35694,1,4,0)
 ;;=4^Z55.9
 ;;^UTILITY(U,$J,358.3,35694,2)
 ;;=^5063106
 ;;^UTILITY(U,$J,358.3,35695,0)
 ;;=T81.30XA^^189^2061^12
 ;;^UTILITY(U,$J,358.3,35695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35695,1,3,0)
 ;;=3^Disruption of wound, unspecified, initial encounter
 ;;^UTILITY(U,$J,358.3,35695,1,4,0)
 ;;=4^T81.30XA
 ;;^UTILITY(U,$J,358.3,35695,2)
 ;;=^5054467
 ;;^UTILITY(U,$J,358.3,35696,0)
 ;;=T81.30XD^^189^2061^14
 ;;^UTILITY(U,$J,358.3,35696,1,0)
 ;;=^358.31IA^4^2
 ;;
 ;;$END ROU IBDEI21L
