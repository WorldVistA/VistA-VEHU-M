IBDEI0VW ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15498,1,4,0)
 ;;=4^788.64
 ;;^UTILITY(U,$J,358.3,15498,1,5,0)
 ;;=5^Urinary Hesitancy
 ;;^UTILITY(U,$J,358.3,15498,2)
 ;;=^334165
 ;;^UTILITY(U,$J,358.3,15499,0)
 ;;=788.65^^81^944^52
 ;;^UTILITY(U,$J,358.3,15499,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15499,1,4,0)
 ;;=4^788.65
 ;;^UTILITY(U,$J,358.3,15499,1,5,0)
 ;;=5^Straining of Urination
 ;;^UTILITY(U,$J,358.3,15499,2)
 ;;=^334166
 ;;^UTILITY(U,$J,358.3,15500,0)
 ;;=600.00^^81^944^4
 ;;^UTILITY(U,$J,358.3,15500,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15500,1,4,0)
 ;;=4^600.00
 ;;^UTILITY(U,$J,358.3,15500,1,5,0)
 ;;=5^BPH w/o Obstruction
 ;;^UTILITY(U,$J,358.3,15500,2)
 ;;=^334276
 ;;^UTILITY(U,$J,358.3,15501,0)
 ;;=599.70^^81^944^20
 ;;^UTILITY(U,$J,358.3,15501,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15501,1,4,0)
 ;;=4^599.70
 ;;^UTILITY(U,$J,358.3,15501,1,5,0)
 ;;=5^Hematuria
 ;;^UTILITY(U,$J,358.3,15501,2)
 ;;=^336751
 ;;^UTILITY(U,$J,358.3,15502,0)
 ;;=599.71^^81^944^21
 ;;^UTILITY(U,$J,358.3,15502,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15502,1,4,0)
 ;;=4^599.71
 ;;^UTILITY(U,$J,358.3,15502,1,5,0)
 ;;=5^Hematuria, Gross
 ;;^UTILITY(U,$J,358.3,15502,2)
 ;;=^336611
 ;;^UTILITY(U,$J,358.3,15503,0)
 ;;=599.72^^81^944^22
 ;;^UTILITY(U,$J,358.3,15503,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15503,1,4,0)
 ;;=4^599.72
 ;;^UTILITY(U,$J,358.3,15503,1,5,0)
 ;;=5^Hematuria, Microscopic
 ;;^UTILITY(U,$J,358.3,15503,2)
 ;;=^336612
 ;;^UTILITY(U,$J,358.3,15504,0)
 ;;=596.89^^81^944^12
 ;;^UTILITY(U,$J,358.3,15504,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15504,1,4,0)
 ;;=4^596.89
 ;;^UTILITY(U,$J,358.3,15504,1,5,0)
 ;;=5^Cystocele
 ;;^UTILITY(U,$J,358.3,15504,2)
 ;;=^87989
 ;;^UTILITY(U,$J,358.3,15505,0)
 ;;=596.81^^81^944^15
 ;;^UTILITY(U,$J,358.3,15505,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15505,1,4,0)
 ;;=4^596.81
 ;;^UTILITY(U,$J,358.3,15505,1,5,0)
 ;;=5^Cystostomy Infection
 ;;^UTILITY(U,$J,358.3,15505,2)
 ;;=^340556
 ;;^UTILITY(U,$J,358.3,15506,0)
 ;;=596.82^^81^944^13
 ;;^UTILITY(U,$J,358.3,15506,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15506,1,4,0)
 ;;=4^596.82
 ;;^UTILITY(U,$J,358.3,15506,1,5,0)
 ;;=5^Cystostomy Complication,Mechanical
 ;;^UTILITY(U,$J,358.3,15506,2)
 ;;=^340557
 ;;^UTILITY(U,$J,358.3,15507,0)
 ;;=596.83^^81^944^14
 ;;^UTILITY(U,$J,358.3,15507,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15507,1,4,0)
 ;;=4^596.83
 ;;^UTILITY(U,$J,358.3,15507,1,5,0)
 ;;=5^Cystostomy Complication,Other
 ;;^UTILITY(U,$J,358.3,15507,2)
 ;;=^340558
 ;;^UTILITY(U,$J,358.3,15508,0)
 ;;=788.91^^81^944^60
 ;;^UTILITY(U,$J,358.3,15508,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15508,1,4,0)
 ;;=4^788.91
 ;;^UTILITY(U,$J,358.3,15508,1,5,0)
 ;;=5^Urinary Incontinence,Functional
 ;;^UTILITY(U,$J,358.3,15508,2)
 ;;=^336673
 ;;^UTILITY(U,$J,358.3,15509,0)
 ;;=788.99^^81^944^64
 ;;^UTILITY(U,$J,358.3,15509,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15509,1,4,0)
 ;;=4^788.99
 ;;^UTILITY(U,$J,358.3,15509,1,5,0)
 ;;=5^Urinary System Symptoms,Other
 ;;^UTILITY(U,$J,358.3,15509,2)
 ;;=^273391
 ;;^UTILITY(U,$J,358.3,15510,0)
 ;;=626.9^^81^945^32
 ;;^UTILITY(U,$J,358.3,15510,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15510,1,4,0)
 ;;=4^626.9
 ;;^UTILITY(U,$J,358.3,15510,1,5,0)
 ;;=5^Menstrual disorder
 ;;^UTILITY(U,$J,358.3,15510,2)
 ;;=^123887
 ;;^UTILITY(U,$J,358.3,15511,0)
 ;;=626.0^^81^945^5
 ;;^UTILITY(U,$J,358.3,15511,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15511,1,4,0)
 ;;=4^626.0
 ;;^UTILITY(U,$J,358.3,15511,1,5,0)
 ;;=5^Amenorrhea
 ;;^UTILITY(U,$J,358.3,15511,2)
 ;;=Amenorrhea^5871
 ;;^UTILITY(U,$J,358.3,15512,0)
 ;;=628.0^^81^945^6
 ;;
 ;;$END ROU IBDEI0VW
