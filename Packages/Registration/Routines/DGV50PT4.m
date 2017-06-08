DGV50PT4 ;ALBISC/TET;POST-CONVERSION - UPDATE;1/28/91 ;5/30/91  09:40
 ;;MAS VERSION 5.0;
EN S U="^",CT=0 W !!,"Beginning DGBT Post-init.",!!
 S DGBTTMP=$S('$D(^TMP("DGBT")):0,1:^TMP("DGBT"))
 I '$D(^DGBT(392))!'$D(^DGBT(392.3)) W !!,">>> You do not have your files properly set up.",!?10,"Re-run the init to set them up.",*7 G EXIT 
 I '$O(^DGBT(392,0)) W !!,">>> The claim file has not been populated, the post-init will be skipped.",*7 K ^TMP("DGBT") S DGTMP=3 G EXIT1
 I 'DGBTTMP W !!,">>> It appears that the pre-init has not been successful.",!,"I will not continue with the post-init.",*7 G EXIT
 I DGBTTMP>1 W !!,">>> I will continue the POST-INIT from where you left off.",!! G CONVERT:DGBTTMP=2,EXIT:DGBTTMP=3
 ;re-index up until FY91 the AS, AC, AD and ACTP cross references
 W ! F IX="AS","AC","AD" K ^DGBT(392,IX) W !,">>> ",IX," Cross-reference killed."
 W !,">>> Re-indexing the 'AS', 'AC', 'AD' and 'ACTP'(new) cross-references",!?3,"in your Beneficiary Travel Claim file, #392, up until FY91."
 F I=0:0 S I=$O(^DGBT(392,I)) Q:I'>0!(I>"2900931.99")  I $D(^(I,0)) S DGBTCLMN=^(0),DGBTACCT=+$P(DGBTCLMN,U,6),DGBTCAR=+$P(DGBTCLMN,U,7),DGBTDED=$P(DGBTCLMN,U,9),DGBTDFN=+$P(DGBTCLMN,U,2) D IX
CONVERT ;update claim file to point to proper account for FY91 claims
 ;and complete re-indexing
 W !!,">>> I will now update your ACCOUNT field in your Beneficiary Travel Claim file",!?3,"# 392 and continue to re-index FY91 entries.",!!
 S ^TMP("DGBT")=2,DGBTBD=$S('$D(^TMP("DGBT",1)):"2900931.9999",1:^TMP("DGBT",1)),CT=$S('$D(^TMP("DGBT",1)):0,1:$P(^TMP("DGBT",1),U,2)),U="^"
 F I=DGBTBD:0 S I=$O(^DGBT(392,I)) Q:I'>0  I $D(^(I,0)) S DGBTCLMN=^(0),DGBTACCT=+$P(DGBTCLMN,U,6),DGBTCAR=+$P(DGBTCLMN,U,7),DGBTDED=$P(DGBTCLMN,U,9),DGBTDFN=+$P(DGBTCLMN,U,2) D UPDATE
 S ^TMP("DGBT")=3
EXIT S DGBTTMP=$S('$D(^TMP("DGBT")):0,1:^TMP("DGBT"))
 I DGBTTMP=0 W !!,">>> DGBT Pre-init not run properly.  Follow instructions and begin again." G EXIT1
 I DGBTTMP<3 W !!,">>> FY91 claims have not been updated to FY91 accounts." G EXIT1
 I DGBTTMP=2 W !!,">>> Bene travel conversion incomplete!",*7,!,"Closest entry you can pick up from is "_$S('$D(^TMP("DGBT",1)):"the beginning of the FY",1:$P(^TMP("DGBT",1),U)) G EXIT1
 I DGBTTMP=3 W !!,">>> FY91 entries have been updated to point to the appropriate account.",!?5,"Bene travel conversion completed." W:CT !?5,"A total of ",CT," bene travel claim"_$S(CT>1:"s have",1:" has")_" been converted." K ^TMP("DGBT")
EXIT1 W !!!!?5,">>> Bene travel Post-init is "_$S(DGBTTMP=3:"Complete.",1:"Incomplete.") K CT,DGBTACCT,DGBTACTN,DGBTBD,DGBTCAR,DGBTCLMN,DGBTDED,DGBTDFN,I,IX
 I DGBTTMP=3 F I="DD","LAYGO","WR" S ^DIC(392.3,0,I)="@" K DGBTTMMP,I
 Q
UPDATE ;update ptr to 392.3 in claim file and "AC", "AS", "AD" & "ACTP" cross-ref's
 G:'DGBTACCT IX
 S DGBTACTN=$S(DGBTACCT=4:8,DGBTACCT=5:7,DGBTACCT=3:6,DGBTACCT=2:9,DGBTACCT=1:1,1:DGBTACCT)
 I DGBTACTN S $P(^DGBT(392,I,0),U,6)=DGBTACTN,^DGBT(392,"AC",DGBTACTN,$E(I,1,30))="",CT=CT+1 I CT#100=0 W " . " W:CT#1000=0 "   ",CT," Claims have been converted.",! S ^TMP("DGBT",1)=I_"^"_CT
IX ;set "ACTP", "AS", "AC", and "AD" cross-references
 I DGBTACCT S ^DGBT(392,"ACTP",DGBTACCT,I)=""
 I DGBTCAR S ^DGBT(392,"AS",$E(DGBTCAR,1,30),I)=""
 I DGBTDED]"" S:DGBTDFN ^DGBT(392,"AD",DGBTDFN,$E(I,2,5),I)=DGBTDED
 I I<2900931.991 S:DGBTACCT ^DGBT(392,"AC",DGBTACCT,$E(I,1,30))=""
 Q
