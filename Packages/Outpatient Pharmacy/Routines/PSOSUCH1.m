PSOSUCH1 ;BHAM ISC/JMB-Change suspense and fill/refill dates; Mar 16, 2026@09:30
 ;;7.0;OUTPATIENT PHARMACY;**148,681,823**;DEC 1997;Build 7
 ;
 ; Reference to ^DIC(4 in ICR #2251
 ; Reference to ^PSXCH in ICR #2206
 ;
LISTSUS S X="?",DIC("S")="I $D(^PSRX(+$P(^PS(52.5,+Y,0),""^""),0)),$P($G(^(""STA"")),""^"")<11,$P($G(^PS(52.5,+Y,""P"")),""^"")=0",DIC="^PS(52.5,",DIC(0)="ZQ" D ^DIC K DIC W ! Q:Y<0!($D(DTOUT))  Q
 ;
LISTPAT S X="?",DIC(0)="EMQ",DIC="^DPT(",DIC("S")="I $D(^PS(52.5,""AC"",+Y))" D ^DIC K DIC Q
 ;
PSOINST S PSOINST=$P($G(^DIC(4,+$P($G(^XMB(1,1,"XUS")),"^",17),99)),"^") I Y["-",'$D(^PSRX($P(Y,"-",2),0)) W !,?7,$C(7),$C(7),$C(7),"   NON-EXISTENT PRESCRIPTION" G SPEC^PSOSUCHG:ACT="S" G ALL^PSOSUCHG:ACT="A"
 I Y["-",$P(Y,"-")'=PSOINST W !,?7,$C(7),$C(7),$C(7),"  NOT FROM THIS INSTITUTION" G SPEC^PSOSUCHG:ACT="S" G ALL^PSOSUCHG:ACT="A"
 Q
 ;
AREC ;
 N PSODUZ
 S PSODUZ=DUZ
 I '$D(^VA(200,+PSODUZ,0)) S PSODUZ=.5
 I 'DEAD S COM="Change "_$S($G(PSOSUSPA):"Partial",'$G(SUB):"Fill",1:"Refill")_" Date "_$E(OLD,4,5)_"/"_$E(OLD,6,7)_"/"_$E(OLD,2,3)_" to "_$E(INDT,4,5)_"/"_$E(INDT,6,7)_"/"_$E(INDT,2,3)
 S CNT=0 F SUB=0:0 S SUB=$O(^PSRX(RXREC,"A",SUB)) Q:'SUB  S CNT=SUB
 S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(RXREC,1,RF)) Q:'RF  S RFCNT=RF S:RF>5 RFCNT=RF+1
 D NOW^%DTC
 S CNT=CNT+1
 S ^PSRX(RXREC,"A",0)="^52.3DA^"_CNT_"^"_CNT
 S ^PSRX(RXREC,"A",CNT,0)=%_"^"_$S(DEAD:"C",1:"S")_"^"_PSODUZ_"^"_$S($G(PSOSUSPA):6,1:RFCNT)_"^"_COM
 K PSOSUSPA
 Q
 ;
CHKDEAD D DEM^VADPT I VADM(1)="" W !?10,"PATIENT NAME UNKNOWN" S DEAD=0 Q
 I VADM(6)="" S DEAD=0 Q
 S SUSDOD=$P(VADM(6),"^",2)
 F RXREC=0:0 S RXREC=$O(^PS(52.5,"AC",DFN,RXREC)) Q:'RXREC  F SRXREC=0:0 S SRXREC=$O(^PS(52.5,"AC",DFN,RXREC,SRXREC)) Q:'SRXREC  S RECORD=$P($G(^PS(52.5,SRXREC,0)),"^") D:RECORD DEAD
 Q
 ;
DEAD S HOLD=$G(DA),REA="C",COM="Died ("_$G(SUSDOD)_")",DA=RECORD,DEAD=1 D CAN^PSOCAN
 W:'WARN !!,?10,$P($G(^DPT(DFN,0)),"^")_" DIED "_SUSDOD_" all prescriptions were discontinued" W:'WARN !,?15," and deleted from the suspense file." S WARN=1,DA=HOLD K HOLD,REA
 Q
 ;
NEXT S PSOX("IRXN")=RXREC D NEXT^PSOUTIL(.PSOX) S NEXT=$P(PSOX("RX3"),"^",2),DA=RXREC,DIE=52,DR="102///"_NEXT D ^DIE K DIE Q:$D(DTOUT)!($D(DUOUT))
 K NEXT,PSOX Q
 ;
CHANGE(RXREC,SUB) ; File update for Suspense Date change
 ;PSO*7.0*823: Added PSOAREC
 N PSOAREC S PSOAREC=1
 I $P($G(^PS(52.5,SFN,0)),"^",5) S PSOSUSPA=1,HDSFN=SFN S SRXPAR=+$P(^(0),"^",5),OLD=+$P($G(^PSRX(RXREC,"P",SRXPAR,0)),"^"),DA(1)=RXREC,DA=SRXPAR,DIE="^PSRX("_DA(1)_",""P"",",DR=".01////"_INDT D ^DIE G FIN
 I '$D(SUB) S SUB=0 F II=0:0 S II=$O(^PSRX(RXREC,1,II)) Q:'II  S SUB=+II
 S HDSFN=SFN I 'SUB S (X,OLD)=$P(^PSRX(RXREC,2),"^",2),DA=RXREC,DR="22///"_INDT_";101///"_INDT,DIE=52 D
 .D ^DIE K DIE K:$G(^PS(52.5,HDSFN,"P"))=1 ^PS(52.5,"AC",DFN,+$P($G(^PS(52.5,HDSFN,0)),"^",2),HDSFN) Q:$D(DTOUT)!($D(DUOUT))  D NEXT K DA Q
 I SUB S (OLD,X)=+$P($G(^PSRX(RXREC,1,SUB,0)),"^"),DA(1)=RXREC,DA=SUB,DIE="^PSRX("_DA(1)_",1,",DR=".01///"_INDT D ^DIE K DIE S $P(^PSRX(RXREC,3),"^")=INDT D
 .K:$G(^PS(52.5,HDSFN,"P"))=1 ^PS(52.5,"AC",DFN,+$P($G(^PS(52.5,HDSFN,0)),"^",2),HDSFN) D NEXT S DA=RXREC K DA Q
 ;PSO*7.0*823: PSOSDLK is set by option "Change Suspense Date".
 ;             No other PSO routines set PSOSDLK.
 ;             A future patch might address related issues with that option.
 I '$D(PSOSDLK) D EXP
 D FIN
 Q
 ;
EXP ;PSO*7.0*823: Create Mailman message and add activity log for suspense beyond expiration date
 N PSOEXPDT,PSOSUS,PSOSUSDT,PSOKEY,PSODUZ,PSORXNUM,PSOUSR,PSOFNSH,PSOCOMNT,XMY,XMDUZ,XMSUB,XMTEXT,XMIN
 S PSOEXPDT=$P(^PSRX(RXREC,2),U,6),PSOSUS=$O(^PS(52.5,"B",RXREC,0)),PSOSUSDT=$P(^PS(52.5,PSOSUS,0),U,2)
 ;No need to send MailMan message if suspense date is not greater than the expiration date.
 I PSOSUSDT'>PSOEXPDT Q
 S PSORXNUM=$P(^PSRX(RXREC,0),U)
 S PSOAREC=0
 S PSOSUSDT=$E(PSOSUSDT,4,5)_"/"_$E(PSOSUSDT,6,7)_"/"_$E(PSOSUSDT,2,3)
 S PSOEXPDT=$E(PSOEXPDT,4,5)_"/"_$E(PSOEXPDT,6,7)_"/"_$E(PSOEXPDT,2,3)
 S PSOKEY=+$O(^DIC(19.1,"B","PSXMAIL",0))
 ;Create MailMan message
 K ^TMP("PSO SUSPENSE EXPIRATION",$J,"TEXT")
 S ^TMP("PSO SUSPENSE EXPIRATION",$J,"TEXT",1)="A 3/4 days supply hold for Rx #"_PSORXNUM_" suspended the suspense date to "_PSOSUSDT
 S ^TMP("PSO SUSPENSE EXPIRATION",$J,"TEXT",2)="which is on or after the Rx expiration date "_PSOEXPDT_"."
 S ^TMP("PSO SUSPENSE EXPIRATION",$J,"TEXT",3)=""
 S ^TMP("PSO SUSPENSE EXPIRATION",$J,"TEXT",4)="Review the Rx #"_PSORXNUM_" activity log to identify the prior Rx fill impacting"
 S ^TMP("PSO SUSPENSE EXPIRATION",$J,"TEXT",5)="the SUSPENSE HOLD date and determine if ECME actions are necessary to avoid"
 S ^TMP("PSO SUSPENSE EXPIRATION",$J,"TEXT",6)="Rx expiration while on suspense."
 S ^TMP("PSO SUSPENSE EXPIRATION",$J,"TEXT",7)=""
 S ^TMP("PSO SUSPENSE EXPIRATION",$J,"TEXT",8)="This message was sent to the Finishing Pharmacist and PSXMAIL security key"
 S ^TMP("PSO SUSPENSE EXPIRATION",$J,"TEXT",9)="holders."
 S ^TMP("PSO SUSPENSE EXPIRATION",$J,"TEXT",10)=""
 ;Gather Recipients
 ;Finishing person
 S PSOFNSH=$P(^PSRX(RXREC,"OR1"),U,5)
 S XMY(PSOFNSH)=""
 ;Holders of PSXMAIL key 
 S PSODUZ=0
 F  S PSODUZ=$O(^VA(200,"AB",PSOKEY,PSODUZ)) Q:'PSODUZ  D
 . Q:$$GET1^DIQ(200,PSODUZ_",",7,"I")
 . S XMY(PSODUZ)=""
 S XMSUB="3/4 Days Supply Suspense Hold After Rx Expiration Date"
 S XMIN("FROM")="Suspense Background Process"
 S XMTEXT="^TMP(""PSO SUSPENSE EXPIRATION"",$J,""TEXT"")"
 D SENDMSG^XMXAPI(DUZ,XMSUB,XMTEXT,.XMY,.XMIN,"","")
 ; Update the Activity Log
 S PSOCOMNT="Suspense Date "_PSOSUSDT_" is on or after Expiration Date "_PSOEXPDT_"."
 N X,DIC,DA,DD,DO,DR,DINUM,Y,DLAYGO
 S DA(1)=RXREC,DIC="^PSRX("_RXREC_",""A"",",DLAYGO=52.3,DIC(0)="L",X=$$NOW^XLFDT()
 S DIC("DR")=".02///E;.03///"_DUZ_";.04///"_$$LSTRFL^PSOBPSU1(RXREC)
 S DIC("DR")=DIC("DR")_";.05///"_PSOCOMNT
 D FILE^DICN
 Q
 ;PSO*7.0*823 end
 ;
FIN S DA=HDSFN,DIK="^PS(52.5," D IX1^DIK
 S SFN=HDSFN D:PSOAREC AREC N X S X="PSXCH" X ^%ZOSF("TEST") K X Q:'$T  D:$G(XOK)=1 X^PSXCH Q
 Q
 ;
DAREC ;
 N PSODUZ
 S PSODUZ=DUZ
 I '$D(^VA(200,+PSODUZ,0)) S PSODUZ=.5
 S SCOM="Rx "_$S($P(SNODE,"^",5):"(Partial) ",1:"")_"deleted from suspense"
 S SSX=0 F SSXX=0:0 S SSXX=$O(^PSRX(RXREC,"A",SSXX)) Q:'SSXX  S SSX=SSXX
 S SXCNT=0 F SCXX=0:0 S SCXX=$O(^PSRX(RXREC,1,SCXX)) Q:'SCXX  S SXCNT=SCXX S:SCXX>5 SXCNT=SCXX+1
 D NOW^%DTC
 S SSX=SSX+1
 S ^PSRX(RXREC,"A",0)="^52.3DA^"_SSX_"^"_SSX
 S ^PSRX(RXREC,"A",SSX,0)=%_"^"_"S"_"^"_PSODUZ_"^"_$S($P(SNODE,"^",5):6,1:SXCNT)_"^"_SCOM
 K SCOM,SSX,SSXX,SXCNT,SCXX
 Q
