DENTVHL3 ;DSS/LM - Dental Transaction Extract HL7 Messaging ;5/29/2003 16:40
 ;;1.2;DENTAL;**40,45,53,55**;Aug 10, 2001;Build 5
 ;Copyright 1995-2007, Document Storage Systems, Inc., All Rights Reserved
 ; Integration Agreements
 ;
 ; 10112  $$SITE^VASITE
 ; 2320   $$PWD^%ZISH
 ; 2320   OPEN^%ZISH
 ; 2320   CLOSE^%ZISH
 ; 10070  ^XMD
 ; 2052   FILE^DID, $$GET1^DID
 ; 2056   $$GET1^DIQ
 ; 10063  ^%ZTLOAD
 ;
 Q
EN ;;Option: DENTVHL PROCESS HISTORIC
 D DQ
 Q
DQ ; process all of the old transactions
 ; (prior to patch 38 setting the "AXMIT" x-ref)
 N DENTVCNT,DENTVMAX S DENTVMAX=99999999
 N DENTVHST S DENTVHST=1 ;Historic process flag
 D B1^DENTVHLB ;Generate batch
 ; Messages are in ^TMP("HLS",$J)
 ; Copy to HFS in one file containing batches of 1000 messages each
 ; reaching the PRA segment means one message is complete
 N DENTVFIL,CNT,BCNT,BMAX,DENTSIT,BHS,PRA
 S DENTSIT=$P($$SITE^VASITE,U,3),CNT=0,BCNT=1,BMAX=1000
 S DENTVFIL="DENTV_HISTORICAL_"_DENTSIT_".TXT"
 N DENTVDIR S DENTVDIR=$$PWD^%ZISH
 S BHS="BHS^~|\&^DENTV-C^SITE^DENTV-AAC-C^200^DATE^^~T~ORU|R01~2.4~NE~NE^^BATCHID^"
 S $P(BHS,U,4)=DENTSIT,$P(BHS,U,7)=$$FMTHL7^XLFDT($$NOW^XLFDT)
 S $P(BHS,U,11)=DENTSIT_"-HIST-"_BCNT
 N POP D OPEN^%ZISH("DENTV"_$J,DENTVDIR,DENTVFIL,"W",512)
 I POP D FAIL,KILL Q
 I $D(^TMP("HLS",$J,"DENTVHL")) D  D SUCCESS
 .N I,J,R S I=0,R=$NA(^TMP("HLS",$J))
 .U IO W BHS,!
 .F  S I=$O(@R@(I)) Q:'I  D
 ..W @R@(I) S J=0 F  S J=$O(@R@(I,J)) Q:'J  W @R@(I,J)
 ..W !
 ..S PRA=$E($G(@R@(I)),1,3) I PRA="PRA"  S CNT=CNT+1 ;count
 ..I CNT=BMAX S CNT=0 W "BTS^"_BMAX,! D
 ...S BCNT=BCNT+1,$P(BHS,U,11)=DENTSIT_"-HIST-"_BCNT
 ...W BHS,!
 ...Q
 ..Q
 .I CNT>0 W "BTS^"_CNT,!
 .Q
 E  D FAIL
 D CLOSE^%ZISH("DENTV"_$J),KILL
 Q
 ;
TASK ;task off the code to check for acks and clean up 228.25
 N X,Y,Z,ZTSK,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC
 S ZTIO="",ZTDTH=$$FMTH^XLFDT($$FMADD^XLFDT(DT,3)+.04)
 S ZTRTN="PS^DENTVHL3",ZTDESC="DENTAL HL7 CHECK ACKS"
 D ^%ZTLOAD
 Q
PS ;enter from queued job
 N I,X,COMPDT,DIK,DA,QUIT,DT1,DT2,NODE,DENT,DENTI
 S COMPDT=$$FMADD^XLFDT(DT,-180) ;6 months ago
 ;first delete old data in file 228.25 starting from the top
 S DIK="^DENT(228.25,",I=0,QUIT=0
 F  S I=$O(^DENT(228.25,I)) Q:'I!QUIT  S X=$P($G(^(I,0)),U,2) D
 .I X>COMPDT S QUIT=1 Q
 .S DA=I D ^DIK
 .Q
 ;now, starting from the bottom, check to see if we have acks for time period
 ;we're checking everything within the DT1-DT2 date range for acks
 ;if there's no ack, then set the HL7 flag for the txn(or fee rec) to Pending
 S DT1=$$FMADD^XLFDT(DT,-14),DT2=$$FMADD^XLFDT(DT,-7),QUIT=0
 S DENTI="A" F  S DENTI=$O(^DENT(228.25,DENTI),-1) Q:'DENTI!QUIT  S NODE=$G(^(DENTI,0)) D
 .S X=$P(NODE,U,2) I X>DT2 Q  ;not old enough to resend
 .I X<DT1 S QUIT=1 Q  ;too old to resend
 .I $P(NODE,U,5)]"" Q  ;has been ackd
 .K DENT
 .I $P(NODE,U,7) S DENT(228.2,$P(NODE,U,7)_",",1.18)="P"
 .I $P(NODE,U,8) S DENT(228.5,$P(NODE,U,8)_",",.12)="P"
 .I $D(DENT) D FILE^DIE(,"DENT")
 .Q
 Q
 ;
SUCCESS ;;Generate success message
 N %,DENTVTXT,R,XMDUZ,XMSUB,XMTEXT,XMY,DIFROM
 S XMDUZ=.5,XMSUB="Dental batch succeeded"
 S %=0,R="DENTVTXT",XMY(XMDUZ)=""
 S %=%+1,@R@(%,0)="Dental historical batch to HFS succeeded."
 S %=%+1,@R@(%,0)=$P($G(^TMP("HLS",$J,"DENTVHL")),"%%",3)
 S @R@(%,0)=@R@(%,0)_" transactions were processed."
 S %=%+1,@R@(%,0)="A host file named "_DENTVFIL
 S %=%+1,@R@(%,0)="should be found in the "_DENTVDIR_" directory."
 S %=%+1,@R@(%,0)="Please copy this file to a CD and mail to"
 S %=%+1,@R@(%,0)="the address provided." ;Placeholder for address
 S XMTEXT="DENTVTXT("
 D ^XMD
 Q
FAIL ;;Generate failure message
 N %,DENTVTXT,R,XMDUZ,XMSUB,XMTEXT,XMY,DIFROM
 S XMDUZ=.5,XMSUB="Dental batch failed"
 S %=0,R="DENTVTXT",XMY(XMDUZ)=""
 S %=%+1,@R@(%,0)="Dental historical batch to HFS failed."
 I $G(POP) D
 .S %=%+1,@R@(%,0)="Open failed for file "_DENTVFIL
 .S %=%+1,@R@(%,0)="in HFS directory "_DENTVDIR
 .Q
 E  D
 .S %=%+1,@R@(%,0)="Batch was empty--no messages generated."
 .Q
 S XMTEXT="DENTVTXT("
 D ^XMD
 Q
KILL ;;Cleanup
 K ^TMP("HLS",$J)
 Q
 ;
MSG(TXN,ERR) ;Send e-mail for bad transaction
 N X,ETEXT,DENTX,DENER,DENPAT,DENFIL,PC  Q:'TXN
 I $P(ERR,";")=228.5 S DENFIL=228.5,PC=4
 E  S DENFIL=228.2,PC=2
 S DENPAT=$P($G(^DENT(DENFIL,TXN,0)),U,PC) I DENPAT D
 .S DENPAT=$$GET1^DIQ(2,DENPAT_",",.01)
 .Q
 S ETEXT="Invalid data for "_DENPAT_" transaction "_TXN_", file "
 D FILE^DID($P(ERR,";"),"","NAME","DENTX")
 I $G(DENTX("NAME"))]"" S ETEXT=ETEXT_$G(DENTX("NAME"))
 E  S ETEXT=ETEXT_"#"_$P(ERR,";")
 S ETEXT=ETEXT_" field "
 S X=$$GET1^DID($P(ERR,";"),$P(ERR,";",2),,"LABEL",,"DENER")
 I X]"" S ETEXT=ETEXT_X
 E  S ETEXT=ETEXT_"#"_$P(ERR,";",2)
 D ERR^DENTVHL2(,ETEXT_".")
 Q
