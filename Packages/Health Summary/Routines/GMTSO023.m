GMTSO023 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",3745,2,1,0)
 ;;=HS PCE EXAMS LATEST
 ;;^UTILITY(U,$J,"PRO",3745,2,"B","HS PCE EXAMS LATEST",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3745,3,0)
 ;;=^101.03P^1^1
 ;;^UTILITY(U,$J,"PRO",3745,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3745,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="EXAM",GMTSTITL="Exams Latest" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3745,99)
 ;;=56488,22289
 ;;^UTILITY(U,$J,"PRO",3746,0)
 ;;=GMTS TP^Health Summary Treatments Provided^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3746,1,0)
 ;;=^^5^5^2950829^^
 ;;^UTILITY(U,$J,"PRO",3746,1,1,0)
 ;;=This component lists treatments provided that are not covered in the
 ;;^UTILITY(U,$J,"PRO",3746,1,2,0)
 ;;=IDC-9-CM procedures for a particular patient for user specified time and
 ;;^UTILITY(U,$J,"PRO",3746,1,3,0)
 ;;=occurrence limits. Some example of treatment types include nursing
 ;;^UTILITY(U,$J,"PRO",3746,1,4,0)
 ;;=activities such as ear irrigation, dental care instructions, or preventive
 ;;^UTILITY(U,$J,"PRO",3746,1,5,0)
 ;;=health care counseling.
 ;;^UTILITY(U,$J,"PRO",3746,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3746,2,1,0)
 ;;=HS PCE TREATMENTS PROVIDED
 ;;^UTILITY(U,$J,"PRO",3746,2,"B","HS PCE TREATMENTS PROVIDED",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3746,3,0)
 ;;=^101.03P^1^1
 ;;^UTILITY(U,$J,"PRO",3746,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3746,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="TP",GMTSTITL="Treatments Provided" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3746,99)
 ;;=56488,22290
 ;;^UTILITY(U,$J,"PRO",3747,0)
 ;;=GMTS BADR^Health Summary Brief Adv React/All^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3747,1,0)
 ;;=^^3^3^2950829^^
 ;;^UTILITY(U,$J,"PRO",3747,1,1,0)
 ;;=This component provides patient allergy/adverse reaction information from
 ;;^UTILITY(U,$J,"PRO",3747,1,2,0)
 ;;=the Allergy Tracking System. It provides a list of all known food, drug
 ;;^UTILITY(U,$J,"PRO",3747,1,3,0)
 ;;=and environmental allergies or adverse reactions (e.g., hay fever).
 ;;^UTILITY(U,$J,"PRO",3747,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3747,2,1,0)
 ;;=HS ADVERSE REACTIONS/ALLERG BRIEF
 ;;^UTILITY(U,$J,"PRO",3747,2,"B","HS ADVERSE REACTIONS/ALLERG BR",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3747,3,0)
 ;;=^101.03P^1^1
 ;;^UTILITY(U,$J,"PRO",3747,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3747,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="BADR",GMTSTITL="Brief Adv React/All" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3747,99)
 ;;=56488,22384
 ;;^UTILITY(U,$J,"PRO",3748,0)
 ;;=GMTS ED^Health Summary Education^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3748,1,0)
 ;;=^^6^6^2950829^^^
 ;;^UTILITY(U,$J,"PRO",3748,1,1,0)
 ;;=This component lists the patient education topics and a brief assessment
 ;;^UTILITY(U,$J,"PRO",3748,1,2,0)
 ;;=of the patient's understanding of the topic for a particular patient for
 ;;^UTILITY(U,$J,"PRO",3748,1,3,0)
 ;;=user-specified time and occurrence limits. Some examples of topics are
 ;;^UTILITY(U,$J,"PRO",3748,1,4,0)
 ;;=complications, diet, disease process, exercise, follow-up care, general
 ;;^UTILITY(U,$J,"PRO",3748,1,5,0)
 ;;=information, etc. lifestyle adaptations, medications, nutrition, smoking,
 ;;^UTILITY(U,$J,"PRO",3748,1,6,0)
 ;;=etc.
 ;;^UTILITY(U,$J,"PRO",3748,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3748,2,1,0)
 ;;=HS PCE EDUCATION
 ;;^UTILITY(U,$J,"PRO",3748,2,"B","HS PCE EDUCATION",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3748,3,0)
 ;;=^101.03P^1^1
 ;;^UTILITY(U,$J,"PRO",3748,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3748,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="ED",GMTSTITL="Education" D ENCWA^GMTS
