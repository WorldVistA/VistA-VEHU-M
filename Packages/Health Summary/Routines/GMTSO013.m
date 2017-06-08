GMTSO013 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1420,1,5,0)
 ;;=  
 ;;^UTILITY(U,$J,"PRO",1420,1,6,0)
 ;;=NOTE: If no time limit is defined, all active orders are reported.  If a time
 ;;^UTILITY(U,$J,"PRO",1420,1,7,0)
 ;;=limit is defined, all unit dose orders which have an expiration or cancel
 ;;^UTILITY(U,$J,"PRO",1420,1,8,0)
 ;;=date within the time limit range are reported.  
 ;;^UTILITY(U,$J,"PRO",1420,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1420,2,2,0)
 ;;=HS PHARMACY UNIT DOSE
 ;;^UTILITY(U,$J,"PRO",1420,2,"B","HS PHARMACY UNIT DOSE",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1420,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1420,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1420,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="RXUD",GMTSTITL="UNIT DOSE PHARMACY" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1420,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1421,0)
 ;;=GMTS PN^Health Summary Progress Notes^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1421,1,0)
 ;;=^^8^8^2910301^
 ;;^UTILITY(U,$J,"PRO",1421,1,1,0)
 ;;=This component contains progress notes from the Generic Progress Notes 
 ;;^UTILITY(U,$J,"PRO",1421,1,2,0)
 ;;=Package AND progress notes from the Mental Health Package.  Time and maximum
 ;;^UTILITY(U,$J,"PRO",1421,1,3,0)
 ;;=occurrence limits apply to this component.  Data presented include: Progress
 ;;^UTILITY(U,$J,"PRO",1421,1,4,0)
 ;;=note date/time, title, text of note, electronic signature block, and the
 ;;^UTILITY(U,$J,"PRO",1421,1,5,0)
 ;;=note's correction text and correction date/time.  
 ;;^UTILITY(U,$J,"PRO",1421,1,6,0)
 ;;=  
 ;;^UTILITY(U,$J,"PRO",1421,1,7,0)
 ;;=Only those notes which have been signed with an electronic signature will be
 ;;^UTILITY(U,$J,"PRO",1421,1,8,0)
 ;;=reported.  
 ;;^UTILITY(U,$J,"PRO",1421,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1421,2,1,0)
 ;;=HS PROGRESS NOTES
 ;;^UTILITY(U,$J,"PRO",1421,2,"B","HS PROGRESS NOTES",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1421,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1421,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1421,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="PN",GMTSTITL="PROGRESS NOTES" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1421,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1422,0)
 ;;=GMTS BPN^Health Summary Brief Progress Notes^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1422,1,0)
 ;;=^^7^7^2910301^
 ;;^UTILITY(U,$J,"PRO",1422,1,1,0)
 ;;=This component contains information from the Mental Health and Generic 
 ;;^UTILITY(U,$J,"PRO",1422,1,2,0)
 ;;=Progress Notes packages. Time and maximum occurrence limits apply.  Data 
 ;;^UTILITY(U,$J,"PRO",1422,1,3,0)
 ;;=presented include:  Progress note date/time, title, author and last 
 ;;^UTILITY(U,$J,"PRO",1422,1,4,0)
 ;;=correction date/time.  
 ;;^UTILITY(U,$J,"PRO",1422,1,5,0)
 ;;=  
 ;;^UTILITY(U,$J,"PRO",1422,1,6,0)
 ;;=Only those notes which have been signed with an electronic signature will be
 ;;^UTILITY(U,$J,"PRO",1422,1,7,0)
 ;;=listed.  
 ;;^UTILITY(U,$J,"PRO",1422,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1422,2,1,0)
 ;;=HS PROGRESS NOTES BRIEF
 ;;^UTILITY(U,$J,"PRO",1422,2,"B","HS PROGRESS NOTES BRIEF",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1422,3,0)
 ;;=^101.03P^88^1
 ;;^UTILITY(U,$J,"PRO",1422,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1422,20)
 ;;=S:'$D(DFN)&$D(ORVP) DFN=+ORVP S GMTSPRM="BPN",GMTSTITL="BRIEF PROGRESS NOTES" D ENCWA^GMTS
 ;;^UTILITY(U,$J,"PRO",1422,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1423,0)
 ;;=GMTS RI^Health Summary Radiology Impression^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1423,1,0)
 ;;=^^5^5^2910301^
 ;;^UTILITY(U,$J,"PRO",1423,1,1,0)
 ;;=This component contains impressions from the Radiology package.  Time and 
