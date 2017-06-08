GMTSO012 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1417,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="ORC",GMTSTITL="ORDERS CURRENT" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1417,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1418,0)
 ;;=GMTS RXIV^Health Summary Intravenous Pharmacy^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1418,1,0)
 ;;=^^7^7^2910301^
 ;;^UTILITY(U,$J,"PRO",1418,1,1,0)
 ;;=This component contains IV orders extracted from the Pharmacy package.  Only
 ;;^UTILITY(U,$J,"PRO",1418,1,2,0)
 ;;=time limits apply.  Data presented include:  start date, stop date, drug
 ;;^UTILITY(U,$J,"PRO",1418,1,3,0)
 ;;=(additives), dose, status, solutions and infusion rates.  
 ;;^UTILITY(U,$J,"PRO",1418,1,4,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",1418,1,5,0)
 ;;=Note: If no time limit is defined, only active IV orders are reported.  If a
 ;;^UTILITY(U,$J,"PRO",1418,1,6,0)
 ;;=time limit is defined, all IV orders which have an expiration or cancel date
 ;;^UTILITY(U,$J,"PRO",1418,1,7,0)
 ;;=within the time limit range are reported.  
 ;;^UTILITY(U,$J,"PRO",1418,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1418,2,2,0)
 ;;=HS PHARMACY INTRAVENOUS
 ;;^UTILITY(U,$J,"PRO",1418,2,"B","HS PHARMACY INTRAVENOUS",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1418,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1418,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1418,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="RXIV",GMTSTITL="INTRAVENOUS PHARMACY" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1418,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1419,0)
 ;;=GMTS RXOP^Health Summary Outpatient Pharmacy^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1419,1,0)
 ;;=^^9^9^2910301^
 ;;^UTILITY(U,$J,"PRO",1419,1,1,0)
 ;;=This component contains information from the Outpatient Pharmacy package.  
 ;;^UTILITY(U,$J,"PRO",1419,1,2,0)
 ;;=Only time limits apply.  Data presented include:  drug, prescription number, 
 ;;^UTILITY(U,$J,"PRO",1419,1,3,0)
 ;;=status expiration/cancellation date (when appropriate), quantity, issue date,
 ;;^UTILITY(U,$J,"PRO",1419,1,4,0)
 ;;=last fill date, refills remaining, provider, and cost/fill (when available).  
 ;;^UTILITY(U,$J,"PRO",1419,1,5,0)
 ;;=  
 ;;^UTILITY(U,$J,"PRO",1419,1,6,0)
 ;;=Note: This component is formatted similar to the Short Medication Profile.  
 ;;^UTILITY(U,$J,"PRO",1419,1,7,0)
 ;;=If no time limit is defined, all orders are reported.  When a time limit is
 ;;^UTILITY(U,$J,"PRO",1419,1,8,0)
 ;;=defined, all outpatient pharmacy orders which have an expiration or cancel
 ;;^UTILITY(U,$J,"PRO",1419,1,9,0)
 ;;=date within the time limit range are reported.  
 ;;^UTILITY(U,$J,"PRO",1419,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1419,2,2,0)
 ;;=HS PHARMACY OUTPATIENT
 ;;^UTILITY(U,$J,"PRO",1419,2,"B","HS PHARMACY OUTPATIENT",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1419,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1419,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1419,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="RXOP",GMTSTITL="OUTPATIENT PHARMACY" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1419,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1420,0)
 ;;=GMTS RXUD^Health Summary Unit Dose Pharmacy^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1420,1,0)
 ;;=^^8^8^2910301^
 ;;^UTILITY(U,$J,"PRO",1420,1,1,0)
 ;;=This component contains Unit Dose information extracted from the Pharmacy 
 ;;^UTILITY(U,$J,"PRO",1420,1,2,0)
 ;;=package.  Only time limits apply.  Data presented include:  Drug, dose, 
 ;;^UTILITY(U,$J,"PRO",1420,1,3,0)
 ;;=pharmacy status, start date, stop date, and sig (which includes schedule 
 ;;^UTILITY(U,$J,"PRO",1420,1,4,0)
 ;;=instructions and route).  
