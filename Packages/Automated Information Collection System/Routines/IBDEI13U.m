IBDEI13U ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19493,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19493,1,4,0)
 ;;=4^V10.83
 ;;^UTILITY(U,$J,358.3,19493,1,5,0)
 ;;=5^H/O Skin Cancer
 ;;^UTILITY(U,$J,358.3,19493,2)
 ;;=H/O Skin Cancer^295241
 ;;^UTILITY(U,$J,358.3,19494,0)
 ;;=285.22^^105^1232^9
 ;;^UTILITY(U,$J,358.3,19494,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19494,1,4,0)
 ;;=4^285.22
 ;;^UTILITY(U,$J,358.3,19494,1,5,0)
 ;;=5^Anemia In Cancer
 ;;^UTILITY(U,$J,358.3,19494,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,19495,0)
 ;;=285.21^^105^1232^10
 ;;^UTILITY(U,$J,358.3,19495,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19495,1,4,0)
 ;;=4^285.21
 ;;^UTILITY(U,$J,358.3,19495,1,5,0)
 ;;=5^Anemia In Renal Dis
 ;;^UTILITY(U,$J,358.3,19495,2)
 ;;=^321977
 ;;^UTILITY(U,$J,358.3,19496,0)
 ;;=285.29^^105^1232^11
 ;;^UTILITY(U,$J,358.3,19496,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19496,1,4,0)
 ;;=4^285.29
 ;;^UTILITY(U,$J,358.3,19496,1,5,0)
 ;;=5^Anemia Of Chronic Dis
 ;;^UTILITY(U,$J,358.3,19496,2)
 ;;=^321979
 ;;^UTILITY(U,$J,358.3,19497,0)
 ;;=284.9^^105^1232^12
 ;;^UTILITY(U,$J,358.3,19497,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19497,1,4,0)
 ;;=4^284.9
 ;;^UTILITY(U,$J,358.3,19497,1,5,0)
 ;;=5^Aplastic Anemia NOS
 ;;^UTILITY(U,$J,358.3,19497,2)
 ;;=^7020
 ;;^UTILITY(U,$J,358.3,19498,0)
 ;;=282.61^^105^1232^78
 ;;^UTILITY(U,$J,358.3,19498,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19498,1,4,0)
 ;;=4^282.61
 ;;^UTILITY(U,$J,358.3,19498,1,5,0)
 ;;=5^Hemoglobin S Disease
 ;;^UTILITY(U,$J,358.3,19498,2)
 ;;=^267981
 ;;^UTILITY(U,$J,358.3,19499,0)
 ;;=282.7^^105^1232^77
 ;;^UTILITY(U,$J,358.3,19499,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19499,1,4,0)
 ;;=4^282.7
 ;;^UTILITY(U,$J,358.3,19499,1,5,0)
 ;;=5^Hemoglobin C Disease
 ;;^UTILITY(U,$J,358.3,19499,2)
 ;;=^87629
 ;;^UTILITY(U,$J,358.3,19500,0)
 ;;=283.9^^105^1232^79
 ;;^UTILITY(U,$J,358.3,19500,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19500,1,4,0)
 ;;=4^283.9
 ;;^UTILITY(U,$J,358.3,19500,1,5,0)
 ;;=5^Hemolytic Anemia,Acquired
 ;;^UTILITY(U,$J,358.3,19500,2)
 ;;=^7071
 ;;^UTILITY(U,$J,358.3,19501,0)
 ;;=283.0^^105^1232^80
 ;;^UTILITY(U,$J,358.3,19501,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19501,1,4,0)
 ;;=4^283.0
 ;;^UTILITY(U,$J,358.3,19501,1,5,0)
 ;;=5^Hemolytic Anemia,Autoimmune
 ;;^UTILITY(U,$J,358.3,19501,2)
 ;;=^7079
 ;;^UTILITY(U,$J,358.3,19502,0)
 ;;=282.9^^105^1232^81
 ;;^UTILITY(U,$J,358.3,19502,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19502,1,4,0)
 ;;=4^282.9
 ;;^UTILITY(U,$J,358.3,19502,1,5,0)
 ;;=5^Hemolytic Anemia,Hereditary
 ;;^UTILITY(U,$J,358.3,19502,2)
 ;;=^56578
 ;;^UTILITY(U,$J,358.3,19503,0)
 ;;=283.19^^105^1232^82
 ;;^UTILITY(U,$J,358.3,19503,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19503,1,4,0)
 ;;=4^283.19
 ;;^UTILITY(U,$J,358.3,19503,1,5,0)
 ;;=5^Hemolytic Anemia,Microang
 ;;^UTILITY(U,$J,358.3,19503,2)
 ;;=^293664
 ;;^UTILITY(U,$J,358.3,19504,0)
 ;;=280.9^^105^1232^86
 ;;^UTILITY(U,$J,358.3,19504,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19504,1,4,0)
 ;;=4^280.9
 ;;^UTILITY(U,$J,358.3,19504,1,5,0)
 ;;=5^Iron Defic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,19504,2)
 ;;=^276946
 ;;^UTILITY(U,$J,358.3,19505,0)
 ;;=285.1^^105^1232^84
 ;;^UTILITY(U,$J,358.3,19505,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19505,1,4,0)
 ;;=4^285.1
 ;;^UTILITY(U,$J,358.3,19505,1,5,0)
 ;;=5^Iron Defic Anemia d/t Acute Blood Loss
 ;;^UTILITY(U,$J,358.3,19505,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,19506,0)
 ;;=280.0^^105^1232^85
 ;;^UTILITY(U,$J,358.3,19506,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19506,1,4,0)
 ;;=4^280.0
 ;;^UTILITY(U,$J,358.3,19506,1,5,0)
 ;;=5^Iron Defic Anemia d/t Chronic Blood Loss
 ;;
 ;;$END ROU IBDEI13U
