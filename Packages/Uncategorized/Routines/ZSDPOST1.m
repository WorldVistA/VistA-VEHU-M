ZSDPOST1    ;LV/PB - Post INT routine for Scheduling KIDS build;July 16, 2013
 ;;1.0;LONGVIEW SCHEDULING;**1**;Jul 16,2013;Build 67
 ;Post INT routine to registered new RPC's to the SD API option
EN  ; get IEN for Option file entry for SD API and get the IEN from the Remote
 ;Procedure file for the two new RPCs
 ;VARIABLES:
 ; CTX = IEN from Option File $19
 ; RPC = IEN for the RPC from the Remote Procedure File #8994
 ; XX = Looping control varible
 ; YY = name of RPC for looping in the B xref of XWB(8994
 S CTX=$O(^DIC(19,"B","SD API",0))
 Q:CTX'>0
 F I=1:1 S XX=$P($T(RPCLIST+I),";",3) Q:$P($T(RPCLIST+I),";",3)=""  D
 .S RPC=$O(^XWB(8994,"B",XX,""))
 .D REGRPC^ZRPCREG(RPC,CTX)
 D REGCPRS
 Q
REGCPRS
 ;Procedure file for the two new RPCs
 ;VARIABLES:
 ; CTX = IEN from Option File $19
 ; RPC = IEN for the RPC from the Remote Procedure File #8994
 ; XX = Looping control varible
 ; YY = name of RPC for looping in the B xref of XWB(8994
 K CTX,I,RPC,RPCLIST
 S CTX=$O(^DIC(19,"B","OR CPRS GUI CHART",0))
 Q:CTX'>0
 F I=1:1 S XX=$P($T(RPCLIST+I),";",3) Q:$P($T(RPCLIST+I),";",3)=""  D
 .S RPC=$O(^XWB(8994,"B",XX,""))
 .D REGRPC^ZRPCREG(RPC,CTX)
 Q
RPCLIST ;
 ;;ZSD FACILITY NEAR LIST;
 ;;ZSD FACILITY WAIT LIST;
 ;;ZSD PATIENT NEAR LIST;
 ;;ZSD RECALL FACILITY LIST;
 ;;ZSD RECALL LIST BY PATIENT;
 ;;ZSD UPDATE NEAR LIST;
 ;;ZSD WAIT LIST BY DFN;
 ;;ZSD PROVIDER TO CLINICS;
 ;;ZSD PATIENT PENDING APPT;
 ;;ZSD REMOVE FROM RECALL LIST
 ;;ZSD CANCEL APPOINTMENT
 ;;ZSD REMOVE FROM EWL
 ;;ZSD ADDITIONAL CLINIC DETAILS
 ;;ZSD ADD TO RECALL LIST
 ;;ZSD VERIFY CLINIC ACCESS
 ;;ZSD EWL NEW
 ;;ZOR NO PATIENT CSLT LOOKUP
 ;;ZOM PATIENT ADMISSIONS
 ;;SD APPOINTMENT MAKE
 Q
