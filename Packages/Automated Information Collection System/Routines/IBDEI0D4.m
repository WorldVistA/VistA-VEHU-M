IBDEI0D4 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5907,1,2,0)
 ;;=2^J2060
 ;;^UTILITY(U,$J,358.3,5907,1,3,0)
 ;;=3^LORAZEPAM INJ PER 2 MG
 ;;^UTILITY(U,$J,358.3,5908,0)
 ;;=J2405^^29^393^32^^^^1
 ;;^UTILITY(U,$J,358.3,5908,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5908,1,2,0)
 ;;=2^J2405
 ;;^UTILITY(U,$J,358.3,5908,1,3,0)
 ;;=3^ONDANSETRON HCL INJ PER 1 MG
 ;;^UTILITY(U,$J,358.3,5909,0)
 ;;=J2997^^29^393^3^^^^1
 ;;^UTILITY(U,$J,358.3,5909,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5909,1,2,0)
 ;;=2^J2997
 ;;^UTILITY(U,$J,358.3,5909,1,3,0)
 ;;=3^ALTEPLASE RECOMBINANT PER 1 MG
 ;;^UTILITY(U,$J,358.3,5910,0)
 ;;=J3260^^29^393^40^^^^1
 ;;^UTILITY(U,$J,358.3,5910,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5910,1,2,0)
 ;;=2^J3260
 ;;^UTILITY(U,$J,358.3,5910,1,3,0)
 ;;=3^TOBRAMYCIN SULFATE PER 80 MG
 ;;^UTILITY(U,$J,358.3,5911,0)
 ;;=J7682^^29^393^39^^^^1
 ;;^UTILITY(U,$J,358.3,5911,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5911,1,2,0)
 ;;=2^J7682
 ;;^UTILITY(U,$J,358.3,5911,1,3,0)
 ;;=3^TOBRAMYCIN NON-COM UNIT 300 MG
 ;;^UTILITY(U,$J,358.3,5912,0)
 ;;=P9047^^29^393^2^^^^1
 ;;^UTILITY(U,$J,358.3,5912,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5912,1,2,0)
 ;;=2^P9047
 ;;^UTILITY(U,$J,358.3,5912,1,3,0)
 ;;=3^ALBUMIN (HUMAN), 25%, 50ML
 ;;^UTILITY(U,$J,358.3,5913,0)
 ;;=J0886^^29^393^17^^^^1
 ;;^UTILITY(U,$J,358.3,5913,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5913,1,2,0)
 ;;=2^J0886
 ;;^UTILITY(U,$J,358.3,5913,1,3,0)
 ;;=3^EPOETIN ALFA 1000 UNITS ESRD
 ;;^UTILITY(U,$J,358.3,5914,0)
 ;;=J3370^^29^393^42^^^^1
 ;;^UTILITY(U,$J,358.3,5914,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5914,1,2,0)
 ;;=2^J3370
 ;;^UTILITY(U,$J,358.3,5914,1,3,0)
 ;;=3^VANCOMYCIN HCL 500 MG
 ;;^UTILITY(U,$J,358.3,5915,0)
 ;;=J0636^^29^393^4^^^^1
 ;;^UTILITY(U,$J,358.3,5915,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5915,1,2,0)
 ;;=2^J0636
 ;;^UTILITY(U,$J,358.3,5915,1,3,0)
 ;;=3^CALCITRIOL INJ PER 0.1 MCG
 ;;^UTILITY(U,$J,358.3,5916,0)
 ;;=J0882^^29^393^10^^^^1
 ;;^UTILITY(U,$J,358.3,5916,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5916,1,2,0)
 ;;=2^J0882
 ;;^UTILITY(U,$J,358.3,5916,1,3,0)
 ;;=3^DARBEPOETIN ALFA,ESRD USE 1MCG
 ;;^UTILITY(U,$J,358.3,5917,0)
 ;;=J3490^^29^393^28^^^^1
 ;;^UTILITY(U,$J,358.3,5917,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5917,1,2,0)
 ;;=2^J3490
 ;;^UTILITY(U,$J,358.3,5917,1,3,0)
 ;;=3^LITHIUM CARBONATE
 ;;^UTILITY(U,$J,358.3,5918,0)
 ;;=J3490^^29^393^30^^^^1
 ;;^UTILITY(U,$J,358.3,5918,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5918,1,2,0)
 ;;=2^J3490
 ;;^UTILITY(U,$J,358.3,5918,1,3,0)
 ;;=3^MIDODRINE
 ;;^UTILITY(U,$J,358.3,5919,0)
 ;;=J0881^^29^393^11^^^^1
 ;;^UTILITY(U,$J,358.3,5919,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5919,1,2,0)
 ;;=2^J0881
 ;;^UTILITY(U,$J,358.3,5919,1,3,0)
 ;;=3^DARBEPOETIN ALFA,NON-ESRD USE 1 MCG
 ;;^UTILITY(U,$J,358.3,5920,0)
 ;;=J0885^^29^393^18^^^^1
 ;;^UTILITY(U,$J,358.3,5920,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5920,1,2,0)
 ;;=2^J0885
 ;;^UTILITY(U,$J,358.3,5920,1,3,0)
 ;;=3^EPOETIN ALFA 1000 UNITS NON-ESRD
 ;;^UTILITY(U,$J,358.3,5921,0)
 ;;=J7060^^29^393^1^^^^1
 ;;^UTILITY(U,$J,358.3,5921,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5921,1,2,0)
 ;;=2^J7060
 ;;^UTILITY(U,$J,358.3,5921,1,3,0)
 ;;=3^5% DEXTROSE/WATER 500 ML=1 UNIT
 ;;^UTILITY(U,$J,358.3,5922,0)
 ;;=J0895^^29^393^12^^^^1
 ;;^UTILITY(U,$J,358.3,5922,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5922,1,2,0)
 ;;=2^J0895
 ;;^UTILITY(U,$J,358.3,5922,1,3,0)
 ;;=3^DEFEROXAMINE MESYLATE 500 MG
 ;;^UTILITY(U,$J,358.3,5923,0)
 ;;=J1160^^29^393^13^^^^1
 ;;^UTILITY(U,$J,358.3,5923,1,0)
 ;;=^358.31IA^3^2
 ;;
 ;;$END ROU IBDEI0D4
