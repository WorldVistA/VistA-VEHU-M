GMTSO017 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",3715,1,10,0)
 ;;=discharged. Transfers included ward location and transfer facility.
 ;;^UTILITY(U,$J,"PRO",3715,1,11,0)
 ;;=Treating specialties includes Specialty Tranfers Diagnosis. Dicharges
 ;;^UTILITY(U,$J,"PRO",3715,1,12,0)
 ;;=include the data in the Discharge Diagnosis and Discharges components.
 ;;^UTILITY(U,$J,"PRO",3715,1,13,0)
 ;;=Following the data for each admission ICD Procedures, and ICD Surgeries
 ;;^UTILITY(U,$J,"PRO",3715,1,14,0)
 ;;=will be include if present.
 ;;^UTILITY(U,$J,"PRO",3715,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3715,2,1,0)
 ;;=HS MAS ADT HISTORY EXPANDED
 ;;^UTILITY(U,$J,"PRO",3715,2,"B","HS MAS ADT HISTORY EXPANDED",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3715,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",3715,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3715,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="EADT",GMTSTITL="ADT History Expanded" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3715,99)
 ;;=56434,65465
 ;;^UTILITY(U,$J,"PRO",3716,0)
 ;;=GMTS MEDA^Health Summary Med Abnormal^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3716,1,0)
 ;;=4^^4^4^2950706^^^^
 ;;^UTILITY(U,$J,"PRO",3716,1,1,0)
 ;;=This component contains information extracted from the Medicine
 ;;^UTILITY(U,$J,"PRO",3716,1,2,0)
 ;;=package.  Data presented include:  procedure date/time, medical
 ;;^UTILITY(U,$J,"PRO",3716,1,3,0)
 ;;=procedure name, and result (e.g., normal, abnormal, borderline).  
 ;;^UTILITY(U,$J,"PRO",3716,1,4,0)
 ;;=Time and maximum occurrence limits apply.
 ;;^UTILITY(U,$J,"PRO",3716,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3716,2,1,0)
 ;;=HS MEDICINE ABNORMAL BRIEF
 ;;^UTILITY(U,$J,"PRO",3716,2,"B","HS MEDICINE ABNORMAL BRIEF",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3716,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",3716,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3716,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="MEDA",GMTSTITL="Med Abnormal" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3716,99)
 ;;=56434,65465
 ;;^UTILITY(U,$J,"PRO",3717,0)
 ;;=GMTS MEDB^Health Summary Med Brief Report^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3717,1,0)
 ;;=^^3^3^2950706^^^
 ;;^UTILITY(U,$J,"PRO",3717,1,1,0)
 ;;=This is the brief procedure view defined by the Medicine View file.
 ;;^UTILITY(U,$J,"PRO",3717,1,2,0)
 ;;=This output can be managed by the local IRM staff.
 ;;^UTILITY(U,$J,"PRO",3717,1,3,0)
 ;;=Time and maximum occurrence limits apply.
 ;;^UTILITY(U,$J,"PRO",3717,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3717,2,1,0)
 ;;=HS MEDICINE BRIEF REPORT
 ;;^UTILITY(U,$J,"PRO",3717,2,"B","HS MEDICINE BRIEF REPORT",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3717,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",3717,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3717,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="MEDB",GMTSTITL="Med Brief Report" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3717,99)
 ;;=56434,65465
 ;;^UTILITY(U,$J,"PRO",3718,0)
 ;;=GMTS MEDC^Health Summary Med Full Captioned^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3718,1,0)
 ;;=^^4^4^2950706^^^^
 ;;^UTILITY(U,$J,"PRO",3718,1,1,0)
 ;;=This prints the full set of results which are present in
 ;;^UTILITY(U,$J,"PRO",3718,1,2,0)
 ;;=each procedure.  No labels will be included which have no
 ;;^UTILITY(U,$J,"PRO",3718,1,3,0)
 ;;=values associated with them.
 ;;^UTILITY(U,$J,"PRO",3718,1,4,0)
 ;;=Time and maximum occurrence limits apply.
 ;;^UTILITY(U,$J,"PRO",3718,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3718,2,1,0)
 ;;=HS MEDICINE FULL CAPTIONED
 ;;^UTILITY(U,$J,"PRO",3718,2,"B","HS MEDICINE FULL CAPTIONED",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3718,3,0)
 ;;=^101.03P^88^1
