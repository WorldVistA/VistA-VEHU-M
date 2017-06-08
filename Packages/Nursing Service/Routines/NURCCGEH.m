NURCCGEH ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13186,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13186,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13187,0)
 ;;=avoids problems of impaired mobility^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13187,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13187,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13189,0)
 ;;=[Extra Goal]^3^NURSC^9^230^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13189,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13189,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13190,0)
 ;;=avoid stooping,bending over,or lying on operative side^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13191,0)
 ;;=Gas Exchange, Impaired^2^NURSC^2^6^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13191,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,13191,1,1,0)
 ;;=13193^Etiology/Related and/or Risk Factors^2^NURSC^177
 ;;^UTILITY("^GMRD(124.2,",$J,13191,1,2,0)
 ;;=13202^Related Problems^2^NURSC^153
 ;;^UTILITY("^GMRD(124.2,",$J,13191,1,3,0)
 ;;=13216^Goals/Expected Outcomes^2^NURSC^175
 ;;^UTILITY("^GMRD(124.2,",$J,13191,1,4,0)
 ;;=13245^Nursing Intervention/Orders^2^NURSC^148
 ;;^UTILITY("^GMRD(124.2,",$J,13191,1,5,0)
 ;;=13381^Defining Characteristics^2^NURSC^155
 ;;^UTILITY("^GMRD(124.2,",$J,13191,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13191,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13191,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13191,"TD",0)
 ;;=^^3^3^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,13191,"TD",1,0)
 ;;=The individual experiences decreased passage of gases (oxygen,
 ;;^UTILITY("^GMRD(124.2,",$J,13191,"TD",2,0)
 ;;=carbon dioxide) between the alveoli of the lungs and the vascular
 ;;^UTILITY("^GMRD(124.2,",$J,13191,"TD",3,0)
 ;;=system.
 ;;^UTILITY("^GMRD(124.2,",$J,13192,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^195^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13192,1,0)
 ;;=^124.21PI^29^11
 ;;^UTILITY("^GMRD(124.2,",$J,13192,1,2,0)
 ;;=13197^implement measures to reduce fear & anxiety [specify]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,13192,1,9,0)
 ;;=13208^assess for S/S of decreased tissue perfussion q[frequency]^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,13192,1,12,0)
 ;;=13213^assess for factors that improve mobility^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,13192,1,17,0)
 ;;=13229^implement measures to improve cerebral blood flow [specify]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,13192,1,23,0)
 ;;=13270^teach techniques to prevent complications^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,13192,1,24,0)
 ;;=13626^[Extra Order]^3^NURSC^241
 ;;^UTILITY("^GMRD(124.2,",$J,13192,1,25,0)
 ;;=15505^assess for visual/spatial disturbances^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13192,1,26,0)
 ;;=15506^orient to enviroment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13192,1,27,0)
 ;;=15507^assist with ADL's^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13192,1,28,0)
 ;;=13609^teach adaptive techniques for ADLs [specify]^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,13192,1,29,0)
 ;;=15509^assess for alterations in thought processes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13192,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13192,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13193,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^177^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13193,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,13193,1,1,0)
 ;;=447^alveoli-capillary membrane changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13193,1,2,0)
 ;;=448^blood flow, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13193,1,3,0)
 ;;=449^oxygen carrying capacity of blood altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13193,1,4,0)
 ;;=2696^ventilation, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13193,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13197,0)
 ;;=implement measures to reduce fear & anxiety [specify]^3^NURSC^11^3^^^T
