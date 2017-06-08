GMTSO010 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1411,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1412,0)
 ;;=GMTS PRC^Health Summary Procedures (ICD codes)^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1412,1,0)
 ;;=^^6^6^2910301^
 ;;^UTILITY(U,$J,"PRO",1412,1,1,0)
 ;;=This component contains MAS coded procedures, by admission, extracted from 
 ;;^UTILITY(U,$J,"PRO",1412,1,2,0)
 ;;=the MAS package.  Time and occurrence limits apply to this component.  Data 
 ;;^UTILITY(U,$J,"PRO",1412,1,3,0)
 ;;=presented include:  procedure date, procedure name, and ICD-9CM procedure 
 ;;^UTILITY(U,$J,"PRO",1412,1,4,0)
 ;;=codes.  
 ;;^UTILITY(U,$J,"PRO",1412,1,5,0)
 ;;=  
 ;;^UTILITY(U,$J,"PRO",1412,1,6,0)
 ;;=Note: The occurrence limits are determined by the occurrence of admissions.  
 ;;^UTILITY(U,$J,"PRO",1412,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1412,2,2,0)
 ;;=HS MAS PROCEDURES ICD CODES
 ;;^UTILITY(U,$J,"PRO",1412,2,"B","HS MAS PROCEDURES ICD CODES",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1412,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1412,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1412,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="PRC",GMTSTITL="PROCEDURES" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1412,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1413,0)
 ;;=GMTS OPC^Health Summary Surgeries (ICD codes)^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1413,1,0)
 ;;=^^6^6^2910301^
 ;;^UTILITY(U,$J,"PRO",1413,1,1,0)
 ;;=This component contains MAS coded surgeries, by admission, extracted from the
 ;;^UTILITY(U,$J,"PRO",1413,1,2,0)
 ;;=MAS package.  Time and occurrence limits apply to this component.  Data
 ;;^UTILITY(U,$J,"PRO",1413,1,3,0)
 ;;=presented include:  surgery date, procedure name, and ICD-9CM procedure 
 ;;^UTILITY(U,$J,"PRO",1413,1,4,0)
 ;;=codes.  
 ;;^UTILITY(U,$J,"PRO",1413,1,5,0)
 ;;=  
 ;;^UTILITY(U,$J,"PRO",1413,1,6,0)
 ;;=Note: The occurrence limits are determined by the occurrence of admissions.  
 ;;^UTILITY(U,$J,"PRO",1413,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1413,2,2,0)
 ;;=HS MAS SURGERIES ICD CODES
 ;;^UTILITY(U,$J,"PRO",1413,2,"B","HS MAS SURGERIES ICD CODES",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1413,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1413,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1413,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="OPC",GMTSTITL="MAS SURGERY" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1413,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1414,0)
 ;;=GMTS TR^Health Summary Transfers^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1414,1,0)
 ;;=^^5^5^2910301^
 ;;^UTILITY(U,$J,"PRO",1414,1,1,0)
 ;;=This component contains information extracted from the MAS package.  Time and
 ;;^UTILITY(U,$J,"PRO",1414,1,2,0)
 ;;=occurrence limits apply to this component.  Data presented include:  transfer
 ;;^UTILITY(U,$J,"PRO",1414,1,3,0)
 ;;=date, type, destination, and provider (when available).  
 ;;^UTILITY(U,$J,"PRO",1414,1,4,0)
 ;;=  
 ;;^UTILITY(U,$J,"PRO",1414,1,5,0)
 ;;=Note: The occurrence limits are determined by the occurrence of admissions.  
 ;;^UTILITY(U,$J,"PRO",1414,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1414,2,2,0)
 ;;=HS MAS TRANSFERS
 ;;^UTILITY(U,$J,"PRO",1414,2,"B","HS MAS TRANSFERS",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1414,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1414,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1414,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="TR",GMTSTITL="TRANSFERS" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1414,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1415,0)
 ;;=GMTS TS^Health Summary Treating Speciality^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1415,1,0)
 ;;=^^6^6^2910301^
