DGPROSAD ;ALB/CKN - Patient Add support for Prosthetics/CERNER; 03/24/23 11:12pm ; 4/14/23 3:05pm
 ;;5.3;Registration;**1096**;Aug 13, 1993;Build 24
 ;This API is supported by DBIA #7421
 Q
 ;
ADD(SRCID,SITE) ;Add patient to site mentioned
 ;This utility code is to support IFC to add patient into VistA for
 ;provided ICN OR EDIPI (one of the value must be passed in)
 ;Input: SRCID - Fully qualified ID (Required)
 ;            ex: For ICN: FullICN~USVHA~NI~200M
 ;                For EDIPI: EDIPI~USDOD~NI~200DOD
 ;       SITE - VistA station number (default: current VistA site)
 ;Output: 1^ICN^STATION NUMBER^DFN value if patient record is created at Site
 ;        Or
 ;        -1^Error message if failed
 ;
 N RETURN,RPC,ICN,DFN,ID,AA,IDTYP,STA,I,RET,RSLT
 I $G(SRCID)="" Q "-1^ID parameter is missing"
 S ID=$P(SRCID,"~"),AA=$P(SRCID,"~",2),IDTYP=$P(SRCID,"~",3),STA=$P(SRCID,"~",4)
 I ID="" Q "-1^Source ID is missing in ID parameter"
 I AA="" Q "-1^Assigning Authority is missing in ID parameter"
 I ((AA'="USVHA")&(AA'="USDOD")) Q "-1^Invalid Assigning Authority for ICN or EDIPI"
 I IDTYP="" Q "-1^ID Type is missing in ID parameter"
 I IDTYP'="NI" Q "-1^Invalid ID type in ID parameter for ICN or EDIPI value"
 I STA="" Q "-1^Station Number is missing in ID parameter"
 I $$IEN^XUAF4($G(STA))="" Q "-1^Invalid Station number in ID parameter"
 I AA="USVHA",(STA'="200M") Q "-1^Assigning Authority and Station number invalid for ICN"
 I AA="USDOD",(STA'="200DOD") Q "-1^Assiging Authority and Station number invalid for EDIPI"
 I $G(SITE)="" S SITE=$P($$SITE^VASITE(),"^",3) ;Default Site to add patient
 I '$$IEN^XUAF4(SITE) Q "-1^Invalid VistA site"
 ;Call MPI RPC - MPI IFC VISTA ADD PATIENT to create patient at VistA
 ;If ICN is passed in, MPI will remotely create patient in VistA using PV data
 ;If EDIPI is passed in, MPI will find 200DOD correlation and use associated ICN
 ;with the correlation to create patient in VistA using its PV data
 ;If EDIPI not found at MPI, MPI will request DoD orchestration to PSIM and once
 ;200DoD correlation is created, using its ICN PV data to create patient at VistA
 S RPC="MPI IFC VISTA ADD PATIENT"
 N DONE,HCNT S HCNT=1
 S DONE=0
TR ;
 D EN1^XWB2HL7(.RET,"200M",RPC,1,$G(SRCID),$G(SITE))
 I $G(RET(0))="" S HCNT=HCNT+1 H 2 I HCNT<15 G TR
 I $G(RET(0))="" Q "-1^"_$G(RET(1))
 I +$G(RET(0))=-1 Q $G(RET(0))
 F I=1:1:25 D  Q:DONE
 .D RPCCHK^XWB2HL7(.RSLT,$G(RET(0)))
 .I $P($G(RSLT(0)),"^")=-1 S DONE=1 Q
 .I $P($G(RSLT(0)),"^")>0 S DONE=1 Q
 .K RSLT
 .H 5
 I $P($G(RSLT(0)),"^")=-1 Q $G(RSLT(0))
 I $P($G(RSLT(0)),"^")'>0 Q "-1^Sorry, it is taking too long retrieve patient information, Please try again later!"
 I +$G(RSLT(0))=1 D RTNDATA^XWBDRPC(.RETURN,RET(0))
 Q $G(RETURN(0))
