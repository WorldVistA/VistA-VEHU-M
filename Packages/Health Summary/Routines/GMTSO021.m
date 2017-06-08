GMTSO021 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",3738,1,2,0)
 ;;=particular patient. The user can specify item and occurrence limits,
 ;;^UTILITY(U,$J,"PRO",3738,1,3,0)
 ;;=whether hospital location should be displayed or not, the format of ICD-9
 ;;^UTILITY(U,$J,"PRO",3738,1,4,0)
 ;;=data (e.g. code only, long text, short text or no ICD-9 data), and whether
 ;;^UTILITY(U,$J,"PRO",3738,1,5,0)
 ;;=the provider narrative should be displayed or not.
 ;;^UTILITY(U,$J,"PRO",3738,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3738,2,1,0)
 ;;=HS PCE OUTPATIENT ENCOUNTERS
 ;;^UTILITY(U,$J,"PRO",3738,2,"B","HS PCE OUTPATIENT ENCOUNTERS",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3738,3,0)
 ;;=^101.03P^1^1
 ;;^UTILITY(U,$J,"PRO",3738,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3738,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="OE",GMTSTITL="Outpatient Encounter" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3738,99)
 ;;=56488,22286
 ;;^UTILITY(U,$J,"PRO",3739,0)
 ;;=GMTS NTM^Health Summary Non-Tabular Measurem^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3739,1,0)
 ;;=^^3^3^2950829^^^
 ;;^UTILITY(U,$J,"PRO",3739,1,1,0)
 ;;=This component lists measurements (e.g. blood pressure, height, weight, 
 ;;^UTILITY(U,$J,"PRO",3739,1,2,0)
 ;;=respirations, etc.) in a non-tabular format for a particular patient for a 
 ;;^UTILITY(U,$J,"PRO",3739,1,3,0)
 ;;=user-specified time and occurrence limits.
 ;;^UTILITY(U,$J,"PRO",3739,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3739,2,1,0)
 ;;=HS PCE MEASUREMENTS NON-TABULAR
 ;;^UTILITY(U,$J,"PRO",3739,2,"B","HS PCE MEASUREMENTS NON-TABULA",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3739,3,0)
 ;;=^101.03P^1^1
 ;;^UTILITY(U,$J,"PRO",3739,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3739,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="NTM",GMTSTITL="Non-Tabular Measurem" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3739,99)
 ;;=56488,22287
 ;;^UTILITY(U,$J,"PRO",3740,0)
 ;;=GMTS IM^Health Summary Immunizations^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3740,1,0)
 ;;=^^3^3^2950829^^^^
 ;;^UTILITY(U,$J,"PRO",3740,1,1,0)
 ;;=This component lists the immunizations (e.g., Rubella, Samllpox,
 ;;^UTILITY(U,$J,"PRO",3740,1,2,0)
 ;;=etc.) and information about each immunization adminstered to a
 ;;^UTILITY(U,$J,"PRO",3740,1,3,0)
 ;;=particular patient.
 ;;^UTILITY(U,$J,"PRO",3740,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3740,2,1,0)
 ;;=HS PCE IMMUNIZATIONS
 ;;^UTILITY(U,$J,"PRO",3740,2,"B","HS PCE IMMUNIZATIONS",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3740,3,0)
 ;;=^101.03P^1^1
 ;;^UTILITY(U,$J,"PRO",3740,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3740,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="IM",GMTSTITL="Immunizations" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3740,99)
 ;;=56488,22287
 ;;^UTILITY(U,$J,"PRO",3741,0)
 ;;=GMTS ST^Health Summary Skin Tests^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3741,1,0)
 ;;=^^3^3^2950829^^^
 ;;^UTILITY(U,$J,"PRO",3741,1,1,0)
 ;;=This component lists the skin tests and the results (e.g. positive,
 ;;^UTILITY(U,$J,"PRO",3741,1,2,0)
 ;;=negative, doubtful, or no take) for a particular patient. Some examples of
 ;;^UTILITY(U,$J,"PRO",3741,1,3,0)
 ;;=skin tests are cocci, mon-vac, PPD, schick, tine, etc.
 ;;^UTILITY(U,$J,"PRO",3741,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3741,2,1,0)
 ;;=HS PCE SKIN TESTS
 ;;^UTILITY(U,$J,"PRO",3741,2,"B","HS PCE SKIN TESTS",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3741,3,0)
 ;;=^101.03P^1^1
 ;;^UTILITY(U,$J,"PRO",3741,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3741,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="ST",GMTSTITL="Skin Tests" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3741,99)
 ;;=56488,22288
