IBDEI0X6 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16127,1,4,0)
 ;;=4^788.0
 ;;^UTILITY(U,$J,358.3,16127,1,5,0)
 ;;=5^Kidney Pain
 ;;^UTILITY(U,$J,358.3,16127,2)
 ;;=^265306
 ;;^UTILITY(U,$J,358.3,16128,0)
 ;;=338.0^^81^953^9
 ;;^UTILITY(U,$J,358.3,16128,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16128,1,4,0)
 ;;=4^338.0
 ;;^UTILITY(U,$J,358.3,16128,1,5,0)
 ;;=5^Central Pain Syndrome
 ;;^UTILITY(U,$J,358.3,16128,2)
 ;;=^334189
 ;;^UTILITY(U,$J,358.3,16129,0)
 ;;=338.11^^81^953^6
 ;;^UTILITY(U,$J,358.3,16129,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16129,1,4,0)
 ;;=4^338.11
 ;;^UTILITY(U,$J,358.3,16129,1,5,0)
 ;;=5^Acute Pain due to Trauma
 ;;^UTILITY(U,$J,358.3,16129,2)
 ;;=^334070
 ;;^UTILITY(U,$J,358.3,16130,0)
 ;;=338.12^^81^953^7
 ;;^UTILITY(U,$J,358.3,16130,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16130,1,4,0)
 ;;=4^338.12
 ;;^UTILITY(U,$J,358.3,16130,1,5,0)
 ;;=5^Acute Post-Operative Pain
 ;;^UTILITY(U,$J,358.3,16130,2)
 ;;=^334071
 ;;^UTILITY(U,$J,358.3,16131,0)
 ;;=338.18^^81^953^31
 ;;^UTILITY(U,$J,358.3,16131,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16131,1,4,0)
 ;;=4^338.18
 ;;^UTILITY(U,$J,358.3,16131,1,5,0)
 ;;=5^Postoperative Pain NOS
 ;;^UTILITY(U,$J,358.3,16131,2)
 ;;=^334072
 ;;^UTILITY(U,$J,358.3,16132,0)
 ;;=338.19^^81^953^26
 ;;^UTILITY(U,$J,358.3,16132,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16132,1,4,0)
 ;;=4^338.19
 ;;^UTILITY(U,$J,358.3,16132,1,5,0)
 ;;=5^Other Acute Pain
 ;;^UTILITY(U,$J,358.3,16132,2)
 ;;=^334073
 ;;^UTILITY(U,$J,358.3,16133,0)
 ;;=338.21^^81^953^12
 ;;^UTILITY(U,$J,358.3,16133,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16133,1,4,0)
 ;;=4^338.21
 ;;^UTILITY(U,$J,358.3,16133,1,5,0)
 ;;=5^Chronic Pain due to Trauma
 ;;^UTILITY(U,$J,358.3,16133,2)
 ;;=^334074
 ;;^UTILITY(U,$J,358.3,16134,0)
 ;;=338.22^^81^953^13
 ;;^UTILITY(U,$J,358.3,16134,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16134,1,4,0)
 ;;=4^338.22
 ;;^UTILITY(U,$J,358.3,16134,1,5,0)
 ;;=5^Chronic Post-Thoracotomy Pain
 ;;^UTILITY(U,$J,358.3,16134,2)
 ;;=^334075
 ;;^UTILITY(U,$J,358.3,16135,0)
 ;;=338.28^^81^953^28
 ;;^UTILITY(U,$J,358.3,16135,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16135,1,4,0)
 ;;=4^338.28
 ;;^UTILITY(U,$J,358.3,16135,1,5,0)
 ;;=5^Other Chronic Postop Pain
 ;;^UTILITY(U,$J,358.3,16135,2)
 ;;=^334076
 ;;^UTILITY(U,$J,358.3,16136,0)
 ;;=338.29^^81^953^27
 ;;^UTILITY(U,$J,358.3,16136,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16136,1,4,0)
 ;;=4^338.29
 ;;^UTILITY(U,$J,358.3,16136,1,5,0)
 ;;=5^Other Chronic Pain
 ;;^UTILITY(U,$J,358.3,16136,2)
 ;;=^334077
 ;;^UTILITY(U,$J,358.3,16137,0)
 ;;=338.3^^81^953^8
 ;;^UTILITY(U,$J,358.3,16137,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16137,1,4,0)
 ;;=4^338.3
 ;;^UTILITY(U,$J,358.3,16137,1,5,0)
 ;;=5^Cancer Associated Pain
 ;;^UTILITY(U,$J,358.3,16137,2)
 ;;=^334078
 ;;^UTILITY(U,$J,358.3,16138,0)
 ;;=338.4^^81^953^11
 ;;^UTILITY(U,$J,358.3,16138,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16138,1,4,0)
 ;;=4^338.4
 ;;^UTILITY(U,$J,358.3,16138,1,5,0)
 ;;=5^Chronic Pain Syndrome
 ;;^UTILITY(U,$J,358.3,16138,2)
 ;;=^334079
 ;;^UTILITY(U,$J,358.3,16139,0)
 ;;=780.96^^81^953^17
 ;;^UTILITY(U,$J,358.3,16139,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16139,1,4,0)
 ;;=4^780.96
 ;;^UTILITY(U,$J,358.3,16139,1,5,0)
 ;;=5^Generalized Pain
 ;;^UTILITY(U,$J,358.3,16139,2)
 ;;=^334163
 ;;^UTILITY(U,$J,358.3,16140,0)
 ;;=607.9^^81^953^30
 ;;^UTILITY(U,$J,358.3,16140,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16140,1,4,0)
 ;;=4^607.9
 ;;^UTILITY(U,$J,358.3,16140,1,5,0)
 ;;=5^Penile Pain
 ;;^UTILITY(U,$J,358.3,16140,2)
 ;;=^270442
 ;;^UTILITY(U,$J,358.3,16141,0)
 ;;=608.9^^81^953^32
 ;;
 ;;$END ROU IBDEI0X6
