VEJDWPCP ;wpb/gbh - routine modified for dental GUI;8/2/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10**;Dec 17, 1997
 ;ORWRA ; ALB/MJK/REV -Imaging Calls ;04/08/98  08:17
 ;
RPT(ROOT,DFN,ORID) ; -- return imaging report
 ;  RPC: ORWRA REPORT TEXT
 ;  See RPC definition for details on input and output parameters
 ;
 ; temporary fix so expand exam call can be used
 ; Problem is at TITLE^VEJDWPCJ
 ; N IORVON,IORVOFF S (IORVON,IORVOFF)=""
 ;
 ; -- init locals and globals
 N ID,LCNT,ORVP
 S RADATA=$NA(^TMP($J,"RAE2"))
 S ROOT=$NA(^TMP("ORXPND",$J))
 K @RADATA,@ROOT
 ; 
 ; -- set up exam id and call to get report text
 S ID=DFN_U_$TR(ORID,"-",U)
 D EN3^VEJDWPCL(ID)
 ;
 ; -- set up counter and vp local for dfn for formating call
 S LCNT=0,ORVP=DFN_";DPT("
 D XRAY^VEJDWPCK
 K @RADATA
 Q
