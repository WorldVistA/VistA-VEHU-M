NURCCG8I ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4522,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4522,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4524,0)
 ;;=[Extra Order]^3^NURSC^11^278^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4524,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4524,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4533,0)
 ;;=[Extra Order]^3^NURSC^11^210^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4533,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4533,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4534,0)
 ;;=Hypertension^2^NURSC^8^2^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4534,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,4534,1,2,0)
 ;;=4359^Cardiac Output, Decreased (Electrical/Mechanical)^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4534,1,3,0)
 ;;=4592^Pain, Acute^2^NURSC^14
 ;;^UTILITY("^GMRD(124.2,",$J,4534,1,4,0)
 ;;=4631^Nutrition, Altered^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4534,1,5,0)
 ;;=4727^Health Knowledge Deficit Related to Hypertension^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4534,1,6,0)
 ;;=4769^[Extra Problem]^2^NURSC^44
 ;;^UTILITY("^GMRD(124.2,",$J,4535,0)
 ;;=I&O, site & character q[frequency]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4536,0)
 ;;=[Extra Problem]^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4536,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4536,1,1,0)
 ;;=4539^Etiology/Related and/or Risk Factors^2^NURSC^210
 ;;^UTILITY("^GMRD(124.2,",$J,4536,1,2,0)
 ;;=4543^Goals/Expected Outcomes^2^NURSC^210
 ;;^UTILITY("^GMRD(124.2,",$J,4536,1,3,0)
 ;;=4544^Nursing Intervention/Orders^2^NURSC^211
 ;;^UTILITY("^GMRD(124.2,",$J,4536,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4536,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4536,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4538,0)
 ;;=skin turgor & oral mucous membranes q[frequency]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4539,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^210^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4539,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4539,1,1,0)
 ;;=4547^[etiology]^3^NURSC^47
 ;;^UTILITY("^GMRD(124.2,",$J,4539,1,2,0)
 ;;=4548^[etiology]^3^NURSC^48
 ;;^UTILITY("^GMRD(124.2,",$J,4539,1,3,0)
 ;;=4743^[etiology]^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4539,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4543,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^210^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4543,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4543,1,1,0)
 ;;=4550^[Extra Goal]^3^NURSC^272
 ;;^UTILITY("^GMRD(124.2,",$J,4543,1,2,0)
 ;;=4551^[Extra Goal]^3^NURSC^273
 ;;^UTILITY("^GMRD(124.2,",$J,4543,1,3,0)
 ;;=4552^[Extra Goal]^3^NURSC^274
 ;;^UTILITY("^GMRD(124.2,",$J,4543,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4544,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^211^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4544,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4544,1,1,0)
 ;;=4553^[Extra Order]^3^NURSC^279
 ;;^UTILITY("^GMRD(124.2,",$J,4544,1,2,0)
 ;;=4555^[Extra Order]^3^NURSC^280
 ;;^UTILITY("^GMRD(124.2,",$J,4544,1,3,0)
 ;;=4556^[Extra Order]^3^NURSC^281
 ;;^UTILITY("^GMRD(124.2,",$J,4544,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4544,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4545,0)
 ;;=VS & BP lying and standing q[frequency]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4546,0)
 ;;=[etiology]^3^NURSC^^46^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4547,0)
 ;;=[etiology]^3^NURSC^^47^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4548,0)
 ;;=[etiology]^3^NURSC^^48^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4550,0)
 ;;=[Extra Goal]^3^NURSC^9^272^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4550,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4550,10)
 ;;=D EN2^NURCCPU1
