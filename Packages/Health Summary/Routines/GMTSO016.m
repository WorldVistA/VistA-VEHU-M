GMTSO016 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",3712,0)
 ;;=GMTS CP^Health Summary Comp. & Pen. Exams^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3712,1,0)
 ;;=^^2^2^2950706^^^^
 ;;^UTILITY(U,$J,"PRO",3712,1,1,0)
 ;;=This component prints all compensation and pension exams for a given
 ;;^UTILITY(U,$J,"PRO",3712,1,2,0)
 ;;=patient by user-specified time and occurrence limits.
 ;;^UTILITY(U,$J,"PRO",3712,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3712,2,1,0)
 ;;=HS COMPENSATION AND PENSION EXAMS
 ;;^UTILITY(U,$J,"PRO",3712,2,"B","HS COMPENSATION AND PENSION EX",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3712,3,0)
 ;;=^101.03P^HS COMP LIST^1
 ;;^UTILITY(U,$J,"PRO",3712,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3712,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="CP",GMTSTITL="Comp. & Pen. Exams" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3712,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",3713,0)
 ;;=GMTS DCS^Health Summary Discharge Summary^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3713,1,0)
 ;;=^^2^2^2950706^
 ;;^UTILITY(U,$J,"PRO",3713,1,1,0)
 ;;=This component prints all discharge summaries (including report text) for
 ;;^UTILITY(U,$J,"PRO",3713,1,2,0)
 ;;=user-specified time and occurrence limits.
 ;;^UTILITY(U,$J,"PRO",3713,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3713,2,1,0)
 ;;=HS DISCHARGE SUMMARY
 ;;^UTILITY(U,$J,"PRO",3713,2,"B","HS DISCHARGE SUMMARY",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3713,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",3713,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3713,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="DCS",GMTSTITL="Discharge Summary" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3713,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",3714,0)
 ;;=GMTS BDS^Health Summary Brief Disch Summary^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3714,1,0)
 ;;=^^3^3^2950706^
 ;;^UTILITY(U,$J,"PRO",3714,1,1,0)
 ;;=This component prints the admission, discharge and cosignature dates, as
 ;;^UTILITY(U,$J,"PRO",3714,1,2,0)
 ;;=the dictating and approving provider names, and signature status of
 ;;^UTILITY(U,$J,"PRO",3714,1,3,0)
 ;;=all discharge summaries for user-specified time and occurrence limits.
 ;;^UTILITY(U,$J,"PRO",3714,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3714,2,1,0)
 ;;=HS DISCHARGE SUMMARY BRIEF
 ;;^UTILITY(U,$J,"PRO",3714,2,"B","HS DISCHARGE SUMMARY BRIEF",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3714,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",3714,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3714,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="BDS",GMTSTITL="Brief Disch Summary" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3714,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",3715,0)
 ;;=GMTS EADT^Health Summary ADT History Expanded^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3715,1,0)
 ;;=^^14^14^2950706^^^^
 ;;^UTILITY(U,$J,"PRO",3715,1,1,0)
 ;;=This component contains information extracted from the MAS package. It is
 ;;^UTILITY(U,$J,"PRO",3715,1,2,0)
 ;;=a consolidated view of all the MAS components. It can only be used with
 ;;^UTILITY(U,$J,"PRO",3715,1,3,0)
 ;;=MAS Version 5 and up.
 ;;^UTILITY(U,$J,"PRO",3715,1,4,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",3715,1,5,0)
 ;;=Time and maximum occurrence limits apply.  Data presented include patient
 ;;^UTILITY(U,$J,"PRO",3715,1,6,0)
 ;;=eligibility and rated disabilities. Movement data then follows with
 ;;^UTILITY(U,$J,"PRO",3715,1,7,0)
 ;;=movement date, movement type (ADM=Admission, TR=Transfer, TS= Treating
 ;;^UTILITY(U,$J,"PRO",3715,1,8,0)
 ;;=Specialty, DC=Discharge), movement description, specialty, and provider.
 ;;^UTILITY(U,$J,"PRO",3715,1,9,0)
 ;;=Admissions include the admission diagnosis if the patient hasn't been
