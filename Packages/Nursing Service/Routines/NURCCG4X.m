NURCCG4X ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1899,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1900,0)
 ;;=the use, effects, and side effects of medication^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1901,0)
 ;;=daily exercise^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1902,0)
 ;;=dietary restriction such as excess cholesterol/lipids^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1903,0)
 ;;=avoidance of injury^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1904,0)
 ;;=avoid emotional stress^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1905,0)
 ;;=avoid crossing legs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1906,0)
 ;;=avoid wearing tight clothes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1907,0)
 ;;=avoid getting chilled^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1908,0)
 ;;=need to report changes promptly to MD, etc.^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1909,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^51^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1909,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1909,1,1,0)
 ;;=1912^environmental lack of diversional activity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1909,1,2,0)
 ;;=1913^frequent lengthy treatments^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1909,1,3,0)
 ;;=1914^long term hospitalization^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1909,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1910,0)
 ;;=Related Problems^2^NURSC^7^39^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1910,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,1910,1,1,0)
 ;;=1403^Anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1910,1,2,0)
 ;;=1406^Cognitive Impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1910,1,3,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1910,1,4,0)
 ;;=1405^Depressive Behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1910,1,5,0)
 ;;=1915^Grieving, Anticipatory^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1910,1,6,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1910,1,7,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1910,1,8,0)
 ;;=1918^Social Isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1910,1,9,0)
 ;;=1919^Spiritual Distress^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1910,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1911,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^50^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1911,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1911,1,1,0)
 ;;=1920^expresses interest in using leisure time meaningfully^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1911,1,2,0)
 ;;=1921^makes decisions abouts time and frequency of activities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1911,1,3,0)
 ;;=1922^participates is chosen activity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1911,1,4,0)
 ;;=2914^[Extra Goal]^3^NURSC^95^0
 ;;^UTILITY("^GMRD(124.2,",$J,1911,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1912,0)
 ;;=environmental lack of diversional activity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1913,0)
 ;;=frequent lengthy treatments^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1914,0)
 ;;=long term hospitalization^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1915,0)
 ;;=Grieving, Anticipatory^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1916,0)
 ;;=Powerlessness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1917,0)
 ;;=Self-Care Deficit [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1918,0)
 ;;=Social Isolation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1919,0)
 ;;=Spiritual Distress^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1920,0)
 ;;=expresses interest in using leisure time meaningfully^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1920,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1920,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1921,0)
 ;;=makes decisions abouts time and frequency of activities^3^NURSC^9^1^^^T
