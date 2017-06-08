NURCCGFH ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14463,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14463,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14469,0)
 ;;=Sensory-Perceptual, Alteration In^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14469,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,14469,1,1,0)
 ;;=14470^Etiology/Related and/or Risk Factors^2^NURSC^193
 ;;^UTILITY("^GMRD(124.2,",$J,14469,1,2,0)
 ;;=14482^Goals/Expected Outcomes^2^NURSC^190
 ;;^UTILITY("^GMRD(124.2,",$J,14469,1,3,0)
 ;;=14502^Nursing Intervention/Orders^2^NURSC^159
 ;;^UTILITY("^GMRD(124.2,",$J,14469,1,4,0)
 ;;=14550^Defining Characteristics^2^NURSC^170
 ;;^UTILITY("^GMRD(124.2,",$J,14469,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14469,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14469,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14469,"TD",0)
 ;;=^^3^3^2890302^^
 ;;^UTILITY("^GMRD(124.2,",$J,14469,"TD",1,0)
 ;;=A state in which an individual experiences a change in the amount of
 ;;^UTILITY("^GMRD(124.2,",$J,14469,"TD",2,0)
 ;;=patterning of incoming stimuli accompanied by a diminished, exaggerated,
 ;;^UTILITY("^GMRD(124.2,",$J,14469,"TD",3,0)
 ;;=distorted or impaired response to such stimuli.
 ;;^UTILITY("^GMRD(124.2,",$J,14470,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^193^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14470,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,14470,1,1,0)
 ;;=1319^altered sensory reception, transmission, and/or integration^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14470,1,2,0)
 ;;=1320^altered communication^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14470,1,3,0)
 ;;=1321^neurologic disease, trauma, or deficit^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14470,1,4,0)
 ;;=1045^pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14470,1,5,0)
 ;;=1322^sleep deprivation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14470,1,6,0)
 ;;=1323^age related: visual, auditory, gustatory^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14470,1,7,0)
 ;;=1324^disease of sensory end organs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14470,1,8,0)
 ;;=1325^peripheral neuropathy: age related^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14470,1,9,0)
 ;;=1326^diabetes (disease related)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14470,1,10,0)
 ;;=1327^alcohol (disease related)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14470,1,11,0)
 ;;=1328^vascular (disease related)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14470,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14482,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^190^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14482,1,0)
 ;;=^124.21PI^14^13
 ;;^UTILITY("^GMRD(124.2,",$J,14482,1,1,0)
 ;;=1329^supports autonomy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14482,1,3,0)
 ;;=1331^uses optimal pain control measures ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14482,1,4,0)
 ;;=2677^reduce isolation with assistive/adaptive devices [example]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14482,1,5,0)
 ;;=14492^participates in self care/health maintenance activities^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14482,1,6,0)
 ;;=14771^[Extra Goal]^3^NURSC^249
 ;;^UTILITY("^GMRD(124.2,",$J,14482,1,7,0)
 ;;=3156^increases self care ability [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14482,1,8,0)
 ;;=14495^attains/maintains orientation time,place,person,situation^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14482,1,9,0)
 ;;=14496^is maintained in/returns to a safe environment^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14482,1,10,0)
 ;;=3159^recognizes signs/symptoms of [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14482,1,11,0)
 ;;=3160^states interventions for complications of [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14482,1,12,0)
 ;;=14499^attends/participates in structured activities^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14482,1,13,0)
 ;;=3162^identifies support system/resources^3^NURSC^1
