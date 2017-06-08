QAQ171EN ;ALB/CM environment check routine ;05/07/96
 ;;1.7;QM Integration Module;**1,2**;07/25/1995
 ;
EN ;the main entry point of the enviroment check routine.
 N CHK
 S CHK=$$VERSION^XPDUTL("QUALITY ASSURANCE INTEGRATION")
 I CHK<1.7 W !,"Not running version 1.7 or greater of Quality Assurance Intergration Module" S XPDQUIT=""
 W:'$D(XPDQUIT) !,"Environment check completed"
 Q
