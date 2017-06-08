NURCCGBL ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8187,1,9,0)
 ;;=786^assure understanding of informed consent^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8187,1,11,0)
 ;;=8549^[Extra Order]^3^NURSC^151
 ;;^UTILITY("^GMRD(124.2,",$J,8187,1,12,0)
 ;;=781^provide physically safe environment^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8187,1,13,0)
 ;;=11210^monitor glucose levels q[specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8187,1,14,0)
 ;;=11324^assess for S/S of hypo/hyperglycemia & neuro changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8187,1,15,0)
 ;;=11412^teach pt & S/O S/S of hypo/hyperglycemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8187,1,16,0)
 ;;=11490^teach pt & S/O prevention/tx of hypo/hyperglycemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8187,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8187,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8218,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^281^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8218,1,0)
 ;;=^124.21PI^16^4
 ;;^UTILITY("^GMRD(124.2,",$J,8218,1,2,0)
 ;;=1471^assess for EKG changes q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8218,1,14,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8218,1,15,0)
 ;;=8714^[Extra Order]^3^NURSC^152
 ;;^UTILITY("^GMRD(124.2,",$J,8218,1,16,0)
 ;;=1221^assess for presence of pulse deficit q[frequency] hrs.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8218,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8218,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8241,0)
 ;;=Related Problems^2^NURSC^7^96^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8241,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,8241,1,1,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8241,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,8241,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8245,0)
 ;;=Defining Characteristics^2^NURSC^12^100^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8245,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,8245,1,1,0)
 ;;=4263^cognitive, effective, and psychomotor factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8245,1,2,0)
 ;;=4265^integrative dysfunction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8245,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8255,0)
 ;;=[Extra Order]^3^NURSC^11^18^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8255,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8255,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8261,0)
 ;;=[Extra Problem]^2^NURSC^2^20^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,8261,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,8261,1,1,0)
 ;;=8262^Etiology/Related and/or Risk Factors^2^NURSC^266
 ;;^UTILITY("^GMRD(124.2,",$J,8261,1,2,0)
 ;;=8266^Goals/Expected Outcomes^2^NURSC^278
 ;;^UTILITY("^GMRD(124.2,",$J,8261,1,3,0)
 ;;=8270^Nursing Intervention/Orders^2^NURSC^282
 ;;^UTILITY("^GMRD(124.2,",$J,8261,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8261,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8261,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8262,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^266^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8262,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,8262,1,1,0)
 ;;=8264^[etiology]^3^NURSC^41
 ;;^UTILITY("^GMRD(124.2,",$J,8262,1,2,0)
 ;;=8265^[etiology]^3^NURSC^42
 ;;^UTILITY("^GMRD(124.2,",$J,8262,1,3,0)
 ;;=8933^[etiology]^3^NURSC^22
 ;;^UTILITY("^GMRD(124.2,",$J,8262,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8263,0)
 ;;=[etiology]^3^NURSC^^40^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8264,0)
 ;;=[etiology]^3^NURSC^^41^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8265,0)
 ;;=[etiology]^3^NURSC^^42^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8266,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^278^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8266,1,0)
 ;;=^124.21PI^3^3
