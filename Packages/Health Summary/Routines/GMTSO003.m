GMTSO003 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1388,1,2,0)
 ;;=Component.  
 ;;^UTILITY(U,$J,"PRO",1388,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1388,2,2,0)
 ;;=HS COMPONENT INQUIRE
 ;;^UTILITY(U,$J,"PRO",1388,2,"B","HS COMPONENT INQUIRE",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1388,3,0)
 ;;=^101.03PA^0^0
 ;;^UTILITY(U,$J,"PRO",1388,20)
 ;;=W ! D ^GMTSCI S DIR(0)="E" D ^DIR
 ;;^UTILITY(U,$J,"PRO",1388,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1389,0)
 ;;=GMTS TYPE INQUIRE^Inquire about a Health Summary Type^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1389,20)
 ;;=W ! D ^GMTSRI W ! S DIR(0)="E" D ^DIR
 ;;^UTILITY(U,$J,"PRO",1389,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1390,0)
 ;;=GMTS BLO^Health Summary Brief Lab Orders^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1390,1,0)
 ;;=^^4^4^2910301^
 ;;^UTILITY(U,$J,"PRO",1390,1,1,0)
 ;;=This component contains information extracted from the Lab package.  Time and
 ;;^UTILITY(U,$J,"PRO",1390,1,2,0)
 ;;=maximum occurrence limits apply.Data presented include: collection date/time,
 ;;^UTILITY(U,$J,"PRO",1390,1,3,0)
 ;;=lab test name, specimen, urgency, and order status (e.g., ORDERED, COLLECTED,
 ;;^UTILITY(U,$J,"PRO",1390,1,4,0)
 ;;=PROCESSING, COMPLETE).  
 ;;^UTILITY(U,$J,"PRO",1390,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1390,2,1,0)
 ;;=HS LAB ORDERS BRIEF
 ;;^UTILITY(U,$J,"PRO",1390,2,"B","HS LAB ORDERS BRIEF",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1390,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1390,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1390,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="BLO",GMTSTITL="BRIEF LAB ORDERS" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1390,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1391,0)
 ;;=GMTS ADR^Health Summary Adverse Reactions/Allergies^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1391,1,0)
 ;;=^^3^3^2950513^^
 ;;^UTILITY(U,$J,"PRO",1391,1,1,0)
 ;;=This component contains information from MAS, Pharmacy, and Dietetics 
 ;;^UTILITY(U,$J,"PRO",1391,1,2,0)
 ;;=packages.  It provides a list of all known food, drug and environmental 
 ;;^UTILITY(U,$J,"PRO",1391,1,3,0)
 ;;=allergies or adverse reactions (e.g., hay fever).  
 ;;^UTILITY(U,$J,"PRO",1391,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1391,2,2,0)
 ;;=HS ADVERSE REACTIONS/ALLERGIES
 ;;^UTILITY(U,$J,"PRO",1391,2,3,0)
 ;;=ADR
 ;;^UTILITY(U,$J,"PRO",1391,2,"B","ADR",3)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1391,2,"B","HS ADVERSE REACTIONS/ALLERGIES",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1391,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1391,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1391,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="ADR",GMTSTITL="ADVERSE REACTIONS/ALLERGIES" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1391,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1392,0)
 ;;=GMTS CW^Health Summary Clinical Warnings^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1392,1,0)
 ;;=^^11^11^2910301^^
 ;;^UTILITY(U,$J,"PRO",1392,1,1,0)
 ;;=This component contains clinical warning notes entered using the Generic 
 ;;^UTILITY(U,$J,"PRO",1392,1,2,0)
 ;;=Progress Note package.  No time or maximum occurrence limits apply to this 
 ;;^UTILITY(U,$J,"PRO",1392,1,3,0)
 ;;=component.  
 ;;^UTILITY(U,$J,"PRO",1392,1,4,0)
 ;;=  
 ;;^UTILITY(U,$J,"PRO",1392,1,5,0)
 ;;=Clinical Warnings are a type of progress note which includes clinical 
 ;;^UTILITY(U,$J,"PRO",1392,1,6,0)
 ;;=information which clinicians need to be alerted to.  
 ;;^UTILITY(U,$J,"PRO",1392,1,7,0)
 ;;=   
 ;;^UTILITY(U,$J,"PRO",1392,1,8,0)
 ;;=If this component is printed out on a CRT, information will include title, 
 ;;^UTILITY(U,$J,"PRO",1392,1,9,0)
 ;;=text of note, electronic signature block, and date posted.  If the printout 
