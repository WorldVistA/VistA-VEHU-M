NURCCG2E ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,740,1,6,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,740,1,7,0)
 ;;=2758^Pain, Acute^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,741,0)
 ;;=Self Concept, Disturbance In^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,741,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,741,1,1,0)
 ;;=1976^Etiology/Related and/or Risk Factors^2^NURSC^53^0
 ;;^UTILITY("^GMRD(124.2,",$J,741,1,2,0)
 ;;=1985^Related Problems^2^NURSC^40^0
 ;;^UTILITY("^GMRD(124.2,",$J,741,1,3,0)
 ;;=1993^Goals/Expected Outcomes^2^NURSC^53^0
 ;;^UTILITY("^GMRD(124.2,",$J,741,1,4,0)
 ;;=2014^Nursing Intervention/Orders^2^NURSC^49^0
 ;;^UTILITY("^GMRD(124.2,",$J,741,1,5,0)
 ;;=4116^Defining Characteristics^2^NURSC^73
 ;;^UTILITY("^GMRD(124.2,",$J,741,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,741,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,741,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,741,"TD",0)
 ;;=^^2^2^2890307^^^
 ;;^UTILITY("^GMRD(124.2,",$J,741,"TD",1,0)
 ;;=A disruption in the way one perceives one's body image, self-esteem,
 ;;^UTILITY("^GMRD(124.2,",$J,741,"TD",2,0)
 ;;=role performance, and/or personal identity.
 ;;^UTILITY("^GMRD(124.2,",$J,742,0)
 ;;=Coping, Ineffective Individual^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,742,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,742,1,1,0)
 ;;=1837^Etiology/Related and/or Risk Factors^2^NURSC^49^0
 ;;^UTILITY("^GMRD(124.2,",$J,742,1,2,0)
 ;;=1838^Goals/Expected Outcomes^2^NURSC^48^0
 ;;^UTILITY("^GMRD(124.2,",$J,742,1,3,0)
 ;;=1839^Nursing Intervention/Orders^2^NURSC^44^0
 ;;^UTILITY("^GMRD(124.2,",$J,742,1,4,0)
 ;;=1840^Related Problems^2^NURSC^37^0
 ;;^UTILITY("^GMRD(124.2,",$J,742,1,5,0)
 ;;=4131^Defining Characteristics^2^NURSC^18
 ;;^UTILITY("^GMRD(124.2,",$J,742,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,742,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,742,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,742,"TD",0)
 ;;=^^2^2^2890306^^^
 ;;^UTILITY("^GMRD(124.2,",$J,742,"TD",1,0)
 ;;=Ineffective coping is the impairment of adaptive behaviors and problem
 ;;^UTILITY("^GMRD(124.2,",$J,742,"TD",2,0)
 ;;=solving abilities of a person in meeting life's demands and roles.
 ;;^UTILITY("^GMRD(124.2,",$J,743,0)
 ;;=Grieving, Anticipatory^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,743,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,743,1,1,0)
 ;;=2275^Etiology/Related and/or Risk Factors^2^NURSC^63^0
 ;;^UTILITY("^GMRD(124.2,",$J,743,1,2,0)
 ;;=2277^Goals/Expected Outcomes^2^NURSC^62^0
 ;;^UTILITY("^GMRD(124.2,",$J,743,1,3,0)
 ;;=2279^Nursing Intervention/Orders^2^NURSC^57^0
 ;;^UTILITY("^GMRD(124.2,",$J,743,1,4,0)
 ;;=2280^Related Problems^2^NURSC^50^0
 ;;^UTILITY("^GMRD(124.2,",$J,743,1,5,0)
 ;;=4106^Defining Characteristics^2^NURSC^15
 ;;^UTILITY("^GMRD(124.2,",$J,743,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,743,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,743,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,743,"TD",0)
 ;;=^^1^1^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,743,"TD",1,0)
 ;;=Grieving before an actual loss.
 ;;^UTILITY("^GMRD(124.2,",$J,744,0)
 ;;=Grieving, Dysfunctional^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,744,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,744,1,1,0)
 ;;=2294^Etiology/Related and/or Risk Factors^2^NURSC^64^0
 ;;^UTILITY("^GMRD(124.2,",$J,744,1,2,0)
 ;;=2295^Goals/Expected Outcomes^2^NURSC^63^0
 ;;^UTILITY("^GMRD(124.2,",$J,744,1,3,0)
 ;;=2296^Nursing Intervention/Orders^2^NURSC^58^0
 ;;^UTILITY("^GMRD(124.2,",$J,744,1,4,0)
 ;;=2297^Related Problems^2^NURSC^51^0
 ;;^UTILITY("^GMRD(124.2,",$J,744,1,5,0)
 ;;=4117^Defining Characteristics^2^NURSC^16
 ;;^UTILITY("^GMRD(124.2,",$J,744,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,744,9)
 ;;=D EN2^NURCCPU3
