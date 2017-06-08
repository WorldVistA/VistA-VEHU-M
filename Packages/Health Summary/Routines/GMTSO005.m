GMTSO005 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1394,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1394,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1394,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="DI",GMTSTITL="DIETETICS" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1394,99)
 ;;=56434,65465
 ;;^UTILITY(U,$J,"PRO",1396,0)
 ;;=GMTS BT^Health Summary Blood Transfusions^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1396,1,0)
 ;;=^^4^4^2910301^
 ;;^UTILITY(U,$J,"PRO",1396,1,1,0)
 ;;=This component contains information from the Blood Bank module of the Lab
 ;;^UTILITY(U,$J,"PRO",1396,1,2,0)
 ;;=Package.  Time and occurrence limits apply to this component.  Data presented
 ;;^UTILITY(U,$J,"PRO",1396,1,3,0)
 ;;=include:  transfusion date and abbreviated blood products (with total number
 ;;^UTILITY(U,$J,"PRO",1396,1,4,0)
 ;;=of units transfused for each, e.g., RBC (2)).  
 ;;^UTILITY(U,$J,"PRO",1396,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1396,2,2,0)
 ;;=HS LAB BLOOD TRANSFUSIONS
 ;;^UTILITY(U,$J,"PRO",1396,2,3,0)
 ;;=BT
 ;;^UTILITY(U,$J,"PRO",1396,2,"B","BT",3)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1396,2,"B","HS LAB BLOOD TRANSFUSIONS",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1396,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1396,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1396,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="BT",GMTSTITL="BLOOD TRANSFUSIONS" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1396,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1397,0)
 ;;=GMTS CH^Health Summary Chemistry & Hematology^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1397,1,0)
 ;;=^^4^4^2910301^
 ;;^UTILITY(U,$J,"PRO",1397,1,1,0)
 ;;=This component contains information extracted from the Lab package.  Time and
 ;;^UTILITY(U,$J,"PRO",1397,1,2,0)
 ;;=maximum occurrence limits apply to this component. Data presented include: 
 ;;^UTILITY(U,$J,"PRO",1397,1,3,0)
 ;;=collection date/time, specimen, test name, results (w/ref flag: 
 ;;^UTILITY(U,$J,"PRO",1397,1,4,0)
 ;;=High/Low/Critical), units, and Reference range.  
 ;;^UTILITY(U,$J,"PRO",1397,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1397,2,2,0)
 ;;=HS LAB CHEMISTRY & HEMATOLOGY
 ;;^UTILITY(U,$J,"PRO",1397,2,3,0)
 ;;=CH
 ;;^UTILITY(U,$J,"PRO",1397,2,"B","CH",3)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1397,2,"B","HS LAB CHEMISTRY & HEMATOLOGY",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1397,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1397,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1397,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="CH",GMTSTITL="CHEMISTRY & HEMATOLOGY" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1397,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1398,0)
 ;;=GMTS CY^Health Summary Cytopathology^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1398,1,0)
 ;;=^^5^5^2910301^
 ;;^UTILITY(U,$J,"PRO",1398,1,1,0)
 ;;=This component contains information extracted from the Cytopathology module
 ;;^UTILITY(U,$J,"PRO",1398,1,2,0)
 ;;=of the Lab package. Time and maximum occurrence limits apply.  Data presented
 ;;^UTILITY(U,$J,"PRO",1398,1,3,0)
 ;;=include:  collection date/time, accession number, specimen, gross description
 ;;^UTILITY(U,$J,"PRO",1398,1,4,0)
 ;;=and microscopic exam (both word processing fields), ICD diagnoses, and SNOMED
 ;;^UTILITY(U,$J,"PRO",1398,1,5,0)
 ;;=fields: topography, disease, morphology, etiology, and procedures.  
 ;;^UTILITY(U,$J,"PRO",1398,2,0)
 ;;=^101.02A^3^1
 ;;^UTILITY(U,$J,"PRO",1398,2,3,0)
 ;;=HS LAB CYTOPATHOLOGY
 ;;^UTILITY(U,$J,"PRO",1398,2,"B","HS LAB CYTOPATHOLOGY",3)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1398,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1398,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1398,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="CY",GMTSTITL="CYTOPATHOLOGY" D ENCWA^GMTS
