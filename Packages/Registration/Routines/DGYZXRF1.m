DGYZXRF1 ;ALB/MIR - SEARCH FOR NON-CROSS-REFERENCED ENTRIES IN DGPM ;AUG 2, 1991
 ;;MAS VERSION 5.0;
 ;
 ;DGYZXRF = Number of entries in DGPM that were cross-referenced
 ;DGYZPRG = Number of entries in DGPM that were purged
 ;DGYZDUP = Number of duplicate entries found and reported
 ;
EN ;Search for non-cross-referenced entries
 D NOW^%DTC S DGSTART=%
 K ^UTILITY("DGYZXRF")
 S (DGYZXRF,DGYZPRG,DGYZDUP)=0
 F DGYZI=0:0 S DGYZI=$O(^DGPM(DGYZI)) Q:'DGYZI  I $D(^DGPM(DGYZI,0)) S DGYZX=^(0) I '$D(^DGPM("B",+DGYZX,DGYZI)) D XRF
 ;
 ;Search for duplicates
 F I=1:1:3 S XRF="APTT"_I F DFN=0:0 S DFN=$O(^DGPM(XRF,DFN)) Q:'DFN  F J=0:0 S J=$O(^DGPM(XRF,DFN,J)) Q:'J  K CT S CT=0 F K=0:0 S K=$O(^DGPM(XRF,DFN,J,K)) Q:'K  I $D(^DGPM(K,0)),($P(+^(0),".",2)]"") S CT=CT+1,CT(K)="" I CT>1 D DUP
 ;
 D NOW^%DTC S DGEND=%
 D BULL
 ;
 S ^UTILITY("DGYZXRF")=DGYZAUTO,^("DGYZXRF","XRF")=DGYZXRF,^("PRG")=DGYZPRG,^("DUP")=DGYZDUP
 K CT,DA,DFN,DGEND,DGSTART,DGYZDUP,DGYZPRG,DGYZXRF,DGYZAUTO,DGYZI,DGYZX,DIK,I,J,K,X,XRF,Y
 Q
 ;
XRF ;If non-cross-referenced:
 ;   Delete if duplicate
 ;   Cross-reference if not
 ;
 S X=$O(^DGPM("APTT"_$P(DGYZX,"^",2),+$P(DGYZX,"^",3),+DGYZX+($P(DGYZX,"^",22)/10000000),0)) I X,(X'=DGYZI) D PURGE Q
 ;
 ;cross-reference entry
 ;^UTILITY("DGYZXRF","XRF",DA)=0 NODE
 ;
 S DGYZXRF=DGYZXRF+1,^UTILITY("DGYZXRF","XRF",DGYZI)=DGYZX
 I 'DGYZAUTO Q  ;don't index
 S DIK="^DGPM(",DA=DGYZI
 S DIK(1)=".01^1^2^4^6" D EN1^DIK ; "B","AINP1","A22","ADFN"
 S DIK(1)=".03^1" D EN1^DIK ;       "C"
 S DIK(1)=".14^2" D EN1^DIK ;       "CA"
 S DIK(1)=".16^1" D EN1^DIK ;       "APTF"
 S DIK(1)=".24^1" D EN1^DIK ;       "APHY"
 S DIK(1)="11500.04^1" D EN1^DIK ;  "AODSA"
 S DIK(1)="11500.07^1" D EN1^DIK ;  "AODSD"
 Q
 ;
PURGE ;purge entry if duplicate
 ;^UTILITY("DGYZXRF","PRG",DA)=0 NODE
 ;
 I DGYZAUTO S DIK="^DGPM(",DA=DGYZI D ^DIK
 S DGYZPRG=DGYZPRG+1,^UTILITY("DGYZXRF","PRG",DGYZI)=DGYZX
 Q
 ;
DUP ;report duplicates found...DO NOT CLEAN-UP!
 ;^UTILITY("DGYZXRF","DUP",DFN,TT,DATE,PREVIOUS DA,DUPLICATE DA)
 ;
 S DGYZDUP=DGYZDUP+1,^UTILITY("DGYZXRF","DUP",DFN,I,J,$O(CT(0)),K)=""
 Q
 ;
BULL ;Fire off bulletin of findings when complete
 ;
 K ^UTILITY("DGYZXRF",$J,"TEXT")
 S Y=DT X ^DD("DD")
 S XMSUB="Search of DGPM is now complete",XMY(DUZ)="",XMTEXT="^UTILITY(""DGYZXRF"",$J,""TEXT"",",DGYZLINE=0,XMDUZ=.5
 S DGYZL="The search for non-cross-referenced and duplicate entries in the PATIENT" D SET
 S DGYZL="MOVEMENT file is now complete." D SET
 S DGYZL=" " D SET,SET
 S Y=DGSTART X ^DD("DD") S DGYZL=" Job started:  "_Y D SET
 S Y=DGEND X ^DD("DD") S DGYZL="Job finished:  "_Y D SET
 S DGYZL=" " D SET
 S DGYZL="Report of findings:" D SET
 S DGYZL="Number of entries in the PATIENT MOVEMENT file                         : "_$J($P(^DGPM(0),"^",4),6) D SET
 S DGYZL="Non-cross-referenced, non-duplicate entries found "_$S(DGYZAUTO:"and cross-referenced",1:"                    ")_" : "_$J(DGYZXRF,6) D SET
 S DGYZL="Non-cross-referenced, duplicate entries found "_$S(DGYZAUTO:"and purged",1:"          ")_"               : "_$J(DGYZPRG,6) D SET
 S DGYZL="Cross-referenced duplicates found                                      : "_$J(DGYZDUP,6) D SET
 S DGYZL=" " D SET,SET
 S DGYZL="NOTE:" D SET
 S DGYZL="   To see a list of reported findings, please type D REPORT^DGYZXRF" D SET
 S DGYZL="   while in programmer mode." D SET
 S DGYZL=" " D SET
 D ^XMD K XMDUZ
 K DGYZL,DGYZLINE,XMY,XMSUB,XMTEXT,^UTILITY("DGYZXRF",$J)
 Q
 ;
SET ; -- set line in xmtext array
 S DGYZLINE=DGYZLINE+1
 S ^UTILITY("DGYZXRF",$J,"TEXT",DGYZLINE,0)=DGYZL
 Q
