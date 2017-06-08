GMTSO006 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1398,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1399,0)
 ;;=GMTS MIC^Health Summary Microbiology^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1399,1,0)
 ;;=^^5^5^2910301^
 ;;^UTILITY(U,$J,"PRO",1399,1,1,0)
 ;;=This component contains information extracted from the Microbiology module of
 ;;^UTILITY(U,$J,"PRO",1399,1,2,0)
 ;;=the Lab Package.  Time and maximum occurrence limits apply. Data include: 
 ;;^UTILITY(U,$J,"PRO",1399,1,3,0)
 ;;=collection date/time, site/specimen, Parasite Report, organism(s), Mycology
 ;;^UTILITY(U,$J,"PRO",1399,1,4,0)
 ;;=Report, Bacteriology Report, Mycobacteriology Report, Gram Stain Result, and
 ;;^UTILITY(U,$J,"PRO",1399,1,5,0)
 ;;=remarks.  
 ;;^UTILITY(U,$J,"PRO",1399,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1399,2,2,0)
 ;;=HS LAB MICROBIOLOGY
 ;;^UTILITY(U,$J,"PRO",1399,2,"B","HS LAB MICROBIOLOGY",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1399,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1399,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1399,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="MIC",GMTSTITL="MICROBIOLOGY" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1399,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1400,0)
 ;;=GMTS BMIC^Health Summary Brief Microbiology^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1400,1,0)
 ;;=^^3^3^2910301^
 ;;^UTILITY(U,$J,"PRO",1400,1,1,0)
 ;;=This component contains information extracted from the Lab package.  Time and
 ;;^UTILITY(U,$J,"PRO",1400,1,2,0)
 ;;=maximum occurrence limits apply to this component in addition to collection
 ;;^UTILITY(U,$J,"PRO",1400,1,3,0)
 ;;=date/time, test name, specimen, report status, and test results.  
 ;;^UTILITY(U,$J,"PRO",1400,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1400,2,2,0)
 ;;=HS LAB MICROBIOLOGY BRIEF
 ;;^UTILITY(U,$J,"PRO",1400,2,"B","HS LAB MICROBIOLOGY BRIEF",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1400,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1400,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1400,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="BMIC",GMTSTITL="BRIEF MICROBIOLOGY" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1400,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1401,0)
 ;;=GMTS LO^Health Summary Lab Orders^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1401,1,0)
 ;;=^^4^4^2910301^
 ;;^UTILITY(U,$J,"PRO",1401,1,1,0)
 ;;=This component contains information extracted from the Lab package.  Time and
 ;;^UTILITY(U,$J,"PRO",1401,1,2,0)
 ;;=maximum occurrence limits apply. Data presented include: collection date
 ;;^UTILITY(U,$J,"PRO",1401,1,3,0)
 ;;=(either actual or expected), lab test, provider, accession, date/time
 ;;^UTILITY(U,$J,"PRO",1401,1,4,0)
 ;;=ordered, specimen, and date/time results available.  
 ;;^UTILITY(U,$J,"PRO",1401,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1401,2,1,0)
 ;;=HS LAB ORDERS
 ;;^UTILITY(U,$J,"PRO",1401,2,"B","HS LAB ORDERS",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1401,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1401,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1401,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="LO",GMTSTITL="LAB ORDERS" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1401,99)
 ;;=56434,65465
 ;;^UTILITY(U,$J,"PRO",1402,0)
 ;;=GMTS SP^Health Summary Surgical Pathology^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1402,1,0)
 ;;=^^6^6^2910301^
 ;;^UTILITY(U,$J,"PRO",1402,1,1,0)
 ;;=This component contains information extracted from the Surical Pathology 
 ;;^UTILITY(U,$J,"PRO",1402,1,2,0)
 ;;=module of the Lab package. Time and maximum occurrence limits apply.  Data
 ;;^UTILITY(U,$J,"PRO",1402,1,3,0)
 ;;=presented include:  collection date/time, accession number, specimen, gross
