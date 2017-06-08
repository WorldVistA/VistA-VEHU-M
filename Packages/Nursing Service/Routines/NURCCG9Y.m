NURCCG9Y ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5362,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,5362,1,1,0)
 ;;=5366^verbal report or observed evidence of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5362,1,2,0)
 ;;=5367^guarding behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5362,1,3,0)
 ;;=4200^facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5362,1,4,0)
 ;;=5368^vital sign changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5362,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5364,0)
 ;;=verbalizes decrease in frequency, pain, urgency, nocturia^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5364,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5364,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5365,0)
 ;;=demonstrates proper catheter care^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5365,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5365,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5366,0)
 ;;=verbal report or observed evidence of pain^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5367,0)
 ;;=guarding behavior^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5368,0)
 ;;=vital sign changes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5370,0)
 ;;=verbalizes relief of suprapubic discomfort^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5370,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5370,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5372,0)
 ;;=verbalize reportable signs and symptoms^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5372,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5372,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5373,0)
 ;;=Defining Characteristics^2^NURSC^12^66^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5373,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,5373,1,1,0)
 ;;=5379^body weight 20% or more under ideal^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5373,1,2,0)
 ;;=5382^reported food intake under RDA^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5373,1,3,0)
 ;;=5384^reported/observed lack of food^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5373,1,4,0)
 ;;=5388^sore/inflammed bucal cavity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5373,1,5,0)
 ;;=5389^lack of interest in food^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5373,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5374,0)
 ;;=demonstrate adaptation to change in body function^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5374,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5374,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5375,0)
 ;;=[Extra Goal]^3^NURSC^9^12^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5375,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5375,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5378,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^262^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5378,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,5378,1,1,0)
 ;;=1273^assess voiding/urgency patterns^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5378,1,2,0)
 ;;=1200^cath care q[frequency]hr^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5378,1,3,0)
 ;;=5393^teach catheterization technique/care q [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5378,1,4,0)
 ;;=1147^maintain fluid intake of [ ]cc q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5378,1,5,0)
 ;;=5457^monitor post void residuals^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5378,1,6,0)
 ;;=5548^teach measures to promote bladder emptying^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5378,1,7,0)
 ;;=5563^implement measures to maintain continence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5378,1,8,0)
 ;;=5565^assess for S/S of self concept disturbance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5378,1,9,0)
 ;;=5567^implement measures to improve patient self esteem^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5378,1,10,0)
 ;;=5614^[Extra Order]^3^NURSC^44
