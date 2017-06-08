DGYGPT ;ALB/CAW - Stuff Type of Test/Total Dependents and Re-index ;12/2/92
 ;;5.2;REGISTRATION;**22**;JUL 29,1992
 ;
EN ;
 D NOW^%DTC S Y=$$FTIME(%) W !!,"  POST INIT STARTED AT: ",Y
 D DEP,TOT,CHNG
 S:'$P(^DG(43,1,0),"^",41) $P(^(0),U,41)=1
TIME D NOW^%DTC S Y=$$FTIME(%) W !!,"POST INIT COMPLETED AT: ",Y
ENQ Q
DEP ; Stuff Total Dependents
 ;
 N CNT,DGMT0,DGMTL,DFN,DGMTDEP,DGDEP,DGINR S DGMTL=0
 W !!,"...adding type of test and total dependents to Means Test file"
 F  S DGMTL=$O(^DGMT(408.31,DGMTL)) Q:'DGMTL  S DGMT0=$G(^(DGMTL,0)) D
 .Q:'DGMT0
 .S DFN=$P(DGMT0,U,2)
 .D DEP1
 .S $P(^DGMT(408.31,DGMTL,0),U,18)=DGMTDEP S:'$P(DGMT0,U,19) $P(^(0),U,19)=1
 .S CNT=$G(CNT)+1 I '(CNT#100) W "."
 K CNT
 Q
 ;
DEP1 D ALL^DGMTU21(DFN,"VSC",+DGMT0,"R") S DGMTDEP=DGDEP
 I $D(DGINR("S")),$D(DGINR("V")),$P($G(^DGMT(408.22,DGINR("V"),0)),U,6) S DGMTDEP=DGDEP+1 Q
 I $D(DGINR("S")),$D(DGINR("V")),'$P($G(^DGMT(408.22,DGINR("V"),0)),U,6),$P(^(0),U,7)>599 S DGMTDEP=DGDEP+1 Q
 Q
 ;
TOT ; Loop through existing MT file
 N DGMTL,DGMT0 S DGMTL=0
 W !!,"...re-indexing Means Test File"
 K ^DGMT(408.31,"AS"),^DGMT(408.31,"AD"),^DGMT(408.31,"AID"),^DGMT(408.41,"AM")
 F  S DGMTL=$O(^DGMT(408.31,DGMTL)) Q:'DGMTL  S DGMT0=^(DGMTL,0) K ^DGMT(408.31,"ADFN"_+$P(DGMT0,U,2),+DGMT0,DGMTL) D
 .I $P(DGMT0,U,2)&($P(DGMT0,U,3))&($P(DGMT0,U,19)) D
 ..S ^DGMT(408.31,"AS",+$P(DGMT0,U,19),+$P(DGMT0,U,3),-$P(DGMT0,U),+$P(DGMT0,U,2),DGMTL)=""
 .I $P(DGMT0,U,2)&($P(DGMT0,U,19)) D
 ..S ^DGMT(408.31,"AID",+$P(DGMT0,U,19),+$P(DGMT0,U,2),-$P(DGMT0,U),DGMTL)=""
 ..S ^DGMT(408.31,"AD",+$P(DGMT0,U,19),+$P(DGMT0,U,2),$P(DGMT0,U),DGMTL)=""
 .I $P(DGMT0,U,2) D
 ..S ^DGMT(408.31,"ADFN"_$P(DGMT0,U,2),+DGMT0,DGMTL)=""
 .S CNT=$G(CNT)+1 I '(CNT#100) W "."
 I '$D(DGMT0) W !,"It appears the re-indexing of the means test changes file did not complete properly.",!,"Please re-start the post init by typing D TOT^DGYGPT." G TOTQ
 I '$D(^DGMT(408.31,"AID",+$P(DGMT0,U,19),+$P(DGMT0,U,2),-$P(DGMT0,U))) W !,"It appears the re-indexing of the means test file did not ",!,"complete properly.  Please re-start the post init by typing D TOT^DGYGPT."
TOTQ K CNT
 Q
 ;
CHNG ;Loop through existing MT changes, stuff type of test and re-index
 N DGMTI,DGMT0 S DGMTI=0
 W !!,"...re-indexing Means Test Changes File"
 F  S DGMTI=$O(^DGMT(408.41,DGMTI)) Q:'DGMTI  S DGMT0=$G(^(DGMTI,0)) D
 .Q:'DGMT0  I '$P(DGMT0,U,19) S $P(^DGMT(408.41,+DGMTI,0),U,19)=1
 .S:$P(^DGMT(408.41,DGMTI,0),U,3)&($P(^(0),U,4)) ^DGMT(408.41,"AM",+$P(^(0),U,19),$P(^(0),U,4),$P(^(0),U,3),DGMTI)=""
 .S CNT=$G(CNT)+1 I '(CNT#100) W "."
 I '$D(DGMT0) W !,"It appears the re-indexing of the means test changes file did not complete ",!,"properly.  Please re-start the post init by typing D CHNG^DGYGPT." G CHNGQ
 I '$D(^DGMT(408.41,"AM",+$P(DGMT0,U,19),+$P(DGMT0,U,4),+$P(DGMT0,U,3))) W !,"It appears the re-indexing of the means test changes file did not complete ",!,"properly.  Please re-start the post init by typing D CHNG^DGYGPT."
CHNGQ Q
FTIME(Y) ; -- return formatted date/time
 ;   input:          Y := internal date/time
 ;  output: [returned] := formatted date and time
 D DD^%DT
 Q Y
 ;
ADFN ; Fix ADFN x-ref
 S DGMTL=0
 F  S DGMTL=$O(^DGMT(408.31,DGMTL)) Q:'DGMTL  S DGMT0=^(DGMTL,0) K ^DGMT(408.31,"ADFN"_+$P(DGMT0,U,2),+DGMT0,DGMTL) D
 .S:$P(DGMT0,U,2) ^DGMT(408.31,"ADFN"_$P(DGMT0,U,2),+DGMT0,DGMTL)=""
 .S CNT=$G(CNT)+1 I '(CNT#100) W "."
 K CNT
 Q
