IBDF5D ;ALB/CJM - ENCOUNTER FORM - (copy page) ;12/12/94
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**63**;APR 24, 1997;Build 81
 ;
 ;
COPYPAGE ;
 N FROMFORM,PAGE,TOLINE,NODE,ROW,COL,BEGIN,END,QUIT,BLOCK
 D FULL^VALM1
 S VALMBCK="R"
 S FROMFORM=$$SLCTFORM^IBDFU4("") Q:'FROMFORM
 Q:'$$FORMSIZE^IBDFU1C(.FROMFORM)
 I FROMFORM("PAGES")=1 D
 .S BEGIN=0,END=FROMFORM("PAGE_HT")-1
 E  D  Q:QUIT
 .S QUIT=0
 .K DIR S DIR(0)="N^1:"_FROMFORM("PAGES")_":0",DIR("A")="Copy Page Number",DIR("B")=1,DIR("?")="Which page do you want to copy?" D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q
 .S PAGE=Y I 'PAGE S QUIT=1 Q
 .S BEGIN=((PAGE-1)*FROMFORM("PAGE_HT"))-1,END=(BEGIN+FROMFORM("PAGE_HT"))-1
 K DIR S DIR(0)="N^1:"_IBFORM("HT")_":0",DIR("A")="Copy To Line Number",DIR("B")=($$CURY^IBDFU4)+1,DIR("?")="Beginning at what line should the page be pasted?" D ^DIR K DIR I 'X!$D(DIRUT) S QUIT=1 Q
 I 'Y S QUIT=1 Q
 S TOLINE=Y-1
 S BLOCK=0
 F  S BLOCK=$O(^IBE(357.1,"C",FROMFORM,BLOCK)) Q:'BLOCK  S NODE=$G(^IBE(357.1,BLOCK,0)) Q:NODE=""  S ROW=$P(NODE,"^",4),COL=$P(NODE,"^",5) D
 .N NEWBLOCK,IBDLST,IBDX,IBDCS,IBDX,IBDY
 .I '(ROW>END),'(ROW<BEGIN)  S NEWBLOCK=$$COPYBLK^IBDFU2(BLOCK,IBFORM,357.1,357.1,(ROW#FROMFORM("PAGE_HT"))+TOLINE,COL)
 .;Now check if new block contains any selection lists that specify ICD-9 or ICD-10
 .;if so, update history field at #357 .19 or .2 plus field .21
 .S IBDLST=0 F  S IBDLST=$O(^IBE(357.2,"C",NEWBLOCK,IBDLST)) Q:IBDLST=""  S IBDX=$P(^IBE(357.2,IBDLST,0),U,11) D:IBDX?1.N
 ..S IBDCS=$P(^IBE(357.6,IBDX,0),U,22) D:IBDCS=1!(IBDCS=30)  ;Coding System 1=ICD-9 30=ICD-10
 ...I '$O(^IBE(357.3,"C",IBDLST,"")) Q  ;Only log history fields if ICD-9 or ICD-10 codes are contained in block.
 ...S IBDY=$$CSUPD357^IBDUTICD(IBFORM,IBDCS,"",$$NOW^XLFDT(),DUZ)
 D IDXFORM^IBDF5A()
 Q
 ;
COPY ;ask user whether to copy a block or a page
 S VALMBCK="R"
 K DIR S DIR(0)="SB^P:PAGE COPY;B:BLOCK COPY;",DIR("A")="Copy an entire page or a single block?",DIR("?")="You can copy either a single block or an entire page."
 D ^DIR K DIR I $D(DIRUT) Q
 D:Y="P" COPYPAGE
 D:Y="B" COPYBLK^IBDF5C
 K DIR
 Q
