GMTSO015 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1426,1,5,0)
 ;;=and text.  
 ;;^UTILITY(U,$J,"PRO",1426,1,6,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",1426,1,7,0)
 ;;=Only surgery reports which have been verified are reported.  
 ;;^UTILITY(U,$J,"PRO",1426,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1426,2,1,0)
 ;;=HS SURGERY REPORTS
 ;;^UTILITY(U,$J,"PRO",1426,2,"B","HS SURGERY REPORTS",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1426,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1426,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1426,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="SR",GMTSTITL="SURGERY REPORTS" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1426,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1427,0)
 ;;=GMTS BSR^Health Summary Brief Surgery Reports^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1427,1,0)
 ;;=^^3^3^2910301^
 ;;^UTILITY(U,$J,"PRO",1427,1,1,0)
 ;;=This component contains surgery report statuses extracted from the Surgery 
 ;;^UTILITY(U,$J,"PRO",1427,1,2,0)
 ;;=package.  Time and maximum occurrence limits apply.  Data presented include: 
 ;;^UTILITY(U,$J,"PRO",1427,1,3,0)
 ;;=surgery date, surgical procedure, and report status (e.g., COMPLETE).  
 ;;^UTILITY(U,$J,"PRO",1427,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1427,2,1,0)
 ;;=HS SURGERY REPORTS BRIEF
 ;;^UTILITY(U,$J,"PRO",1427,2,"B","HS SURGERY REPORTS BRIEF",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1427,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1427,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1427,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="BSR",GMTSTITL="BRIEF SURGERY REPORTS"
 ;;^UTILITY(U,$J,"PRO",1427,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1428,0)
 ;;=GMTS VS^Health Summary Vitals^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1428,1,0)
 ;;=^^4^4^2910301^
 ;;^UTILITY(U,$J,"PRO",1428,1,1,0)
 ;;=This component contains vital measurements extracted from the Vital Signs 
 ;;^UTILITY(U,$J,"PRO",1428,1,2,0)
 ;;=module of the Nursing package.  Time and maximum occurrence limits apply.  
 ;;^UTILITY(U,$J,"PRO",1428,1,3,0)
 ;;=Data presented include:  measurement date/time, blood pressure (as SBP/DBP), 
 ;;^UTILITY(U,$J,"PRO",1428,1,4,0)
 ;;=pulse, temperature, height, weight, and respiratory rate.  
 ;;^UTILITY(U,$J,"PRO",1428,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1428,2,2,0)
 ;;=HS VITAL SIGNS
 ;;^UTILITY(U,$J,"PRO",1428,2,"B","HS VITAL SIGNS",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1428,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1428,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1428,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="VS",GMTSTITL="VITAL SIGNS" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1428,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1429,0)
 ;;=GMTS COMP LIST^List Health Summary Components^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1429,1,0)
 ;;=^^2^2^2910301^
 ;;^UTILITY(U,$J,"PRO",1429,1,1,0)
 ;;=Lists all components which may be used to define Health Summary Types, along
 ;;^UTILITY(U,$J,"PRO",1429,1,2,0)
 ;;=with several component characteristics.
 ;;^UTILITY(U,$J,"PRO",1429,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1429,2,1,0)
 ;;=HS COMP LIST
 ;;^UTILITY(U,$J,"PRO",1429,2,"B","HS COMP LIST",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1429,20)
 ;;=W ! S DIC="^GMT(142.1,",L=0,FLDS="[GMTS COMP LIST]",BY=.01,FR="A",TO="zzzz" D EN1^DIP S DIR(0)="E" D ^DIR
 ;;^UTILITY(U,$J,"PRO",1429,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1430,0)
 ;;=GMTS TYPE LIST^List Health Summary Types^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1430,20)
 ;;=W ! S DIC="^GMT(142,",L=0,FLDS="[GMTS TYPE LIST]",BY=.01,FR="A",TO="zzzz" D EN1^DIP W ! S DIR(0)="E" D ^DIR
 ;;^UTILITY(U,$J,"PRO",1430,99)
 ;;=56434,65466
