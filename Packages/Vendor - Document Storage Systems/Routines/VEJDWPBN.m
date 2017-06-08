VEJDWPBN ;WPB/CAM routine modified for dental GUI;8/1/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;; ALB/MJK/REV -Imaging Calls ;04/08/98  08:17
 ;ORWRA;3.0;ORDER ENTRY/RESULTS REPORTING;**10**;Dec 17, 1997
EXAMS(ROOT,DFN) ; Return imaging exams
 ; RPC: ORWRA IMAGING EXAMS
 ;  See RPC definition for details on input and output parameters
 ;
 N RADATA,I,X,X1,X2,ID
 S RADATA=$NA(^TMP($J,"RAE1",DFN))
 S ROOT=$NA(^TMP($J,"ORAEXAMS"))
 K @RADATA,@ROOT
 ;
 ; -- set date range
 S X1=DT,X2=-14 D C^%DTC ; <-- need date range default
 D EN1^RAO7PC1(DFN,2950701,DT)
 ;
 ; -- reformat data array for rpc
 S I=0,ID=""
 F  S ID=$O(@RADATA@(ID)) Q:ID=""  D
 . S I=I+1
 . S @ROOT@(I)=ID_U_(9999999.9999-ID)_U_@RADATA@(ID)
 K @RADATA
 Q
 ;
RPT(ROOT,DFN,ORID) ; -- return imaging report
 ;  RPC: ORWRA REPORT TEXT
 ;  See RPC definition for details on input and output parameters
 ;
 ; temporary fix so expand exam call can be used
 ; Problem is at TITLE^ORCXPND
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
 D EN3^RAO7PC1(ID)
 ;
 ; -- set up counter and vp local for dfn for formating call
 S LCNT=0,ORVP=DFN_";DPT("
 D XRAY
 K @RADATA
 Q
 ;
TEST ; -- test to get exam list
 N I,ROOT,DFN
 S DFN=16
 D EXAMS(.ROOT,DFN)
 W !,"Root: ",ROOT
 S I=0 F  S I=$O(@ROOT@(I)) Q:'I  W !,@ROOT@(I)
 Q
 ;
TEST1 ; -- test to print reprt for first 3 exams
 N I,ROOT,ROOT1,L,X,DFN
 S DFN=16
 D EXAMS(.ROOT,DFN)
 S I=0 F  S I=$O(@ROOT@(I)) Q:'I  D  Q:I=3
 . S X=@ROOT@(I)
 . D RPT(.ROOT1,DFN,$P(X,U))
 . S L=0 F  S L=$O(@ROOT1@(L)) Q:'L  W !,@ROOT1@(L,0)
 Q
XRAY ;FROM ORCXPND2
 N CASE,PROC
 S CASE=0 F  S CASE=$O(^TMP($J,"RAE2",+ORVP,CASE)) Q:CASE'>0  D
 . ;blj/dss 14/6/2000 The linetag XRPT mentioned below is no longer present in this routine
 . ;S PROC="" F  S PROC=$O(^TMP($J,"RAE2",+ORVP,CASE,PROC)) Q:PROC=""  D ITEM(PROC),BLANK,XRPT,BLANK
 . S PROC="" F  S PROC=$O(^TMP($J,"RAE2",+ORVP,CASE,PROC)) Q:PROC=""  D ITEM(PROC),BLANK
 Q
ITEM(PROC) ;FROM ORCXPND
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X
 I $D(IORVON),$D(IORVOFF) D SETVIDEO(LCNT,1,$L(X),IORVON,IORVOFF)
 Q
BLANK ;FROM ORCXPND
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="   "
 Q
SETVIDEO(LINE,CON,WIDTH,ON,OFF) ;FROM ORCXPND
 S ^TMP("ORXPND",$J,"VIDEO",LINE,COL,WIDTH)=ON
 S ^TMP("ORXPND",$J,"VIDEO",LINE,COL+WIDTH,0)=OFF
 Q
