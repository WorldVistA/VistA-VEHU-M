NURCCG2F ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,744,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,744,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,744,"TD",1,0)
 ;;=Delayed or exaggerated response to a preceived actual or potential
 ;;^UTILITY("^GMRD(124.2,",$J,744,"TD",2,0)
 ;;=loss.
 ;;^UTILITY("^GMRD(124.2,",$J,745,0)
 ;;=Powerlessness^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,745,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,745,1,1,0)
 ;;=1930^Etiology/Related and/or Risk Factors^2^NURSC^52^0
 ;;^UTILITY("^GMRD(124.2,",$J,745,1,2,0)
 ;;=1935^Related Problems^2^NURSC^59^0
 ;;^UTILITY("^GMRD(124.2,",$J,745,1,3,0)
 ;;=1938^Goals/Expected Outcomes^2^NURSC^51^0
 ;;^UTILITY("^GMRD(124.2,",$J,745,1,4,0)
 ;;=1951^Nursing Intervention/Orders^2^NURSC^47^0
 ;;^UTILITY("^GMRD(124.2,",$J,745,1,5,0)
 ;;=4090^Defining Characteristics^2^NURSC^11
 ;;^UTILITY("^GMRD(124.2,",$J,745,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,745,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,745,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,745,"TD",0)
 ;;=^^3^3^2890301^^
 ;;^UTILITY("^GMRD(124.2,",$J,745,"TD",1,0)
 ;;=The perception of the individual that one's own action will not 
 ;;^UTILITY("^GMRD(124.2,",$J,745,"TD",2,0)
 ;;=significantly affect an outcome. Powerlessness is the perceived lack
 ;;^UTILITY("^GMRD(124.2,",$J,745,"TD",3,0)
 ;;=of control over a current situation or immediate happening.^
 ;;^UTILITY("^GMRD(124.2,",$J,746,0)
 ;;=Depressive Behavior^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,746,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,746,1,1,0)
 ;;=2337^Etiology/Related and/or Risk Factors^2^NURSC^65^0
 ;;^UTILITY("^GMRD(124.2,",$J,746,1,2,0)
 ;;=2339^Goals/Expected Outcomes^2^NURSC^64^0
 ;;^UTILITY("^GMRD(124.2,",$J,746,1,3,0)
 ;;=2341^Nursing Intervention/Orders^2^NURSC^59^0
 ;;^UTILITY("^GMRD(124.2,",$J,746,1,4,0)
 ;;=2342^Related Problems^2^NURSC^52^0
 ;;^UTILITY("^GMRD(124.2,",$J,746,1,5,0)
 ;;=4148^Defining Characteristics^2^NURSC^22
 ;;^UTILITY("^GMRD(124.2,",$J,746,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,746,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,746,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,746,"TD",0)
 ;;=^^2^2^2890307^^
 ;;^UTILITY("^GMRD(124.2,",$J,746,"TD",1,0)
 ;;=A universal mode of interacting manifested by sadness, poor self-concept,
 ;;^UTILITY("^GMRD(124.2,",$J,746,"TD",2,0)
 ;;=and inability to act for self; ranges from mild grief to a psychosis.
 ;;^UTILITY("^GMRD(124.2,",$J,747,0)
 ;;=Violence, Potential For, Self Directed^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,747,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,747,1,1,0)
 ;;=2184^Etiology/Related and/or Risk Factors^2^NURSC^59^0
 ;;^UTILITY("^GMRD(124.2,",$J,747,1,2,0)
 ;;=2196^Related Problems^2^NURSC^46^0
 ;;^UTILITY("^GMRD(124.2,",$J,747,1,3,0)
 ;;=2198^Goals/Expected Outcomes^2^NURSC^58^0
 ;;^UTILITY("^GMRD(124.2,",$J,747,1,4,0)
 ;;=2205^Nursing Intervention/Orders^2^NURSC^54^0
 ;;^UTILITY("^GMRD(124.2,",$J,747,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,747,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,747,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,747,"TD",0)
 ;;=^^2^2^2900607^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,747,"TD",1,0)
 ;;=A state in which an individual experiences behaviors that can be
 ;;^UTILITY("^GMRD(124.2,",$J,747,"TD",2,0)
 ;;=physically harmful to the self.
 ;;^UTILITY("^GMRD(124.2,",$J,748,0)
 ;;=Violence Potential, Directed At Others^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,748,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,748,1,1,0)
 ;;=2184^Etiology/Related and/or Risk Factors^2^NURSC^59^0
 ;;^UTILITY("^GMRD(124.2,",$J,748,1,2,0)
 ;;=2196^Related Problems^2^NURSC^46^0
 ;;^UTILITY("^GMRD(124.2,",$J,748,1,3,0)
 ;;=2198^Goals/Expected Outcomes^2^NURSC^58^0
