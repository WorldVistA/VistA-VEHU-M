GMTSO008 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1405,2,2,0)
 ;;=HS MAS CLINIC VISITS FUTURE
 ;;^UTILITY(U,$J,"PRO",1405,2,"B","HS MAS CLINIC VISITS FUTURE",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1405,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1405,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1405,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="CVF",GMTSTITL="CLINIC VISITS FUTURE" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1405,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1406,0)
 ;;=GMTS CVP^Health Summary Clinic Visits Past^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1406,1,0)
 ;;=^^4^4^2910301^
 ;;^UTILITY(U,$J,"PRO",1406,1,1,0)
 ;;=This component contains information from the MAS scheduling module.  Time and
 ;;^UTILITY(U,$J,"PRO",1406,1,2,0)
 ;;=occurrence limits apply to this component.  Data presented include:  past
 ;;^UTILITY(U,$J,"PRO",1406,1,3,0)
 ;;=clinic visits, dates, and a visit status (e.g., NO SHOW, INPATIENT VISIT). 
 ;;^UTILITY(U,$J,"PRO",1406,1,4,0)
 ;;=Note: Cancellations are not shown.  
 ;;^UTILITY(U,$J,"PRO",1406,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1406,2,2,0)
 ;;=HS MAS CLINIC VISITS PAST
 ;;^UTILITY(U,$J,"PRO",1406,2,"B","HS MAS CLINIC VISITS PAST",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1406,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1406,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1406,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="CVP",GMTSTITL="CLINIC VISITS PAST" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1406,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1407,0)
 ;;=GMTS DEM^Health Summary Demographics^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1407,1,0)
 ;;=^^6^6^2910301^
 ;;^UTILITY(U,$J,"PRO",1407,1,1,0)
 ;;=This component contains the following patient demographic data (if available)
 ;;^UTILITY(U,$J,"PRO",1407,1,2,0)
 ;;=from the MAS package: address, phone, county, marital status, religion,
 ;;^UTILITY(U,$J,"PRO",1407,1,3,0)
 ;;=period of service, POW status (e.g., Y or N), branch of service, combat
 ;;^UTILITY(U,$J,"PRO",1407,1,4,0)
 ;;=status (e.g., Y or N), eligibility code, current (verified) eligibility
 ;;^UTILITY(U,$J,"PRO",1407,1,5,0)
 ;;=status, service connected %, eligible for care (e.g., Y or N), next of kin
 ;;^UTILITY(U,$J,"PRO",1407,1,6,0)
 ;;=(NOK), NOK phone number and address.  
 ;;^UTILITY(U,$J,"PRO",1407,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1407,2,2,0)
 ;;=HS MAS DEMOGRAPHICS
 ;;^UTILITY(U,$J,"PRO",1407,2,"B","HS MAS DEMOGRAPHICS",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1407,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1407,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1407,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="DEM",GMTSTITL="DEMOGRAPHICS" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1407,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1408,0)
 ;;=GMTS BDEM^Health Summary Brief Demographics^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1408,1,0)
 ;;=^^3^3^2910301^
 ;;^UTILITY(U,$J,"PRO",1408,1,1,0)
 ;;=This component contains information from the MAS package.  It provides brief
 ;;^UTILITY(U,$J,"PRO",1408,1,2,0)
 ;;=patient demographic information including:  address, phone number, and
 ;;^UTILITY(U,$J,"PRO",1408,1,3,0)
 ;;=eligibility code (e.g., service connected 50-100%).  
 ;;^UTILITY(U,$J,"PRO",1408,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1408,2,2,0)
 ;;=HS MAS DEMOGRAPHICS BRIEF
 ;;^UTILITY(U,$J,"PRO",1408,2,"B","HS MAS DEMOGRAPHICS BRIEF",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1408,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1408,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1408,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="BDEM",GMTSTITL="BRIEF DEMOGRAPHICS" D ENCWA^GMTS
