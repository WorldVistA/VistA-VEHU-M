GMTSO014 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1423,1,2,0)
 ;;=maximum occurrence limits apply.  Data presented include:  study date, 
 ;;^UTILITY(U,$J,"PRO",1423,1,3,0)
 ;;=procedure(s), status, and radiologist's impression (narrative).  
 ;;^UTILITY(U,$J,"PRO",1423,1,4,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",1423,1,5,0)
 ;;=Only radiology impressions which have been verified are reported.  
 ;;^UTILITY(U,$J,"PRO",1423,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1423,2,1,0)
 ;;=HS RADIOLOGY IMPRESSION
 ;;^UTILITY(U,$J,"PRO",1423,2,"B","HS RADIOLOGY IMPRESSION",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1423,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1423,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1423,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="RI",GMTSTITL="RADIOLOGY IMPRESSION" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1423,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1424,0)
 ;;=GMTS RP^Health Summary Radiology Profile^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1424,1,0)
 ;;=^^7^7^2910301^
 ;;^UTILITY(U,$J,"PRO",1424,1,1,0)
 ;;=This component contains information from the Radiology package.  Time and
 ;;^UTILITY(U,$J,"PRO",1424,1,2,0)
 ;;=maximum occurrence limits apply.  Data presented include:  study date, 
 ;;^UTILITY(U,$J,"PRO",1424,1,3,0)
 ;;=procedure(s) with status(es), report status, staff radiologist, resident 
 ;;^UTILITY(U,$J,"PRO",1424,1,4,0)
 ;;=radiologist, and the narrative fields modifier, history, report, and 
 ;;^UTILITY(U,$J,"PRO",1424,1,5,0)
 ;;=impression.  
 ;;^UTILITY(U,$J,"PRO",1424,1,6,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",1424,1,7,0)
 ;;=Only radiology profiles which have been verified are reported.  
 ;;^UTILITY(U,$J,"PRO",1424,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1424,2,1,0)
 ;;=HS RADIOLOGY PROFILE
 ;;^UTILITY(U,$J,"PRO",1424,2,"B","HS RADIOLOGY PROFILE",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1424,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1424,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1424,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="RP",GMTSTITL="RADIOLOGY PROFILE" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1424,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1425,0)
 ;;=GMTS RS^Health Summary Radiology Status^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1425,1,0)
 ;;=^^3^3^2910301^
 ;;^UTILITY(U,$J,"PRO",1425,1,1,0)
 ;;=This component contains procedure statuses from the Radiology package.  Time 
 ;;^UTILITY(U,$J,"PRO",1425,1,2,0)
 ;;=and maximum occurrence limits apply. Data presented include:  request date/ 
 ;;^UTILITY(U,$J,"PRO",1425,1,3,0)
 ;;=time, status, procedure, scheduled date/time, and provider name.  
 ;;^UTILITY(U,$J,"PRO",1425,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1425,2,1,0)
 ;;=HS RADIOLOGY STATUS
 ;;^UTILITY(U,$J,"PRO",1425,2,"B","HS RADIOLOGY STATUS",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1425,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1425,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1425,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="RS",GMTSTITL="RADIOLOGY STATUS" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1425,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1426,0)
 ;;=GMTS SR^Health Summary Surgery Reports^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1426,1,0)
 ;;=^^7^7^2910301^
 ;;^UTILITY(U,$J,"PRO",1426,1,1,0)
 ;;=This component contains information from the Surgery package.  Time and 
 ;;^UTILITY(U,$J,"PRO",1426,1,2,0)
 ;;=maximum occurrence limits apply.  Data presented include:  surgery date, 
 ;;^UTILITY(U,$J,"PRO",1426,1,3,0)
 ;;=surgeon, surgery report status, pre-operative diagnosis, post-operative 
 ;;^UTILITY(U,$J,"PRO",1426,1,4,0)
 ;;=diagnosis, surgeon's dictation, current procedural terminology operation code
