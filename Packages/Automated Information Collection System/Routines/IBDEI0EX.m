IBDEI0EX ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6832,0)
 ;;=278.00^^31^415^114
 ;;^UTILITY(U,$J,358.3,6832,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6832,1,4,0)
 ;;=4^278.00
 ;;^UTILITY(U,$J,358.3,6832,1,5,0)
 ;;=5^Obesity
 ;;^UTILITY(U,$J,358.3,6832,2)
 ;;=Obesity^84823
 ;;^UTILITY(U,$J,358.3,6833,0)
 ;;=278.01^^31^415^115
 ;;^UTILITY(U,$J,358.3,6833,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6833,1,4,0)
 ;;=4^278.01
 ;;^UTILITY(U,$J,358.3,6833,1,5,0)
 ;;=5^Obesity, Morbid
 ;;^UTILITY(U,$J,358.3,6833,2)
 ;;=Obesity, Morbid^84844
 ;;^UTILITY(U,$J,358.3,6834,0)
 ;;=783.5^^31^415^126
 ;;^UTILITY(U,$J,358.3,6834,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6834,1,4,0)
 ;;=4^783.5
 ;;^UTILITY(U,$J,358.3,6834,1,5,0)
 ;;=5^Polydipsia
 ;;^UTILITY(U,$J,358.3,6834,2)
 ;;=Polydipsia^186699
 ;;^UTILITY(U,$J,358.3,6835,0)
 ;;=783.6^^31^415^127
 ;;^UTILITY(U,$J,358.3,6835,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6835,1,4,0)
 ;;=4^783.6
 ;;^UTILITY(U,$J,358.3,6835,1,5,0)
 ;;=5^Polyphagia
 ;;^UTILITY(U,$J,358.3,6835,2)
 ;;=Polyphagia^60236
 ;;^UTILITY(U,$J,358.3,6836,0)
 ;;=780.2^^31^415^143
 ;;^UTILITY(U,$J,358.3,6836,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6836,1,4,0)
 ;;=4^780.2
 ;;^UTILITY(U,$J,358.3,6836,1,5,0)
 ;;=5^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,6836,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,6837,0)
 ;;=783.1^^31^415^156
 ;;^UTILITY(U,$J,358.3,6837,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6837,1,4,0)
 ;;=4^783.1
 ;;^UTILITY(U,$J,358.3,6837,1,5,0)
 ;;=5^Weight gain, abnormal
 ;;^UTILITY(U,$J,358.3,6837,2)
 ;;=^998
 ;;^UTILITY(U,$J,358.3,6838,0)
 ;;=783.21^^31^415^157
 ;;^UTILITY(U,$J,358.3,6838,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6838,1,4,0)
 ;;=4^783.21
 ;;^UTILITY(U,$J,358.3,6838,1,5,0)
 ;;=5^Weight loss, abnormal
 ;;^UTILITY(U,$J,358.3,6838,2)
 ;;=^322005
 ;;^UTILITY(U,$J,358.3,6839,0)
 ;;=796.2^^31^415^34
 ;;^UTILITY(U,$J,358.3,6839,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6839,1,4,0)
 ;;=4^796.2
 ;;^UTILITY(U,$J,358.3,6839,1,5,0)
 ;;=5^Blood Pressure Elevated, w/o HTN
 ;;^UTILITY(U,$J,358.3,6839,2)
 ;;=^273464
 ;;^UTILITY(U,$J,358.3,6840,0)
 ;;=790.92^^31^415^9
 ;;^UTILITY(U,$J,358.3,6840,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6840,1,4,0)
 ;;=4^790.92
 ;;^UTILITY(U,$J,358.3,6840,1,5,0)
 ;;=5^Abnorm Coagulation Profile
 ;;^UTILITY(U,$J,358.3,6840,2)
 ;;=Abnorm Coagulation Profile^295771
 ;;^UTILITY(U,$J,358.3,6841,0)
 ;;=794.31^^31^415^10
 ;;^UTILITY(U,$J,358.3,6841,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6841,1,4,0)
 ;;=4^794.31
 ;;^UTILITY(U,$J,358.3,6841,1,5,0)
 ;;=5^Abnormal EKG
 ;;^UTILITY(U,$J,358.3,6841,2)
 ;;=Abnormal EKG^83844
 ;;^UTILITY(U,$J,358.3,6842,0)
 ;;=790.1^^31^415^66
 ;;^UTILITY(U,$J,358.3,6842,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6842,1,4,0)
 ;;=4^790.1
 ;;^UTILITY(U,$J,358.3,6842,1,5,0)
 ;;=5^Elevated Sedimentation Rate
 ;;^UTILITY(U,$J,358.3,6842,2)
 ;;=Elevated Sedimentation Rate^39339
 ;;^UTILITY(U,$J,358.3,6843,0)
 ;;=790.93^^31^415^65
 ;;^UTILITY(U,$J,358.3,6843,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6843,1,4,0)
 ;;=4^790.93
 ;;^UTILITY(U,$J,358.3,6843,1,5,0)
 ;;=5^Elevated PSA
 ;;^UTILITY(U,$J,358.3,6843,2)
 ;;=Elevated PSA^295772
 ;;^UTILITY(U,$J,358.3,6844,0)
 ;;=791.0^^31^415^131
 ;;^UTILITY(U,$J,358.3,6844,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6844,1,4,0)
 ;;=4^791.0
 ;;^UTILITY(U,$J,358.3,6844,1,5,0)
 ;;=5^Proteinuria
 ;;^UTILITY(U,$J,358.3,6844,2)
 ;;=Proteinuria^99873
 ;;^UTILITY(U,$J,358.3,6845,0)
 ;;=791.9^^31^415^14
 ;;^UTILITY(U,$J,358.3,6845,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6845,1,4,0)
 ;;=4^791.9
 ;;^UTILITY(U,$J,358.3,6845,1,5,0)
 ;;=5^Abnormal UA
 ;;
 ;;$END ROU IBDEI0EX
