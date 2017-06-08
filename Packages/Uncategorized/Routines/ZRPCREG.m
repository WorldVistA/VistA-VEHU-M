ZRPCREG ;LV/PB - Utility to register RPCs to an option
 ;;1.0;Utility;**1**;July 16, 2013;Build 65
 ;This utility is used to register RPC's to an option. It can be called from a post int routine
 ;
 ;To use this utility to register an RPC to an Option,
 ;create a post int routine that will run at the end of the KIDS install
 ;the post int routine needs to get the IEN for the option from the OPTION file
 ;then loop thru the RPCs in XWB(8994 to be registered and get the IEN for each 
 ;RPC and call this routine to register or unregister the RPCs
 ;set RPC = IEN for the RPC in XWB(8994
 ;set CTX = IEN for the option in the Option file DIC(19
 ;set DEL = 0 or "" 
 ;sample call : REGRPC^ZRPCREG(RPCIEN,OPTIONIEN) 
 ;
 ;To unregister an RPC from an Option
 ;set RPC and CTX the same as for registering an RPC, but set DEL=1
 ;sample call : REGRPC^ZRPCREG(RPCIEN,OPTIONIEN,1)
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
 S Y=$$FIND1^DIC(8994,"","X",X)
 W:'Y "Cannot find RPC "_X,!!
 Q Y
