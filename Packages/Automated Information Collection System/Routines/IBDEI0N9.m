IBDEI0N9 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11073,1,3,0)
 ;;=3^Group Hlth/Behave,Ea 15min
 ;;^UTILITY(U,$J,358.3,11074,0)
 ;;=H0046^^48^621^4^^^^1
 ;;^UTILITY(U,$J,358.3,11074,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11074,1,2,0)
 ;;=2^H0046
 ;;^UTILITY(U,$J,358.3,11074,1,3,0)
 ;;=3^PTSD Group
 ;;^UTILITY(U,$J,358.3,11075,0)
 ;;=H0038^^48^621^5^^^^1
 ;;^UTILITY(U,$J,358.3,11075,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11075,1,2,0)
 ;;=2^H0038
 ;;^UTILITY(U,$J,358.3,11075,1,3,0)
 ;;=3^Self-Help/Peer Svc per 15 Min
 ;;^UTILITY(U,$J,358.3,11076,0)
 ;;=97535^^48^622^1^^^^1
 ;;^UTILITY(U,$J,358.3,11076,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11076,1,2,0)
 ;;=2^97535
 ;;^UTILITY(U,$J,358.3,11076,1,3,0)
 ;;=3^ADL Train per 15 min
 ;;^UTILITY(U,$J,358.3,11077,0)
 ;;=96119^^48^622^2^^^^1
 ;;^UTILITY(U,$J,358.3,11077,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11077,1,2,0)
 ;;=2^96119
 ;;^UTILITY(U,$J,358.3,11077,1,3,0)
 ;;=3^Neuropsych Test by tech,per hr
 ;;^UTILITY(U,$J,358.3,11078,0)
 ;;=96102^^48^622^5^^^^1
 ;;^UTILITY(U,$J,358.3,11078,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11078,1,2,0)
 ;;=2^96102
 ;;^UTILITY(U,$J,358.3,11078,1,3,0)
 ;;=3^Psych Test by Tech,per hr
 ;;^UTILITY(U,$J,358.3,11079,0)
 ;;=96103^^48^622^6^^^^1
 ;;^UTILITY(U,$J,358.3,11079,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11079,1,2,0)
 ;;=2^96103
 ;;^UTILITY(U,$J,358.3,11079,1,3,0)
 ;;=3^Psych Test by computer
 ;;^UTILITY(U,$J,358.3,11080,0)
 ;;=96120^^48^622^3^^^^1
 ;;^UTILITY(U,$J,358.3,11080,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11080,1,2,0)
 ;;=2^96120
 ;;^UTILITY(U,$J,358.3,11080,1,3,0)
 ;;=3^Neuropsych Tst Admin w/Comp
 ;;^UTILITY(U,$J,358.3,11081,0)
 ;;=Q3014^^48^622^7^^^^1
 ;;^UTILITY(U,$J,358.3,11081,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11081,1,2,0)
 ;;=2^Q3014
 ;;^UTILITY(U,$J,358.3,11081,1,3,0)
 ;;=3^Telehealth Facility Fee
 ;;^UTILITY(U,$J,358.3,11082,0)
 ;;=90889^^48^622^4^^^^1
 ;;^UTILITY(U,$J,358.3,11082,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11082,1,2,0)
 ;;=2^90889
 ;;^UTILITY(U,$J,358.3,11082,1,3,0)
 ;;=3^Preparation of Report
 ;;^UTILITY(U,$J,358.3,11083,0)
 ;;=G0177^^48^622^8^^^^1
 ;;^UTILITY(U,$J,358.3,11083,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11083,1,2,0)
 ;;=2^G0177
 ;;^UTILITY(U,$J,358.3,11083,1,3,0)
 ;;=3^Train/Ed for Disability > 44 Min
 ;;^UTILITY(U,$J,358.3,11084,0)
 ;;=99368^^48^623^3^^^^1
 ;;^UTILITY(U,$J,358.3,11084,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11084,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,11084,1,3,0)
 ;;=3^Team Conf w/o Pt by HC Pro>29min
 ;;^UTILITY(U,$J,358.3,11085,0)
 ;;=99366^^48^623^1^^^^1
 ;;^UTILITY(U,$J,358.3,11085,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11085,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,11085,1,3,0)
 ;;=3^Team Conf w/ Pt by HC Pro>29min
 ;;^UTILITY(U,$J,358.3,11086,0)
 ;;=H0001^^48^624^1^^^^1
 ;;^UTILITY(U,$J,358.3,11086,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11086,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,11086,1,3,0)
 ;;=3^Addictions Assessment
 ;;^UTILITY(U,$J,358.3,11087,0)
 ;;=H0002^^48^624^9^^^^1
 ;;^UTILITY(U,$J,358.3,11087,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11087,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,11087,1,3,0)
 ;;=3^Screen for Addictions Admit
 ;;^UTILITY(U,$J,358.3,11088,0)
 ;;=H0003^^48^624^6^^^^1
 ;;^UTILITY(U,$J,358.3,11088,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11088,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,11088,1,3,0)
 ;;=3^Alcohol/Drug Scrn;lab analysis
 ;;^UTILITY(U,$J,358.3,11089,0)
 ;;=H0004^^48^624^7^^^^1
 ;;^UTILITY(U,$J,358.3,11089,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11089,1,2,0)
 ;;=2^H0004
 ;;
 ;;$END ROU IBDEI0N9
