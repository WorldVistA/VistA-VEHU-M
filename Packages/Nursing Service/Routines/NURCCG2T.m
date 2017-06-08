NURCCG2T ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,10,0)
 ;;=940^administer prescribed laxative, stool softener or enema^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,11,0)
 ;;=943^use digital stimulation to relax sphincter^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,12,0)
 ;;=945^teach patient to respond immediately to elimination urge^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,13,0)
 ;;=946^teach adverse effects of habitual use of enemas, laxatives^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,14,0)
 ;;=948^teach about normal bowel pattern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,15,0)
 ;;=952^teach when to seek medical attention^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,16,0)
 ;;=955^teach side effects of many medications maybe constipation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,17,0)
 ;;=957^teach to attempt defecation [ ]hr/s after meal and @ [ ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,18,0)
 ;;=2972^[Extra Order]^3^NURSC^55^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,886,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,887,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^22^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,887,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,887,1,1,0)
 ;;=894^insuring agents^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,887,1,2,0)
 ;;=903^chemical^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,887,1,3,0)
 ;;=904^physical^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,887,1,4,0)
 ;;=764^psychologic^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,887,1,5,0)
 ;;=1050^myocardial ischemia^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,887,1,6,0)
 ;;=759^biological^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,887,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,888,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^21^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,888,1,0)
 ;;=^124.21PI^12^12
 ;;^UTILITY("^GMRD(124.2,",$J,888,1,1,0)
 ;;=909^expresses sense of comfort with ICU/CCU routine^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,888,1,2,0)
 ;;=910^states anxiety and fears are alleviated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,888,1,3,0)
 ;;=911^conserves energy^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,888,1,4,0)
 ;;=920^verbalizes onset & description of chest pain on 1-10 scale^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,888,1,5,0)
 ;;=923^remains hemodynamically stable^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,888,1,6,0)
 ;;=941^states free of pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,888,1,7,0)
 ;;=942^lab values return to normal e.g. enzymes, ABGs, CBC^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,888,1,8,0)
 ;;=944^maintains personal integrity and self worth^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,888,1,9,0)
 ;;=947^free from complications related to immobility/hemostasis^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,888,1,10,0)
 ;;=953^relates risk factors of CAD^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,888,1,11,0)
 ;;=954^describes preventive measures related to CAD^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,888,1,12,0)
 ;;=2886^[Extra Goal]^3^NURSC^63^0
 ;;^UTILITY("^GMRD(124.2,",$J,888,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,889,0)
 ;;=Related Problems^2^NURSC^7^17^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,889,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,889,1,1,0)
 ;;=1398^Nutrition, Alteration In: Less Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,889,1,2,0)
 ;;=1399^Nutrition, Alteration In: More Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,889,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,890,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^18^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,0)
 ;;=^124.21PI^18^18
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,1,0)
 ;;=956^attach to cardiac monitor; obtain rhythm strip^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,2,0)
 ;;=958^document history of pain^2^NURSC^1^0
