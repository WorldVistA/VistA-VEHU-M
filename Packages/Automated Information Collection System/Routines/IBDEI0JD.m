IBDEI0JD ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9103,1,5,0)
 ;;=5^369.23
 ;;^UTILITY(U,$J,358.3,9103,2)
 ;;=^268883
 ;;^UTILITY(U,$J,358.3,9104,0)
 ;;=369.24^^38^512^5
 ;;^UTILITY(U,$J,358.3,9104,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9104,1,4,0)
 ;;=4^BE:MODERATE IMPRMT;LE:SEVERE IMPRMT
 ;;^UTILITY(U,$J,358.3,9104,1,5,0)
 ;;=5^369.24
 ;;^UTILITY(U,$J,358.3,9104,2)
 ;;=^268884
 ;;^UTILITY(U,$J,358.3,9105,0)
 ;;=369.25^^38^512^12
 ;;^UTILITY(U,$J,358.3,9105,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9105,1,4,0)
 ;;=4^MODERATE IMPAIRMENT,BOTH EYES
 ;;^UTILITY(U,$J,358.3,9105,1,5,0)
 ;;=5^369.25
 ;;^UTILITY(U,$J,358.3,9105,2)
 ;;=^268885
 ;;^UTILITY(U,$J,358.3,9106,0)
 ;;=369.3^^38^512^28
 ;;^UTILITY(U,$J,358.3,9106,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9106,1,4,0)
 ;;=4^VISION LOSS,BOTH EYES
 ;;^UTILITY(U,$J,358.3,9106,1,5,0)
 ;;=5^369.3
 ;;^UTILITY(U,$J,358.3,9106,2)
 ;;=^268886
 ;;^UTILITY(U,$J,358.3,9107,0)
 ;;=366.41^^38^512^8
 ;;^UTILITY(U,$J,358.3,9107,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9107,1,4,0)
 ;;=4^DIABETIC CATARACT
 ;;^UTILITY(U,$J,358.3,9107,1,5,0)
 ;;=5^366.41
 ;;^UTILITY(U,$J,358.3,9107,2)
 ;;=^33638
 ;;^UTILITY(U,$J,358.3,9108,0)
 ;;=365.44^^38^512^9
 ;;^UTILITY(U,$J,358.3,9108,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9108,1,4,0)
 ;;=4^GLAUCOMA,SYSTEMIC DISEASE
 ;;^UTILITY(U,$J,358.3,9108,1,5,0)
 ;;=5^365.44
 ;;^UTILITY(U,$J,358.3,9108,2)
 ;;=^268769
 ;;^UTILITY(U,$J,358.3,9109,0)
 ;;=070.54^^38^513^2
 ;;^UTILITY(U,$J,358.3,9109,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9109,1,4,0)
 ;;=4^CHR HEP C W/O HEP COMA
 ;;^UTILITY(U,$J,358.3,9109,1,5,0)
 ;;=5^070.54
 ;;^UTILITY(U,$J,358.3,9109,2)
 ;;=^303252
 ;;^UTILITY(U,$J,358.3,9110,0)
 ;;=070.51^^38^513^1
 ;;^UTILITY(U,$J,358.3,9110,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9110,1,4,0)
 ;;=4^AC HEP C W/O HEP COMA
 ;;^UTILITY(U,$J,358.3,9110,1,5,0)
 ;;=5^070.51
 ;;^UTILITY(U,$J,358.3,9110,2)
 ;;=^331778
 ;;^UTILITY(U,$J,358.3,9111,0)
 ;;=070.71^^38^513^3
 ;;^UTILITY(U,$J,358.3,9111,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9111,1,4,0)
 ;;=4^HEP C W/ HEP COMA,UNSPEC
 ;;^UTILITY(U,$J,358.3,9111,1,5,0)
 ;;=5^070.71
 ;;^UTILITY(U,$J,358.3,9111,2)
 ;;=^331437
 ;;^UTILITY(U,$J,358.3,9112,0)
 ;;=V02.62^^38^513^4
 ;;^UTILITY(U,$J,358.3,9112,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9112,1,4,0)
 ;;=4^VIRAL HEPATITIS CARRIER
 ;;^UTILITY(U,$J,358.3,9112,1,5,0)
 ;;=5^V02.62
 ;;^UTILITY(U,$J,358.3,9112,2)
 ;;=^317947
 ;;^UTILITY(U,$J,358.3,9113,0)
 ;;=260.^^38^514^2
 ;;^UTILITY(U,$J,358.3,9113,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9113,1,4,0)
 ;;=4^KWASHIORKOR
 ;;^UTILITY(U,$J,358.3,9113,1,5,0)
 ;;=5^260.
 ;;^UTILITY(U,$J,358.3,9113,2)
 ;;=^67659
 ;;^UTILITY(U,$J,358.3,9114,0)
 ;;=261.^^38^514^6
 ;;^UTILITY(U,$J,358.3,9114,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9114,1,4,0)
 ;;=4^NUTRITIONAL MARASMUS
 ;;^UTILITY(U,$J,358.3,9114,1,5,0)
 ;;=5^261.
 ;;^UTILITY(U,$J,358.3,9114,2)
 ;;=^99809
 ;;^UTILITY(U,$J,358.3,9115,0)
 ;;=262.^^38^514^7
 ;;^UTILITY(U,$J,358.3,9115,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9115,1,4,0)
 ;;=4^SEVERE MALNUTRITION
 ;;^UTILITY(U,$J,358.3,9115,1,5,0)
 ;;=5^262.
 ;;^UTILITY(U,$J,358.3,9115,2)
 ;;=^267899
 ;;^UTILITY(U,$J,358.3,9116,0)
 ;;=263.0^^38^514^5
 ;;^UTILITY(U,$J,358.3,9116,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9116,1,4,0)
 ;;=4^MODERATE MALNUTRITION
 ;;^UTILITY(U,$J,358.3,9116,1,5,0)
 ;;=5^263.0
 ;;^UTILITY(U,$J,358.3,9116,2)
 ;;=^267901
 ;;^UTILITY(U,$J,358.3,9117,0)
 ;;=263.1^^38^514^4
 ;;^UTILITY(U,$J,358.3,9117,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9117,1,4,0)
 ;;=4^MILD MALNUTRITION
 ;;
 ;;$END ROU IBDEI0JD
