IBDEI1JU ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27503,1,5,0)
 ;;=5^Asthma, Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,27503,2)
 ;;=^322001
 ;;^UTILITY(U,$J,358.3,27504,0)
 ;;=493.20^^162^1783^11
 ;;^UTILITY(U,$J,358.3,27504,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,27504,1,4,0)
 ;;=4^493.20
 ;;^UTILITY(U,$J,358.3,27504,1,5,0)
 ;;=5^COPD w/ Asthma
 ;;^UTILITY(U,$J,358.3,27504,2)
 ;;=COPD with Asthma^269964
 ;;^UTILITY(U,$J,358.3,27505,0)
 ;;=493.91^^162^1783^3
 ;;^UTILITY(U,$J,358.3,27505,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,27505,1,4,0)
 ;;=4^493.91
 ;;^UTILITY(U,$J,358.3,27505,1,5,0)
 ;;=5^Asthma w/ Status Asthmaticus
 ;;^UTILITY(U,$J,358.3,27505,2)
 ;;=^269967
 ;;^UTILITY(U,$J,358.3,27506,0)
 ;;=491.21^^162^1783^9
 ;;^UTILITY(U,$J,358.3,27506,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,27506,1,4,0)
 ;;=4^491.21
 ;;^UTILITY(U,$J,358.3,27506,1,5,0)
 ;;=5^COPD Exacerbation
 ;;^UTILITY(U,$J,358.3,27506,2)
 ;;=COPD Exacerbation^269954
 ;;^UTILITY(U,$J,358.3,27507,0)
 ;;=494.0^^162^1783^7
 ;;^UTILITY(U,$J,358.3,27507,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,27507,1,4,0)
 ;;=4^494.0
 ;;^UTILITY(U,$J,358.3,27507,1,5,0)
 ;;=5^Bronchiectasis, Chronic
 ;;^UTILITY(U,$J,358.3,27507,2)
 ;;=^321990
 ;;^UTILITY(U,$J,358.3,27508,0)
 ;;=494.1^^162^1783^6
 ;;^UTILITY(U,$J,358.3,27508,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,27508,1,4,0)
 ;;=4^494.1
 ;;^UTILITY(U,$J,358.3,27508,1,5,0)
 ;;=5^Bronchiectasis w/ Exacerb
 ;;^UTILITY(U,$J,358.3,27508,2)
 ;;=^321991
 ;;^UTILITY(U,$J,358.3,27509,0)
 ;;=496.^^162^1783^10
 ;;^UTILITY(U,$J,358.3,27509,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,27509,1,4,0)
 ;;=4^496.
 ;;^UTILITY(U,$J,358.3,27509,1,5,0)
 ;;=5^COPD General
 ;;^UTILITY(U,$J,358.3,27509,2)
 ;;=COPD, General^24355
 ;;^UTILITY(U,$J,358.3,27510,0)
 ;;=491.20^^162^1783^5
 ;;^UTILITY(U,$J,358.3,27510,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,27510,1,4,0)
 ;;=4^491.20
 ;;^UTILITY(U,$J,358.3,27510,1,5,0)
 ;;=5^Asthmatic Bronchitis,Chronic
 ;;^UTILITY(U,$J,358.3,27510,2)
 ;;=Chronic Asthmatic Bronchitis^269953
 ;;^UTILITY(U,$J,358.3,27511,0)
 ;;=491.9^^162^1783^8
 ;;^UTILITY(U,$J,358.3,27511,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,27511,1,4,0)
 ;;=4^491.9
 ;;^UTILITY(U,$J,358.3,27511,1,5,0)
 ;;=5^Bronchitis,Chronic
 ;;^UTILITY(U,$J,358.3,27511,2)
 ;;=^24359
 ;;^UTILITY(U,$J,358.3,27512,0)
 ;;=786.2^^162^1783^12
 ;;^UTILITY(U,$J,358.3,27512,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,27512,1,4,0)
 ;;=4^786.2
 ;;^UTILITY(U,$J,358.3,27512,1,5,0)
 ;;=5^Cough
 ;;^UTILITY(U,$J,358.3,27512,2)
 ;;=Cough^28905
 ;;^UTILITY(U,$J,358.3,27513,0)
 ;;=786.09^^162^1783^13
 ;;^UTILITY(U,$J,358.3,27513,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,27513,1,4,0)
 ;;=4^786.09
 ;;^UTILITY(U,$J,358.3,27513,1,5,0)
 ;;=5^Dyspnea
 ;;^UTILITY(U,$J,358.3,27513,2)
 ;;=Dyspnea^87547
 ;;^UTILITY(U,$J,358.3,27514,0)
 ;;=492.8^^162^1783^14
 ;;^UTILITY(U,$J,358.3,27514,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,27514,1,4,0)
 ;;=4^492.8
 ;;^UTILITY(U,$J,358.3,27514,1,5,0)
 ;;=5^Emphysema
 ;;^UTILITY(U,$J,358.3,27514,2)
 ;;=Emphysema^87569
 ;;^UTILITY(U,$J,358.3,27515,0)
 ;;=487.1^^162^1783^15
 ;;^UTILITY(U,$J,358.3,27515,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,27515,1,4,0)
 ;;=4^487.1
 ;;^UTILITY(U,$J,358.3,27515,1,5,0)
 ;;=5^Influenza w/ Other Resp Manifest
 ;;^UTILITY(U,$J,358.3,27515,2)
 ;;=^63125
 ;;^UTILITY(U,$J,358.3,27516,0)
 ;;=487.0^^162^1783^16
 ;;^UTILITY(U,$J,358.3,27516,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,27516,1,4,0)
 ;;=4^487.0
 ;;^UTILITY(U,$J,358.3,27516,1,5,0)
 ;;=5^Influenza w/ Pneumonia
 ;;^UTILITY(U,$J,358.3,27516,2)
 ;;=^269942
 ;;
 ;;$END ROU IBDEI1JU
