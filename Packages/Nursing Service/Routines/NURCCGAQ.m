NURCCGAQ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6621,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6621,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6622,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^259^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6622,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,6622,1,1,0)
 ;;=4614^hypovolemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6622,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6624,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^270^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6624,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,6624,1,1,0)
 ;;=4813^peripheral pulses present^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6624,1,2,0)
 ;;=4397^maintain ABG's/pulse oximeter WNL for pt;oxygen sat [spec]%^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6624,1,3,0)
 ;;=6850^[Extra Goal]^3^NURSC^227
 ;;^UTILITY("^GMRD(124.2,",$J,6624,1,4,0)
 ;;=1831^demonstrates improved circulation by [specify]:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6624,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6627,0)
 ;;=[Extra Goal]^3^NURSC^9^226^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6627,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6627,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6628,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^272^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6628,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,6628,1,2,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6628,1,4,0)
 ;;=6632^[Extra Order]^3^NURSC^231
 ;;^UTILITY("^GMRD(124.2,",$J,6628,1,5,0)
 ;;=4428^assess,monitor,document V/S^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6628,1,6,0)
 ;;=16561^skin color and temperature WNL for pt^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6628,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6628,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6632,0)
 ;;=[Extra Order]^3^NURSC^11^231^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6632,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6632,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6633,0)
 ;;=Anxiety^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6633,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6633,1,1,0)
 ;;=6634^Etiology/Related and/or Risk Factors^2^NURSC^93
 ;;^UTILITY("^GMRD(124.2,",$J,6633,1,2,0)
 ;;=6648^Goals/Expected Outcomes^2^NURSC^92
 ;;^UTILITY("^GMRD(124.2,",$J,6633,1,3,0)
 ;;=6656^Nursing Intervention/Orders^2^NURSC^80
 ;;^UTILITY("^GMRD(124.2,",$J,6633,1,4,0)
 ;;=6668^Related Problems^2^NURSC^79
 ;;^UTILITY("^GMRD(124.2,",$J,6633,1,5,0)
 ;;=6679^Defining Characteristics^2^NURSC^87
 ;;^UTILITY("^GMRD(124.2,",$J,6633,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6633,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6633,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6634,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^93^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6634,1,0)
 ;;=^124.21PI^8^6
 ;;^UTILITY("^GMRD(124.2,",$J,6634,1,2,0)
 ;;=1851^situational crises^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6634,1,4,0)
 ;;=6638^threat to or change in:^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6634,1,5,0)
 ;;=2008^threat to self-concept^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6634,1,6,0)
 ;;=2009^threat of death^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6634,1,7,0)
 ;;=2010^unconscious conflict about essential values and goals^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6634,1,8,0)
 ;;=2012^unmet needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6634,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6638,0)
 ;;=threat to or change in:^2^NURSC^^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6638,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,6638,1,1,0)
 ;;=2000^health status^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6638,1,2,0)
 ;;=2001^socioeconomic status^3^NURSC^1
