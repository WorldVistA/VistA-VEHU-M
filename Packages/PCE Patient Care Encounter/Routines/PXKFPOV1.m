PXKFPOV1 ;BPFO/LMT - PROMBLEM OF VISIT Routine #2 ;01/12/16  14:36
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**215**;Aug 12, 1996;Build 11
 ;
 ;
IMM ;
 D MAIN
 Q
SK ;
 D MAIN
 Q
 ;
MAIN ;
 I PXKFGAD=1 D ADD
 I PXKFGDE=1 D DEL
 Q
 ;
ADD ;
 N PXKSEQ1,PXNARR,PXVISIT,PXVISITDT
 ;
 S PXVISIT=$G(^TMP("PXK",$J,"VST",1,"IEN"))
 ;
 ; Entry already exists with this Code - don't add duplicate
 I $$FNDVPOV(PXVISIT,PXCODE) Q
 ;
 ; use diagnosis description as narrative
 S PXVISITDT=$$CSDATE^PXDXUTL(PXVISIT)
 S PXNARR=$$DXNARR^PXUTL1(PXCODE,PXVISITDT)
 S PXNARR=+$$PROVNARR^PXAPI(PXNARR,9000010.07)
 ;
 S PXKSEQ1=PXKSEQ+PXKXX
 S ^TMP("PXKSAVE",$J,"POV",PXKSEQ1,0,"AFTER")=PXCODE_"^"_$G(PXKAV(0,2))_"^"_$G(PXKAV(0,3))_"^"_PXNARR_"^^^^^^^^S"
 S ^TMP("PXKSAVE",$J,"POV",PXKSEQ1,12,"AFTER")=$G(PXKAV(12,1))_"^"_$G(PXKAV(12,2))_"^^"_$G(PXKAV(12,4))
 S ^TMP("PXKSAVE",$J,"POV",PXKSEQ1,812,"AFTER")=$G(PXKAFT(812))
 S ^TMP("PXKSAVE",$J,"POV",PXKSEQ1,"IEN")=""
 ;
 Q
 ;
DEL ;
 N PXKSEQ1,PXVISIT,PXVPOV
 ;
 S PXVISIT=$G(^TMP("PXK",$J,"VST",1,"IEN"))
 ;
 S PXVPOV=$$FNDVPOV(PXVISIT,PXCODE)
 I 'PXVPOV Q
 ;
 S PXKSEQ1=PXKSEQ+PXKXX
 S ^TMP("PXKSAVE",$J,"POV",PXKSEQ1,0,"BEFORE")=$G(^AUPNVPOV(PXVPOV,0))
 S ^TMP("PXKSAVE",$J,"POV",PXKSEQ1,12,"BEFORE")=$G(^AUPNVPOV(PXVPOV,12))
 S ^TMP("PXKSAVE",$J,"POV",PXKSEQ1,800,"BEFORE")=$G(^AUPNVPOV(PXVPOV,800))
 S ^TMP("PXKSAVE",$J,"POV",PXKSEQ1,802,"BEFORE")=$G(^AUPNVPOV(PXVPOV,802))
 S ^TMP("PXKSAVE",$J,"POV",PXKSEQ1,811,"BEFORE")=$G(^AUPNVPOV(PXVPOV,811))
 S ^TMP("PXKSAVE",$J,"POV",PXKSEQ1,812,"BEFORE")=$G(^AUPNVPOV(PXVPOV,812))
 S ^TMP("PXKSAVE",$J,"POV",PXKSEQ1,"IEN")=PXVPOV
 ;
 S ^TMP("PXKSAVE",$J,"POV",PXKSEQ1,0,"AFTER")="@"
 S ^TMP("PXKSAVE",$J,"POV",PXKSEQ1,12,"AFTER")=""
 S ^TMP("PXKSAVE",$J,"POV",PXKSEQ1,812,"AFTER")=""
 ;
 Q
 ;
DUP(PXVISIT,PXCODE) ;
 N PXFOUND,PXSEQ
 ;
 I $$FNDVPOV(PXVISIT,PXCODE) Q 1
 ;
 S PXFOUND=0
 S PXSEQ=0
 F  Q:PXFOUND  S PXSEQ=$O(^TMP("PXK",$J,"POV",PXSEQ)) Q:'PXSEQ  D
 . I $P($G(^TMP("PXK",$J,"POV",PXSEQ,0,"AFTER")),U,1)=PXCODE D
 . . S PXFOUND=1
 ;
 Q PXFOUND
 ;
FNDVPOV(PXVISIT,PXCODE) ;
 N PXFOUND,PXRSLT,PXVPOV
 ;
 S PXRSLT=0
 S PXFOUND=0
 ;
 S PXVPOV=0
 F  Q:PXFOUND  S PXVPOV=$O(^AUPNVPOV("AD",PXVISIT,PXVPOV)) Q:'PXVPOV  D
 . I $P($G(^AUPNVPOV(PXVPOV,0)),U,1)=PXCODE D
 . . S PXFOUND=1
 . . S PXRSLT=PXVPOV
 ;
 Q PXRSLT
