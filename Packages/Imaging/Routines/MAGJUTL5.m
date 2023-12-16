MAGJUTL5 ;WOIFO/JHC - VistARad RPCs ; 12/29/2022
 ;;3.0;IMAGING;**65,76,101,90,115,104,120,133,152,153,184,199,255,341**;Dec 21, 2022;Build 28
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
 ; Reference to INSTALDT^XPDUTL in ICR #10141
 ;; ISI IMAGING;**99,101,102,106**
 Q
 ; ISI <*> Version # changes for ISI Rad 1.1.0 -- Jan 2018
GETVER(SVRVER,SVRBVER,ALLOWCL,VIXVER) ;
 ; SVRVER -- holds the Server Version that is always hardcoded to match the Client
 ; SVRBVER - holds the smallest value for the client build # that is compatible with
 ;           the current server--the client's value must be equal to or greater than SVRBVER
 ;
 ; <*> Edit below line whenever both client and server are changing together
 ;
 S SVRVER="1.1.1",SVRBVER=217  ; min. build version for P110--VA VistARad to ISI Rad conversion
 ;   Rev-2 enabled in v1.1.1
 S ALLOWCL="|3.0.199|3.0.255|"  ; back-compatible prior clients (ISI_v1.1.nnn; VA: 3.0.nnn)
 S VIXVER=""
 ; VIX may present versions different from vrad Client/Server versions; this would
 ; happen if M-only changes are made to vrad Server code as part of a VIX patch
 ; to support updated VIX-related functionality. VIXVERS contains the version numbers
 ; that are to be supported in this fashion; related M changes need to be back-compatible
 ; with prior vrad versions' behavior in the interface
 N T,VIXVERS
 S VIXVERS="|3.0.104|" ; keep compatible with P115 & P90  <*> edit as needed for patches
 S T=$G(MAGJOB("VIX"))
 I T,VIXVERS[("|"_T_"|") S ALLOWCL=ALLOWCL_T_"|",VIXVER=T
 Q
 ;
CHKVER(MAGRY,CLVER,PLC,SVERSION) ;
 ; Input CLVER is the version of the Client
 ;    format: ISI_Major . ISI_Minor . Rad_Version . Build# -- e.g., 1.0.0.38
 ; 3 possible return codes in MAGRY:
 ;   2^n~msg : Client displays a message and continues
 ;   1^1~msg : Client continues without displaying a message
 ;   0^n~msg : Client displays a message then Aborts
 ; PLC returns 2006.1 pointer
 ; SVERSION returns the Server version string
 ;
 S CLVER=$G(CLVER),PLC="",MAGRY=""
 N SV,SBUILD,CV,CBUILD,ALLOWV,SVSTAT,VIXVER
 ; SVERSION = Full Server Version -> (3.0.18.132)
 ; SV = Server Version -> (3.0.18); only 1st 3 parts
 ; SBUILD = Server Build # -> define this to correspond to client
 ; CV = Client Version, w/out build #
 ; CBUILD = Client build # alone
 ; ALLOWV = Hard coded string of allowed clients for this KIDS.
 ;
 ;   get VIX version if a VIX session
 I $P(CLVER,"|",2)["VIX" S MAGJOB("VIX")=$P(CLVER,"|")  ; VIX facade version
 ;
 I $G(DUZ(2)) S PLC=$$PLACE^MAGBAPI(DUZ(2))
 ;  Quit if we don't have a valid DUZ(2) or valid PLACE: ^MAG(2006.1,PLC)
 I 'PLC S MAGRY="0^4~Error verifying Imaging Site (Place) -- Contact Imaging support." Q
 D GETVER(.SV,.SBUILD,.ALLOWV,.VIXVER)
 S CLVER=$P(CLVER,"|")
 S CV=$P(CLVER,".",1,3),CBUILD=+$P(CLVER,".",4)
 S SVERSION=SV_"."_SBUILD
 ; Check Version differences:
 ;   MAG*341--age out Vrad, per end-of-life date defined below
 I '$G(MAGJOB("VIX")),$E(CV,1,4)="3.0." D  Q  ; ISI -- VistARad last gasp; <*> remove "I 0," when final End Date is established
 . N ENDDATE,ZJ,X,X1,X2
 . I '$$INSTALDT^XPDUTL("MAG*3.0*341",.ZJ) Q  ; if false, how did we get here?!
 . S X="" S X=$O(ZJ(X),-1) ; most recent install of patch
 . S X1=$E(X,1,7),X2=31 D C^%DTC  ; get date 31 days out
 . S ENDDATE=X
 . I '(ALLOWV[("|"_CV_"|")) D  Q
 . . S MAGRY="0^4~VistARad Workstation software version "_CLVER_" is not compatible with the VistA server version "_SVERSION_".  Contact Imaging support. (CNA2)"
 . ; Warn the Client, allow to continue if the expiration date is future
 . S X1=ENDDATE,X2=DT D ^%DTC
 . I X<1 D  Q
 . . S MAGRY="0^4~VistARad is no longer supported; contact Imaging Support to install ISI Rad workstation software."
 . ; Warn the Client, allow to continue
 . S MAGRY="2^3~VistARad vs. "_CLVER_" reaches end-of-life "_$S(X>1:"in "_X_" days",1:"TOMORROW")_"; VistARad will Continue, but contact Imaging Support to install ISI Rad workstation software."
 . Q
 ;
 I (CV'=SV) D  Q
 . I '(ALLOWV[("|"_CV_"|")) D  Q
 . . S MAGRY="0^4~ISI Rad Workstation software version "_CLVER_" is not compatible with the VistA server version "_SVERSION_".  Contact Imaging support. (CNA)"
 . ; Warn the Client, allow to continue
 . E  D
 . . I VIXVER]"" S MAGRY="1^1~VIX software vs. "_CLVER_" is running with VistA server vs. "_SVERSION_". (VIXdif)"
 . . E  D
 . . . N PROGNAME S PROGNAME="ISI Rad"
 . . . I $E(CV,1,4)="3.0." S PROGNAME="VistARad"
 . . . S MAGRY="2^3~"_PROGNAME_" vs. "_CLVER_"; VistA server is "_SVERSION_" - "_PROGNAME_" will Continue, but contact Imaging Support to install newer workstation version. (RPdif)"  ; ISI
 . Q
 ; Versions are the Same: If build #s are not compatible, warn the Client if needed.
 ; Released Client (of any version) will have a build # in range that the server
 ; expects, so no warning will be displayed.
 I CBUILD<SBUILD D  Q  ; server expects a higher client build #; provide warning
 . S MAGRY="2^3~ISI Rad vs. "_CLVER_"; VistA server is "_SVERSION_" - Some features may not function as expected. Contact Imaging Support to install updated client software.  (Tdif-1)"
 . Q
 ; Client and Server Versions are compatible
 S MAGRY="1^1~Version Check OK. Server: "_SVERSION_" Client: "_CLVER Q
 Q
 ;
 ;  ISI  remove deprecated logic
END ;
