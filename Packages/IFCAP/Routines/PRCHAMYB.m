PRCHAMYB ;WISC/DJM-MOVING AMENDMENT INFO FROM 443.6 TO 442 ;4/4/95  10:57 AM
V ;;5.1;IFCAP;**79,100,220**;Oct 20, 2000;Build 23
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRC*5.1*220 Comment out line related to FPDS message generation
 ;
 N PRCIEN,PRCIEN1,PRCDSL,PAT,PRCDS,PRCDATA,PRCAS,FLAG,DIC,X,DIK,PRCHIEN,LAST,%X,%Y,LOOP,LOOPVAL,DA,MESSG1,CHECKSUM,PRCHPO1,PRCHPOX,PRCHPO2,STATUS,FCP,IMF,O0,O1,PODATE,Y,PRCOPODA
 S PRCIEN=0 F  S PRCIEN=$O(^PRC(442,PRCHPO,6,PRCHAM,3,PRCIEN)) Q:PRCIEN'>0  D
 .S PRCIEN1=$G(^PRC(442,PRCHPO,6,PRCHAM,3,PRCIEN,0)) Q:PRCIEN1=""
 .S PRCDSL=$P(PRCIEN1,U,7) Q:PRCDSL'>0
 .S ^PRC(442,PRCHPO,6,PRCHAM,3,"AD",PRCDSL,PRCIEN)=""
 .Q
 ;
COPY2 ;NOW TO COPY ANY DELIVERY SCHEDULES FROM 441.7 TO 442.8.
 S FLAG=0,PAT=$P(^PRC(443.6,PRCHPO,0),U,1),PRCDS=""
 F  S PRCDS=$O(^PRC(441.7,"AG",PAT,PRCDS)) Q:PRCDS'>0  D  Q:FLAG>0
 .S PRCDSL="" F  S PRCDSL=$O(^PRC(441.7,"AG",PAT,PRCDS,PRCDSL)) Q:PRCDSL'>0  D  Q:FLAG>0
 ..S PRCDATA=$G(^PRC(441.7,PRCDSL,0))
 ..S PRCAS=$P(PRCDATA,U,7)
 ..S PRCDATA=$P(PRCDATA,U,1,6)
 ..S PRCDELF=$P(PRCDATA,U,6)
 ..S:PRCAS>0&(PRCDELF="") ^PRC(442.8,PRCAS,0)=PRCDATA
 ..I PRCAS>0&(PRCDELF="D") D
 ...S DIK="^PRC(442.8,"
 ...S DA=PRCAS
 ...D ^DIK
 ...Q
 ..I PRCAS'>0 D  Q:FLAG>0
 ...S DIC="^PRC(442.8,",DIC(0)="L",X=PAT K DD,DO D FILE^DICN I Y'>0 W !,"An error has occurred while restoring file 442.8 for "_PAT,!,",item "_PRCDS_"." S FLAG=1 Q
 ...S PRCAS=$S(PRCAS>0:PRCAS,1:+Y),^PRC(442.8,PRCAS,0)=PRCDATA
 ..Q:FLAG>0
 ..S DIK="^PRC(442.8,",DA=$S(PRCAS>0:PRCAS,1:+Y) D IX^DIK
 ..S PRCHIEN=0 F  S PRCHIEN=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AD",PRCDSL,PRCHIEN)) Q:PRCHIEN=""  S $P(^PRC(442,PRCHPO,6,PRCHAM,3,PRCHIEN,0),U,7)=PRCAS
 ..Q
 .Q
 Q:FLAG>0
ROLL ;THIS WILL DO THE LINE ITEM ROLL-UP INTO ALL THE 'BOC's.
 S LAST=0,%X="^PRC(442,PRCHPO,22,",%Y="^PRC(443.6,PRCHPO,22," D %XY^%RCR
 S LOOP=0 F  S LOOP=$O(^PRC(442,PRCHPO,22,LOOP)) Q:LOOP'>0  D
 .S LOOPVAL=$G(^PRC(442,PRCHPO,22,LOOP,0)),$P(LOOPVAL,U,2)=0
 .S ^PRC(442,PRCHPO,22,LOOP,0)=LOOPVAL I $P(LOOPVAL,U,3)'=991,$P(LOOPVAL,U,3)>LAST S LAST=$P(LOOPVAL,U,3)
 .Q
 S DA=PRCHPO D ^PRCHAMYC,^PRCHSF1
 S (MESSG1,CHECKSUM)="" D RECODE^PRCHES5(PRCHPO,CHECKSUM,.MESSG1)
 ;
CLEANUP ;THE CODE FOLLOWING THIS COMMENT WILL DELETE THE TEMPORARY FILE
 ;ENTRIES IN FILE 443.6 AND 441.7 FOR PRCHPO ENTRY FROM 442 AND 442.8
 ;FILES.
 S PRCHPO1=$P($G(^PRC(443.6,PRCHPO,0)),U),PRCHPOX=$P($G(^PRC(443.6,PRCHPO,23)),U,4)
 I PRCHPOX]"" S PRCHPO2=$P($G(^PRC(443.6,PRCHPOX,0)),U)
 K ^PRC(443.6,PRCHPO) I PRCHPOX>0 K ^PRC(443.6,PRCHPOX)
 K ^PRC(443.6,"E",$P(PRCHPO1,"-",2),PRCHPO),^PRC(443.6,"B",PRCHPO1,PRCHPO),^PRC(443.6,"D",PRCHPO),^PRC(443.6,"C",PRCHPO,PRCHAM)
 I PRCHPOX>0 K ^PRC(443.6,"E",$P(PRCHPO2,"-",2),PRCHPOX),^PRC(443.6,"B",PRCHPO2,PRCHPOX),^PRC(443.6,"D",PRCHPOX),^PRC(443.6,"C",PRCHPOX,PRCHAM)
 S PRCDS="" F  S PRCDS=$O(^PRC(441.7,"B",PRCHPO1,PRCDS)) Q:PRCDS'>0  D
 .S DIK="^PRC(441.7,",DA=PRCDS D ^DIK
 .Q
 ;
STATUS ;NOW TO UPDATE THE 'SUPPLY STATUS', FIELD .5.  THIS WILL UPDATE
 ;THE P.O. STATUS TO EQUAL THE LATEST AMENDMENT STATUS.
 S STATUS=$P($G(^PRC(442,PRCHPO,6,PRCHAM,1)),U,4),DR=".5////^S X=STATUS",DIE="^PRC(442,",DA=PRCHPO D ^DIE
 S PRCOPODA=PRCHPO_"^"_1_"^"_PRCHAM
 ; ...now generating the PHM transaction...
 D NEW^PRCOEDI ; set up & send PHM
 ; Create FPDS message for the AAC, PRC*5.1*79. Check if the order was
 ; amended but the total dollar amount did not. If there is a cancellation, then send the HL7 message.
 ;PRC*5.1*100: check node 9 and the source code before sending PO to FPDS. Source codes 0,1,3, and 9 not required by FPDS - IEN stored in global.
 I "1378"[$P(^PRC(442,PRCHPO,1),U,7) G OUT1
 I $P(^PRC(442,PRCHPO,0),U,15)>0,$D(^PRC(442,PRCHPO,25)),$D(^PRC(442,PRCHPO,9,1,0)) D
 . I $D(^PRC(442,PRCHPO,6,0)) D
 .. S PRCMN=$P(^PRC(442,PRCHPO,6,0),U,3)
 .. I $P(^PRC(442,PRCHPO,6,PRCMN,0),U,3)=0,$P(^PRC(442,PRCHPO,7),U,2)'=45 S PRCQ=1
 . ;D:$G(PRCQ)'=1 EN^DDIOL("...now generating the FPDS message for the AAC...","","!!"),EN^DDIOL(" ")    PRC*5.1*220
 . D:$G(PRCQ)'=1 AAC^PRCHAAC
 ; End of changes for PRC*5.1*79
OUT1 K PRCOPODA,PRCQ,PRCMN
 I STATUS'=45 G EXIT
 S AUTH=$P($G(^PRC(442,PRCHPO,6,PRCHAM,0)),U,4)
 G:AUTH="" EXIT
 G:'((AUTH=5)!(AUTH=15)) UPDATE
 K AUTH,REF,REF1 G EXIT
 ;
UPDATE ;UPDATE FILE 410 TO POINT TO THE CORRECT P.O.
 S O0=$G(^PRC(442,PRCHPO,0))
 S O1=$G(^PRC(442,PRCHPO,1))
 S FCP=+$P(O0,U)_+$P(O0,U,3)
 S PODATE=+$P(O1,U,15)
 S NEWPO=$P($G(^PRC(442,PRCHPO,23)),U,4)
 G:NEWPO="" FINI
 S PRCOPODA=NEWPO_"^"_2_"^"_PRCHAM_"^"_PRCHPO
 ;...now generating PHA transaction...
 D NEW^PRCOEDI
 K PRCOPODA
 S LOOP=0 F  S LOOP=$O(^PRC(442,NEWPO,2,LOOP)) Q:LOOP'>0  D
 .S L0=$G(^PRC(442,NEWPO,2,LOOP,0))
 .S L2=$G(^PRC(442,NEWPO,2,LOOP,2))
 .S L0=$P(L0,U,10),L2=$P(L2,U,13)
 .Q:L0=""!(L2="")
 .I $P(L0,U,5)>0 D
 ..S IMF=$P(L0,U,5)
 ..K ^PRC(441,IMF,4,FCP,1,PRCHPO,0)
 ..S ^PRC(441,IMF,4,FCP,1,NEWPO,0)=NEWPO
 ..K ^PRC(441,IMF,4,FCP,1,"AC",9999999-PODATE,PRCHPO)
 ..S ^PRC(441,IMF,4,FCP,1,"AC",9999999-PODATE,NEWPO)=""
 ..Q
 .S DA(1)=L0,DA=L2,DIE="^PRCS(410,"_DA(1)_",""IT"",",DR="9///^S X=NEWPO"
 .D ^DIE
 .Q
 S PRC2237=$P($G(^PRC(442,PRCHPO,0)),U,12) G:PRC2237'>0 FINI
 S PRCCNS=$P($P($G(^PRC(442,NEWPO,0)),U),"-",2)
 S OLDCNS=$P(^PRCS(410,PRC2237,4),U,5)
 K ^PRCS(410,"D",OLDCNS,PRC2237)
 S $P(^PRCS(410,PRC2237,4),U,5)=PRCCNS
 S ^PRCS(410,"D",PRCCNS,PRC2237)=""
 S $P(^PRCS(410,PRC2237,10),U,3)=NEWPO
 S MESSAGE="" D RECODE^PRCSC2(PRC2237,.MESSAGE)
 I MESSAGE'=1 W !,"An error has occurred while recoding an ESIG.",!
FINI K NEWPO,LOOP,L0,L2,DIE,DR,PRC2237,OLDCNS,PRCCNS,MESSAGE
EXIT G OTHER^PRCHAMYD
