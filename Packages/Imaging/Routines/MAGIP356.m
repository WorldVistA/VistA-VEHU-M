MAGIP356 ;WOIFO/CD - Install code for MAG*3.0*356 ; 27 Jul, 2023@13:31:33
 ;;3.0;IMAGING;**356**;Mar 19, 2002;Build 9
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
EN ;
 N PAR,ENT,INST,VAL,ERR,I,PNAME,RPCNAME
 S PNAME="MAG TELER SSERV URL"
 S PAR=$O(^XTV(8989.51,"B",PNAME,0))
 D GETENT^XPAREDIT(.ENT,PAR_"^"_PNAME,0)
 S INST=1,VAL="http://siteservice.telereader.das.domain.ext/VistaWebSvcs/ExchangeSiteService"
 D BMES^XPDUTL("Setting parameter "_PNAME_" to "_VAL)
 D EN^XPAR(ENT,PAR,INST,VAL,.ERR)
 I $D(ERR),$G(ERR)'=0 D BMES^XPDUTL("Failed to set "_PNAME_". Exiting post install.") Q
 ; Register RPC
 D BMES^XPDUTL("Adding RPC MAG TELER UPDATES to MAG WINDOWS")
 S RPCNAME="MAG TELER UPDATES"
 I $$FIND1^DIC(8994,,"O",RPCNAME,"B",,"MAGMSG")>0 D
 . N DIC,Y,X S DIC="^DIC(19,",DIC(0)="",X="MAG WINDOWS" D ^DIC Q:$P(Y,U)<0
 . I '$D(^DIC(19,+Y,"RPC","B",$O(^XWB(8994,"B",RPCNAME,"")))) D ADDRPC^MAGQBUT4(RPCNAME,"MAG WINDOWS")
 D BMES^XPDUTL("Install Successfully Complete")
 Q
