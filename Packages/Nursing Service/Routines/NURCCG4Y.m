NURCCG4Y ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1921,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1921,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1922,0)
 ;;=participates is chosen activity^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1922,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1922,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1923,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^46^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1923,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1923,1,1,0)
 ;;=1924^schedule time each day to pursue leisure activities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1923,1,2,0)
 ;;=1925^encourage S/O to bring familiar objects/personal items^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1923,1,3,0)
 ;;=1926^ask someone to read to client on a regular basis^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1923,1,4,0)
 ;;=3001^[Extra Order]^3^NURSC^87^0
 ;;^UTILITY("^GMRD(124.2,",$J,1923,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1923,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1924,0)
 ;;=schedule time each day to pursue leisure activities^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1924,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1924,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1925,0)
 ;;=encourage S/O to bring familiar objects/personal items^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1925,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1925,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1926,0)
 ;;=ask someone to read to client on a regular basis^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1926,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1926,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1927,0)
 ;;=Physical Therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1928,0)
 ;;=Occupational Therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1929,0)
 ;;=Corrective Therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1930,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^52^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1930,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1930,1,1,0)
 ;;=1931^health care environment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1930,1,2,0)
 ;;=1932^illness-related regimen^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1930,1,3,0)
 ;;=1933^interpersonal interaction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1930,1,4,0)
 ;;=1934^life-style of helplessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1930,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1931,0)
 ;;=health care environment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1932,0)
 ;;=illness-related regimen^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1933,0)
 ;;=interpersonal interaction^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1934,0)
 ;;=life-style of helplessness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1935,0)
 ;;=Related Problems^2^NURSC^7^59^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1935,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1935,1,1,0)
 ;;=1405^Depressive Behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1935,1,2,0)
 ;;=1918^Social Isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1935,1,3,0)
 ;;=1420^Fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1935,1,4,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1935,1,5,0)
 ;;=1936^Sexual Dysfunction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1935,1,6,0)
 ;;=1937^Sexual Pattern, Altered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1935,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,1935,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1936,0)
 ;;=Sexual Dysfunction^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1937,0)
 ;;=Sexual Pattern, Altered^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1938,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^51^1^^T
