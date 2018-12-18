XWBRMX ;OIFO-Oakland/REM - M2M Broker Server Request Mgr ; 08/28/2013 10:41am
 ;;1.1;RPC BROKER;**28,991**;Mar 28, 1997;Build 9
 ;
 QUIT  ; routine XWBRMX is not callable at the top
 ;
 ; Change History:
 ;
 ; 2002 08 10 OIFO/REM: XWB*1.1*28 SEQ #25, M2M Broker. Original routine
 ; created.
 ;
 ; 2013 08 16-28 VEN/TOAD: XWB*1.1*991 SEQ #46, M2M Security Fixes.
 ; Eliminate unused lines in ELEST that set DUZ and tokens (unfinished).
 ; Change History added. in XWBRMX, ELEST, EOR.
 ;
 ;
 ;----------------------------------------------------------------------
 ;
 ;    Request Manager -Parse XML Requests using SAX interface
 ;
 ;----------------------------------------------------------------------
 ;
EN(DOC,XWBOPT,XWBDATA) ; -- Parse XML uses SAX parser
 N XWBCBK,XWBINVAL
 SET XWBINVAL="#UNKNOWN#"
 ;
 SET XWBDATA("DUZ")=XWBINVAL ;**M2M don't need duz
 SET XWBDATA("SECTOKEN")=XWBINVAL
 DO SET(.XWBCBK)
 DO EN^MXMLPRSE(DOC,.XWBCBK,.XWBOPT)
 ;
 ;;D ^%ZTER
 ;
ENQ Q
 ;
SET(CBK) ; -- set the event interface entry points
 SET XWBCBK("STARTELEMENT")="ELEST^XWBRMX"
 SET XWBCBK("ENDELEMENT")="ELEND^XWBRMX"
 SET XWBCBK("CHARACTERS")="CHR^XWBRMX"
 QUIT
 ;
ESC(X) ; -- convert special characters to \x format
 Q X
 ;
 N C,Y,Z
 F Z=1:1 S C=$E(X,Z) Q:C=""  D
 .S Y=$TR(C,$C(9,10,13,92),"tnc")
 .S:C'=Y $E(X,Z)="" ;$S(Y="":"\\",1:"\"_Y),Z=Z+1
 Q X
 ;
ELEST(ELE,ATR) ; -- element start
 IF ELE="vistalink",$G(ATR("type"))="Gov.VA.Med.RPC.Request" DO
 . SET XWBDATA("APP")="RPC"
 . ;SET XWBDATA("MODE")=$G(ATR("mode"),"singleton") ;Comment out for M2M
 . SET XWBDATA("MODE")=$G(ATR("mode"),"RPCBroker") ;M2M change to RPCBroker
 ;
 IF ELE="vistalink",$G(ATR("type"))="Gov.VA.Med.Foundations.CloseSocketRequest" DO  QUIT
 . SET XWBDATA("APP")="CLOSE"
 . SET XWBDATA("MODE")=$G(ATR("mode"),"single call")
 ;
 IF ELE="session" SET XWBSESS=1 QUIT
 ; -- set session vars here so apps can use during xml parsing
 ;
 ;*M2M - check for RPCBroker
 IF $G(XWBSESS) DO  QUIT
 . IF ELE="security" SET XWBSEC=1 QUIT
 ;
 ; -- // TODO: make dynamic off RPC app config
 IF $GET(XWBDATA("APP"))="RPC" DO ELEST^XWBRPC(.ELE,.ATR)
 Q
 ;
ELEND(ELE) ; -- element end
 IF ELE="session" KILL XWBSESS QUIT
 IF $G(XWBSESS) DO  QUIT
 . IF ELE="security" KILL XWBSEC
 ;
 ;
 ; -- // TODO: make dynamic off RPC app config
 IF $G(XWBDATA("APP"))="RPC" DO ELEND^XWBRPC(.ELE)
 Q
 ;
CHR(TXT) ;
 ; -- // TODO:  make dynamic off RPC app config
 IF $G(XWBDATA("APP"))="RPC" DO CHR^XWBRPC(.TXT)
 Q
 ;
 ;
EOR ; end of routine XWBRMX
