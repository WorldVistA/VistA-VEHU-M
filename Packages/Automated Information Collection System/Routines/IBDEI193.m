IBDEI193 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22160,1,5,0)
 ;;=5^Hypocalcemia
 ;;^UTILITY(U,$J,358.3,22160,2)
 ;;=^60542
 ;;^UTILITY(U,$J,358.3,22161,0)
 ;;=276.7^^125^1388^23
 ;;^UTILITY(U,$J,358.3,22161,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22161,1,4,0)
 ;;=4^276.7
 ;;^UTILITY(U,$J,358.3,22161,1,5,0)
 ;;=5^Hyperkalemia
 ;;^UTILITY(U,$J,358.3,22161,2)
 ;;=^60042
 ;;^UTILITY(U,$J,358.3,22162,0)
 ;;=275.2^^125^1388^19
 ;;^UTILITY(U,$J,358.3,22162,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22162,1,4,0)
 ;;=4^275.2
 ;;^UTILITY(U,$J,358.3,22162,1,5,0)
 ;;=5^Hyper Or Hypomagnesemia
 ;;^UTILITY(U,$J,358.3,22162,2)
 ;;=^35626
 ;;^UTILITY(U,$J,358.3,22163,0)
 ;;=276.0^^125^1388^25
 ;;^UTILITY(U,$J,358.3,22163,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22163,1,4,0)
 ;;=4^276.0
 ;;^UTILITY(U,$J,358.3,22163,1,5,0)
 ;;=5^Hypernatremia
 ;;^UTILITY(U,$J,358.3,22163,2)
 ;;=^60144
 ;;^UTILITY(U,$J,358.3,22164,0)
 ;;=276.1^^125^1388^32
 ;;^UTILITY(U,$J,358.3,22164,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22164,1,4,0)
 ;;=4^276.1
 ;;^UTILITY(U,$J,358.3,22164,1,5,0)
 ;;=5^Hyponatremia
 ;;^UTILITY(U,$J,358.3,22164,2)
 ;;=Hyponatremia^60722
 ;;^UTILITY(U,$J,358.3,22165,0)
 ;;=275.3^^125^1388^20
 ;;^UTILITY(U,$J,358.3,22165,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22165,1,4,0)
 ;;=4^275.3
 ;;^UTILITY(U,$J,358.3,22165,1,5,0)
 ;;=5^Hyper Or Hypophosphatemia
 ;;^UTILITY(U,$J,358.3,22165,2)
 ;;=^93796
 ;;^UTILITY(U,$J,358.3,22166,0)
 ;;=240.0^^125^1388^14
 ;;^UTILITY(U,$J,358.3,22166,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22166,1,4,0)
 ;;=4^240.0
 ;;^UTILITY(U,$J,358.3,22166,1,5,0)
 ;;=5^Goiter, Simple
 ;;^UTILITY(U,$J,358.3,22166,2)
 ;;=^259806
 ;;^UTILITY(U,$J,358.3,22167,0)
 ;;=241.1^^125^1388^13
 ;;^UTILITY(U,$J,358.3,22167,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22167,1,4,0)
 ;;=4^241.1
 ;;^UTILITY(U,$J,358.3,22167,1,5,0)
 ;;=5^Goiter, Nontox, Multinod
 ;;^UTILITY(U,$J,358.3,22167,2)
 ;;=^267790
 ;;^UTILITY(U,$J,358.3,22168,0)
 ;;=241.0^^125^1388^50
 ;;^UTILITY(U,$J,358.3,22168,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22168,1,4,0)
 ;;=4^241.0
 ;;^UTILITY(U,$J,358.3,22168,1,5,0)
 ;;=5^Thyroid Nodule, Nontoxic
 ;;^UTILITY(U,$J,358.3,22168,2)
 ;;=^83865
 ;;^UTILITY(U,$J,358.3,22169,0)
 ;;=242.00^^125^1388^15
 ;;^UTILITY(U,$J,358.3,22169,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22169,1,4,0)
 ;;=4^242.00
 ;;^UTILITY(U,$J,358.3,22169,1,5,0)
 ;;=5^Graves' Disease
 ;;^UTILITY(U,$J,358.3,22169,2)
 ;;=^267793
 ;;^UTILITY(U,$J,358.3,22170,0)
 ;;=242.01^^125^1388^12
 ;;^UTILITY(U,$J,358.3,22170,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22170,1,4,0)
 ;;=4^242.01
 ;;^UTILITY(U,$J,358.3,22170,1,5,0)
 ;;=5^Goiter Diff Tox W Strm
 ;;^UTILITY(U,$J,358.3,22170,2)
 ;;=^267794
 ;;^UTILITY(U,$J,358.3,22171,0)
 ;;=252.1^^125^1388^33
 ;;^UTILITY(U,$J,358.3,22171,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22171,1,4,0)
 ;;=4^252.1
 ;;^UTILITY(U,$J,358.3,22171,1,5,0)
 ;;=5^Hypoparathyroidism
 ;;^UTILITY(U,$J,358.3,22171,2)
 ;;=^60635
 ;;^UTILITY(U,$J,358.3,22172,0)
 ;;=242.90^^125^1388^27
 ;;^UTILITY(U,$J,358.3,22172,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22172,1,4,0)
 ;;=4^242.90
 ;;^UTILITY(U,$J,358.3,22172,1,5,0)
 ;;=5^Hyperthyroidism w/o Goiter/Storm
 ;;^UTILITY(U,$J,358.3,22172,2)
 ;;=^267811
 ;;^UTILITY(U,$J,358.3,22173,0)
 ;;=242.91^^125^1388^26
 ;;^UTILITY(U,$J,358.3,22173,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22173,1,4,0)
 ;;=4^242.91
 ;;^UTILITY(U,$J,358.3,22173,1,5,0)
 ;;=5^Hyperthyroidism w/o Goit w/ Storm
 ;;^UTILITY(U,$J,358.3,22173,2)
 ;;=^267812
 ;;^UTILITY(U,$J,358.3,22174,0)
 ;;=244.0^^125^1388^36
 ;;
 ;;$END ROU IBDEI193
