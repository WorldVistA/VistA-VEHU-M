PSJOEA1 ;BIR/MLM - INPATIENT ORDER ENTRY ; Feb 02, 2022
 ;;5.0;INPATIENT MEDICATIONS;**110,127,133,171,254,382,327,401,399,433**;16 DEC 97;Build 2
 ;
 ; Reference to ^PS(55 is supported by DBIA #2191.
 ; Reference to ^PSSLOCK is supported by DBIA #2789.
 ;
CHK ;Check to be sure all the orders in the complex order series are completed.
 N COMQUIT,PSJCOMV,PSJOT,PSJSTAT,PSJSTAT2,PSGND2P5,DUR,ND14,PSJPREX S (PSJCOMV,COMQUIT)=0,PSJSTAT2="" K ^TMP("PSJINTER",$J)
 I '$D(^TMP("PSJCOM",$J)) Q
 N PSJO S PSJO=0 F  S PSJO=$O(^PS(53.1,"ACX",PSJORD,PSJO)) Q:'PSJO  Q:COMQUIT  S PSJOT=$P(^PS(53.1,PSJO,0),"^",4) D
 . I '$D(^TMP("PSJCOM",$J,PSJO,0)) M ^TMP("PSJCOM",$J,PSJO)=^PS(53.1,PSJO) I '$D(^TMP("PSJCOM",$J,PSJO,0)) S COMQUIT=2 Q:COMQUIT
 . S PSJSTAT=$P(^TMP("PSJCOM",$J,PSJO,0),"^",9)
 . I PSJSTAT="DE" S PSJSTAT=$P($G(^TMP("PSJCOM2",$J,PSJO,0)),"^",9) I PSJSTAT="" S COMQUIT=1 Q
 . S:PSJSTAT2="" PSJSTAT2=PSJSTAT S:PSJSTAT'=PSJSTAT2 COMQUIT=2 Q:COMQUIT  S PSJSTAT2=PSJSTAT
 I COMQUIT,PSJOT="U",$G(^TMP("PSJCOM",$J))'="A" S:$G(PSJOWALL)]"" $P(^PS(55,PSGP,5.1),U)=PSJOWALL
 I (COMQUIT=2)!(COMQUIT&($G(^TMP("PSJCOM",$J))'="A")) D  Q
 .K ^TMP("PSJCOM",$J),^TMP("PSJCOM2",$J),PSGCMPLX,PSGTMPSD
 .W !,"By not finishing all the orders, none of the orders will be updated." D PAUSE^VALM1
 I 'COMQUIT N PSJO S PSJO=0 F  S PSJO=$O(^TMP("PSJCOM",$J,PSJO)) Q:'PSJO  D
 .S PSGS0Y=$P($G(^TMP("PSJCOM",$J,+PSJO,2)),"^",5),PSGS0XT=$P($G(^TMP("PSJCOM",$J,+PSJO,2)),"^",6)
 .N EDITS0Y,EDITS0XT S EDITS0Y=$P($G(^TMP("PSJCOM2",$J,+PSJO,2)),"^",5),EDITS0XT=$P($G(^TMP("PSJCOM2",$J,+PSJO,2)),"^",6) D
 ..S:EDITS0Y PSGS0Y=EDITS0Y I EDITS0XT!(",O,D,"[(","_EDITS0XT_",")) S PSGS0XT=EDITS0XT
 .;save the old value of indication and status before filing data to the file (#53.1) entry for this particular sub-order of the complex order
 .N PSJPRIND,PSPRSTAT S PSJPRIND=$G(^PS(53.1,+PSJO,18)),PSPRSTAT=$P($G(^PS(53.1,+PSJO,0)),U,9) ;*399-IND
 .;change the status
 .N DIE,DA,DR S DR="28////^S X=$P(^TMP(""PSJCOM"",$J,+PSJO,0),""^"",9)",DA=+PSJO,DIE="^PS(53.1," D ^DIE
 .N DIK,DA S DIK="^PS(53.1,",DA=+PSJO S:$G(DFN) DA(1)=DFN D IX^DIK K DIK,DA
 .M ^PS(53.1,+PSJO)=^TMP("PSJCOM",$J,+PSJO)
 .;the new value of indication after filing in the file (#53.1) is difefrent for this particular sub-order of the complex order
 .;then add active log entry if INDICATION has changed
 .I PSJPRIND'=$G(^PS(53.1,+PSJO,18)) D
 ..I PSPRSTAT="P"!(PSPRSTAT="N") D NEWNVAL^PSGAL5(+PSJO,6000,"INDICATION",PSJPRIND)
 ..I PSPRSTAT="U" D NEWUDAL^PSGAL5(DFN,+PSJO,6000,"INDICATION",PSJPRIND)
 .S PSGND=$G(^PS(53.1,+PSJO,0)),PSGND2P5=$G(^PS(53.1,+PSJO,2.5)),DUR=$P(PSGND2P5,"^",2),ND14=$$LASTREN^PSJLMPRI(DFN,+PSJO_"P")
 .I $P(PSGND,U,4)="U",$P(PSGND,U,24)="R" D
 ..N PND0,PSGORDR S PND0=^PS(53.1,+PSJO,0) I $P(PND0,U,24)="R" S PSGORDR=$P(PND0,U,25) D
 ...S:'$G(PSGP) PSGP=$G(DFN) Q:'$$LS^PSSLOCK(PSGP,PSGORDR)
 ...N OEORD,OOEORD,FILE55,FILE55N0,PNDP2 S PNDP2=^PS(53.1,+PSJO,.2),FILE55="^PS(55,"_DFN_$S($P(PND0,U,4)="U":",5,",1:",""IV"","),FILE55N0=FILE55_+PSGORDR_",0)"
 ...S OEORD=$P(PND0,U,21) I PSGORDR S OOEORD=$P(@FILE55N0,"^",21) I OEORD'=OOEORD D
 ....D EXPOE^PSGOER(DFN,+PSJO_"P",+$$LASTREN^PSJLMPRI(DFN,+PSJO_"P"))
 ...S PSGORDP=PSJO,DIE="^PS(53.1,",DA=+PSJO,DR="28////A;104////@" W "." D ^DIE
 ...D START^PSGOTR(+PSJO_"P",+PSGORDR) I OEORD D
 ....K DA,DR,DIE S DA(1)=DFN,DA=+PSGORDR,DIE=FILE55,DR=$S(DIE["IV":110,1:66)_"////"_+OEORD
 ....S:$P(PNDP2,U,8) DR=DR_";125////"_$P(PNDP2,U,8) D ^DIE S DIE=FILE55_+PSGORDR_",0)",$P(@DIE,U,21)=OEORD
 ....D EN1^PSJHL2(DFN,"SC",PSGORDR) ;UNL^PSSLOCK(DFN,PSGORDR) move below p433
 ..I '$G(COMQUIT) S ND14=$$LASTREN^PSJLMPRI(DFN,+PSJO_"P") I $G(ND14) S DA=+$P(PSGND,U,25) I DA D
 ...N PSGAT S PSGAT=$P($G(^TMP("PSJCOM",$J,+PSJO,2)),"^",5)
 ...D UPDREN^PSGOER(DA,$P(ND14,U),$P(ND14,U,3),$P(ND14,U,4),$P($G(^PS(53.1,+PSJO,.2)),U,3),$P(ND14,U,2))
 ...D EN1^PSJHL2(DFN,"SC",PSGORDR) ;p433
 ...N PDTYP,PSJHLDFN,RXO S PDTYP="SC",PSJHLDFN=PSGP,RXO=+PSGORDR_"U" D PDORD^PSJPDCLU       ;Complex Renewals, Call PADE HL7 routine for NW Order with new OR100 ordnum-ORC.3  *401
 ...K PSJPREX I $G(PSGORDR)["U" I $G(PSJORD)=+$G(PSJORD) D CMPLX2^PSJCOM1(DFN,PSJORD,PSGORDR) I $G(PSGPXN) S PSJPREX=1
 ..D UNL^PSSLOCK(DFN,PSGORDR) ;Move unlock to here p433
 .I '$G(PSGP) S:$G(DFN) PSGP=DFN
 .I $P(PSGND,U,4)'="U",$P(PSGND,U,24)="R",$P(PSGND,U,25),$P($G(^PS(53.1,+PSJO,2)),U,2)<$P($G(^PS(55,PSGP,"IV",+$P(PSGND,U,25),0)),U,3) D
 ..K DA,DR S DA(1)=PSGP,DA=+$P(PSGND,U,25),DIE="^PS(55,"_PSGP_",""IV"",",DR=".03////"_$P($G(^PS(53.1,+PSJO,2)),U,2)_";116////"_$P($G(^PS(55,PSGP,"IV",+$P(PSGND,U,25),0)),U,3)
 ..D ^DIE,EN1^PSJHL2(PSGP,"XX",$P(PSGND,U,25)) L -^PS(53.1,+PSJO)
 .I $P(PSGND,U,9)="DE",$D(^TMP("PSJCOM2",$J,PSJO,0)),(",N,A,"[$P(^TMP("PSJCOM2",$J,PSJO,0),"^",9)) D
 ..S:'$G(PSGP) PSGP=DFN S PSGS0Y=$P($G(^TMP("PSJCOM2",$J,+PSJO,2)),"^",5)
 ..N DA,DR,DIE D ENGNN^PSGOETO S $P(^TMP("PSJCOM",$J,PSJO,0),"^",26)=DA_"P",$P(^TMP("PSJCOM2",$J,PSJO,0),"^")=DA,$P(^(0),"^",18)=DA
 ..S DR="28////^S X=$P(^TMP(""PSJCOM2"",$J,+PSJO,0),""^"",9)",DIE="^PS(53.1," D ^DIE
 ..M ^PS(53.1,DA)=^TMP("PSJCOM2",$J,+PSJO) M ^TMP("PSJCOM2",$J,DA)=^TMP("PSJCOM2",$J,+PSJO) N PSJOCHIL S PSJOCHIL=$P(^PS(53.1,DA,.2),"^",8) I PSJOCHIL S ^PS(53.1,"ACX",+PSJOCHIL,DA)=""
 ..M:$D(^TMP("PSJCOM",$J,PSJO,"DSS")) ^PS(53.1,DA,"DSS")=^TMP("PSJCOM",$J,PSJO,"DSS") ; p382 move clinic data to pending order file for corrected order
 ..I $P(^PS(53.1,+PSJO,2),"^",5)'=$P(^TMP("PSJCOM2",$J,+PSJO,2),"^",5) S $P(^PS(53.1,+PSJO,2),"^",5)=$P(^TMP("PSJCOM2",$J,+PSJO,2),"^",5)
 ..D EN1^PSJHL2(PSGP,"OD",+PSJO_"P"),EN1^PSJHL2(PSGP,"SN",+DA_"P")
 ..K ^PS(53.1,"ACX",PSJORD,PSJO) L -^PS(53.1,+PSJO) L -^PS(53.1,DA)
 ..D SETUDINT^PSGSICH1(PSJO_"P",DA_"P")
 I '$G(COMQUIT) N PSJO S PSJO=0 F  S PSJO=$O(^PS(53.1,"ACX",PSJORD,PSJO)) Q:'PSJO  Q:PSJCOMV  D
 .I '$D(^TMP("PSJCOM",$J,PSJO)) D  Q:$G(PSJCOMV)
 ..N EDITND0,PREV,REAS S EDITND0=$G(^PS(53.1,+PSJO,0)) S PREV=$P(EDITND0,"^",25),REAS=$P(EDITND0,"^",24)
 ..I PREV,REAS="E" I $P($G(^PS(53.1,+PREV,0)),"^",9)="DE" M ^TMP("PSJCOM",$J,+PSJO)=^PS(53.1,+PSJO) K ^TMP("PSJCOM",$J,+PREV),^PS(53.1,"ACX",+PREV) Q
 ..S PSJCOMV=1
 .I $P(^TMP("PSJCOM",$J,PSJO,0),"^",9)'="A",'$D(^TMP("PSJCOM2",$J,PSJO,0)) S PSJCOMV=1 Q
 .I $P($G(^TMP("PSJCOM2",$J,PSJO,0)),"^",4)="U",$P(^TMP("PSJCOM",$J,PSJO,0),"^",9)'="A",$P($G(^TMP("PSJCOM2",$J,PSJO,0)),"^",9)'="A" S PSJCOMV=1 Q
 .I $P($G(^TMP("PSJCOM2",$J,PSJO,0)),"^",4)'="U",$P(^TMP("PSJCOM",$J,PSJO,0),"^",9)'="A",$P($G(^TMP("PSJCOM2",$J,PSJO,0)),"^",17)'="A" S PSJCOMV=1
 I ($G(COMQUIT)=2)!(($G(COMQUIT)!PSJCOMV)&$G(^TMP("PSJCOM",$J))="A") K ^TMP("PSJCOM",$J),^TMP("PSJCOM2",$J) W !,"By not verifying all the orders, none of the orders will be verified." D PAUSE^VALM1 Q
 ; 
 D CHK^PSJOEA2
 Q
