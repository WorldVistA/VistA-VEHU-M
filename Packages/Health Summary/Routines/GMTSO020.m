GMTSO020 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",3725,1,7,0)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3725,1,8,0)
 ;;=If this component is printed to either a CRT or another device type,
 ;;^UTILITY(U,$J,"PRO",3725,1,9,0)
 ;;=information will include title, text of note,
 ;;^UTILITY(U,$J,"PRO",3725,1,10,0)
 ;;=electronic signature block, and date/time posted.
 ;;^UTILITY(U,$J,"PRO",3725,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3725,2,1,0)
 ;;=HS ADVANCE DIRECTIVE
 ;;^UTILITY(U,$J,"PRO",3725,2,"B","HS ADVANCE DIRECTIVE",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3725,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",3725,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3725,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="CD",GMTSTITL="Advance Directive" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3725,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",3726,0)
 ;;=GMTS EM^Health Summary Electron Microscopy^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3726,1,0)
 ;;=^^5^5^2950706^
 ;;^UTILITY(U,$J,"PRO",3726,1,1,0)
 ;;=This component contains information extracted from the Electron Microscopy
 ;;^UTILITY(U,$J,"PRO",3726,1,2,0)
 ;;=module of the Lab package. Time and maximum occurrence limits apply. Data
 ;;^UTILITY(U,$J,"PRO",3726,1,3,0)
 ;;=presented include:  collection date/time, accession number, specimen,
 ;;^UTILITY(U,$J,"PRO",3726,1,4,0)
 ;;=gross description, microscopic exam, supplementary report description,
 ;;^UTILITY(U,$J,"PRO",3726,1,5,0)
 ;;=brief clinical history, and EM Diagnosis.
 ;;^UTILITY(U,$J,"PRO",3726,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3726,2,1,0)
 ;;=HS LAB ELECTRON MICROSCOPY
 ;;^UTILITY(U,$J,"PRO",3726,2,"B","HS LAB ELECTRON MICROSCOPY",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3726,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",3726,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3726,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="EM",GMTSTITL="Electron Microscopy" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3726,99)
 ;;=56434,65465
 ;;^UTILITY(U,$J,"PRO",3737,0)
 ;;=GMTS HF^Health Summary Health Factors^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3737,1,0)
 ;;=^^9^9^2950829^^^
 ;;^UTILITY(U,$J,"PRO",3737,1,1,0)
 ;;=This component lists all the health factors associated with a particular
 ;;^UTILITY(U,$J,"PRO",3737,1,2,0)
 ;;=patient for user-specified time and occurrence limits. The list will
 ;;^UTILITY(U,$J,"PRO",3737,1,3,0)
 ;;=display health factors by category and include a level of severity for
 ;;^UTILITY(U,$J,"PRO",3737,1,4,0)
 ;;=each health factor including Minimal(M), Moderate(MO), and
 ;;^UTILITY(U,$J,"PRO",3737,1,5,0)
 ;;=Heavy/Severe(H).
 ;;^UTILITY(U,$J,"PRO",3737,1,6,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",3737,1,7,0)
 ;;=Set the occurrence limit to 1 to list the latest unique health factors
 ;;^UTILITY(U,$J,"PRO",3737,1,8,0)
 ;;=within each category.  (E.g. If there were 12 "Non-Smoker" health factor
 ;;^UTILITY(U,$J,"PRO",3737,1,9,0)
 ;;=entries, only the latest "Non-Smoker" entry would display.)
 ;;^UTILITY(U,$J,"PRO",3737,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3737,2,1,0)
 ;;=HS PCE HEALTH FACTORS ALL
 ;;^UTILITY(U,$J,"PRO",3737,2,"B","HS PCE HEALTH FACTORS ALL",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3737,3,0)
 ;;=^101.03P^1^1
 ;;^UTILITY(U,$J,"PRO",3737,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3737,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="HF",GMTSTITL="Health Factors" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3737,99)
 ;;=56488,22285
 ;;^UTILITY(U,$J,"PRO",3738,0)
 ;;=GMTS OE^Health Summary Outpatient Encounter^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3738,1,0)
 ;;=^^5^5^2950829^^^^
 ;;^UTILITY(U,$J,"PRO",3738,1,1,0)
 ;;=This component lists outpatient diagnosis (ICD-9) and procedure (CPT) for a
