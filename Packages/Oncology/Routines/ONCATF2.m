ONCATF2 ;HINES OIFO/RTK - New Surgery field defaults/stuffing ;08/27/24
 ;;2.2;ONCOLOGY;**20**;Jul 31, 2013;Build 5
 ;
SURG23 ; RX SUMM--SURG PRIM SITE 2023
 N TOPSRCDZ
 S TOPX=$P($G(^ONCO(165.5,DA,2)),U,1),TOPSRCDZ=$P($G(^ONCO(164,TOPX,0)),U,16)
 S SURGSM23=$P($G(^ONCO(165.5,DA,3.2)),U,9)
 I (SURGSM23="A000")!(SURGSM23="B000") D
 .S TXDT=$P($G(^ONCO(165.5,DA,3)),U,1)_"S1"
 .K ^ONCO(165.5,"ATX",DA,TXDT)
 .S $P(^ONCO(165.5,DA,3),U,1)="0000000"        ;field #50
 .S ^ONCO(165.5,"ATX",DA,"0000000S1")=""       ;"ATX" x-ref
 .S $P(^ONCO(165.5,DA,3),U,28)=8               ;field #59
 .S $P(^ONCO(165.5,DA,"THY1"),U,36)="0000000"  ;field #435
 .S $P(^ONCO(165.5,DA,3.1),U,28)=0             ;field #14
 .S $P(^ONCO(165.5,DA,7),U,19)=9               ;field #46
 .S $P(^ONCO(165.5,DA,7),U,20)=""              ;field #47
 .S $P(^ONCO(165.5,DA,3.2),U,8)=SURGSM23       ;field #58.8 = #58.9
 .W !!,"MOST DEFINITIVE SURG DATE......: 00/00/0000"
 .W !,"DATE MOST DEFINITIVE SURG DIS..: 00/00/0000"
 .W !,"READMISSION W/I 30 DAYS SURG...: No surgery/not readmitted"
 .W !,"SURGICAL MARGINS...............: No primary site surgery"
 .W !,"CAP PROTOCOL REVIEW............: NA or exempt"
 .I $P($G(^ONCO(165.5,DA,2)),"^",1)'=67209 S Y="@42"
 .I $P($G(^ONCO(165.5,D0,2)),"^",1)=67209 W ! S Y=3950
 .Q
 I (SURGSM23="A990")!(SURGSM23="B990") D
 .S TXDT=$P($G(^ONCO(165.5,DA,3)),U,1)_"S1"
 .K ^ONCO(165.5,"ATX",DA,TXDT)
 .S $P(^ONCO(165.5,DA,3),U,1)="9999999"        ;field #50
 .S ^ONCO(165.5,"ATX",DA,"9999999S1")=""       ;"ATX" x-ref
 .S $P(^ONCO(165.5,DA,3),U,28)=9               ;field #59
 .S $P(^ONCO(165.5,DA,"THY1"),U,36)="9999999"  ;field #435
 .S $P(^ONCO(165.5,DA,3.1),U,28)=9             ;field #14
 .S $P(^ONCO(165.5,DA,7),U,19)=9               ;field #46
 .S $P(^ONCO(165.5,DA,7),U,20)=""              ;field #47
 .S $P(^ONCO(165.5,DA,3.2),U,8)=SURGSM23       ;field #58.8 = #58.9
 .W !!,"MOST DEFINITIVE SURG DATE......: 99/99/9999"
 .W !,"DATE MOST DEFINITIVE SURG DIS..: 99/99/9999"
 .W !,"READMISSION W/I 30 DAYS SURG...: Unknown if surgery or readmission"
 .W !,"SURGICAL MARGINS...............: Unknown or NA"
 .W !,"CAP PROTOCOL REVIEW............: NA or exempt"
 .I $P($G(^ONCO(165.5,DA,2)),"^",1)'=67209 S Y="@42"
 .I $P($G(^ONCO(165.5,D0,2)),"^",1)=67209 W ! S Y=3950
 .Q
 Q
 ;
SURGHO23 ; RX HOSP--SURG PRIM SITE 2023
 N TOPSRCDZ
 S TOPX=$P($G(^ONCO(165.5,DA,2)),U,1),TOPSRCDZ=$P($G(^ONCO(164,TOPX,0)),U,16)
 S SURGHO23=$P($G(^ONCO(165.5,DA,3.2)),U,8)
 I (SURGHO23="A000")!(SURGHO23="B000") D
 .S $P(^ONCO(165.5,DA,3.1),U,8)="0000000"
 .S $P(^ONCO(165.5,DA,2.3),U,4)=0
 .W !!,"RX HOSP--SURG APP 2010.........: No surgery/Dx at autopsy"
 .W !,"MOST DEFINITIVE SURG @FAC DATE.: 00/00/0000"
 .S Y="@43"
 I (SURGHO23="A990")!(SURGHO23="B990") D
 .S $P(^ONCO(165.5,DA,3.1),U,8)=9999999
 .S $P(^ONCO(165.5,DA,2.3),U,4)=9
 .W !!,"RX HOSP--SURG APP 2010.........: Not stated/Death cert only"
 .W !,"MOST DEFINITIVE SURG @FAC DATE.: 99/99/9999"
 .S Y="@43"
 .Q
 Q
