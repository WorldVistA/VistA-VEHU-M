DVBCTXM2 ;ALB/BG - CAPRI XML RPCS; FEB 6, 2023@16:20 ; 3/4/24 8:50am
 ;;2.7;AMIE;**250,252**;Apr 10, 1995;Build 92
 ; Per VHA Directive 6402 this routine should not be modified
 ; Reference to SUPPORTED PARAMETER TOOL ENTRY POINTS in ICR #2263
 Q
 ;
NEWSFEED(DVBRTN) ;
 N DVBCLNT,DVBTNT,DVBTKN,DVBTKI,DVBTKS,DVBTKD,DVBTKF
 S DVBCLNT=$$GET^XPAR("PKG","DVBAB CAPRI NF CLIENT")
 S DVBTNT=$$GET^XPAR("PKG","DVBAB CAPRI NF TENANT")
 S DVBTKN=$$GET^XPAR("PKG","DVBAB CAPRI NF TOKEN")
 S DVBTKI=$$GET^XPAR("PKG","DVBAB CAPRI NF TOKEN URL")
 S DVBTKS=$$GET^XPAR("PKG","DVBAB CAPRI NF SITEID URL")
 S DVBTKD=$$GET^XPAR("PKG","DVBAB CAPRI NF DRIVEID URL")
 S DVBTKF=$$GET^XPAR("PKG","DVBAB CAPRI NF FILEINFO URL")
 S DVBRTN=DVBCLNT_U_DVBTNT_U_DVBTKN_U_DVBTKI_U_DVBTKS_U_DVBTKD_U_DVBTKF
 Q
PARDATE(DVBRTN,DVBDATE) ;
 N DVBRN
 I '$D(DVBDATE) S DVBRTN="-1^MISSING DATE" Q
 D EN^XPAR("PKG","DVBAB CAPRI GITHUB ERROR DATE",1,DVBDATE,.DVBRN)
 I +DVBRN S DVBRTN="-1^"_$P(DVBRN,U,2) Q
 S DVBRTN="0^SUCCESS"
 Q
GITDATE(DVBRTN) ;
 S DVBRTN=$$GET^XPAR("PKG","DVBAB CAPRI GITHUB ERROR DATE")
 I DVBRTN="" S DVBRTN="-1"
 Q
SPIEPD(DVBRTN) ;
 N DVBIEPD
 D NEWSFEED(.DVBRTN)
 S DVBIEPD=$$GET^XPAR("PKG","DVBAB CAPRI SP IEPD INFO")
 S $P(DVBRTN,U,7)=DVBIEPD
 Q
GETSSNVAR(DVBRTN) ;
 N DVBARTN,DVBAERROR
 K ^TMP("DVBASSNVAR",$J)
 S DVBARTN=$NA(^TMP("DVBASSNVAR",$J))
 D GETLST^XPAR(DVBARTN,"PKG","DVBAB CAPRI CMT SSN VAR","Q",.DVBAERROR,1)
 S DVBRTN=DVBARTN
 I DVBRTN="" S DVBRTN="-1"
 Q
