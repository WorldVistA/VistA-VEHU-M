VEJDIC3 ;DSS/LM - Insurance card RPC's ;12/14/2004
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;
 ; 4419   $$INSUR^IBBAPI
 ; 
 Q
INSUR(VEJD,DFN,IBDT,IBSTAT,IBFLDS) ;;Wraps $$INSUR^IBBAPI
 ; Implements VEJDIC PATIENT INSURANCE DATA remote procedure
 ; See REMOTE PROCEDURE entry for input parameter definitions
 ; 
 ; Returns patient insurance data in local array
 ; 
 S VEJD(1)="-1^Patient ID Required" Q:'$G(DFN)
 S IBDT=$G(IBDT),IBSTAT=$G(IBSTAT)
 S IBFLDS=$G(IBFLDS,"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17")
 N VEJICR,Y S Y=$$INSUR^IBBAPI(DFN,IBDT,IBSTAT,.VEJICR,IBFLDS)
 I Y<0 D  Q
 .S VEJD(1)=Y,Y=$O(VEJICR("IBBAPI","INSUR","ERROR","")) Q:'Y
 .S VEJD(1)=VEJD(1)_U_VEJICR("IBBAPI","INSUR","ERROR",Y)
 .Q
 I Y=0 S VEJD(1)=Y_U_"No data found" Q
 N I S I=0,Y="VEJICR" F  S Y=$Q(@Y) Q:Y=""  D
 .S I=I+1,VEJD(I)=$QS(Y,3)_","_$QS(Y,4)_U_@Y
 .Q
 Q
