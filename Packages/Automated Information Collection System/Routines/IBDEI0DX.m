IBDEI0DX ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6325,1,5,0)
 ;;=5^Alcohol Abuse-Episodic
 ;;^UTILITY(U,$J,358.3,6325,2)
 ;;=^268229
 ;;^UTILITY(U,$J,358.3,6326,0)
 ;;=305.03^^31^409^3
 ;;^UTILITY(U,$J,358.3,6326,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6326,1,4,0)
 ;;=4^305.03
 ;;^UTILITY(U,$J,358.3,6326,1,5,0)
 ;;=5^Alcohol Abuse-In Remiss
 ;;^UTILITY(U,$J,358.3,6326,2)
 ;;=^268230
 ;;^UTILITY(U,$J,358.3,6327,0)
 ;;=303.90^^31^409^16
 ;;^UTILITY(U,$J,358.3,6327,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6327,1,4,0)
 ;;=4^303.90
 ;;^UTILITY(U,$J,358.3,6327,1,5,0)
 ;;=5^Etoh Dependence
 ;;^UTILITY(U,$J,358.3,6327,2)
 ;;=^268187
 ;;^UTILITY(U,$J,358.3,6328,0)
 ;;=300.00^^31^409^6
 ;;^UTILITY(U,$J,358.3,6328,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6328,1,4,0)
 ;;=4^300.00
 ;;^UTILITY(U,$J,358.3,6328,1,5,0)
 ;;=5^Anxiety
 ;;^UTILITY(U,$J,358.3,6328,2)
 ;;=^1
 ;;^UTILITY(U,$J,358.3,6329,0)
 ;;=296.7^^31^409^7
 ;;^UTILITY(U,$J,358.3,6329,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6329,1,4,0)
 ;;=4^296.7
 ;;^UTILITY(U,$J,358.3,6329,1,5,0)
 ;;=5^Bipolar Affective Disorder
 ;;^UTILITY(U,$J,358.3,6329,2)
 ;;=^14793
 ;;^UTILITY(U,$J,358.3,6330,0)
 ;;=304.20^^31^409^8
 ;;^UTILITY(U,$J,358.3,6330,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6330,1,4,0)
 ;;=4^304.20
 ;;^UTILITY(U,$J,358.3,6330,1,5,0)
 ;;=5^Cocaine Dependence
 ;;^UTILITY(U,$J,358.3,6330,2)
 ;;=^25599
 ;;^UTILITY(U,$J,358.3,6331,0)
 ;;=294.11^^31^409^9
 ;;^UTILITY(U,$J,358.3,6331,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6331,1,4,0)
 ;;=4^294.11
 ;;^UTILITY(U,$J,358.3,6331,1,5,0)
 ;;=5^Dementia W/Behav Disturb
 ;;^UTILITY(U,$J,358.3,6331,2)
 ;;=^321982
 ;;^UTILITY(U,$J,358.3,6332,0)
 ;;=294.10^^31^409^10
 ;;^UTILITY(U,$J,358.3,6332,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6332,1,4,0)
 ;;=4^294.10
 ;;^UTILITY(U,$J,358.3,6332,1,5,0)
 ;;=5^Dementia W/O Behav Disturb
 ;;^UTILITY(U,$J,358.3,6332,2)
 ;;=^321980
 ;;^UTILITY(U,$J,358.3,6333,0)
 ;;=311.^^31^409^12
 ;;^UTILITY(U,$J,358.3,6333,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6333,1,4,0)
 ;;=4^311.
 ;;^UTILITY(U,$J,358.3,6333,1,5,0)
 ;;=5^Depression
 ;;^UTILITY(U,$J,358.3,6333,2)
 ;;=^35603
 ;;^UTILITY(U,$J,358.3,6334,0)
 ;;=309.0^^31^409^13
 ;;^UTILITY(U,$J,358.3,6334,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6334,1,4,0)
 ;;=4^309.0
 ;;^UTILITY(U,$J,358.3,6334,1,5,0)
 ;;=5^Depressive Reaction, Brief
 ;;^UTILITY(U,$J,358.3,6334,2)
 ;;=^3308
 ;;^UTILITY(U,$J,358.3,6335,0)
 ;;=305.50^^31^409^19
 ;;^UTILITY(U,$J,358.3,6335,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6335,1,4,0)
 ;;=4^305.50
 ;;^UTILITY(U,$J,358.3,6335,1,5,0)
 ;;=5^IV Drug Use
 ;;^UTILITY(U,$J,358.3,6335,2)
 ;;=^85868
 ;;^UTILITY(U,$J,358.3,6336,0)
 ;;=302.72^^31^409^20
 ;;^UTILITY(U,$J,358.3,6336,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6336,1,4,0)
 ;;=4^302.72
 ;;^UTILITY(U,$J,358.3,6336,1,5,0)
 ;;=5^Inhibited Sex Excitement(Not Organic Impotence)
 ;;^UTILITY(U,$J,358.3,6336,2)
 ;;=^1
 ;;^UTILITY(U,$J,358.3,6337,0)
 ;;=780.52^^31^409^21
 ;;^UTILITY(U,$J,358.3,6337,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6337,1,4,0)
 ;;=4^780.52
 ;;^UTILITY(U,$J,358.3,6337,1,5,0)
 ;;=5^Insomnia
 ;;^UTILITY(U,$J,358.3,6337,2)
 ;;=^87662
 ;;^UTILITY(U,$J,358.3,6338,0)
 ;;=300.3^^31^409^22
 ;;^UTILITY(U,$J,358.3,6338,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6338,1,4,0)
 ;;=4^300.3
 ;;^UTILITY(U,$J,358.3,6338,1,5,0)
 ;;=5^Obsessive-Compulsive
 ;;^UTILITY(U,$J,358.3,6338,2)
 ;;=^1
 ;;^UTILITY(U,$J,358.3,6339,0)
 ;;=304.00^^31^409^23
 ;;^UTILITY(U,$J,358.3,6339,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6339,1,4,0)
 ;;=4^304.00
 ;;^UTILITY(U,$J,358.3,6339,1,5,0)
 ;;=5^Opioid Dependence 
 ;;
 ;;$END ROU IBDEI0DX
