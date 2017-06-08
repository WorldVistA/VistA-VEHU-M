NURCCGDN ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11863,0)
 ;;=teach assistive devices [specify] to facilitate mobility^3^NURSC^11^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11863,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11863,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11874,0)
 ;;=[Extra Order]^3^NURSC^11^192^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11874,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11874,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11875,0)
 ;;=Related Problems^2^NURSC^7^139^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11875,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11875,1,1,0)
 ;;=819^skin integrity, impairment of^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11875,1,2,0)
 ;;=820^tissue perfusion, alteration in ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11875,1,3,0)
 ;;=821^gas exchange, impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11875,1,4,0)
 ;;=822^constipation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11875,1,5,0)
 ;;=823^injury, potential for^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11875,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,11875,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11880,0)
 ;;=foot care^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11882,0)
 ;;=Defining Characteristics^2^NURSC^12^139^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11882,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11882,1,1,0)
 ;;=4337^decreased muscle strength,control and/or mass^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11882,1,2,0)
 ;;=4339^impaired coordination^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11882,1,3,0)
 ;;=4340^imposed restriction of movement including mechanical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11882,1,4,0)
 ;;=4341^limited range of motion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11882,1,5,0)
 ;;=1769^impaired physical mobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11882,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11888,0)
 ;;=Gas Exchange, Impaired^2^NURSC^2^5^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11888,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11888,1,1,0)
 ;;=11889^Etiology/Related and/or Risk Factors^2^NURSC^161
 ;;^UTILITY("^GMRD(124.2,",$J,11888,1,2,0)
 ;;=11894^Related Problems^2^NURSC^140
 ;;^UTILITY("^GMRD(124.2,",$J,11888,1,3,0)
 ;;=11899^Goals/Expected Outcomes^2^NURSC^159
 ;;^UTILITY("^GMRD(124.2,",$J,11888,1,4,0)
 ;;=11927^Nursing Intervention/Orders^2^NURSC^194
 ;;^UTILITY("^GMRD(124.2,",$J,11888,1,5,0)
 ;;=12044^Defining Characteristics^2^NURSC^141
 ;;^UTILITY("^GMRD(124.2,",$J,11888,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11888,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11888,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11888,"TD",0)
 ;;=^^3^3^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,11888,"TD",1,0)
 ;;=The individual experiences decreased passage of gases (oxygen,
 ;;^UTILITY("^GMRD(124.2,",$J,11888,"TD",2,0)
 ;;=carbon dioxide) between the alveoli of the lungs and the vascular
 ;;^UTILITY("^GMRD(124.2,",$J,11888,"TD",3,0)
 ;;=system.
 ;;^UTILITY("^GMRD(124.2,",$J,11889,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^161^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11889,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,11889,1,1,0)
 ;;=447^alveoli-capillary membrane changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11889,1,2,0)
 ;;=448^blood flow, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11889,1,3,0)
 ;;=449^oxygen carrying capacity of blood altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11889,1,4,0)
 ;;=2696^ventilation, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11889,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11894,0)
 ;;=Related Problems^2^NURSC^7^140^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11894,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,11894,1,1,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
