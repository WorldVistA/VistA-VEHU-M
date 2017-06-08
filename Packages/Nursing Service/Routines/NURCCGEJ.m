NURCCGEJ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13270,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,13270,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13270,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13273,0)
 ;;=[Extra Order]^3^NURSC^11^236^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13273,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13273,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13275,0)
 ;;=Defining Characteristics^2^NURSC^12^153^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13275,1,0)
 ;;=^124.21PI^7^6
 ;;^UTILITY("^GMRD(124.2,",$J,13275,1,1,0)
 ;;=4306^claudication^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13275,1,2,0)
 ;;=4307^diminished arterial pulsation, BP changes in extremities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13275,1,4,0)
 ;;=4311^skin of extremity blue or purple when dependent^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13275,1,5,0)
 ;;=4312^leg becomes pale on elevation and remains pale when lowered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13275,1,6,0)
 ;;=4313^skin quality shining and without hair^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13275,1,7,0)
 ;;=4314^skin temperature cold extremities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13275,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13294,0)
 ;;=provide patient teaching (Gas Exchange, Impaired)^2^NURSC^11^6^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13294,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,13294,1,1,0)
 ;;=457^discuss risk factors [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13294,1,2,0)
 ;;=458^disease process^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13294,1,3,0)
 ;;=459^medications^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13294,1,4,0)
 ;;=460^pulmonary hygiene^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13294,1,5,0)
 ;;=461^signs of infection (for reporting to health care provider)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13294,1,6,0)
 ;;=462^inhalation equipment and oxygen therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13294,1,7,0)
 ;;=463^fire and safety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13294,1,8,0)
 ;;=464^ventilator use, cleaning, assembly, and back-up equipment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13294,1,9,0)
 ;;=465^suctioning^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13294,1,10,0)
 ;;=466^emergency care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13294,1,11,0)
 ;;=2712^tracheostomy care q[frequency]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,13294,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,13294,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13294,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13294,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13300,0)
 ;;=Communication Impaired^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13300,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,13300,1,1,0)
 ;;=13302^Etiology/Related and/or Risk Factors^2^NURSC^178
 ;;^UTILITY("^GMRD(124.2,",$J,13300,1,2,0)
 ;;=13340^Goals/Expected Outcomes^2^NURSC^176
 ;;^UTILITY("^GMRD(124.2,",$J,13300,1,3,0)
 ;;=13353^Nursing Intervention/Orders^2^NURSC^149
 ;;^UTILITY("^GMRD(124.2,",$J,13300,1,4,0)
 ;;=13379^Defining Characteristics^2^NURSC^154
 ;;^UTILITY("^GMRD(124.2,",$J,13300,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13300,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13300,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13300,"TD",0)
 ;;=^^2^2^2890803^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,13300,"TD",1,0)
 ;;=The state in which an individual experiences a decreased or absent
 ;;^UTILITY("^GMRD(124.2,",$J,13300,"TD",2,0)
 ;;=ability to use or understand language in human interaction.
 ;;^UTILITY("^GMRD(124.2,",$J,13302,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^178^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13302,1,0)
 ;;=^124.21PI^17^8
 ;;^UTILITY("^GMRD(124.2,",$J,13302,1,1,0)
 ;;=1101^anatomic deficit [specify]^3^NURSC^1
