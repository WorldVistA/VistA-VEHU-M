NURCCGBE ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7852,1,5,0)
 ;;=7860^refer for appropriate consults^2^NURSC^22
 ;;^UTILITY("^GMRD(124.2,",$J,7852,1,6,0)
 ;;=7953^[Extra Order]^3^NURSC^145
 ;;^UTILITY("^GMRD(124.2,",$J,7852,1,7,0)
 ;;=15524^involve family in decisions as indicated by client^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7852,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7852,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7856,0)
 ;;=teach effective coping skills^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7856,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7856,1,1,0)
 ;;=65^problem solving/decision making^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7856,1,2,0)
 ;;=66^assertiveness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7856,1,3,0)
 ;;=67^help-seeking^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7856,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7856,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7856,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7860,0)
 ;;=refer for appropriate consults^2^NURSC^11^22^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7860,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,7860,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7860,1,2,0)
 ;;=297^Chaplain Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7860,1,3,0)
 ;;=1928^Occupational Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7860,1,4,0)
 ;;=1927^Physical Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7860,1,5,0)
 ;;=1929^Corrective Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7860,1,6,0)
 ;;=2649^Respiratory Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7860,1,7,0)
 ;;=2579^Social Work Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7860,1,8,0)
 ;;=2718^Speech Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7860,5)
 ;;=specifically
 ;;^UTILITY("^GMRD(124.2,",$J,7860,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7860,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7860,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7870,0)
 ;;=Related Problems^2^NURSC^7^92^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7870,1,0)
 ;;=^124.21PI^12^12
 ;;^UTILITY("^GMRD(124.2,",$J,7870,1,1,0)
 ;;=78^communication, impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7870,1,2,0)
 ;;=79^coping, family: potential for growth^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7870,1,3,0)
 ;;=80^family process, alteration in^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7870,1,4,0)
 ;;=81^grieving^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7870,1,5,0)
 ;;=82^health maintenance, alteration in^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7870,1,6,0)
 ;;=83^home management, maintenance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7870,1,7,0)
 ;;=84^parenting, alteration in^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7870,1,8,0)
 ;;=85^sexual dysfunction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7870,1,9,0)
 ;;=86^sexual pattern, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7870,1,10,0)
 ;;=87^social interaction, impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7870,1,11,0)
 ;;=88^social isolation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7870,1,12,0)
 ;;=89^spiritual distress^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7870,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,7870,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7883,0)
 ;;=provide Ed material/discussion re addiction/med complication^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7883,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7883,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7884,0)
 ;;=Defining Characteristics^2^NURSC^12^96^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7884,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,7884,1,1,0)
 ;;=4285^client concerned about S/O's response to health problems^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7884,1,2,0)
 ;;=4286^S/O preoccupied with personal reaction to client's illness^3^NURSC^1
