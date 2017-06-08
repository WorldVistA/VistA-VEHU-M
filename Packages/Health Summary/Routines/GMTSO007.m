GMTSO007 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1402,1,4,0)
 ;;=description and microscopic exam (both word processing fields), ICD
 ;;^UTILITY(U,$J,"PRO",1402,1,5,0)
 ;;=diagnoses, and SNOMED fields: topography, disease, morphology, etiology, and
 ;;^UTILITY(U,$J,"PRO",1402,1,6,0)
 ;;=procedures.  
 ;;^UTILITY(U,$J,"PRO",1402,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1402,2,2,0)
 ;;=HS LAB SURGICAL PATHOLOGY
 ;;^UTILITY(U,$J,"PRO",1402,2,"B","HS LAB SURGICAL PATHOLOGY",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1402,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1402,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1402,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="SP",GMTSTITL="SURGICAL PATHOLOGY" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1402,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1403,0)
 ;;=GMTS ADC^Health Summary Admissions/Discharges^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1403,1,0)
 ;;=^^5^5^2910301^
 ;;^UTILITY(U,$J,"PRO",1403,1,1,0)
 ;;=This component contains information from the MAS package.  Time and 
 ;;^UTILITY(U,$J,"PRO",1403,1,2,0)
 ;;=occurrence limits apply to this component.  Data presented include: date
 ;;^UTILITY(U,$J,"PRO",1403,1,3,0)
 ;;=range of admission, ward, length of stay (LOS), last treating specialty, last
 ;;^UTILITY(U,$J,"PRO",1403,1,4,0)
 ;;=provider, admitting diagnosis text, bedsection, principal diagnosis,
 ;;^UTILITY(U,$J,"PRO",1403,1,5,0)
 ;;=diagnosis for longest length of stay (DXLS), and seconary ICD diagnoses.  
 ;;^UTILITY(U,$J,"PRO",1403,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1403,2,2,0)
 ;;=HS MAS ADMISSIONS/DISCHARGES
 ;;^UTILITY(U,$J,"PRO",1403,2,"B","HS MAS ADMISSIONS/DISCHARGES",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1403,3,0)
 ;;=^101.03P^GMTS EM^1
 ;;^UTILITY(U,$J,"PRO",1403,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1403,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="ADC",GMTSTITL="ADMISSIONS/DISCHARGES" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1403,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1404,0)
 ;;=GMTS ADT^Health Summary ADT History^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1404,1,0)
 ;;=^^6^6^2910301^
 ;;^UTILITY(U,$J,"PRO",1404,1,1,0)
 ;;=This component contains information extracted from the MAS package.  It can
 ;;^UTILITY(U,$J,"PRO",1404,1,2,0)
 ;;=only be used with MAS Version 5 and up.  
 ;;^UTILITY(U,$J,"PRO",1404,1,3,0)
 ;;=  
 ;;^UTILITY(U,$J,"PRO",1404,1,4,0)
 ;;=Time and maximum occurrence limits apply.  Data presented include: movement
 ;;^UTILITY(U,$J,"PRO",1404,1,5,0)
 ;;=date, movement type (ADM=Admission, TR=Transfer, TS= Treating Specialty,
 ;;^UTILITY(U,$J,"PRO",1404,1,6,0)
 ;;=DC=Discharge), movement description, specialty, and provider.  
 ;;^UTILITY(U,$J,"PRO",1404,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1404,2,2,0)
 ;;=HS MAS ADT HISTORY
 ;;^UTILITY(U,$J,"PRO",1404,2,"B","HS MAS ADT HISTORY",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1404,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1404,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1404,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="ADT",GMTSTITL="ADT HISTORY" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1404,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1405,0)
 ;;=GMTS CVF^Health Summary Clinic Visits Future^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1405,1,0)
 ;;=^^3^3^2910301^
 ;;^UTILITY(U,$J,"PRO",1405,1,1,0)
 ;;=This component provides a listing from the MAS scheduling module that 
 ;;^UTILITY(U,$J,"PRO",1405,1,2,0)
 ;;=contains future clinic visit dates, the clinic visited, and the appointment
 ;;^UTILITY(U,$J,"PRO",1405,1,3,0)
 ;;=type.  
 ;;^UTILITY(U,$J,"PRO",1405,2,0)
 ;;=^101.02A^2^1
