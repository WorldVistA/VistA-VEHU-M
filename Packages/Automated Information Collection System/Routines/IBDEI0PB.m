IBDEI0PB ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12089,1,2,0)
 ;;=2^95806
 ;;^UTILITY(U,$J,358.3,12089,1,3,0)
 ;;=3^Sleep Study/Unattended
 ;;^UTILITY(U,$J,358.3,12090,0)
 ;;=95807^^59^713^8^^^^1
 ;;^UTILITY(U,$J,358.3,12090,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12090,1,2,0)
 ;;=2^95807
 ;;^UTILITY(U,$J,358.3,12090,1,3,0)
 ;;=3^Sleep Study in Hosp/Clinic
 ;;^UTILITY(U,$J,358.3,12091,0)
 ;;=95805^^59^713^3^^^^1
 ;;^UTILITY(U,$J,358.3,12091,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12091,1,2,0)
 ;;=2^95805
 ;;^UTILITY(U,$J,358.3,12091,1,3,0)
 ;;=3^Multiple Sleep Latency Test
 ;;^UTILITY(U,$J,358.3,12092,0)
 ;;=95808^^59^713^4^^^^1
 ;;^UTILITY(U,$J,358.3,12092,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12092,1,2,0)
 ;;=2^95808
 ;;^UTILITY(U,$J,358.3,12092,1,3,0)
 ;;=3^Polysomnography,1-3
 ;;^UTILITY(U,$J,358.3,12093,0)
 ;;=G8839^^59^713^7^^^^1
 ;;^UTILITY(U,$J,358.3,12093,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12093,1,2,0)
 ;;=2^G8839
 ;;^UTILITY(U,$J,358.3,12093,1,3,0)
 ;;=3^Sleep Apnea Assess
 ;;^UTILITY(U,$J,358.3,12094,0)
 ;;=92585^^59^713^2^^^^1
 ;;^UTILITY(U,$J,358.3,12094,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12094,1,2,0)
 ;;=2^92585
 ;;^UTILITY(U,$J,358.3,12094,1,3,0)
 ;;=3^Auditor Evoke Potent,Comprehensive
 ;;^UTILITY(U,$J,358.3,12095,0)
 ;;=95803^^59^713^1^^^^1
 ;;^UTILITY(U,$J,358.3,12095,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12095,1,2,0)
 ;;=2^95803
 ;;^UTILITY(U,$J,358.3,12095,1,3,0)
 ;;=3^Actigraphy Testing (72hrs/14 consecutive days)
 ;;^UTILITY(U,$J,358.3,12096,0)
 ;;=95810^^59^713^5^^^^1
 ;;^UTILITY(U,$J,358.3,12096,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12096,1,2,0)
 ;;=2^95810
 ;;^UTILITY(U,$J,358.3,12096,1,3,0)
 ;;=3^Polysomnography w/ 4+ Parameters         
 ;;^UTILITY(U,$J,358.3,12097,0)
 ;;=95811^^59^713^6^^^^1
 ;;^UTILITY(U,$J,358.3,12097,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12097,1,2,0)
 ;;=2^95811
 ;;^UTILITY(U,$J,358.3,12097,1,3,0)
 ;;=3^Polysomnography w/ 4+ Parameters w/ CPAP
 ;;^UTILITY(U,$J,358.3,12098,0)
 ;;=95860^^59^714^12^^^^1
 ;;^UTILITY(U,$J,358.3,12098,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12098,1,2,0)
 ;;=2^95860
 ;;^UTILITY(U,$J,358.3,12098,1,3,0)
 ;;=3^EMG, one extremity
 ;;^UTILITY(U,$J,358.3,12099,0)
 ;;=95861^^59^714^1^^^^1
 ;;^UTILITY(U,$J,358.3,12099,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12099,1,2,0)
 ;;=2^95861
 ;;^UTILITY(U,$J,358.3,12099,1,3,0)
 ;;=3^EMG, 2 extremities
 ;;^UTILITY(U,$J,358.3,12100,0)
 ;;=95863^^59^714^2^^^^1
 ;;^UTILITY(U,$J,358.3,12100,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12100,1,2,0)
 ;;=2^95863
 ;;^UTILITY(U,$J,358.3,12100,1,3,0)
 ;;=3^EMG, 3 extremities
 ;;^UTILITY(U,$J,358.3,12101,0)
 ;;=95864^^59^714^3^^^^1
 ;;^UTILITY(U,$J,358.3,12101,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12101,1,2,0)
 ;;=2^95864
 ;;^UTILITY(U,$J,358.3,12101,1,3,0)
 ;;=3^EMG, 4 extremities
 ;;^UTILITY(U,$J,358.3,12102,0)
 ;;=95869^^59^714^11^^^^1
 ;;^UTILITY(U,$J,358.3,12102,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12102,1,2,0)
 ;;=2^95869
 ;;^UTILITY(U,$J,358.3,12102,1,3,0)
 ;;=3^EMG, Thoracic Paraspinal Muscles,T-2 to T-11
 ;;^UTILITY(U,$J,358.3,12103,0)
 ;;=95867^^59^714^6^^^^1
 ;;^UTILITY(U,$J,358.3,12103,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12103,1,2,0)
 ;;=2^95867
 ;;^UTILITY(U,$J,358.3,12103,1,3,0)
 ;;=3^EMG, Cranial Nerve supplied Muscles, unilat
 ;;^UTILITY(U,$J,358.3,12104,0)
 ;;=51785^^59^714^4^^^^1
 ;;^UTILITY(U,$J,358.3,12104,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12104,1,2,0)
 ;;=2^51785
 ;;^UTILITY(U,$J,358.3,12104,1,3,0)
 ;;=3^EMG, Anal/Urinary Muscle
 ;;^UTILITY(U,$J,358.3,12105,0)
 ;;=51792^^59^714^30^^^^1
 ;;
 ;;$END ROU IBDEI0PB
