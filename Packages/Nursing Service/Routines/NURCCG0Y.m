NURCCG0Y ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,351,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,351,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,351,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,351,"TD",0)
 ;;=^^3^3^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,351,"TD",1,0)
 ;;=A state in which an individual expeiences a change in normal bowel
 ;;^UTILITY("^GMRD(124.2,",$J,351,"TD",2,0)
 ;;=habits characterized by a decrease in frequency and/or passage
 ;;^UTILITY("^GMRD(124.2,",$J,351,"TD",3,0)
 ;;=of hard stools.
 ;;^UTILITY("^GMRD(124.2,",$J,352,0)
 ;;=Diarrhea^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,352,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,352,1,1,0)
 ;;=962^Etiology/Related and/or Risk Factors^2^NURSC^23^0
 ;;^UTILITY("^GMRD(124.2,",$J,352,1,2,0)
 ;;=964^Goals/Expected Outcomes^2^NURSC^22^0
 ;;^UTILITY("^GMRD(124.2,",$J,352,1,3,0)
 ;;=966^Nursing Intervention/Orders^2^NURSC^19^0
 ;;^UTILITY("^GMRD(124.2,",$J,352,1,4,0)
 ;;=967^Related Problems^2^NURSC^19^0
 ;;^UTILITY("^GMRD(124.2,",$J,352,1,5,0)
 ;;=4157^Defining Characteristics^2^NURSC^24
 ;;^UTILITY("^GMRD(124.2,",$J,352,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,352,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,352,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,352,"TD",0)
 ;;=^^3^3^2890303^^^
 ;;^UTILITY("^GMRD(124.2,",$J,352,"TD",1,0)
 ;;=A state in which an individual experiences a change in normal bowel
 ;;^UTILITY("^GMRD(124.2,",$J,352,"TD",2,0)
 ;;=habits characterized by involuntary frequent passage of loose, fluid,
 ;;^UTILITY("^GMRD(124.2,",$J,352,"TD",3,0)
 ;;=unformed stools.
 ;;^UTILITY("^GMRD(124.2,",$J,353,0)
 ;;=Incontinence, Bowel^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,353,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,353,1,1,0)
 ;;=1026^Etiology/Related and/or Risk Factors^2^NURSC^24^0
 ;;^UTILITY("^GMRD(124.2,",$J,353,1,2,0)
 ;;=1027^Goals/Expected Outcomes^2^NURSC^23^0
 ;;^UTILITY("^GMRD(124.2,",$J,353,1,3,0)
 ;;=1029^Nursing Intervention/Orders^2^NURSC^20^0
 ;;^UTILITY("^GMRD(124.2,",$J,353,1,4,0)
 ;;=1030^Related Problems^2^NURSC^20^0
 ;;^UTILITY("^GMRD(124.2,",$J,353,1,5,0)
 ;;=4342^Defining Characteristics^2^NURSC^58
 ;;^UTILITY("^GMRD(124.2,",$J,353,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,353,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,353,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,353,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,353,"TD",1,0)
 ;;=A state in which an individual is unable to control excretory function
 ;;^UTILITY("^GMRD(124.2,",$J,353,"TD",2,0)
 ;;=characterized by involuntary passage of stool.
 ;;^UTILITY("^GMRD(124.2,",$J,354,0)
 ;;=Incontinence, Urine^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,354,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,354,1,1,0)
 ;;=1133^Etiology/Related and/or Risk Factors^2^NURSC^29^0
 ;;^UTILITY("^GMRD(124.2,",$J,354,1,2,0)
 ;;=1134^Goals/Expected Outcomes^2^NURSC^27^0
 ;;^UTILITY("^GMRD(124.2,",$J,354,1,3,0)
 ;;=1135^Nursing Intervention/Orders^2^NURSC^24^0
 ;;^UTILITY("^GMRD(124.2,",$J,354,1,4,0)
 ;;=1136^Related Problems^2^NURSC^21^0
 ;;^UTILITY("^GMRD(124.2,",$J,354,1,5,0)
 ;;=4081^Defining Characteristics^2^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,354,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,354,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,354,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,354,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,354,"TD",1,0)
 ;;=The state in which an individual experiences an involuntary, unpre-
 ;;^UTILITY("^GMRD(124.2,",$J,354,"TD",2,0)
 ;;=dictable passage of urine.
 ;;^UTILITY("^GMRD(124.2,",$J,355,0)
 ;;=Infection Potential (Specific to Elimination)^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,355,1,0)
 ;;=^124.21PI^4^4
