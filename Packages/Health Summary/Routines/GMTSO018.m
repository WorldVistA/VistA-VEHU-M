GMTSO018 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",3718,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3718,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="MEDC",GMTSTITL="Med Full Captioned" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3718,99)
 ;;=56434,65465
 ;;^UTILITY(U,$J,"PRO",3719,0)
 ;;=GMTS MEDF^Health Summary Med Full Report^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3719,1,0)
 ;;=^^4^4^2950706^^^
 ;;^UTILITY(U,$J,"PRO",3719,1,1,0)
 ;;=This component provides a full report of procedures as defined by the
 ;;^UTILITY(U,$J,"PRO",3719,1,2,0)
 ;;=Medicine View file.  This report includes labels which have no value
 ;;^UTILITY(U,$J,"PRO",3719,1,3,0)
 ;;=associated with them.
 ;;^UTILITY(U,$J,"PRO",3719,1,4,0)
 ;;=Time and maximum occurence limits apply.
 ;;^UTILITY(U,$J,"PRO",3719,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3719,2,1,0)
 ;;=HS MEDICINE FULL REPORT
 ;;^UTILITY(U,$J,"PRO",3719,2,"B","HS MEDICINE FULL REPORT",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3719,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",3719,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3719,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="MEDF",GMTSTITL="Med Full Report" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3719,99)
 ;;=56434,65465
 ;;^UTILITY(U,$J,"PRO",3720,0)
 ;;=GMTS PLL^Health Summary All Problems^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3720,1,0)
 ;;=^^2^2^2950706^
 ;;^UTILITY(U,$J,"PRO",3720,1,1,0)
 ;;=This component lists all known problems, both active and inactive,
 ;;^UTILITY(U,$J,"PRO",3720,1,2,0)
 ;;=for a patient.
 ;;^UTILITY(U,$J,"PRO",3720,1,3,0)
 ;;=based upon ICD Text Display parameter, provider narrative unless Provider
 ;;^UTILITY(U,$J,"PRO",3720,1,4,0)
 ;;=Narrative Display parameter set to NO, date of onset if problem is active,
 ;;^UTILITY(U,$J,"PRO",3720,1,5,0)
 ;;=date problem resolved if inactive, date last modified, the responsible
 ;;^UTILITY(U,$J,"PRO",3720,1,6,0)
 ;;=provider, and all active comments for the problem.
 ;;^UTILITY(U,$J,"PRO",3720,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3720,2,1,0)
 ;;=HS PROBLEM LIST ALL
 ;;^UTILITY(U,$J,"PRO",3720,2,"B","HS PROBLEM LIST ALL",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3720,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",3720,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3720,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="PLL",GMTSTITL="All Problems" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3720,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",3721,0)
 ;;=GMTS PLA^Health Summary Active Problems^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",3721,1,0)
 ;;=^^1^1^2950706^
 ;;^UTILITY(U,$J,"PRO",3721,1,1,0)
 ;;=This component lists all known active problems for a patient.
 ;;^UTILITY(U,$J,"PRO",3721,1,2,0)
 ;;=display ICD data based up ICD Text Display parameter, provider narrative
 ;;^UTILITY(U,$J,"PRO",3721,1,3,0)
 ;;=unless Provider Narrative Display parameter set to NO, date of onset if
 ;;^UTILITY(U,$J,"PRO",3721,1,4,0)
 ;;=problem is active, date problem resolved if inactive, date last modified,
 ;;^UTILITY(U,$J,"PRO",3721,1,5,0)
 ;;=the responsible provider, and all active comments for the problem.
 ;;^UTILITY(U,$J,"PRO",3721,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",3721,2,1,0)
 ;;=HS PROBLEM LIST ACTIVE
 ;;^UTILITY(U,$J,"PRO",3721,2,"B","HS PROBLEM LIST ACTIVE",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",3721,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",3721,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",3721,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="PLA",GMTSTITL="Active Problems" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",3721,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",3722,0)
 ;;=GMTS PLI^Health Summary Inactive Problems^^A^^^^^^^^HEALTH SUMMARY
