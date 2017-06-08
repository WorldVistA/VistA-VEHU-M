NURCCGAB ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6017,1,2,0)
 ;;=6019^reported food intake under RDA^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6017,1,3,0)
 ;;=6020^reported/observed lack of food^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6017,1,4,0)
 ;;=6021^sore/inflammed bucal cavity^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6017,1,5,0)
 ;;=6022^lack of interest in food^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6017,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6018,0)
 ;;=body weight 20% or more under ideal^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6019,0)
 ;;=reported food intake under RDA^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6020,0)
 ;;=reported/observed lack of food^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6021,0)
 ;;=sore/inflammed bucal cavity^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6022,0)
 ;;=lack of interest in food^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6023,0)
 ;;=Fluid Volume Deficit (Potential)^2^NURSC^2^2^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,6023,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,6023,1,1,0)
 ;;=6024^Goals/Expected Outcomes^2^NURSC^266
 ;;^UTILITY("^GMRD(124.2,",$J,6023,1,2,0)
 ;;=6031^Nursing Intervention/Orders^2^NURSC^268
 ;;^UTILITY("^GMRD(124.2,",$J,6023,1,3,0)
 ;;=6040^Etiology/Related and/or Risk Factors^2^NURSC^84
 ;;^UTILITY("^GMRD(124.2,",$J,6023,1,4,0)
 ;;=6051^Defining Characteristics^2^NURSC^78
 ;;^UTILITY("^GMRD(124.2,",$J,6023,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6023,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6023,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6024,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^266^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,6024,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6024,1,1,0)
 ;;=4629^maintains fluid/electrolyte balance:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6024,1,2,0)
 ;;=14808^[Extra Goal]^3^NURSC^130
 ;;^UTILITY("^GMRD(124.2,",$J,6024,1,3,0)
 ;;=2552^maintains nutritional intake to meet metabolic requirements^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6024,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6030,0)
 ;;=[Extra Goal]^3^NURSC^9^70^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6030,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6030,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6031,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^268^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6031,1,0)
 ;;=^124.21PI^3^2
 ;;^UTILITY("^GMRD(124.2,",$J,6031,1,1,0)
 ;;=6032^assess, monitor & record:^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6031,1,3,0)
 ;;=8255^[Extra Order]^3^NURSC^18
 ;;^UTILITY("^GMRD(124.2,",$J,6031,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6031,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6032,0)
 ;;=assess, monitor & record:^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6032,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6032,1,1,0)
 ;;=4535^I&O, site & character q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6032,1,2,0)
 ;;=4538^skin turgor & oral mucous membranes q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6032,1,3,0)
 ;;=1196^specific gravity q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6032,1,4,0)
 ;;=4545^VS & BP lying and standing q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6032,1,5,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6032,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6032,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6032,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6039,0)
 ;;=[Extra Order]^3^NURSC^11^66^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6039,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6039,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6040,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^84^1^^T^1
