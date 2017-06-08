SDPOST1    ;LV/PB - Post INT routine for Scheduling KIDS build;July 16, 2013
 ;;1.0;LONGVIEW SCHEDULING;**1**;Jul 16,2013;Build 77
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
 .D REGRPC(RPC,CTX)
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
 .W !,XX
 .S RPC=$O(^XWB(8994,"B",XX,""))
 .D REGRPC(RPC,CTX)
 Q
REGRPC(RPC,CTX,DEL) ;EP
 S RPC=+$$GETRPC(RPC)
 Q $S(RPC<1:0,1:$$REGMULT(19.05,"RPC",RPC,.CTX,.DEL))
 ; Add/remove a context to/from the ITEM multiple of another context.
 ; Add/delete an entry to/from a specified OPTION multiple.
 ; SFN = Subfile #
 ; NOD = Subnode for multiple
 ; ITM = Item IEN to add
 ; CTX = Option to add to
 ; DEL = Delete flag (optional)
REGMULT(SFN,NOD,ITM,CTX,DEL) ;
 ;W !,"REGMULT"
 N FDA,IEN
 S CTX=+$$GETOPT(CTX)
 S DEL=+$G(DEL)
 S IEN=+$O(^DIC(19,CTX,NOD,"B",ITM,0))
 Q:'IEN=DEL -1
 K ^TMP("DIERR",$J)
 I DEL S FDA(SFN,IEN_","_CTX_",",.01)="@"
 E  S FDA(SFN,"+1,"_CTX_",",.01)=ITM
 D UPDATE^DIE("","FDA")
 S FDA='$D(^TMP("DIERR",$J)) K ^($J)
 Q FDA
 ; Return IEN of option
GETOPT(X) ;EP
 N Y
 Q:X=+X X
 S Y=$$FIND1^DIC(19,"","X",X)
 W:'Y "Cannot find option "_X,!!
 Q Y
GETRPC(X) ;EP
 N Y
 Q:X=+X X
 W !,X
 S Y=$$FIND1^DIC(8994,"","X",X)
 W:'Y "Cannot find RPC "_X,!!
 Q Y
RPCLIST ;
 ;;SD FACILITY NEAR LIST;
 ;;SD FACILITY WAIT LIST;
 ;;SD PATIENT NEAR LIST;
 ;;SD RECALL FACILITY LIST;
 ;;SD RECALL LIST BY PATIENT;
 ;;SD UPDATE NEAR LIST;
 ;;SD WAIT LIST BY DFN;
 ;;SD PROVIDER TO CLINICS;
 ;;SD PATIENT PENDING APPT;
 ;;SD REMOVE FROM RECALL LIST;
 ;;SD CANCEL APPOINTMENT;
 ;;SD REMOVE FROM EWL;
 ;;SD ADDITIONAL CLINIC DETAILS;
 ;;SD ADD TO RECALL LIST;
 ;;SD VERIFY ACCESS TO CLINIC;
 ;;SD NEW EWL ENTRY;
 ;;SD NO PATIENT CSLT LOOKUP;
 ;;SD PATIENT ADMISSIONS;
 ;;SD APPOINTMENT MAKE;
 D UPDATE^DIE("","FDA")
