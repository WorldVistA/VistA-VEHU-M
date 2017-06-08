NURCCG2H ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,752,1,1,0)
 ;;=1909^Etiology/Related and/or Risk Factors^2^NURSC^51^0
 ;;^UTILITY("^GMRD(124.2,",$J,752,1,2,0)
 ;;=1910^Related Problems^2^NURSC^39^0
 ;;^UTILITY("^GMRD(124.2,",$J,752,1,3,0)
 ;;=1911^Goals/Expected Outcomes^2^NURSC^50^0
 ;;^UTILITY("^GMRD(124.2,",$J,752,1,4,0)
 ;;=1923^Nursing Intervention/Orders^2^NURSC^46^0
 ;;^UTILITY("^GMRD(124.2,",$J,752,1,5,0)
 ;;=4164^Defining Characteristics^2^NURSC^25
 ;;^UTILITY("^GMRD(124.2,",$J,752,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,752,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,752,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,752,"TD",0)
 ;;=^^2^2^2890823^^^
 ;;^UTILITY("^GMRD(124.2,",$J,752,"TD",1,0)
 ;;=The state in which an individual experiences a decreased stimulation
 ;;^UTILITY("^GMRD(124.2,",$J,752,"TD",2,0)
 ;;=from or interest or engagement in recreational or leisure activites.
 ;;^UTILITY("^GMRD(124.2,",$J,753,0)
 ;;=Thought Processes, Alteration In^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,753,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,753,1,1,0)
 ;;=2168^Etiology/Related and/or Risk Factors^2^NURSC^58^0
 ;;^UTILITY("^GMRD(124.2,",$J,753,1,2,0)
 ;;=2172^Related Problems^2^NURSC^45^0
 ;;^UTILITY("^GMRD(124.2,",$J,753,1,3,0)
 ;;=2175^Goals/Expected Outcomes^2^NURSC^57^0
 ;;^UTILITY("^GMRD(124.2,",$J,753,1,4,0)
 ;;=2182^Nursing Intervention/Orders^2^NURSC^53^0
 ;;^UTILITY("^GMRD(124.2,",$J,753,1,5,0)
 ;;=4291^Defining Characteristics^2^NURSC^50
 ;;^UTILITY("^GMRD(124.2,",$J,753,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,753,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,753,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,753,"TD",0)
 ;;=^^2^2^2890308^^
 ;;^UTILITY("^GMRD(124.2,",$J,753,"TD",1,0)
 ;;=A state in which an individual expereiences a disruption in
 ;;^UTILITY("^GMRD(124.2,",$J,753,"TD",2,0)
 ;;=cognitive operations and activities.
 ;;^UTILITY("^GMRD(124.2,",$J,754,0)
 ;;=Ocular Disorders/Surgery^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,754,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,754,1,1,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,754,1,2,0)
 ;;=366^Pain, Chronic^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,754,1,3,0)
 ;;=371^Sensory-Perceptual, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,754,1,4,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,754,1,5,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^17^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,0)
 ;;=^124.21PI^20^20
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,1,0)
 ;;=758^individual/environment conditions which impose a risk^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,2,0)
 ;;=759^biological^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,3,0)
 ;;=903^chemical^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,4,0)
 ;;=760^developmental^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,5,0)
 ;;=761^physiologic^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,6,0)
 ;;=762^psychologic perception^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,7,0)
 ;;=763^people provider^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,8,0)
 ;;=765^loss of motor ability from disease/injury/aging/restraints^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,9,0)
 ;;=766^sensory loss from disease/injury/aging/restraints^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,10,0)
 ;;=767^cognitive deficit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,11,0)
 ;;=768^perceptual deficit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,12,0)
 ;;=769^adverse effects of chemicals/drugs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,13,0)
 ;;=645^knowledge deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,14,0)
 ;;=770^self-mutilation^3^NURSC^1^0
