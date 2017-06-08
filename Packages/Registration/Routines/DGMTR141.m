DGMTR141 ;ALB/SEK - Check Means Test Requirements - DG*5.3*141 ;09/24/97
 ;;5.3;Registration;**141**;Aug 13, 1993
 ;
 ;This modification of DGMTR is used for the cleanup of 0% SC
 ;veterans in Patch DG*5.3*141.  Line ADD+4 was changed to use the
 ;input variable DGADDDT for the DATE OF TEST of the created
 ;required Means Test. 
 ;
 ;A patient requires a means test under the following conditions:
 ;  - Primary Eligibility is NSC OR patient is SC 0% non-compensable
 ;  - who is NOT receiving disability retirement from the military
 ;  - who is NOT eligible for medicaid
 ;  - who is NOT on a DOM ward
 ;  - who has NOT been means tested in the past year
 ;
 ; Input  -- DFN     Patient IEN
 ;           DGADDDT date of test for the created required Means Test
 ;           DGADDF  Means Test Add Flag  (Optional- default none)
 ;                   (1 if using the 'Add a New Means Test' option)
 ;           DGMSGF  Means Test Msg Flag  (Optional- default none)
 ;                   (1 to suppress messages)
 ; Output -- DGREQF  Means Test Require Flag
 ;                   (1 if required and 0 if not required)
 ;           DGDOM1  DOM Patient Flag (defined and set to 1 if
 ;                               patient currently on a DOM ward)
 ;
 ;           If NOT using the 'Add a New Means Test' option,
 ;           a REQUIRED date of test will be added for the
 ;           patient if it is required.
 ;
 ;           If a means test is required and the current
 ;           status is NO LONGER REQUIRED, the last date of
 ;           test and current means test status will be
 ;           updated to REQUIRED.
 ;
 ;           If a means test is no longer required the
 ;           last date of test and the current means test
 ;           status will also be updated to NO LONGER REQUIRED.
 ;
EN N DGCS,DGDOM,DGLDN,DGMT0,DGMTI,DGMTYPT
 S (DGREQF,DGLDN)=0,DGMTYPT=1
 I $D(^DPT(DFN,.36)) S X=^(.36) D
 . I $P($G(^DIC(8,+X,0)),"^",9)=5!($$SC(DFN)) S DGREQF=1
 . I $P(X,"^",2),$P(X,"^",2)<3 S DGREQF=0
 I DGREQF S:$G(^DPT(DFN,.38)) DGREQF=0
 I DGREQF D DOM S:$G(DGDOM) DGREQF=0
 S DGMTI=+$$LST^DGMTU(DFN),DGMT0=$G(^DGMT(408.31,DGMTI,0)),DGCS=$P(DGMT0,"^",3)
 I DGCS S X1=DT,X2=+DGMT0 D ^%DTC S DGLDN=X
 I DGREQF D REQ:(DGCS=3&(DGLDN'>365)),ADD:('$G(DGADDF)&('DGCS!(DGCS&(DGLDN'<365))))
 I 'DGREQF D NOL:(DGCS&(DGCS'=3)&('$G(DGDOM)))
 Q
 ;
 ;Check if patient is in a DOM
 ;  call to DOM checks if patient currently on a DOM ward
 ;                                     (called from EN)
 ;  call to DOM1 checks if patient on a DOM ward for a specific date
 ;    before call to DOM1 - N VAINDT,VADMVT,DGDOM,DGDOM1
 ;                          S VAINDT=specific date
 ;                          S DFN=Patient IEN
 ;                 output - DGDOM & DGDOM1 (defined and set to 1 if
 ;                          patient on a DOM ward for specific date)
 ;
DOM N VAINDT,VADMVT
DOM1 D ADM^VADPT2
 I VADMVT,$P($G(^DG(43,1,0)),"^",21),$D(^DIC(42,+$P($G(^DGPM(VADMVT,0)),"^",6),0)),$P(^(0),"^",3)="D" S (DGDOM,DGDOM1)=1
 Q
 ;
SC(DFN) ;Check if patient is SC 0% non-compensable
 ; Input  -- DFN     Patient IEN
 ; Output -- 1=Yes and 0=No
 ;
 ;     No if:
 ;        No total annual VA check amount
 ;        POW STATUS INDICATOR is yes
 ;        Secondary Eligibility is one of the following:
 ;           A&A
 ;           NSC, VA PENSION
 ;           HOUSEBOUND
 ;           MEXICAN BORDER WAR
 ;           WWI
 ;           POW
 ;
 N DG,DGE,Y
 S Y=0
 ;Primary eligibility is SC LESS THAN 50%
 I $D(^DPT(DFN,.36)),$P($G(^DIC(8,+^(.36),0)),"^",9)=3 S Y=1
 G:'Y SCQ
 ;Service connected percentage is 0
 I $P($G(^DPT(DFN,.3)),"^",2)'=0 S Y=0 G SCQ
 ;No Total annual VA check amount
 I $P($G(^DPT(DFN,.362)),"^",20) S Y=0 G SCQ
 ;POW STATUS INDICATOR
 I $P($G(^DPT(DFN,.52)),"^",5)="Y" S Y=0 G SCQ
 ;Secondary Eligibility
 F DG=2,4,15:1:18 S DGE(DG)=""
 S DG=0 F  S DG=$O(^DPT(DFN,"E","B",DG)) Q:'DG  I $D(DGE($P($G(^DIC(8,+DG,0)),"^",9))) S Y=0 Q
SCQ Q +$G(Y)
 ;
ADD ;Add a required means test
 N DGMTA,DGMTACT,DGMTDT,DGMTI,DGMTP
 W:'$G(DGMSGF) !,"MEANS TEST REQUIRED"
 S DGMTACT="ADD" D PRIOR^DGMTEVT
 S DGMTDT=DGADDDT D ADD^DGMTA
 I DGMTI>0 S DGMTYPT=1 D QUE,EN^DGMTCOR
 Q
 ;
REQ ;Update means test status to REQUIRED
 N DGMTA,DGMTACT,DGFL,DGFLD,DGIEN,DGMTP,DGVAL
 W:'$G(DGMSGF) !,"MEANS TEST REQUIRED"
 S DGMTACT="STA" D PRIOR^DGMTEVT
 S DGFL=408.31,DGFLD=.03,DGIEN=DGMTI I DGCS]"" S DGVAL=DGCS D KILL
 S DGVAL=1,$P(^DGMT(408.31,DGMTI,0),"^",3)=DGVAL D SET
 S DGFLD=.17,DGVAL=$P(DGMT0,"^",17) I DGVAL]"" D KILL
 S $P(^DGMT(408.31,DGMTI,0),"^",17)=""
 S DGMTYPT=1 D QUE,EN^DGMTCOR
 Q
 ;
NOL ;Update means test status to NO LONGER REQUIRED
 N DGMT0,DGMTA,DGMTACT,DGFL,DGFLD,DGIEN,DGINI,DGINR,DGMTDT,DGMTP,DGVAL
 W:'$G(DGMSGF) !,"MEANS TEST NO LONGER REQUIRED"
 S DGMTACT="STA" D PRIOR^DGMTEVT
 S DGINI=0 F  S DGINI=$O(^DGMT(408.22,"AMT",DGMTI,DFN,DGINI)) Q:'DGINI  S DGINR=$O(^DGMT(408.22,"AMT",DGMTI,DFN,DGINI,"")) I $P($G(^DGMT(408.22,+DGINR,"MT")),"^")]"" S DGVAL=$P(^("MT"),"^") D
 .S DGFL=408.22,DGFLD=31,DGIEN=DGINR D KILL ;clean-up inc ptrs to mt
 .S $P(^DGMT(408.22,DGINR,"MT"),"^")=""
 S DGMT0=$G(^DGMT(408.31,DGMTI,0)),DGFL=408.31,DGIEN=DGMTI
 S DGFLD=.03 I DGCS]"" S DGVAL=DGCS D KILL
 S DGVAL=3,$P(^DGMT(408.31,DGMTI,0),"^",3)=DGVAL D SET
 F DGFLD=.04:.01:.16 S DGVAL=$P(DGMT0,"^",DGFLD/.01) I DGVAL]"" D
 .D KILL
 .S $P(^DGMT(408.31,DGMTI,0),"^",DGFLD/.01)=""
 S DGFLD=.17,DGVAL=DT,$P(^DGMT(408.31,DGMTI,0),"^",17)=DT D SET
 D QUE,EN^DGMTCOR
NOLQ Q
 ;
SET ;Set Cross-reference
 N D0,DA,DIV,DGIX,X
 S DA=DGIEN,X=DGVAL,DGIX=0
 F  S DGIX=$O(^DD(DGFL,DGFLD,1,DGIX)) Q:'DGIX  X ^(DGIX,1) S X=DGVAL
 Q
 ;
KILL ;Kill Cross-reference
 N D0,DA,DIV,DGIX,X
 S DA=DGIEN,X=DGVAL,DGIX=0
 F  S DGIX=$O(^DD(DGFL,DGFLD,1,DGIX)) Q:'DGIX  X ^(DGIX,2) S X=DGVAL
 Q
 ;
QUE ;Queue means test event driver
 D AFTER^DGMTEVT
 S ZTDESC="MEANS TEST EVENT DRIVER",ZTDTH=$H,ZTRTN="EN^DGMTEVT"
 F I="DFN","DGMTACT","DGMTI","DGMTP","DGMTA","DGMTYPT" S ZTSAVE(I)=""
 S ZTSAVE("DGMTINF")=1
 S ZTIO="" D ^%ZTLOAD
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
