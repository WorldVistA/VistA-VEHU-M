IBDEI0W5 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15621,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15621,1,4,0)
 ;;=4^V10.3
 ;;^UTILITY(U,$J,358.3,15621,1,5,0)
 ;;=5^H/O Breast Cancer
 ;;^UTILITY(U,$J,358.3,15621,2)
 ;;=^295217
 ;;^UTILITY(U,$J,358.3,15622,0)
 ;;=V10.41^^81^946^58
 ;;^UTILITY(U,$J,358.3,15622,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15622,1,4,0)
 ;;=4^V10.41
 ;;^UTILITY(U,$J,358.3,15622,1,5,0)
 ;;=5^H/O Cervical Cancer
 ;;^UTILITY(U,$J,358.3,15622,2)
 ;;=^295219
 ;;^UTILITY(U,$J,358.3,15623,0)
 ;;=V10.05^^81^946^59
 ;;^UTILITY(U,$J,358.3,15623,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15623,1,4,0)
 ;;=4^V10.05
 ;;^UTILITY(U,$J,358.3,15623,1,5,0)
 ;;=5^H/O Colon Cancer
 ;;^UTILITY(U,$J,358.3,15623,2)
 ;;=H/O Colon Cancer^295207
 ;;^UTILITY(U,$J,358.3,15624,0)
 ;;=V10.03^^81^946^60
 ;;^UTILITY(U,$J,358.3,15624,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15624,1,4,0)
 ;;=4^V10.03
 ;;^UTILITY(U,$J,358.3,15624,1,5,0)
 ;;=5^H/O Esophageal Cancer
 ;;^UTILITY(U,$J,358.3,15624,2)
 ;;=^295205
 ;;^UTILITY(U,$J,358.3,15625,0)
 ;;=V10.60^^81^946^62
 ;;^UTILITY(U,$J,358.3,15625,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15625,1,4,0)
 ;;=4^V10.60
 ;;^UTILITY(U,$J,358.3,15625,1,5,0)
 ;;=5^H/O Leukemia
 ;;^UTILITY(U,$J,358.3,15625,2)
 ;;=H/O Leukemia^295231
 ;;^UTILITY(U,$J,358.3,15626,0)
 ;;=V10.11^^81^946^63
 ;;^UTILITY(U,$J,358.3,15626,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15626,1,4,0)
 ;;=4^V10.11
 ;;^UTILITY(U,$J,358.3,15626,1,5,0)
 ;;=5^H/O Lung Cancer
 ;;^UTILITY(U,$J,358.3,15626,2)
 ;;=H/O Lung Cancer^295211
 ;;^UTILITY(U,$J,358.3,15627,0)
 ;;=V10.79^^81^946^64
 ;;^UTILITY(U,$J,358.3,15627,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15627,1,4,0)
 ;;=4^V10.79
 ;;^UTILITY(U,$J,358.3,15627,1,5,0)
 ;;=5^H/O Lymphoma
 ;;^UTILITY(U,$J,358.3,15627,2)
 ;;=H/O Lymphoma^295238
 ;;^UTILITY(U,$J,358.3,15628,0)
 ;;=V10.82^^81^946^65
 ;;^UTILITY(U,$J,358.3,15628,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15628,1,4,0)
 ;;=4^V10.82
 ;;^UTILITY(U,$J,358.3,15628,1,5,0)
 ;;=5^H/O Malig Melanoma Of Skin
 ;;^UTILITY(U,$J,358.3,15628,2)
 ;;=^295240
 ;;^UTILITY(U,$J,358.3,15629,0)
 ;;=V10.02^^81^946^68
 ;;^UTILITY(U,$J,358.3,15629,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15629,1,4,0)
 ;;=4^V10.02
 ;;^UTILITY(U,$J,358.3,15629,1,5,0)
 ;;=5^H/O Oral Cavity/Pharynx Cancer
 ;;^UTILITY(U,$J,358.3,15629,2)
 ;;=^295204
 ;;^UTILITY(U,$J,358.3,15630,0)
 ;;=V10.43^^81^946^69
 ;;^UTILITY(U,$J,358.3,15630,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15630,1,4,0)
 ;;=4^V10.43
 ;;^UTILITY(U,$J,358.3,15630,1,5,0)
 ;;=5^H/O Ovarian Cancer
 ;;^UTILITY(U,$J,358.3,15630,2)
 ;;=^295221
 ;;^UTILITY(U,$J,358.3,15631,0)
 ;;=V10.46^^81^946^70
 ;;^UTILITY(U,$J,358.3,15631,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15631,1,4,0)
 ;;=4^V10.46
 ;;^UTILITY(U,$J,358.3,15631,1,5,0)
 ;;=5^H/O Prostate Cancer
 ;;^UTILITY(U,$J,358.3,15631,2)
 ;;=^295224
 ;;^UTILITY(U,$J,358.3,15632,0)
 ;;=V10.06^^81^946^71
 ;;^UTILITY(U,$J,358.3,15632,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15632,1,4,0)
 ;;=4^V10.06
 ;;^UTILITY(U,$J,358.3,15632,1,5,0)
 ;;=5^H/O Rectal/Anal Cancer
 ;;^UTILITY(U,$J,358.3,15632,2)
 ;;=^295208
 ;;^UTILITY(U,$J,358.3,15633,0)
 ;;=V10.52^^81^946^72
 ;;^UTILITY(U,$J,358.3,15633,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15633,1,4,0)
 ;;=4^V10.52
 ;;^UTILITY(U,$J,358.3,15633,1,5,0)
 ;;=5^H/O Renal Cancer
 ;;^UTILITY(U,$J,358.3,15633,2)
 ;;=H/o Renal Cancer^295229
 ;;^UTILITY(U,$J,358.3,15634,0)
 ;;=V10.04^^81^946^74
 ;;^UTILITY(U,$J,358.3,15634,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15634,1,4,0)
 ;;=4^V10.04
 ;;^UTILITY(U,$J,358.3,15634,1,5,0)
 ;;=5^H/O Stomach Cancer
 ;;
 ;;$END ROU IBDEI0W5
