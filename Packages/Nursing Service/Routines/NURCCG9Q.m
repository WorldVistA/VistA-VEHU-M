NURCCG9Q ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5115,1,5,0)
 ;;=8108^Cardiac Output, Decreased (Electrical/Mechanical)^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5115,1,6,0)
 ;;=8261^[Extra Problem]^2^NURSC^20
 ;;^UTILITY("^GMRD(124.2,",$J,5116,0)
 ;;=[Extra Problem]^2^NURSC^2^9^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,5116,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,5116,1,1,0)
 ;;=5124^Etiology/Related and/or Risk Factors^2^NURSC^249
 ;;^UTILITY("^GMRD(124.2,",$J,5116,1,3,0)
 ;;=5134^Goals/Expected Outcomes^2^NURSC^256
 ;;^UTILITY("^GMRD(124.2,",$J,5116,1,4,0)
 ;;=5145^Nursing Intervention/Orders^2^NURSC^258
 ;;^UTILITY("^GMRD(124.2,",$J,5116,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5116,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5116,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5117,0)
 ;;=Tuberculosis^2^NURSC^8^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5117,1,0)
 ;;=^124.21IP^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,5117,1,1,0)
 ;;=14820^Airway Clearance, Ineffective^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,5117,1,2,0)
 ;;=14918^Breathing Pattern, Ineffective^2^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,5117,1,3,0)
 ;;=15013^Gas Exchange, Impaired^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,5117,1,4,0)
 ;;=15116^Infection Potential^2^NURSC^11
 ;;^UTILITY("^GMRD(124.2,",$J,5117,1,5,0)
 ;;=15189^Nutrition, Alteration in:(Less Than Required)^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,5117,1,6,0)
 ;;=15247^[Extra Problem]^2^NURSC^51
 ;;^UTILITY("^GMRD(124.2,",$J,5118,0)
 ;;=Depressive Neurosis^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5118,1,0)
 ;;=^124.21IP^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5118,1,1,0)
 ;;=13995^Depressive Behavior^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5118,1,2,0)
 ;;=14049^Violence Potential, Directed At Others^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5118,1,3,0)
 ;;=14176^[Extra Problem]^2^NURSC^37
 ;;^UTILITY("^GMRD(124.2,",$J,5119,0)
 ;;=Substance Abuse Withdrawal/Detoxification^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5119,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,5119,1,1,0)
 ;;=7418^Sensory/Perception Alteration due to Toxic Substance^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5119,1,2,0)
 ;;=10741^[Extra Problem]^2^NURSC^24
 ;;^UTILITY("^GMRD(124.2,",$J,5120,0)
 ;;=Post Traumatic Stress Disorder^2^NURSC^8^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5120,1,0)
 ;;=^124.21IP^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,5120,1,1,0)
 ;;=14060^Post Trauma Response^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5120,1,2,0)
 ;;=14194^[Extra Problem]^2^NURSC^38
 ;;^UTILITY("^GMRD(124.2,",$J,5121,0)
 ;;=Alcohol/Drug Dependency Rehabilitation^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5121,1,0)
 ;;=^124.21IP^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,5121,1,1,0)
 ;;=14245^Alcohol/Drug Dependency Rehabilitation^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5121,1,2,0)
 ;;=14413^[Extra Problem]^2^NURSC^39
 ;;^UTILITY("^GMRD(124.2,",$J,5122,0)
 ;;=Organic Disturbances^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5122,1,0)
 ;;=^124.21IP^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,5122,1,1,0)
 ;;=14469^Sensory-Perceptual, Alteration In^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5122,1,2,0)
 ;;=14564^[Extra Problem]^2^NURSC^40
 ;;^UTILITY("^GMRD(124.2,",$J,5123,0)
 ;;=[Extra Goal]^3^NURSC^9^302^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5123,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5123,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5124,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^249^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5124,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5124,1,1,0)
 ;;=5129^[etiology]^3^NURSC^33
 ;;^UTILITY("^GMRD(124.2,",$J,5124,1,2,0)
 ;;=5131^[etiology]^3^NURSC^34
 ;;^UTILITY("^GMRD(124.2,",$J,5124,1,3,0)
 ;;=5341^[etiology]^3^NURSC^130
