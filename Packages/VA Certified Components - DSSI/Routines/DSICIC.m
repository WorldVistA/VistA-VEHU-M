DSICIC ;DSS/LM - Insurance card RPC's ;12/14/2004
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;
 ; 4419   $$INSUR^IBBAPI
 ; 
 Q
INSUR(RESULT,DFN,IBDT,IBSTAT,IBFLDS) ;;Wraps $$INSUR^IBBAPI
 ; Implements DSICIC PATIENT INSURANCE DATA remote procedure
 ; See REMOTE PROCEDURE entry for input parameter definitions
 ; 
 ; Returns patient insurance data in local array
 ; 
 S RESULT(1)="-1^Patient ID Required" Q:'$G(DFN)
 S IBDT=$G(IBDT),IBSTAT=$G(IBSTAT)
 S IBFLDS=$G(IBFLDS,"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17")
 N DSICICR,Y S Y=$$INSUR^IBBAPI(DFN,IBDT,IBSTAT,.DSICICR,IBFLDS)
 I Y<0 D  Q
 .S RESULT(1)=Y,Y=$O(DSICICR("IBBAPI","INSUR","ERROR","")) Q:'Y
 .S RESULT(1)=RESULT(1)_U_DSICICR("IBBAPI","INSUR","ERROR",Y)
 .Q
 I Y=0 S RESULT(1)=Y_U_"No data found" Q
 N I S I=0,Y="DSICICR" F  S Y=$Q(@Y) Q:Y=""  D
 .S I=I+1,RESULT(I)=$QS(Y,3)_","_$QS(Y,4)_U_@Y
 .Q
 Q
