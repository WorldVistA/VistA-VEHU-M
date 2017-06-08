NURCCG58 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2057,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2057,1,1,0)
 ;;=66^assertiveness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2057,1,2,0)
 ;;=2059^goal setting techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2057,1,3,0)
 ;;=2060^alternative self-help strategies^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2057,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,2057,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2057,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2057,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2058,0)
 ;;=psychological needs such as:^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2058,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2058,1,1,0)
 ;;=2061^dependency^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2058,1,2,0)
 ;;=2062^low self-esteem^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2058,1,3,0)
 ;;=2063^inadequate self identity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2058,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2059,0)
 ;;=goal setting techniques^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2060,0)
 ;;=alternative self-help strategies^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2061,0)
 ;;=dependency^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2062,0)
 ;;=low self-esteem^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2063,0)
 ;;=inadequate self identity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2064,0)
 ;;=increased stress^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2065,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^56^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2065,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,2065,1,1,0)
 ;;=2067^disasters^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2065,1,2,0)
 ;;=2068^wars^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2065,1,3,0)
 ;;=2070^epidemics^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2065,1,4,0)
 ;;=2071^rape^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2065,1,5,0)
 ;;=2072^assault^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2065,1,6,0)
 ;;=2074^torture^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2065,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2066,0)
 ;;=pattern of pathological alcohol use such as:^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2066,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2066,1,1,0)
 ;;=2069^inability to stop drinking^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2066,1,2,0)
 ;;=2073^binges or alcohol use necessary for daily functioning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2066,1,3,0)
 ;;=2076^physical problems related to alcohol use,e.g. cirrhosis^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2066,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2067,0)
 ;;=disasters^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2068,0)
 ;;=wars^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2069,0)
 ;;=inability to stop drinking^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2070,0)
 ;;=epidemics^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2071,0)
 ;;=rape^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2072,0)
 ;;=assault^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2073,0)
 ;;=binges or alcohol use necessary for daily functioning^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2074,0)
 ;;=torture^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2075,0)
 ;;=Related Problems^2^NURSC^7^43^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2075,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,2075,1,1,0)
 ;;=1420^Fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2075,1,2,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2075,1,3,0)
 ;;=1944^Grieving, Dysfunctional^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2075,1,4,0)
 ;;=2257^Home Maintenance Management, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2075,1,5,0)
 ;;=2078^Hopelessness ^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2075,1,6,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
