NURCCG8Z ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4765,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4766,0)
 ;;=vibrations q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4766,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4766,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4767,0)
 ;;=cough/turn/deep breathe q[specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4768,0)
 ;;=turn,cough,deep breath q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4768,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4768,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4769,0)
 ;;=[Extra Problem]^2^NURSC^2^44^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4769,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4769,1,1,0)
 ;;=4772^Etiology/Related and/or Risk Factors^2^NURSC^223
 ;;^UTILITY("^GMRD(124.2,",$J,4769,1,2,0)
 ;;=4780^Goals/Expected Outcomes^2^NURSC^228
 ;;^UTILITY("^GMRD(124.2,",$J,4769,1,3,0)
 ;;=4787^Nursing Intervention/Orders^2^NURSC^230
 ;;^UTILITY("^GMRD(124.2,",$J,4769,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4769,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4769,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4770,0)
 ;;=Aortobifemoral Bypass^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4770,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4770,1,1,0)
 ;;=4771^Cardiac Output, Decreased (Mechanical)^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4770,1,2,0)
 ;;=4773^Tissue Perfusion, Alteration in^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4770,1,3,0)
 ;;=4775^Skin Integrity, Impairment of^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4770,1,4,0)
 ;;=4777^Pain, Acute^2^NURSC^15
 ;;^UTILITY("^GMRD(124.2,",$J,4770,1,5,0)
 ;;=4779^[Extra Problem]^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,4771,0)
 ;;=Cardiac Output, Decreased (Mechanical)^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4771,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4771,1,1,0)
 ;;=4781^Etiology/Related and/or Risk Factors^2^NURSC^224
 ;;^UTILITY("^GMRD(124.2,",$J,4771,1,2,0)
 ;;=4783^Goals/Expected Outcomes^2^NURSC^229
 ;;^UTILITY("^GMRD(124.2,",$J,4771,1,3,0)
 ;;=4785^Nursing Intervention/Orders^2^NURSC^229
 ;;^UTILITY("^GMRD(124.2,",$J,4771,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4771,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4771,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4772,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^223^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4772,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4772,1,1,0)
 ;;=4776^[etiology]^3^NURSC^80
 ;;^UTILITY("^GMRD(124.2,",$J,4772,1,2,0)
 ;;=4778^[etiology]^3^NURSC^81
 ;;^UTILITY("^GMRD(124.2,",$J,4772,1,3,0)
 ;;=4863^[etiology]^3^NURSC^14
 ;;^UTILITY("^GMRD(124.2,",$J,4772,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4773,0)
 ;;=Tissue Perfusion, Alteration in^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4773,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4773,1,1,0)
 ;;=4799^Etiology/Related and/or Risk Factors^2^NURSC^228
 ;;^UTILITY("^GMRD(124.2,",$J,4773,1,2,0)
 ;;=4801^Goals/Expected Outcomes^2^NURSC^232
 ;;^UTILITY("^GMRD(124.2,",$J,4773,1,3,0)
 ;;=4802^Nursing Intervention/Orders^2^NURSC^233
 ;;^UTILITY("^GMRD(124.2,",$J,4773,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4773,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4773,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4774,0)
 ;;=[etiology]^3^NURSC^^79^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4775,0)
 ;;=Skin Integrity, Impairment of^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4775,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4775,1,1,0)
 ;;=4794^Etiology/Related and/or Risk Factors^2^NURSC^226
 ;;^UTILITY("^GMRD(124.2,",$J,4775,1,2,0)
 ;;=4796^Goals/Expected Outcomes^2^NURSC^231
