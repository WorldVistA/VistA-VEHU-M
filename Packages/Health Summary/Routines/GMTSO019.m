GMTSO019 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",3722,1,0)
 ;;=^^1^1^2950706^
 ;;^UTILITY(U,$J,"PRO",3722,1,1,0)
 ;;=This component lists all known inactive problems for a patient.
 ;;^UTILITY(U,$J,"PRO",3722,1,2,0)
 ;;=display ICD data based upon ICD Text Display parameter, provider narrative
 ;;^UTILITY(U,$J,"PRO",3722,1,3,0)
 ;;=unless Provider Narrative Display parameter set to NO, date of onset if
 ;;^UTILITY(U,$J,"PRO",3722,1,4,0)
 ;;=problem is active, date problem resolved if inactive, date last modified,
 ;;^UTILITY(U,$J,"PRO",3722,1,5,0)
 ;;=the responsible provider, and all active comments for the problem.
 ;;^UTILITY(U,$J,"PRO",3722,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3722,2,1,0)
 ;;=HS PROBLEM LIST INACTIVE
 ;;^UTILITY(U,$J,"PRO",3722,2,"B","HS PROBLEM LIST INACTIVE",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3722,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",3722,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3722,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="PLI",GMTSTITL="Inactive Problems" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3722,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",3723,0)
 ;;=GMTS MHPE^Health Summary MH Physical Exam^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3723,1,0)
 ;;=^^4^4^2950706^^^^
 ;;^UTILITY(U,$J,"PRO",3723,1,1,0)
 ;;=The Mental Health Physical Exam component contains the results of the
 ;;^UTILITY(U,$J,"PRO",3723,1,2,0)
 ;;=physical examintation concerning patient's overall condition 
 ;;^UTILITY(U,$J,"PRO",3723,1,3,0)
 ;;=associated with the systems identified. This data is being extracted
 ;;^UTILITY(U,$J,"PRO",3723,1,4,0)
 ;;=from the Medical Record (# 90) file.
 ;;^UTILITY(U,$J,"PRO",3723,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3723,2,1,0)
 ;;=HS MENTAL HEALTH PHYSICAL EXAM
 ;;^UTILITY(U,$J,"PRO",3723,2,"B","HS MENTAL HEALTH PHYSICAL EXAM",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3723,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",3723,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3723,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="MHPE",GMTSTITL="MH Physical Exam" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3723,99)
 ;;=56434,65465
 ;;^UTILITY(U,$J,"PRO",3724,0)
 ;;=GMTS SW^Health Summary Social Work^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3724,1,0)
 ;;=^^3^3^2950706^
 ;;^UTILITY(U,$J,"PRO",3724,1,1,0)
 ;;=This component provides information from the Social Work package about a
 ;;^UTILITY(U,$J,"PRO",3724,1,2,0)
 ;;=patient's Social/Family Relationship, Current Substance Abuse Problems,
 ;;^UTILITY(U,$J,"PRO",3724,1,3,0)
 ;;=and Psycho-Social Assessment.
 ;;^UTILITY(U,$J,"PRO",3724,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3724,2,1,0)
 ;;=HS SOCIAL WORK
 ;;^UTILITY(U,$J,"PRO",3724,2,"B","HS SOCIAL WORK",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3724,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",3724,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3724,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="SW",GMTSTITL="Social Work" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3724,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",3725,0)
 ;;=GMTS CD^Health Summary Advance Directive^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3725,1,0)
 ;;=^^10^10^2950706^^^^
 ;;^UTILITY(U,$J,"PRO",3725,1,1,0)
 ;;=This component contains advance directive
 ;;^UTILITY(U,$J,"PRO",3725,1,2,0)
 ;;=notes entered using the Generic Progress Note package.
 ;;^UTILITY(U,$J,"PRO",3725,1,3,0)
 ;;=Time and maximum occurrent limits apply to this component.
 ;;^UTILITY(U,$J,"PRO",3725,1,4,0)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3725,1,5,0)
 ;;=Advance Directives are a type a progress note which includes
 ;;^UTILITY(U,$J,"PRO",3725,1,6,0)
 ;;=clinical information that clinicians need to be alerted to.
