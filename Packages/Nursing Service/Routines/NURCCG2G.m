NURCCG2G ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,748,1,4,0)
 ;;=2205^Nursing Intervention/Orders^2^NURSC^54^0
 ;;^UTILITY("^GMRD(124.2,",$J,748,1,5,0)
 ;;=4035^Defining Characteristics^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,748,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,748,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,748,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,748,"TD",0)
 ;;=^^2^2^2900607^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,748,"TD",1,0)
 ;;=A state in which an individual experiences behaviors that can be
 ;;^UTILITY("^GMRD(124.2,",$J,748,"TD",2,0)
 ;;=physically harmful to others.
 ;;^UTILITY("^GMRD(124.2,",$J,749,0)
 ;;=Social Isolation^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,749,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,749,1,1,0)
 ;;=2216^Etiology/Related and/or Risk Factors^2^NURSC^60^0
 ;;^UTILITY("^GMRD(124.2,",$J,749,1,2,0)
 ;;=2240^Related Problems^2^NURSC^48^0
 ;;^UTILITY("^GMRD(124.2,",$J,749,1,3,0)
 ;;=2245^Goals/Expected Outcomes^2^NURSC^60^0
 ;;^UTILITY("^GMRD(124.2,",$J,749,1,4,0)
 ;;=2272^Nursing Intervention/Orders^2^NURSC^169^0
 ;;^UTILITY("^GMRD(124.2,",$J,749,1,5,0)
 ;;=4257^Defining Characteristics^2^NURSC^44
 ;;^UTILITY("^GMRD(124.2,",$J,749,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,749,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,749,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,749,"TD",0)
 ;;=^^2^2^2890309^^
 ;;^UTILITY("^GMRD(124.2,",$J,749,"TD",1,0)
 ;;=Condition of aloneness experienced by the individual and perceived as
 ;;^UTILITY("^GMRD(124.2,",$J,749,"TD",2,0)
 ;;=imposed by others and as a negative or threatened state.
 ;;^UTILITY("^GMRD(124.2,",$J,750,0)
 ;;=Social Interaction, Impaired^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,750,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,750,1,1,0)
 ;;=2218^Etiology/Related and/or Risk Factors^2^NURSC^61^0
 ;;^UTILITY("^GMRD(124.2,",$J,750,1,2,0)
 ;;=2219^Goals/Expected Outcomes^2^NURSC^59^0
 ;;^UTILITY("^GMRD(124.2,",$J,750,1,3,0)
 ;;=2220^Nursing Intervention/Orders^2^NURSC^55^0
 ;;^UTILITY("^GMRD(124.2,",$J,750,1,4,0)
 ;;=2221^Related Problems^2^NURSC^47^0
 ;;^UTILITY("^GMRD(124.2,",$J,750,1,5,0)
 ;;=4250^Defining Characteristics^2^NURSC^42
 ;;^UTILITY("^GMRD(124.2,",$J,750,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,750,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,750,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,750,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,750,"TD",1,0)
 ;;=The state in which an individual participates in an insufficient
 ;;^UTILITY("^GMRD(124.2,",$J,750,"TD",2,0)
 ;;=quantity or quality of social exchange.
 ;;^UTILITY("^GMRD(124.2,",$J,751,0)
 ;;=Family Processes, Alteration in^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,751,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,751,1,1,0)
 ;;=2250^Etiology/Related and/or Risk Factors^2^NURSC^62^0
 ;;^UTILITY("^GMRD(124.2,",$J,751,1,2,0)
 ;;=2251^Goals/Expected Outcomes^2^NURSC^61^0
 ;;^UTILITY("^GMRD(124.2,",$J,751,1,3,0)
 ;;=2252^Nursing Intervention/Orders^2^NURSC^56^0
 ;;^UTILITY("^GMRD(124.2,",$J,751,1,4,0)
 ;;=2253^Related Problems^2^NURSC^49^0
 ;;^UTILITY("^GMRD(124.2,",$J,751,1,5,0)
 ;;=4170^Defining Characteristics^2^NURSC^26
 ;;^UTILITY("^GMRD(124.2,",$J,751,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,751,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,751,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,751,"TD",0)
 ;;=^^2^2^2890803^^
 ;;^UTILITY("^GMRD(124.2,",$J,751,"TD",1,0)
 ;;=The state in which a family that normally functions effectively
 ;;^UTILITY("^GMRD(124.2,",$J,751,"TD",2,0)
 ;;=experiences a dysfunction.
 ;;^UTILITY("^GMRD(124.2,",$J,752,0)
 ;;=Diversional Activity Deficit^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,752,1,0)
 ;;=^124.21PI^5^5
