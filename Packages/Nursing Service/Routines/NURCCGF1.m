NURCCGF1 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14049,1,2,0)
 ;;=14064^Related Problems^2^NURSC^161
 ;;^UTILITY("^GMRD(124.2,",$J,14049,1,3,0)
 ;;=14073^Goals/Expected Outcomes^2^NURSC^185
 ;;^UTILITY("^GMRD(124.2,",$J,14049,1,4,0)
 ;;=14097^Nursing Intervention/Orders^2^NURSC^155
 ;;^UTILITY("^GMRD(124.2,",$J,14049,1,5,0)
 ;;=14140^Defining Characteristics^2^NURSC^164
 ;;^UTILITY("^GMRD(124.2,",$J,14049,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14049,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14049,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14049,"TD",0)
 ;;=^^2^2^2900607^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,14049,"TD",1,0)
 ;;=A state in which an individual experiences behaviors that can be
 ;;^UTILITY("^GMRD(124.2,",$J,14049,"TD",2,0)
 ;;=physically harmful to others.
 ;;^UTILITY("^GMRD(124.2,",$J,14050,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^188^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14050,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,14050,1,1,0)
 ;;=2185^antisocial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14050,1,2,0)
 ;;=2186^battered women^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14050,1,3,0)
 ;;=2187^catatonic excitement^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14050,1,4,0)
 ;;=2188^child abuse^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14050,1,5,0)
 ;;=2189^manic excitement^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14050,1,6,0)
 ;;=2190^organic brain syndrome^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14050,1,7,0)
 ;;=2191^panic states^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14050,1,8,0)
 ;;=2192^rage reactions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14050,1,9,0)
 ;;=2193^suicidal behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14050,1,10,0)
 ;;=2194^temporal lobe epilepsy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14050,1,11,0)
 ;;=2195^toxic reactions to medications^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14050,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14060,0)
 ;;=Post Trauma Response^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14060,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14060,1,1,0)
 ;;=14063^Etiology/Related and/or Risk Factors^2^NURSC^189
 ;;^UTILITY("^GMRD(124.2,",$J,14060,1,2,0)
 ;;=14077^Related Problems^2^NURSC^162
 ;;^UTILITY("^GMRD(124.2,",$J,14060,1,3,0)
 ;;=14098^Goals/Expected Outcomes^2^NURSC^186
 ;;^UTILITY("^GMRD(124.2,",$J,14060,1,4,0)
 ;;=14136^Nursing Intervention/Orders^2^NURSC^156
 ;;^UTILITY("^GMRD(124.2,",$J,14060,1,5,0)
 ;;=14175^Defining Characteristics^2^NURSC^165
 ;;^UTILITY("^GMRD(124.2,",$J,14060,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14060,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14060,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14060,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,14060,"TD",1,0)
 ;;=The state of an individual experiencing a sustained painful response
 ;;^UTILITY("^GMRD(124.2,",$J,14060,"TD",2,0)
 ;;=to (an) overwhelming traumatic event(s).
 ;;^UTILITY("^GMRD(124.2,",$J,14063,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^189^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14063,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,14063,1,1,0)
 ;;=2067^disasters^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14063,1,2,0)
 ;;=2068^wars^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14063,1,3,0)
 ;;=2070^epidemics^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14063,1,4,0)
 ;;=2071^rape^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14063,1,5,0)
 ;;=2072^assault^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14063,1,6,0)
 ;;=2074^torture^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14063,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14064,0)
 ;;=Related Problems^2^NURSC^7^161^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14064,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14064,1,1,0)
 ;;=1945^Family Process, Alteration In^3^NURSC^1
