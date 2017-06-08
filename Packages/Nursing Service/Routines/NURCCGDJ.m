NURCCGDJ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,17,0)
 ;;=11402^use mild cleansing agent for bathing^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,18,0)
 ;;=15357^apply barrier cream to skin at risk [specify area]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,19,0)
 ;;=4650^activity: chair q[frequency] or ambulate q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,20,0)
 ;;=15359^evaluate effectiveness of bowel/bladder program^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,21,0)
 ;;=7407^wound care/drsg change(s) of [specify area] q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,22,0)
 ;;=15361^teach self skin inspection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,23,0)
 ;;=15363^evaluate pt/SO in performing dressing changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,24,0)
 ;;=11394^apply lotion/ointment to skin as indicated/ordered^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,25,0)
 ;;=15374^debridement technique [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11673,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11673,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11674,0)
 ;;=assess skin& document findings , related to:^2^NURSC^11^4^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11674,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,11674,1,1,0)
 ;;=1805^area(s) in question [location] q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11674,1,2,0)
 ;;=1806^color q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11674,1,3,0)
 ;;=1808^size q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11674,1,4,0)
 ;;=1809^presence of pain/discomfort q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11674,1,5,0)
 ;;=1810^presence/absence of drainage q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11674,1,6,0)
 ;;=2952^temperature per[route] q[ frequency ]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11674,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11674,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11674,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11685,0)
 ;;=implement skin care protocol [specify]^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11685,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11685,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11686,0)
 ;;=provide comfort/preventive measures:^2^NURSC^11^4^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11686,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,11686,1,1,0)
 ;;=841^sheepskin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11686,1,2,0)
 ;;=842^alternating pressure pads^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11686,1,3,0)
 ;;=843^overhead bars^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11686,1,4,0)
 ;;=844^reposition q[frequency]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11686,1,5,0)
 ;;=845^massage bony prominence [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11686,1,6,0)
 ;;=11692^[additional measure]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,11686,1,7,0)
 ;;=15355^protective aids [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11686,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,11686,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11686,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11686,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11692,0)
 ;;=[additional measure]^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11699,0)
 ;;=teach how to attain/maintain skin integrity^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11699,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11699,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11701,0)
 ;;=[Extra Order]^3^NURSC^11^190^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11701,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11701,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11702,0)
 ;;=Related Problems^2^NURSC^7^136^1^^T^1
