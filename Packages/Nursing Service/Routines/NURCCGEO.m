NURCCGEO ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13578,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13578,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,13578,"TD",1,0)
 ;;=A state in which the individual experiences a limitation of ability
 ;;^UTILITY("^GMRD(124.2,",$J,13578,"TD",2,0)
 ;;=for independent physical movement.
 ;;^UTILITY("^GMRD(124.2,",$J,13579,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^181^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13579,1,0)
 ;;=^124.21PI^19^4
 ;;^UTILITY("^GMRD(124.2,",$J,13579,1,3,0)
 ;;=210^neuromuscular impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13579,1,7,0)
 ;;=1039^perceptual impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13579,1,14,0)
 ;;=1046^decrease strength and endurance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13579,1,19,0)
 ;;=159^cognitive limitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13579,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13599,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^179^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13599,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,13599,1,1,0)
 ;;=806^free from injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13599,1,2,0)
 ;;=807^maintains ROM in all joints^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13599,1,3,0)
 ;;=808^maintains independent ambulation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13599,1,4,0)
 ;;=13783^[Extra Goal]^3^NURSC^238
 ;;^UTILITY("^GMRD(124.2,",$J,13599,1,5,0)
 ;;=15261^demonstrates excercises to improve mobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13599,1,6,0)
 ;;=15262^adapts gait to wide base with arm swing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13599,1,7,0)
 ;;=15263^correctly uses adaptive equipment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13599,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13603,0)
 ;;=[Extra Goal]^3^NURSC^9^235^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13603,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13603,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13604,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^150^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13604,1,0)
 ;;=^124.21PI^15^14
 ;;^UTILITY("^GMRD(124.2,",$J,13604,1,1,0)
 ;;=13605^teach/reinforce exercise program & gait training^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,13604,1,2,0)
 ;;=810^assess risks if mobile^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13604,1,3,0)
 ;;=13607^prevent complications of immobility^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,13604,1,4,0)
 ;;=782^protect with restraints [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13604,1,5,0)
 ;;=13609^teach adaptive techniques for ADLs [specify]^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,13604,1,6,0)
 ;;=783^provide restraint care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13604,1,7,0)
 ;;=813^perimeter protection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13604,1,8,0)
 ;;=814^adjust environment as appropriate^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13604,1,9,0)
 ;;=13613^teach enviromental adjustments to maintain safety^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,13604,1,10,0)
 ;;=816^reposition/turn q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,13604,1,11,0)
 ;;=817^utilize devices [specify] to facilitate mobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13604,1,12,0)
 ;;=818^limit activities as set by medical protocols & as indicated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13604,1,14,0)
 ;;=14033^[Extra Order]^3^NURSC^246
 ;;^UTILITY("^GMRD(124.2,",$J,13604,1,15,0)
 ;;=781^provide physically safe environment^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13604,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13604,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13605,0)
 ;;=teach/reinforce exercise program & gait training^3^NURSC^11^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13605,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13605,10)
 ;;=D EN1^NURCCPU3
