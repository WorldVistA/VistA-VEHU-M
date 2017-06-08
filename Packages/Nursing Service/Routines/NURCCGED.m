NURCCGED ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13002,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13002,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13005,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^146^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13005,1,0)
 ;;=^124.21PI^17^4
 ;;^UTILITY("^GMRD(124.2,",$J,13005,1,13,0)
 ;;=13043^review disease process,medications,risk factors w/pt & SO^3^NURSC^14
 ;;^UTILITY("^GMRD(124.2,",$J,13005,1,15,0)
 ;;=13475^[Extra Order]^3^NURSC^239
 ;;^UTILITY("^GMRD(124.2,",$J,13005,1,16,0)
 ;;=15607^discuss importance of maintaining optimal health^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13005,1,17,0)
 ;;=15608^encourage wearing medical I.D. bracelet for seizure activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13005,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13005,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13024,0)
 ;;=instruct patient in post-operative eye care:^2^NURSC^11^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13024,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,13024,1,1,0)
 ;;=13190^avoid stooping,bending over,or lying on operative side^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13024,1,2,0)
 ;;=13405^avoid touching,squeezing or rubbing eye^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13024,1,3,0)
 ;;=13500^avoid straining on bowel movements^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13024,1,4,0)
 ;;=13575^report severe eye pain or irritation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13024,1,5,0)
 ;;=13680^[additional instructions]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13024,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13024,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13024,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13043,0)
 ;;=review disease process,medications,risk factors w/pt & SO^3^NURSC^11^14^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13043,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13043,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13052,0)
 ;;=[Extra Order]^3^NURSC^11^233^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13052,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13052,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13053,0)
 ;;=Airway Clearance, Ineffective^2^NURSC^2^5^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13053,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,13053,1,1,0)
 ;;=13054^Related Problems^2^NURSC^151
 ;;^UTILITY("^GMRD(124.2,",$J,13053,1,2,0)
 ;;=13060^Etiology/Related and/or Risk Factors^2^NURSC^175
 ;;^UTILITY("^GMRD(124.2,",$J,13053,1,3,0)
 ;;=13072^Goals/Expected Outcomes^2^NURSC^173
 ;;^UTILITY("^GMRD(124.2,",$J,13053,1,4,0)
 ;;=13090^Nursing Intervention/Orders^2^NURSC^147
 ;;^UTILITY("^GMRD(124.2,",$J,13053,1,6,0)
 ;;=13157^Defining Characteristics^2^NURSC^152
 ;;^UTILITY("^GMRD(124.2,",$J,13053,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13053,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13053,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13053,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,13053,"TD",1,0)
 ;;=A state in which an individual is unable to clear secretions or
 ;;^UTILITY("^GMRD(124.2,",$J,13053,"TD",2,0)
 ;;=obstructions from the respiratory tract to maintain airway patency.
 ;;^UTILITY("^GMRD(124.2,",$J,13054,0)
 ;;=Related Problems^2^NURSC^7^151^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13054,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,13054,1,1,0)
 ;;=2398^Breathing Pattern, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13054,1,2,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13054,1,3,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13054,1,4,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13054,5)
 ;;=see
