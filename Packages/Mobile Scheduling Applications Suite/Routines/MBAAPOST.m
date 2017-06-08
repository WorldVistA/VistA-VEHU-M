MBAAPOST ;OIT-PD/PB - Post INT routine for Scheduling KIDS build;08/27/2014
 ;;1.0;Scheduling Calendar View;;Aug 27, 2014;Build 52
 ;Associated ICRs
 ;  ICR#
 ;  6063 MBAA RPC REGISTRATION
 ;
 ;Post INT routine to registered new RPC's to the SD API option
EN  ; get IEN for Option file entry for SD API and get the IEN from the Remote
 ;Procedure file for the two new RPCs
 ;VARIABLES:
 ; CTX = IEN from Option File $19
 ; RPC = IEN for the RPC from the Remote Procedure File #8994
 ; XX = Looping control varible
 ; YY = name of RPC for looping in the B xref of XWB(8994
 S CTX=$O(^DIC(19,"B","OR CPRS GUI CHART",0))
 Q:CTX'>0
 F I=1:1 S XX=$P($T(RPCLIST+I),";",3) Q:$P($T(RPCLIST+I),";",3)=""  D
 .;S RPC=$O(^XWB(8994,"B",XX,"")) -- Removed May 1 to change the look up to use a DIC call
 .K DIC,DIC(0),X,Y
 .S DIC="^XWB(8994,",DIC(0)="X",X=XX D ^DIC
 .S RPC=+Y
 .K DIC,DIC(0),X,Y
 .D REGRPC(XX,CTX)
 Q
REGRPC(RPC,CTX,DEL) ;EP
 S RPC=+$$GETRPC(RPC)
 Q $S(RPC<1:0,1:$$REGMULT(19.05,"RPC",RPC,.CTX,.DEL))
REGMULT(SFN,NOD,ITM,CTX,DEL) ;
 ;W !,"REGMULT"
 N FDA,IEN
 S CTX=+$$GETOPT(CTX)
 S DEL=+$G(DEL)
 S IEN=+$O(^DIC(19,CTX,NOD,"B",ITM,0))
 Q:'IEN=DEL -1
 K ^TMP("MBAAERR",$J)
 I DEL S FDA(SFN,IEN_","_CTX_",",.01)="@"
 E  S FDA(SFN,"+1,"_CTX_",",.01)=ITM
 D UPDATE^DIE("","FDA")
 S FDA='$D(^TMP("MBAAERR",$J)) K ^TMP("MBAAERR",$J)
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
 ;;MBAA APPOINTMENT MAKE
 ;;MBAA CANCEL APPOINTMENT
 ;;MBAA FACILITY NEAR LIST
 ;;MBAA FACILITY WAIT LIST
 ;;MBAA NO PATIENT CSLT LOOKUP
 ;;MBAA PATIENT NEAR LIST
 ;;MBAA PATIENT PENDING APPT
 ;;MBAA RECALL FACILITY LIST
 ;;MBAA RECALL LIST BY PATIENT
 ;;MBAA REMOVE FROM EWL
 ;;MBAA REMOVE FROM RECALL LIST
 ;;MBAA UPDATE NEAR LIST
 ;;MBAA WAIT LIST BY DFN
 ;;MBAA APPOINTMENT LIST BY NAME
 ;;MBAA GET CLINIC AVAILABILITY
 ;;MBAA LIST CANCELLATION REASONS
 ;;MBAA VERIFY CLINIC ACCESS
 ;;MBAA EWL NEW
 ;;MBAA PROVIDERS BY CLINIC
