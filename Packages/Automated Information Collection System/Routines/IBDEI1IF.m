IBDEI1IF ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26795,1,3,0)
 ;;=3^SPONDYLOPATHY IN OTH DIS
 ;;^UTILITY(U,$J,358.3,26795,1,4,0)
 ;;=4^720.81
 ;;^UTILITY(U,$J,358.3,26795,2)
 ;;=^63097
 ;;^UTILITY(U,$J,358.3,26796,0)
 ;;=721.90^^156^1728^32
 ;;^UTILITY(U,$J,358.3,26796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26796,1,3,0)
 ;;=3^SPONDYLOPATH W/O MYELOPATH
 ;;^UTILITY(U,$J,358.3,26796,1,4,0)
 ;;=4^721.90
 ;;^UTILITY(U,$J,358.3,26796,2)
 ;;=^272463
 ;;^UTILITY(U,$J,358.3,26797,0)
 ;;=721.91^^156^1728^34
 ;;^UTILITY(U,$J,358.3,26797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26797,1,3,0)
 ;;=3^SPONDYLOSIS NOS W MYELOPATH
 ;;^UTILITY(U,$J,358.3,26797,1,4,0)
 ;;=4^721.91
 ;;^UTILITY(U,$J,358.3,26797,2)
 ;;=^272464
 ;;^UTILITY(U,$J,358.3,26798,0)
 ;;=722.11^^156^1728^37
 ;;^UTILITY(U,$J,358.3,26798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26798,1,3,0)
 ;;=3^THORACIC DISC DISPLACMNT
 ;;^UTILITY(U,$J,358.3,26798,1,4,0)
 ;;=4^722.11
 ;;^UTILITY(U,$J,358.3,26798,2)
 ;;=^272470
 ;;^UTILITY(U,$J,358.3,26799,0)
 ;;=721.2^^156^1728^38
 ;;^UTILITY(U,$J,358.3,26799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26799,1,3,0)
 ;;=3^THORACIC SPONDYLOSIS
 ;;^UTILITY(U,$J,358.3,26799,1,4,0)
 ;;=4^721.2
 ;;^UTILITY(U,$J,358.3,26799,2)
 ;;=^272455
 ;;^UTILITY(U,$J,358.3,26800,0)
 ;;=721.7^^156^1728^46
 ;;^UTILITY(U,$J,358.3,26800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26800,1,3,0)
 ;;=3^TRAUMATIC SPONDYLOPATHY
 ;;^UTILITY(U,$J,358.3,26800,1,4,0)
 ;;=4^721.7
 ;;^UTILITY(U,$J,358.3,26800,2)
 ;;=^265068
 ;;^UTILITY(U,$J,358.3,26801,0)
 ;;=736.89^^156^1728^21
 ;;^UTILITY(U,$J,358.3,26801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26801,1,3,0)
 ;;=3^OTH ACQ LIMB DEFORMITY
 ;;^UTILITY(U,$J,358.3,26801,1,4,0)
 ;;=4^736.89
 ;;^UTILITY(U,$J,358.3,26801,2)
 ;;=^87243
 ;;^UTILITY(U,$J,358.3,26802,0)
 ;;=716.13^^156^1728^40
 ;;^UTILITY(U,$J,358.3,26802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26802,1,3,0)
 ;;=3^TRAUM ARTHROPATH-FOREARM
 ;;^UTILITY(U,$J,358.3,26802,1,4,0)
 ;;=4^716.13
 ;;^UTILITY(U,$J,358.3,26802,2)
 ;;=^272182
 ;;^UTILITY(U,$J,358.3,26803,0)
 ;;=716.17^^156^1728^39
 ;;^UTILITY(U,$J,358.3,26803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26803,1,3,0)
 ;;=3^TRAUM ARTHROPATH-ANKLE
 ;;^UTILITY(U,$J,358.3,26803,1,4,0)
 ;;=4^716.17
 ;;^UTILITY(U,$J,358.3,26803,2)
 ;;=^272186
 ;;^UTILITY(U,$J,358.3,26804,0)
 ;;=716.14^^156^1728^41
 ;;^UTILITY(U,$J,358.3,26804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26804,1,3,0)
 ;;=3^TRAUM ARTHROPATH-HAND
 ;;^UTILITY(U,$J,358.3,26804,1,4,0)
 ;;=4^716.14
 ;;^UTILITY(U,$J,358.3,26804,2)
 ;;=^272183
 ;;^UTILITY(U,$J,358.3,26805,0)
 ;;=716.16^^156^1728^42
 ;;^UTILITY(U,$J,358.3,26805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26805,1,3,0)
 ;;=3^TRAUM ARTHROPATH-L/LEG
 ;;^UTILITY(U,$J,358.3,26805,1,4,0)
 ;;=4^716.16
 ;;^UTILITY(U,$J,358.3,26805,2)
 ;;=^272185
 ;;^UTILITY(U,$J,358.3,26806,0)
 ;;=716.15^^156^1728^43
 ;;^UTILITY(U,$J,358.3,26806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26806,1,3,0)
 ;;=3^TRAUM ARTHROPATH-PELVIS
 ;;^UTILITY(U,$J,358.3,26806,1,4,0)
 ;;=4^716.15
 ;;^UTILITY(U,$J,358.3,26806,2)
 ;;=^272184
 ;;^UTILITY(U,$J,358.3,26807,0)
 ;;=716.12^^156^1728^44
 ;;^UTILITY(U,$J,358.3,26807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26807,1,3,0)
 ;;=3^TRAUM ARTHROPATH-UP/ARM
 ;;^UTILITY(U,$J,358.3,26807,1,4,0)
 ;;=4^716.12
 ;;^UTILITY(U,$J,358.3,26807,2)
 ;;=^272181
 ;;^UTILITY(U,$J,358.3,26808,0)
 ;;=722.72^^156^1728^35
 ;;^UTILITY(U,$J,358.3,26808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26808,1,3,0)
 ;;=3^THOR DISC DIS W MYELOPAT
 ;;^UTILITY(U,$J,358.3,26808,1,4,0)
 ;;=4^722.72
 ;;
 ;;$END ROU IBDEI1IF
