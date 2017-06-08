RCTOPINI ;ALBANY CIOFO@ALTOONA,PA/TJK-PATCH PRCA*4.5*141 INITIAL RUN ;2/22/00  12:27 PM
V ;;4.5;Accounts Receivable;**155**;MAR 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified
 N SITE D CODE,FDELETE,CLOSE
 Q
 ;
CODE ;get station number, store code in data base
 N CODE
 S SITE=$E($$SITE^RCMSITE(),1,3),CODE=$P($T(@SITE),";;",2),$P(^RC(342,1,3),U,5)=CODE
 Q
 ;
FDELETE ;deletes fields 3.01:3.04 from ar site parameter file
 N REC,DIK,DA,I
 S DIK="^DD(342,",DA(1)=342 F DA=3.01:.01:3.04 D ^DIK
 S REC=$O(^RC(342,0)) Q:'REC  F I=1:1:4 S $P(^RC(342,REC,3),U,I)=""
 Q
 ;
CLOSE ;queues background job to 'close' out current accounts at treasury
 ;as a result of irs offset
 N ZTDESC,ZTASK,ZTDTH,ZTIO,ZTRTN,ARDUZ,ZTSAVE
 S ZTIO="",ZTRTN="CLOSE1^RCTOPINI",ZTSAVE("SITE")=""
 S ZTDESC="RC CLOSE OUT CURRENT TOP REFERRALS ",ZTDTH=$H
 D ^%ZTLOAD
 Q
 ;
CLOSE1 ;closes out current referrals to top
 N DEBTOR,N0,BILL,REF,B6,EFFDT,RDATE,CNTR,RCNT,B0,DFN
 K ^XTMP("RCTOPINI") S ^XTMP("RCTOPINI",0)=DT_U_DT,(DEBTOR,CNTR)=0
 F  S DEBTOR=$O(^RCD(340,DEBTOR)) Q:'DEBTOR  D
    .S N0=$G(^RCD(340,DEBTOR,0)) Q:$P(N0,U)'[";DPT("
    .S DFN=+N0 D DEM^VADPT Q:$E(VADM(2),1,5)="00000"
    .S (BILL,REF)=0
    .F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:('BILL)!(REF)  D
       ..S B6=$G(^PRCA(430,BILL,6)),RDATE=$P(B6,U,15) Q:$E(RDATE,2,3)'=99
       ..S B0=$G(^PRCA(430,BILL,0)),EFFDT=$P(B0,U,10) S:'EFFDT EFFDT=RDATE
       ..S REF=1
       ..Q
    .Q:'REF
    .D PROC(DEBTOR,EFFDT,.CNTR)
    .Q
 Q:'CNTR  D COMPILE(CNTR)
 Q
 ;
PROC(DEBTOR,EFFDT,CNTR) ;set up close document in temporary global
 N DEBTOR0,DEBNR,REC,TAXID,NM
 S DEBTOR0=$G(^RCD(340,DEBTOR,0)),NM=+DEBTOR0,NM=$P($G(^DPT(NM,0)),U)
 S REC="04      81      "
 S DEBNR=SITE_$TR($J(DEBTOR,9)," ",0),REC=REC_DEBNR_"      U1"
 S TAXID=$$TAXID(DEBTOR,2),REC=REC_TAXID
 S REC=REC_$$BLANK(86)_"C"_$$BLANK(68)
 ;SET GLOBAL FOR COMPILING OF MAILMAN MESSAGE TO AUSTIN
 S CNTR=CNTR+1,^XTMP("RCTOPINI",$J,1,CNTR)=REC
 ;SET GLOBAL FOR COMPILING OF SITE MESSAGE
 S ^XTMP("RCTOPINI",$J,"REC",NM_TAXID_"#:"_CNTR)=$$LJ^XLFSTR($E(NM,1,30),30)_"   "_TAXID
 Q
 ;
COMPILE(CNTR) ;COMPILES DOCUMENTS INTO MAIL MESSAGES AND TRANSMITS THEM
 ;BUILDS MESSAGE ARRAY
 N CNT,SEQ,REC,XMDUZ,DOCTYP,LRTYPE,XMSUB,XMTEXT,XMY,TSEQ
 S (SEQ,REC)=0,TSEQ=(CNTR\150)+$S(CNTR#150:1,1:0)
 F CNT=1:1:CNTR D
    .D:CNT#150=1
       ..K ^XTMP("RCTOPINI",$J,"BUILD") S SEQ=SEQ+1
       ..S REC=1
       ..Q
    .S REC=REC+1,^XTMP("RCTOPINI",$J,"BUILD",REC)=^XTMP("RCTOPINI",$J,1,CNT)_U
    .I CNTR=CNT S ^XTMP("RCTOPINI",$J,"BUILD",REC+1)="END OF TRANSMISSION FOR SITE# "_SITE_":  TOTAL RECORDS: "_CNTR
    .I $S(CNTR=CNT:1,CNT#150=0:1,1:0) D
       ..S ^XTMP("RCTOPINI",$J,"BUILD",1)=SITE_U_SEQ_U_TSEQ_U_(REC-1)_U_0_U
       ..S XMDUZ="AR PACKAGE"
       ..S XMY("XXX@Q-TOP.MED.VA.GOV")=""
       ..S XMSUB=SITE_"/TOP(C) TRANSMISSION/SEQ#: "_SEQ_"/"_$$NOW()
       ..S XMTEXT="^XTMP(""RCTOPINI"","_$J_",""BUILD"","
       ..D ^XMD
       ..Q
    .Q
 D USRMSG,KVAR^VADPT
 K ^XTMP("RCTOPINI"),XMDUZ
 Q
 ;
USRMSG ;sends mailman message of documents sent to user
 N XMY S XMDUZ="AR PACKAGE"
 S XMY("G.TOP")=""
 S XMSUB="IRS Offset records closed in TOP"
 S ^XTMP("RCTOPINI",$J,"REC1",1)="As a preparation for submitting debtors to the Treasury Offset Program,"
 S ^XTMP("RCTOPINI",$J,"REC1",2)="the following debtors submitted under the IRS Offset program have had"
 S ^XTMP("RCTOPINI",$J,"REC1",3)="their accounts closed at TOP:"
 S ^XTMP("RCTOPINI",$J,"REC1",4)=""
 S ^XTMP("RCTOPINI",$J,"REC1",5)="Name                             TIN"
 S ^XTMP("RCTOPINI",$J,"REC1",6)="----                             ---"
 S X="",RCNT=7 F  S X=$O(^XTMP("RCTOPINI",$J,"REC",X)) Q:X=""  S ^XTMP("RCTOPINI",$J,"REC1",RCNT)=^(X),RCNT=RCNT+1
 S ^XTMP("RCTOPINI",$J,"REC1",RCNT)=""
 S ^XTMP("RCTOPINI",$J,"REC1",RCNT+1)="Total Records: "_CNTR
 S XMTEXT="^XTMP(""RCTOPINI"","_$J_",""REC1"","
 D ^XMD
USRMSGQ Q
 ;
BLANK(X) ;returns 'x' blank spaces
 N BLANK
 S BLANK="",$P(BLANK," ",X+1)=""
 Q BLANK
 ;
TAXID(DEBTOR,FILE) ;computes tax id (tid) to place on documents
 N TAXID,DIC,DA,DR,DIQ
 I FILE'=440 S TAXID=$$SSN^RCFN01(DEBTOR) G TAXIDQ
 S DIC="^PRC(440,",DA=+^RCD(340,DEBTOR,0),DR="38",DIQ="TAXID(",DIQ(0)="E"
 D EN^DIQ1 S TAXID=TAXID(440,DA,38,"E")
TAXIDQ S:$L(TAXID)'=9 TAXID="         "
 Q TAXID
 ;
        ;
NOW()   ;compiles current date,time
        N X,Y,%,%H
        S %H=$H D YX^%DTC
        Q Y
 ;
CODES ;list of station codes
523 ;;A1
525 ;;A2
689 ;;A3
627 ;;A4
402 ;;A5
405 ;;A6
518 ;;A7
608 ;;A8
631 ;;A9
650 ;;AA
532 ;;B1
528 ;;B2
513 ;;B3
500 ;;B4
514 ;;B5
670 ;;B6
561 ;;C1
604 ;;C2
620 ;;C3
533 ;;C4
526 ;;C5
527 ;;C6
630 ;;C7
632 ;;C8
646 ;;D1
645 ;;D2
460 ;;D3
503 ;;D4
529 ;;D5
540 ;;D6
542 ;;D7
562 ;;D8
595 ;;D9
642 ;;DA
693 ;;DB
512 ;;E1
566 ;;E2
641 ;;E3
613 ;;E4
688 ;;E5
517 ;;F1
558 ;;F2
565 ;;F3
590 ;;F4
637 ;;F5
652 ;;F6
658 ;;F7
659 ;;F8
619 ;;G1
680 ;;G2
508 ;;G3
509 ;;G4
521 ;;G5
534 ;;G6
544 ;;G7
557 ;;G8
679 ;;G9
573 ;;H1
594 ;;H2
516 ;;H3
546 ;;H4
548 ;;H5
672 ;;H6
673 ;;H7
581 ;;I1
596 ;;I2
603 ;;I3
614 ;;I4
621 ;;I5
622 ;;I6
626 ;;I7
539 ;;J1
541 ;;J2
757 ;;J3
538 ;;J4
552 ;;J5
655 ;;K1
610 ;;K2
569 ;;K3
506 ;;K4
515 ;;K5
550 ;;K6
553 ;;K7
583 ;;K8
537 ;;L1
535 ;;L2
556 ;;L3
578 ;;L4
585 ;;L5
607 ;;L6
676 ;;L7
695 ;;L8
568 ;;M1
579 ;;M2
437 ;;M3
438 ;;M4
618 ;;M5
656 ;;M6
555 ;;N1
592 ;;N2
636 ;;N3
574 ;;N4
597 ;;N5
584 ;;N6
677 ;;O1
686 ;;O2
452 ;;O3
543 ;;O4
589 ;;O5
609 ;;O6
647 ;;O7
657 ;;O8
502 ;;P1
520 ;;P2
564 ;;P3
580 ;;P4
586 ;;P5
598 ;;P6
623 ;;P7
629 ;;P8
635 ;;P9
667 ;;PP
549 ;;Q1
522 ;;Q2
671 ;;Q3
591 ;;Q4
674 ;;Q5
685 ;;Q6
611 ;;Q7
501 ;;R1
504 ;;R2
519 ;;R3
644 ;;R4
649 ;;R5
678 ;;R6
756 ;;R7
436 ;;S1
617 ;;S2
442 ;;S3
554 ;;S4
567 ;;S5
575 ;;S6
660 ;;S7
666 ;;S8
531 ;;T1
663 ;;T2
505 ;;T3
463 ;;T4
648 ;;T5
653 ;;T6
668 ;;T7
687 ;;T8
692 ;;T9
654 ;;U1
640 ;;U2
599 ;;U3
459 ;;U4
570 ;;U5
612 ;;U6
662 ;;U7
691 ;;V1
665 ;;V2
752 ;;V3
593 ;;V4
600 ;;V5
605 ;;V6
664 ;;V7
