IBDEI20Q ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35285,1,4,0)
 ;;=4^R05.
 ;;^UTILITY(U,$J,358.3,35285,2)
 ;;=^5019179
 ;;^UTILITY(U,$J,358.3,35286,0)
 ;;=R06.00^^185^2029^9
 ;;^UTILITY(U,$J,358.3,35286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35286,1,3,0)
 ;;=3^Dyspnea,Unspec
 ;;^UTILITY(U,$J,358.3,35286,1,4,0)
 ;;=4^R06.00
 ;;^UTILITY(U,$J,358.3,35286,2)
 ;;=^5019180
 ;;^UTILITY(U,$J,358.3,35287,0)
 ;;=J86.0^^185^2029^10
 ;;^UTILITY(U,$J,358.3,35287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35287,1,3,0)
 ;;=3^Empyema w/ Fistula
 ;;^UTILITY(U,$J,358.3,35287,1,4,0)
 ;;=4^J86.0
 ;;^UTILITY(U,$J,358.3,35287,2)
 ;;=^5008308
 ;;^UTILITY(U,$J,358.3,35288,0)
 ;;=J86.9^^185^2029^11
 ;;^UTILITY(U,$J,358.3,35288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35288,1,3,0)
 ;;=3^Empyema w/o Fistula
 ;;^UTILITY(U,$J,358.3,35288,1,4,0)
 ;;=4^J86.9
 ;;^UTILITY(U,$J,358.3,35288,2)
 ;;=^5008309
 ;;^UTILITY(U,$J,358.3,35289,0)
 ;;=R09.02^^185^2029^13
 ;;^UTILITY(U,$J,358.3,35289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35289,1,3,0)
 ;;=3^Hypoxemia
 ;;^UTILITY(U,$J,358.3,35289,1,4,0)
 ;;=4^R09.02
 ;;^UTILITY(U,$J,358.3,35289,2)
 ;;=^332831
 ;;^UTILITY(U,$J,358.3,35290,0)
 ;;=J98.2^^185^2029^15
 ;;^UTILITY(U,$J,358.3,35290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35290,1,3,0)
 ;;=3^Interstitial Lung Disease
 ;;^UTILITY(U,$J,358.3,35290,1,4,0)
 ;;=4^J98.2
 ;;^UTILITY(U,$J,358.3,35290,2)
 ;;=^39734
 ;;^UTILITY(U,$J,358.3,35291,0)
 ;;=J99.^^185^2029^16
 ;;^UTILITY(U,$J,358.3,35291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35291,1,3,0)
 ;;=3^Lung Involvement in Oth Diseases
 ;;^UTILITY(U,$J,358.3,35291,1,4,0)
 ;;=4^J99.
 ;;^UTILITY(U,$J,358.3,35291,2)
 ;;=^5008367
 ;;^UTILITY(U,$J,358.3,35292,0)
 ;;=J98.4^^185^2029^17
 ;;^UTILITY(U,$J,358.3,35292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35292,1,3,0)
 ;;=3^Lung Nodule
 ;;^UTILITY(U,$J,358.3,35292,1,4,0)
 ;;=4^J98.4
 ;;^UTILITY(U,$J,358.3,35292,2)
 ;;=^5008362
 ;;^UTILITY(U,$J,358.3,35293,0)
 ;;=J18.9^^185^2029^18
 ;;^UTILITY(U,$J,358.3,35293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35293,1,3,0)
 ;;=3^Pneumonia,Unspec
 ;;^UTILITY(U,$J,358.3,35293,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,35293,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,35294,0)
 ;;=J84.10^^185^2029^19
 ;;^UTILITY(U,$J,358.3,35294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35294,1,3,0)
 ;;=3^Postinflam Pulm Fibrosis
 ;;^UTILITY(U,$J,358.3,35294,1,4,0)
 ;;=4^J84.10
 ;;^UTILITY(U,$J,358.3,35294,2)
 ;;=^5008300
 ;;^UTILITY(U,$J,358.3,35295,0)
 ;;=Z01.811^^185^2029^20
 ;;^UTILITY(U,$J,358.3,35295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35295,1,3,0)
 ;;=3^Pre-Op Respiratory Exam
 ;;^UTILITY(U,$J,358.3,35295,1,4,0)
 ;;=4^Z01.811
 ;;^UTILITY(U,$J,358.3,35295,2)
 ;;=^5062626
 ;;^UTILITY(U,$J,358.3,35296,0)
 ;;=J18.2^^185^2029^12
 ;;^UTILITY(U,$J,358.3,35296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35296,1,3,0)
 ;;=3^Hypostatic Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,35296,1,4,0)
 ;;=4^J18.2
 ;;^UTILITY(U,$J,358.3,35296,2)
 ;;=^5008184
 ;;^UTILITY(U,$J,358.3,35297,0)
 ;;=J81.1^^185^2029^22
 ;;^UTILITY(U,$J,358.3,35297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35297,1,3,0)
 ;;=3^Pulmonary Edema,Chronic
 ;;^UTILITY(U,$J,358.3,35297,1,4,0)
 ;;=4^J81.1
 ;;^UTILITY(U,$J,358.3,35297,2)
 ;;=^5008296
 ;;^UTILITY(U,$J,358.3,35298,0)
 ;;=J84.112^^185^2029^14
 ;;^UTILITY(U,$J,358.3,35298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35298,1,3,0)
 ;;=3^Idiopathic Pulmonary Fibrosis
 ;;^UTILITY(U,$J,358.3,35298,1,4,0)
 ;;=4^J84.112
 ;;^UTILITY(U,$J,358.3,35298,2)
 ;;=^340534
 ;;^UTILITY(U,$J,358.3,35299,0)
 ;;=I27.0^^185^2029^21
 ;;
 ;;$END ROU IBDEI20Q
