IBDEI114 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18125,1,5,0)
 ;;=5^Elevated Sedimentation Rate
 ;;^UTILITY(U,$J,358.3,18125,2)
 ;;=Elevated Sedimentation Rate^39339
 ;;^UTILITY(U,$J,358.3,18126,0)
 ;;=790.93^^96^1155^61
 ;;^UTILITY(U,$J,358.3,18126,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18126,1,4,0)
 ;;=4^790.93
 ;;^UTILITY(U,$J,358.3,18126,1,5,0)
 ;;=5^Elevated PSA
 ;;^UTILITY(U,$J,358.3,18126,2)
 ;;=Elevated PSA^295772
 ;;^UTILITY(U,$J,358.3,18127,0)
 ;;=791.0^^96^1155^122
 ;;^UTILITY(U,$J,358.3,18127,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18127,1,4,0)
 ;;=4^791.0
 ;;^UTILITY(U,$J,358.3,18127,1,5,0)
 ;;=5^Proteinuria
 ;;^UTILITY(U,$J,358.3,18127,2)
 ;;=Proteinuria^99873
 ;;^UTILITY(U,$J,358.3,18128,0)
 ;;=791.9^^96^1155^14
 ;;^UTILITY(U,$J,358.3,18128,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18128,1,4,0)
 ;;=4^791.9
 ;;^UTILITY(U,$J,358.3,18128,1,5,0)
 ;;=5^Abnormal UA
 ;;^UTILITY(U,$J,358.3,18128,2)
 ;;=Abnormal UA^273408
 ;;^UTILITY(U,$J,358.3,18129,0)
 ;;=789.01^^96^1155^7
 ;;^UTILITY(U,$J,358.3,18129,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18129,1,4,0)
 ;;=4^789.01
 ;;^UTILITY(U,$J,358.3,18129,1,5,0)
 ;;=5^Abdominal pain, RUQ
 ;;^UTILITY(U,$J,358.3,18129,2)
 ;;=^303318
 ;;^UTILITY(U,$J,358.3,18130,0)
 ;;=789.02^^96^1155^4
 ;;^UTILITY(U,$J,358.3,18130,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18130,1,4,0)
 ;;=4^789.02
 ;;^UTILITY(U,$J,358.3,18130,1,5,0)
 ;;=5^Abdominal pain, LUQ
 ;;^UTILITY(U,$J,358.3,18130,2)
 ;;=^303319
 ;;^UTILITY(U,$J,358.3,18131,0)
 ;;=789.03^^96^1155^6
 ;;^UTILITY(U,$J,358.3,18131,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18131,1,4,0)
 ;;=4^789.03
 ;;^UTILITY(U,$J,358.3,18131,1,5,0)
 ;;=5^Abdominal pain, RLQ
 ;;^UTILITY(U,$J,358.3,18131,2)
 ;;=^303320
 ;;^UTILITY(U,$J,358.3,18132,0)
 ;;=789.04^^96^1155^3
 ;;^UTILITY(U,$J,358.3,18132,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18132,1,4,0)
 ;;=4^789.04
 ;;^UTILITY(U,$J,358.3,18132,1,5,0)
 ;;=5^Abdominal pain, LLQ
 ;;^UTILITY(U,$J,358.3,18132,2)
 ;;=^303321
 ;;^UTILITY(U,$J,358.3,18133,0)
 ;;=789.06^^96^1155^2
 ;;^UTILITY(U,$J,358.3,18133,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18133,1,4,0)
 ;;=4^789.06
 ;;^UTILITY(U,$J,358.3,18133,1,5,0)
 ;;=5^Abdominal pain, Epigastric
 ;;^UTILITY(U,$J,358.3,18133,2)
 ;;=^303323
 ;;^UTILITY(U,$J,358.3,18134,0)
 ;;=789.05^^96^1155^5
 ;;^UTILITY(U,$J,358.3,18134,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18134,1,4,0)
 ;;=4^789.05
 ;;^UTILITY(U,$J,358.3,18134,1,5,0)
 ;;=5^Abdominal pain, Periumbilical
 ;;^UTILITY(U,$J,358.3,18134,2)
 ;;=^303322
 ;;^UTILITY(U,$J,358.3,18135,0)
 ;;=789.40^^96^1155^8
 ;;^UTILITY(U,$J,358.3,18135,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18135,1,4,0)
 ;;=4^789.40
 ;;^UTILITY(U,$J,358.3,18135,1,5,0)
 ;;=5^Abdominal rigidity, unsp site
 ;;^UTILITY(U,$J,358.3,18135,2)
 ;;=^273393
 ;;^UTILITY(U,$J,358.3,18136,0)
 ;;=789.1^^96^1155^75
 ;;^UTILITY(U,$J,358.3,18136,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18136,1,4,0)
 ;;=4^789.1
 ;;^UTILITY(U,$J,358.3,18136,1,5,0)
 ;;=5^Hepatomegaly
 ;;^UTILITY(U,$J,358.3,18136,2)
 ;;=Hepatomegaly^56494
 ;;^UTILITY(U,$J,358.3,18137,0)
 ;;=789.30^^96^1155^1
 ;;^UTILITY(U,$J,358.3,18137,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18137,1,4,0)
 ;;=4^789.30
 ;;^UTILITY(U,$J,358.3,18137,1,5,0)
 ;;=5^Abdominal Mass/Lump
 ;;^UTILITY(U,$J,358.3,18137,2)
 ;;=Abdominal Mass/Lump^917
 ;;^UTILITY(U,$J,358.3,18138,0)
 ;;=789.2^^96^1155^130
 ;;^UTILITY(U,$J,358.3,18138,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18138,1,4,0)
 ;;=4^789.2
 ;;^UTILITY(U,$J,358.3,18138,1,5,0)
 ;;=5^Splenomegaly
 ;;^UTILITY(U,$J,358.3,18138,2)
 ;;=Splenomegaly^113452
 ;;
 ;;$END ROU IBDEI114
