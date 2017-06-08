NURCCGE1 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12446,0)
 ;;=reported/observed lack of food^3^NURSC^^6^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12447,0)
 ;;=sore/inflammed bucal cavity^3^NURSC^^6^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12448,0)
 ;;=lack of interest in food^3^NURSC^^6^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12451,0)
 ;;=[Extra Goal]^3^NURSC^9^200^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12451,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12451,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12474,0)
 ;;=[Extra Order]^3^NURSC^11^203^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12474,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12474,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12475,0)
 ;;=Related Problems^2^NURSC^7^144^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12475,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,12475,1,1,0)
 ;;=819^skin integrity, impairment of^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12475,1,2,0)
 ;;=820^tissue perfusion, alteration in ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12475,1,3,0)
 ;;=821^gas exchange, impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12475,1,4,0)
 ;;=822^constipation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12475,1,5,0)
 ;;=823^injury, potential for^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12475,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,12475,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12481,0)
 ;;=Defining Characteristics^2^NURSC^12^144^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12481,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,12481,1,1,0)
 ;;=4337^decreased muscle strength,control and/or mass^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12481,1,2,0)
 ;;=4339^impaired coordination^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12481,1,3,0)
 ;;=4340^imposed restriction of movement including mechanical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12481,1,4,0)
 ;;=4341^limited range of motion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12481,1,5,0)
 ;;=1769^impaired physical mobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12481,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12488,0)
 ;;=Sensory-Perceptual, Alteration In^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12488,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,12488,1,1,0)
 ;;=12489^Etiology/Related and/or Risk Factors^2^NURSC^168
 ;;^UTILITY("^GMRD(124.2,",$J,12488,1,4,0)
 ;;=12588^Defining Characteristics^2^NURSC^145
 ;;^UTILITY("^GMRD(124.2,",$J,12488,1,5,0)
 ;;=15716^Goals/Expected Outcomes^2^NURSC^314
 ;;^UTILITY("^GMRD(124.2,",$J,12488,1,6,0)
 ;;=15727^Nursing Intervention/Orders^2^NURSC^316
 ;;^UTILITY("^GMRD(124.2,",$J,12488,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12488,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12488,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12488,"TD",0)
 ;;=^^3^3^2890302^^
 ;;^UTILITY("^GMRD(124.2,",$J,12488,"TD",1,0)
 ;;=A state in which an individual experiences a change in the amount of
 ;;^UTILITY("^GMRD(124.2,",$J,12488,"TD",2,0)
 ;;=patterning of incoming stimuli accompanied by a diminished, exaggerated,
 ;;^UTILITY("^GMRD(124.2,",$J,12488,"TD",3,0)
 ;;=distorted or impaired response to such stimuli.
 ;;^UTILITY("^GMRD(124.2,",$J,12489,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^168^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12489,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,12489,1,1,0)
 ;;=1319^altered sensory reception, transmission, and/or integration^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12489,1,2,0)
 ;;=1320^altered communication^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,12489,1,3,0)
 ;;=1321^neurologic disease, trauma, or deficit^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12489,1,4,0)
 ;;=1045^pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12489,1,5,0)
 ;;=1322^sleep deprivation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12489,1,6,0)
 ;;=1323^age related: visual, auditory, gustatory^3^NURSC^1
