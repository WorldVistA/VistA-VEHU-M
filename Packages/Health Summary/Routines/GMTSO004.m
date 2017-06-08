GMTSO004 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1392,1,10,0)
 ;;=is to another device type, information will include electronic signature 
 ;;^UTILITY(U,$J,"PRO",1392,1,11,0)
 ;;=block and date posted to ensure security of information.  
 ;;^UTILITY(U,$J,"PRO",1392,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1392,2,1,0)
 ;;=HS CLINICAL WARNINGS
 ;;^UTILITY(U,$J,"PRO",1392,2,2,0)
 ;;=CW
 ;;^UTILITY(U,$J,"PRO",1392,2,"B","CW",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1392,2,"B","HS CLINICAL WARNINGS",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1392,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1392,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1392,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="CW",GMTSTITL="CLINICAL WARNINGS" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1392,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1393,0)
 ;;=GMTS CN^Health Summary Crisis Notes^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1393,1,0)
 ;;=^^10^10^2910301^
 ;;^UTILITY(U,$J,"PRO",1393,1,1,0)
 ;;=This component contains crisis notes entered using the Generic Progress Note
 ;;^UTILITY(U,$J,"PRO",1393,1,2,0)
 ;;=package.  No time or maximum occurrence limits apply to this component.  
 ;;^UTILITY(U,$J,"PRO",1393,1,3,0)
 ;;=  
 ;;^UTILITY(U,$J,"PRO",1393,1,4,0)
 ;;=Crisis Notes are a type of progress note which contains important information
 ;;^UTILITY(U,$J,"PRO",1393,1,5,0)
 ;;=for anyone who deals with a patient.  
 ;;^UTILITY(U,$J,"PRO",1393,1,6,0)
 ;;=  
 ;;^UTILITY(U,$J,"PRO",1393,1,7,0)
 ;;=If this component is printed out on a CRT, information will include title, 
 ;;^UTILITY(U,$J,"PRO",1393,1,8,0)
 ;;=text of note, electronic signature block, and date posted.  If the printout 
 ;;^UTILITY(U,$J,"PRO",1393,1,9,0)
 ;;=is to another device type, information will include electronic signature 
 ;;^UTILITY(U,$J,"PRO",1393,1,10,0)
 ;;=block and date posted to ensure security of information.  
 ;;^UTILITY(U,$J,"PRO",1393,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1393,2,1,0)
 ;;=HS CRISIS NOTES
 ;;^UTILITY(U,$J,"PRO",1393,2,2,0)
 ;;=CN
 ;;^UTILITY(U,$J,"PRO",1393,2,"B","CN",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1393,2,"B","HS CRISIS NOTES",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1393,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1393,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1393,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="CN",GMTSTITL="CRISIS NOTES" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1393,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1394,0)
 ;;=GMTS DIET^Health Summary Dietetics^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1394,1,0)
 ;;=^^8^8^2910301^
 ;;^UTILITY(U,$J,"PRO",1394,1,1,0)
 ;;=This component contains information from the Dietetics package.  Time and
 ;;^UTILITY(U,$J,"PRO",1394,1,2,0)
 ;;=occurrence limits apply to this component.  Data presented include: diet
 ;;^UTILITY(U,$J,"PRO",1394,1,3,0)
 ;;=orders, start/stop dates, type of service (tray, e.g.); nutritional status,
 ;;^UTILITY(U,$J,"PRO",1394,1,4,0)
 ;;=date assessed; supplemental feedings, start/stop dates; tube feedings,
 ;;^UTILITY(U,$J,"PRO",1394,1,5,0)
 ;;=start/stop dates, strength of product, quantity ordered, and daily dosages.  
 ;;^UTILITY(U,$J,"PRO",1394,1,6,0)
 ;;=  
 ;;^UTILITY(U,$J,"PRO",1394,1,7,0)
 ;;=Note:  When a time limit is selected, the data presented reflects orders 
 ;;^UTILITY(U,$J,"PRO",1394,1,8,0)
 ;;=initiated within the time period.  
 ;;^UTILITY(U,$J,"PRO",1394,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1394,2,1,0)
 ;;=HS DIETETICS
 ;;^UTILITY(U,$J,"PRO",1394,2,2,0)
 ;;=DI
 ;;^UTILITY(U,$J,"PRO",1394,2,"B","DI",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1394,2,"B","HS DIETETICS",1)
 ;;=
