NURCCG10 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,359,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,359,1,1,0)
 ;;=1496^Etiology/Related and/or Risk Factors^2^NURSC^38^0
 ;;^UTILITY("^GMRD(124.2,",$J,359,1,2,0)
 ;;=1497^Goals/Expected Outcomes^2^NURSC^37^0
 ;;^UTILITY("^GMRD(124.2,",$J,359,1,3,0)
 ;;=1498^Nursing Intervention/Orders^2^NURSC^34^0
 ;;^UTILITY("^GMRD(124.2,",$J,359,1,4,0)
 ;;=1499^Related Problems^2^NURSC^28^0
 ;;^UTILITY("^GMRD(124.2,",$J,359,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,359,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,359,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,359,"TD",0)
 ;;=^^2^2^2890428^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,359,"TD",1,0)
 ;;=The state in which an individual is at increased risk for being invaded
 ;;^UTILITY("^GMRD(124.2,",$J,359,"TD",2,0)
 ;;=by pathogenic organisms.
 ;;^UTILITY("^GMRD(124.2,",$J,360,0)
 ;;=Oral Mucous Membrane, Alteration In^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,360,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,360,1,1,0)
 ;;=1684^Etiology/Related and/or Risk Factors^2^NURSC^45^0
 ;;^UTILITY("^GMRD(124.2,",$J,360,1,2,0)
 ;;=1685^Goals/Expected Outcomes^2^NURSC^44^0
 ;;^UTILITY("^GMRD(124.2,",$J,360,1,3,0)
 ;;=1688^Nursing Intervention/Orders^2^NURSC^40^0
 ;;^UTILITY("^GMRD(124.2,",$J,360,1,4,0)
 ;;=1689^Related Problems^2^NURSC^33^0
 ;;^UTILITY("^GMRD(124.2,",$J,360,1,5,0)
 ;;=5185^Defining Characteristics^2^NURSC^62
 ;;^UTILITY("^GMRD(124.2,",$J,360,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,360,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,360,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,360,"TD",0)
 ;;=^^2^2^2910821^^^
 ;;^UTILITY("^GMRD(124.2,",$J,360,"TD",1,0)
 ;;=The state in which an individual experiences disruptions in the tissue
 ;;^UTILITY("^GMRD(124.2,",$J,360,"TD",2,0)
 ;;=layers of the oral cavity.
 ;;^UTILITY("^GMRD(124.2,",$J,361,0)
 ;;=Skin Integrity, Impairment Of (Actual)^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,361,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,361,1,1,0)
 ;;=1760^Etiology/Related and/or Risk Factors^2^NURSC^47^0
 ;;^UTILITY("^GMRD(124.2,",$J,361,1,2,0)
 ;;=1762^Goals/Expected Outcomes^2^NURSC^45^0
 ;;^UTILITY("^GMRD(124.2,",$J,361,1,3,0)
 ;;=1763^Nursing Intervention/Orders^2^NURSC^42^0
 ;;^UTILITY("^GMRD(124.2,",$J,361,1,4,0)
 ;;=1764^Related Problems^2^NURSC^34^0
 ;;^UTILITY("^GMRD(124.2,",$J,361,1,5,0)
 ;;=4231^Defining Characteristics^2^NURSC^38
 ;;^UTILITY("^GMRD(124.2,",$J,361,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,361,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,361,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,361,"TD",0)
 ;;=^^1^1^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,361,"TD",1,0)
 ;;=A state in which the individual's skin is adversely altered.
 ;;^UTILITY("^GMRD(124.2,",$J,362,0)
 ;;=Skin Integrity, Impairment Of (Potential)^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,362,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,362,1,1,0)
 ;;=828^Etiology/Related and/or Risk Factors^2^NURSC^19^0
 ;;^UTILITY("^GMRD(124.2,",$J,362,1,2,0)
 ;;=830^Goals/Expected Outcomes^2^NURSC^18^0
 ;;^UTILITY("^GMRD(124.2,",$J,362,1,3,0)
 ;;=831^Nursing Intervention/Orders^2^NURSC^15^0
 ;;^UTILITY("^GMRD(124.2,",$J,362,1,4,0)
 ;;=832^Related Problems^2^NURSC^15^0
 ;;^UTILITY("^GMRD(124.2,",$J,362,1,5,0)
 ;;=4222^Defining Characteristics^2^NURSC^35
 ;;^UTILITY("^GMRD(124.2,",$J,362,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,362,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,362,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,362,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,362,"TD",1,0)
 ;;=A state in which the individual's skin is at risk of being adversely
 ;;^UTILITY("^GMRD(124.2,",$J,362,"TD",2,0)
 ;;=altered.
