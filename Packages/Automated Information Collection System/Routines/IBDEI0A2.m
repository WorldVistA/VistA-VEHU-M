IBDEI0A2 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4309,0)
 ;;=94004^^22^222^1^^^^1
 ;;^UTILITY(U,$J,358.3,4309,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4309,1,2,0)
 ;;=2^Inpt Vent Mgmt NF per Day
 ;;^UTILITY(U,$J,358.3,4309,1,3,0)
 ;;=3^94004
 ;;^UTILITY(U,$J,358.3,4310,0)
 ;;=S0250^^22^223^1^^^^1
 ;;^UTILITY(U,$J,358.3,4310,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4310,1,2,0)
 ;;=2^Comp Geriatric Assess/Treat
 ;;^UTILITY(U,$J,358.3,4310,1,3,0)
 ;;=3^S0250
 ;;^UTILITY(U,$J,358.3,4311,0)
 ;;=99356^^22^224^1^^^^1
 ;;^UTILITY(U,$J,358.3,4311,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4311,1,2,0)
 ;;=2^Prolonged Svc,Inpt,1st Hr
 ;;^UTILITY(U,$J,358.3,4311,1,3,0)
 ;;=3^99356
 ;;^UTILITY(U,$J,358.3,4312,0)
 ;;=99357^^22^224^2^^^^1
 ;;^UTILITY(U,$J,358.3,4312,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4312,1,2,0)
 ;;=2^Prolonged Svc,Inpt,Ea Addl 30Min
 ;;^UTILITY(U,$J,358.3,4312,1,3,0)
 ;;=3^99357
 ;;^UTILITY(U,$J,358.3,4313,0)
 ;;=99366^^22^225^5^^^^1
 ;;^UTILITY(U,$J,358.3,4313,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4313,1,2,0)
 ;;=2^Team Conf w/ Pat by HC Prof 30 Min
 ;;^UTILITY(U,$J,358.3,4313,1,3,0)
 ;;=3^99366
 ;;^UTILITY(U,$J,358.3,4314,0)
 ;;=99367^^22^225^6^^^^1
 ;;^UTILITY(U,$J,358.3,4314,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4314,1,2,0)
 ;;=2^Team Conf w/o Pat by Phys 30 Min
 ;;^UTILITY(U,$J,358.3,4314,1,3,0)
 ;;=3^99367
 ;;^UTILITY(U,$J,358.3,4315,0)
 ;;=99368^^22^225^7^^^^1
 ;;^UTILITY(U,$J,358.3,4315,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4315,1,2,0)
 ;;=2^Team Conf w/o Pat by HC Prof 30 Min
 ;;^UTILITY(U,$J,358.3,4315,1,3,0)
 ;;=3^99368
 ;;^UTILITY(U,$J,358.3,4316,0)
 ;;=441.4^^23^226^1
 ;;^UTILITY(U,$J,358.3,4316,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4316,1,4,0)
 ;;=4^441.4
 ;;^UTILITY(U,$J,358.3,4316,1,5,0)
 ;;=5^Aortic Aneursym, abdominal
 ;;^UTILITY(U,$J,358.3,4316,2)
 ;;=^269769
 ;;^UTILITY(U,$J,358.3,4317,0)
 ;;=441.2^^23^226^2
 ;;^UTILITY(U,$J,358.3,4317,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4317,1,4,0)
 ;;=4^441.2
 ;;^UTILITY(U,$J,358.3,4317,1,5,0)
 ;;=5^Aortic Aneursym, thoracic
 ;;^UTILITY(U,$J,358.3,4317,2)
 ;;=^269765
 ;;^UTILITY(U,$J,358.3,4318,0)
 ;;=429.3^^23^226^10
 ;;^UTILITY(U,$J,358.3,4318,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4318,1,4,0)
 ;;=4^429.3
 ;;^UTILITY(U,$J,358.3,4318,1,5,0)
 ;;=5^Cardiomegaly
 ;;^UTILITY(U,$J,358.3,4318,2)
 ;;=^54748
 ;;^UTILITY(U,$J,358.3,4319,0)
 ;;=433.10^^23^226^12
 ;;^UTILITY(U,$J,358.3,4319,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4319,1,4,0)
 ;;=4^433.10
 ;;^UTILITY(U,$J,358.3,4319,1,5,0)
 ;;=5^Carotid Artery disease
 ;;^UTILITY(U,$J,358.3,4319,2)
 ;;=^295801
 ;;^UTILITY(U,$J,358.3,4320,0)
 ;;=458.0^^23^226^18
 ;;^UTILITY(U,$J,358.3,4320,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4320,1,4,0)
 ;;=4^458.0
 ;;^UTILITY(U,$J,358.3,4320,1,5,0)
 ;;=5^Orthostatic Hypotension
 ;;^UTILITY(U,$J,358.3,4320,2)
 ;;=^60741
 ;;^UTILITY(U,$J,358.3,4321,0)
 ;;=443.9^^23^226^19
 ;;^UTILITY(U,$J,358.3,4321,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4321,1,4,0)
 ;;=4^443.9
 ;;^UTILITY(U,$J,358.3,4321,1,5,0)
 ;;=5^PVD
 ;;^UTILITY(U,$J,358.3,4321,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,4322,0)
 ;;=V45.81^^23^226^21
 ;;^UTILITY(U,$J,358.3,4322,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4322,1,4,0)
 ;;=4^V45.81
 ;;^UTILITY(U,$J,358.3,4322,1,5,0)
 ;;=5^S/P CABG
 ;;^UTILITY(U,$J,358.3,4322,2)
 ;;=^97129
 ;;^UTILITY(U,$J,358.3,4323,0)
 ;;=459.81^^23^226^28
 ;;^UTILITY(U,$J,358.3,4323,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4323,1,4,0)
 ;;=4^459.81
 ;;^UTILITY(U,$J,358.3,4323,1,5,0)
 ;;=5^Venous Insufficiency
 ;;^UTILITY(U,$J,358.3,4323,2)
 ;;=^125826
 ;;
 ;;$END ROU IBDEI0A2
