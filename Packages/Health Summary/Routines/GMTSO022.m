GMTSO022 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",3742,0)
 ;;=GMTS LH^Health Summary Location of Home^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3742,1,0)
 ;;=^^1^1^2950829^
 ;;^UTILITY(U,$J,"PRO",3742,1,1,0)
 ;;=This component lists directions to a particular patient's home.
 ;;^UTILITY(U,$J,"PRO",3742,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3742,2,1,0)
 ;;=HS PCE LOCATION OF HOME
 ;;^UTILITY(U,$J,"PRO",3742,2,"B","HS PCE LOCATION OF HOME",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3742,3,0)
 ;;=^101.03P^1^1
 ;;^UTILITY(U,$J,"PRO",3742,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3742,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="LH",GMTSTITL="Location of Home" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3742,99)
 ;;=56488,22288
 ;;^UTILITY(U,$J,"PRO",3743,0)
 ;;=GMTS EDL^Health Summary Education Latest^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3743,1,0)
 ;;=^^6^6^2950829^
 ;;^UTILITY(U,$J,"PRO",3743,1,1,0)
 ;;=This component lists the latest patient education for each topic and a
 ;;^UTILITY(U,$J,"PRO",3743,1,2,0)
 ;;=brief assessment of the patient's understanding of the topic for a
 ;;^UTILITY(U,$J,"PRO",3743,1,3,0)
 ;;=particular patient for a user-specified time limit. Some examples of
 ;;^UTILITY(U,$J,"PRO",3743,1,4,0)
 ;;=topics are complications, diet, disease process, exercise, follow-up care,
 ;;^UTILITY(U,$J,"PRO",3743,1,5,0)
 ;;=general information, lifestyle adaptations, medications, nutrition,
 ;;^UTILITY(U,$J,"PRO",3743,1,6,0)
 ;;=smoking, etc.
 ;;^UTILITY(U,$J,"PRO",3743,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3743,2,1,0)
 ;;=HS PCE EDUCATION LATEST
 ;;^UTILITY(U,$J,"PRO",3743,2,"B","HS PCE EDUCATION LATEST",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3743,3,0)
 ;;=^101.03P^1^1
 ;;^UTILITY(U,$J,"PRO",3743,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3743,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="EDL",GMTSTITL="Education Latest" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3743,99)
 ;;=56488,22288
 ;;^UTILITY(U,$J,"PRO",3744,0)
 ;;=GMTS OD^Health Summary Outpatient Diagnosis^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3744,1,0)
 ;;=^^5^5^2950829^^^
 ;;^UTILITY(U,$J,"PRO",3744,1,1,0)
 ;;=This component lists outpatient diagnosis (ICD-9) for a particular patient.
 ;;^UTILITY(U,$J,"PRO",3744,1,2,0)
 ;;=The user can specify time and occurrence limits, whether hospital location
 ;;^UTILITY(U,$J,"PRO",3744,1,3,0)
 ;;=should be displayed or not, the format of ICD-9 data (e.g. code only, long
 ;;^UTILITY(U,$J,"PRO",3744,1,4,0)
 ;;=text, short text or no ICD-9 data), and whether the provider narrative
 ;;^UTILITY(U,$J,"PRO",3744,1,5,0)
 ;;=should be displayed or not.
 ;;^UTILITY(U,$J,"PRO",3744,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3744,2,1,0)
 ;;=HS PCE OUTPATIENT DIAGNOSIS
 ;;^UTILITY(U,$J,"PRO",3744,2,"B","HS PCE OUTPATIENT DIAGNOSIS",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3744,3,0)
 ;;=^101.03P^1^1
 ;;^UTILITY(U,$J,"PRO",3744,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3744,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="OD",GMTSTITL="Outpatient Diagnosis" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3744,99)
 ;;=56488,22289
 ;;^UTILITY(U,$J,"PRO",3745,0)
 ;;=GMTS EXAM^Health Summary Exams Latest^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3745,1,0)
 ;;=^^3^3^2950829^
 ;;^UTILITY(U,$J,"PRO",3745,1,1,0)
 ;;=This component lists the latest examination information and results for a
 ;;^UTILITY(U,$J,"PRO",3745,1,2,0)
 ;;=particular patient for a user-specified time limit. Some examples of exam
 ;;^UTILITY(U,$J,"PRO",3745,1,3,0)
 ;;=types are eye exams, ear exams, neurological exams, pelvis exams, etc.
 ;;^UTILITY(U,$J,"PRO",3745,2,0)
 ;;=^101.02A^1^1
