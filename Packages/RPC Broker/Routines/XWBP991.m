XWBP991 ;VEN/TOAD - XWB*1.1*991 Post-install ; 8/28/2013 10:40am
 ;;1.1;RPC BROKER;**991**;Mar 28, 1997;Build 9
 ;
 QUIT  ; routine XWBP991 is not callable at the top
 ;
 ; Change History:
 ;
 ; 2013 08 19-28 VEN/TOAD: XWB*1.1*991 SEQ #46, M2M Security Fixes.
 ; Original routine created to set the new XWBM2M package-parameter
 ; to enable the M-to-M Broker.
 ;
 ;
POST ; Post-install for XWB*1.1*991
 ;
 ; 1. set XWBM2M package-parameter
 ;
 N XWBERR ; error message from setting XWBM2M
 D PUT^XPAR("PKG","XWBM2M",1,1,.XWBERR) ; set default value of XWBM2M
 ;
 ; 2. report results to screen & Install file
 ;
 N XWBMSG S XWBMSG(1)="   "
 I $G(XWBERR) D  ; if set failed
 . S XWBMSG(2)="   Error setting parameter XWBM2M: "_XWBERR_"."
 E  D  ; if it succeeded
 . S XWBMSG(2)="   Parameter XWBM2M set to default of Yes, Enabled."
 D MES^XPDUTL(.XWBMSG)
 ;
 QUIT  ; end of POST
 ;
 ;
EOR ; end of routine XWBP991
