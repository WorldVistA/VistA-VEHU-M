NURCCGBJ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8092,1,8,0)
 ;;=1946^Violence, Potential For, Self Directed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8092,1,9,0)
 ;;=1948^Violence, Potential For, Directed At Others^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8092,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8102,0)
 ;;=Defining Characteristics^2^NURSC^12^99^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8102,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,8102,1,1,0)
 ;;=4133^chronic worry, anxiety, depression^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8102,1,2,0)
 ;;=4135^inability to meet role expectations and for basic needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8102,1,3,0)
 ;;=4137^verbalization of inability to cope or ask for assistance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8102,1,4,0)
 ;;=4146^inability to problem solve^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8102,1,5,0)
 ;;=4147^inappropriate use of defense mechanisms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8102,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8108,0)
 ;;=Cardiac Output, Decreased (Electrical/Mechanical)^2^NURSC^2^3^1^^T^
 ;;^UTILITY("^GMRD(124.2,",$J,8108,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,8108,1,1,0)
 ;;=8109^Etiology/Related and/or Risk Factors^2^NURSC^265
 ;;^UTILITY("^GMRD(124.2,",$J,8108,1,2,0)
 ;;=8117^Goals/Expected Outcomes^2^NURSC^277
 ;;^UTILITY("^GMRD(124.2,",$J,8108,1,4,0)
 ;;=8218^Nursing Intervention/Orders^2^NURSC^281
 ;;^UTILITY("^GMRD(124.2,",$J,8108,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8108,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8108,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8109,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^265^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8109,1,0)
 ;;=^124.21PI^7^2
 ;;^UTILITY("^GMRD(124.2,",$J,8109,1,2,0)
 ;;=4368^alteration in preload/afterload^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8109,1,7,0)
 ;;=4405^electrophysiological disturbance/impulse formation/conduct^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8109,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8117,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^277^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8117,1,0)
 ;;=^124.21PI^6^3
 ;;^UTILITY("^GMRD(124.2,",$J,8117,1,1,0)
 ;;=8118^maintain stable hemodynamics^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8117,1,5,0)
 ;;=4397^maintain ABG's/pulse oximeter WNL for pt;oxygen sat [spec]%^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8117,1,6,0)
 ;;=8184^[Extra Goal]^3^NURSC^145
 ;;^UTILITY("^GMRD(124.2,",$J,8117,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8118,0)
 ;;=maintain stable hemodynamics^2^NURSC^9^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8118,1,0)
 ;;=^124.21PI^9^8
 ;;^UTILITY("^GMRD(124.2,",$J,8118,1,1,0)
 ;;=4380^Cardiac Index (CI) [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8118,1,2,0)
 ;;=4382^Cardiac Output (CO) [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8118,1,3,0)
 ;;=4383^SVR (systemic vascular resistance) [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8118,1,4,0)
 ;;=4384^PAWP pulmonary artery wedge pressure [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8118,1,6,0)
 ;;=4386^BP [specify systolic/diastolic HIGH] to [specify LOW]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8118,1,7,0)
 ;;=4387^pulse [specify range] ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8118,1,8,0)
 ;;=4388^respirations [specify range]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,8118,1,9,0)
 ;;=4436^temperature per[route] q[ frequency ]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,8118,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8118,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8118,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8131,0)
 ;;=Injury Potential^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8131,1,0)
 ;;=^124.21PI^5^5
