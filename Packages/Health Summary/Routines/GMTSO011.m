GMTSO011 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1415,1,1,0)
 ;;=This component contains information extracted from the MAS package.  Time and
 ;;^UTILITY(U,$J,"PRO",1415,1,2,0)
 ;;=occurrence limits apply to this component.  Data presented include:  treating
 ;;^UTILITY(U,$J,"PRO",1415,1,3,0)
 ;;=specialty change date/time, new treating specialty, (admission date), and
 ;;^UTILITY(U,$J,"PRO",1415,1,4,0)
 ;;=provider.  
 ;;^UTILITY(U,$J,"PRO",1415,1,5,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",1415,1,6,0)
 ;;=Note: The occurrence limits are determined by the occurrence of admissions.  
 ;;^UTILITY(U,$J,"PRO",1415,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1415,2,2,0)
 ;;=HS MAS TREATING SPECIALTY
 ;;^UTILITY(U,$J,"PRO",1415,2,"B","HS MAS TREATING SPECIALTY",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1415,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1415,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1415,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="TS",GMTSTITL="TREATING SPECIALITY" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1415,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1416,0)
 ;;=GMTS MED^Health Summary Medicine^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1416,1,0)
 ;;=^^4^4^2910301^
 ;;^UTILITY(U,$J,"PRO",1416,1,1,0)
 ;;=This component contains information extracted from the Medicine package.  
 ;;^UTILITY(U,$J,"PRO",1416,1,2,0)
 ;;=Time and maximum occurrence limits apply.  Data presented include: procedure
 ;;^UTILITY(U,$J,"PRO",1416,1,3,0)
 ;;=date/time, medical procedure name, and result (e.g., normal, abnormal,
 ;;^UTILITY(U,$J,"PRO",1416,1,4,0)
 ;;=borderline).  Note: This component is a summary of procedure statuses.  
 ;;^UTILITY(U,$J,"PRO",1416,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1416,2,1,0)
 ;;=HS MEDICINE
 ;;^UTILITY(U,$J,"PRO",1416,2,"B","HS MEDICINE",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1416,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1416,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1416,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="MEDS",GMTSTITL="MEDICINE SUMMARY" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1416,99)
 ;;=56434,65465
 ;;^UTILITY(U,$J,"PRO",1417,0)
 ;;=GMTS ORC^Health Summary Orders Current^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1417,1,0)
 ;;=^^11^11^2910301^
 ;;^UTILITY(U,$J,"PRO",1417,1,1,0)
 ;;=This component contains current orders from the OE/RR package.  Since the  
 ;;^UTILITY(U,$J,"PRO",1417,1,2,0)
 ;;=OE/RR package integrates all orders for the ancillary services, the orders 
 ;;^UTILITY(U,$J,"PRO",1417,1,3,0)
 ;;=will be reported in most recent orders first sequence without concern for the
 ;;^UTILITY(U,$J,"PRO",1417,1,4,0)
 ;;=ancillary package the order originated from/for. Current orders are defined
 ;;^UTILITY(U,$J,"PRO",1417,1,5,0)
 ;;=as those orders with an OE/RR order status other than discontinued or
 ;;^UTILITY(U,$J,"PRO",1417,1,6,0)
 ;;=expired.  
 ;;^UTILITY(U,$J,"PRO",1417,1,7,0)
 ;;=  
 ;;^UTILITY(U,$J,"PRO",1417,1,8,0)
 ;;=The component information includes item ordered, OE/RR order status, start
 ;;^UTILITY(U,$J,"PRO",1417,1,9,0)
 ;;=date, and stop date. OE/RR order status abbreviations include "blank"=Active,
 ;;^UTILITY(U,$J,"PRO",1417,1,10,0)
 ;;="c"=Complete, "dc"=Discontinued, "e"= expired, "?"=Flagged, "h"=Hold,
 ;;^UTILITY(U,$J,"PRO",1417,1,11,0)
 ;;="i"=incomplete, "p"=pending, "s"=scheduled.  
 ;;^UTILITY(U,$J,"PRO",1417,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1417,2,1,0)
 ;;=HS ORDERS CURRENT
 ;;^UTILITY(U,$J,"PRO",1417,2,"B","HS ORDERS CURRENT",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1417,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1417,3,1,0)
 ;;=ORWARD
