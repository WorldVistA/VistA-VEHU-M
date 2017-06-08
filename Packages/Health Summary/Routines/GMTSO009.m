GMTSO009 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1408,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1409,0)
 ;;=GMTS DS^Health Summary Disabilities^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1409,1,0)
 ;;=^^4^4^2910301^
 ;;^UTILITY(U,$J,"PRO",1409,1,1,0)
 ;;=This component provides information from the MAS package about a patient's 
 ;;^UTILITY(U,$J,"PRO",1409,1,2,0)
 ;;=eligibility code and eligibility status (Verified), and rated disabilities, 
 ;;^UTILITY(U,$J,"PRO",1409,1,3,0)
 ;;=including the disability percentage and whether the disability is service 
 ;;^UTILITY(U,$J,"PRO",1409,1,4,0)
 ;;=connected or non-service connected.  
 ;;^UTILITY(U,$J,"PRO",1409,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1409,2,2,0)
 ;;=HS MAS DISABILITIES
 ;;^UTILITY(U,$J,"PRO",1409,2,"B","HS MAS DISABILITIES",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1409,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1409,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1409,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="DS",GMTSTITL="DISABILITIES" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1409,99)
 ;;=56434,65465
 ;;^UTILITY(U,$J,"PRO",1410,0)
 ;;=GMTS DD^Health Summary Discharge Diagnosis^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1410,1,0)
 ;;=^^8^8^2910301^
 ;;^UTILITY(U,$J,"PRO",1410,1,1,0)
 ;;=This component contains information extracted from the MAS package.  Time and
 ;;^UTILITY(U,$J,"PRO",1410,1,2,0)
 ;;=occurrence limits apply to this component.  Data presented include: Date
 ;;^UTILITY(U,$J,"PRO",1410,1,3,0)
 ;;=range of admission through discharge, length of stay (LOS), Principal 
 ;;^UTILITY(U,$J,"PRO",1410,1,4,0)
 ;;=diagnosis, diagnosis for longest length of stay (DXLS), and secondary ICD
 ;;^UTILITY(U,$J,"PRO",1410,1,5,0)
 ;;=discharge diagnoses.  
 ;;^UTILITY(U,$J,"PRO",1410,1,6,0)
 ;;=  
 ;;^UTILITY(U,$J,"PRO",1410,1,7,0)
 ;;=Note: This component provides discharge diagnoses coded in the MAS PTF file.  
 ;;^UTILITY(U,$J,"PRO",1410,1,8,0)
 ;;=The occurrence limits are determined by the occurrence of admissions.  
 ;;^UTILITY(U,$J,"PRO",1410,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1410,2,2,0)
 ;;=HS MAS DISCHARGE DIAGNOSIS
 ;;^UTILITY(U,$J,"PRO",1410,2,"B","HS MAS DISCHARGE DIAGNOSIS",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1410,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1410,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1410,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="DD",GMTSTITL="DISCHARGE DIAGNOSIS" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1410,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1411,0)
 ;;=GMTS DC^Health Summary Discharges^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1411,1,0)
 ;;=^^6^6^2910301^
 ;;^UTILITY(U,$J,"PRO",1411,1,1,0)
 ;;=This component contains information extracted from the MAS package. Time and
 ;;^UTILITY(U,$J,"PRO",1411,1,2,0)
 ;;=occurrence limits apply to this component.  Data presented include:  date of
 ;;^UTILITY(U,$J,"PRO",1411,1,3,0)
 ;;=discharge, DXLS, bedsection, disposition type, disposition disposition place,
 ;;^UTILITY(U,$J,"PRO",1411,1,4,0)
 ;;=and outpatient treatment flag.  
 ;;^UTILITY(U,$J,"PRO",1411,1,5,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",1411,1,6,0)
 ;;=Note: The occurrence limits are determined by the occurrence of admissions.  
 ;;^UTILITY(U,$J,"PRO",1411,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1411,2,2,0)
 ;;=HS MAS DISCHARGES
 ;;^UTILITY(U,$J,"PRO",1411,2,"B","HS MAS DISCHARGES",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1411,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1411,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1411,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="DC",GMTSTITL="DISCHARGES" D ENCWA^GMTS
