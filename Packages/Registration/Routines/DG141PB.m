DG141PB ;ALB/SEK 0% SC CLEANUP POST-INS DG*5.3*141 CONT ;09/24/97
 ;;5.3;Registration;**141**;Aug 13, 1993
 ;
 ;This routine is the continuation of the post-installation
 ;routine, DG53141P, for patch DG*5.3*141.
 ;This is a cleanup for all 0% SC veterans who had an outpatient
 ;encounter since the installation of Tricare, who is an inpatient
 ;(when or since the installation of Tricare), who has a future
 ;appointment, and who has a Means Test entry since installation of
 ;Tricare.  If the veteran meets any of the above criteria, routine
 ;DGMTR141 is called to determine if the veteran requires a Means Test.
 ;The following can occur:
 ;       No change is made if the requirement is the same as the
 ;          veteran has now.
 ;       Status of the veteran will be changed to NO LONGER REQUIRED
 ;          from REQUIRED.
 ;       Status of the veteran will be changed to REQUIRED by
 ;          adding a new test with a status of REQUIRED or by
 ;          changing a NO LONGER REQUIRED status to REQUIRED. 
 ;
 ;       Status of Copay Tests will be changed to INCOMPLETE or
 ;          NO LONGER APPLICABLE.
 ;
EN ;begin processing
 ;
 N DGPCPA,DGPCPB,DGPCPI,DGPMTA,DGPMTB
 ;get Means Test status before
 S DGPMTB=$P($G(^DPT(DFN,0)),"^",14)
 ;
 ;get copay status before
 S DGPCPB=""
 S DGPCPI=+$$LST^DGMTU(DFN,"",2) I DGPCPI  S DGPCPB=$P($G(^DGMT(408.31,DGPCPI,0)),"^",3)
 ;
 S (DGMSGF,DGMTMSG)=1
 D EN^DGMTR141
 ;
 ;get Means Test status after
 S DGPMTA=$P($G(^DPT(DFN,0)),"^",14)
 ;
 ;get copay status after
 S DGPCPA=""
 S DGPCPI=+$$LST^DGMTU(DFN,"",2) I DGPCPI  S DGPCPA=$P($G(^DGMT(408.31,DGPCPI,0)),"^",3)
 ;
 ;if before and after different build storage array with data
 Q:DGPMTB=DGPMTA
 Q:DGPMTA'=1&(DGPMTA'=3)
 S:DGPCPB=DGPCPA DGPCPA=""
 D BUILDLN
 Q
 ;
BUILDLN ; Build storage array with data
 ;
 ;  Output:  
 ;    ^XTMP("DG53141G",type of change,sort,pt name_"_"_DFN)=previous 
 ;                                                 status^long id^
 ;                                                 copay status
 ;       type of change 1 - Means Test REQUIRED
 ;                      3 - Means Test NO LONGER REQUIRED
 ;
 ;       sort is the criteria found that indicates that the
 ;            veteran's Means Test requirement be checked
 ;            1 - had an outpatient encounter since Tricare has
 ;                    installed
 ;            2 - an inpatient when/since Tricare has been installed
 ;            3 - has a future appointment
 ;            4 - has a Means Test entry since installation of Tricare
 ;     
 ;       previous status - CURRENT MEANS TEST STATUS (#.14)
 ;              1 - REQUIRED   3 - NO LONGER REQUIRED
 ;         
 ;       long id - PRIMARY LONG ID (#.363) - (SSN)
 ;
 ;       copay status - new copay status
 ;              9 - INCOMPLETE   10 - NO LONGER APPLICABLE
 ;
 ;      counters stored at:
 ;   ^XTMP("DG53141G",1,sort,0  - change to Means Test REQUIRED
 ;   ^XTMP("DG53141G",3,sort,0  - change to Means Test NO LONGER REQUIRED
 ;
 N DGNAME,DGSSN
 ;
 ;pt name and ssn from Patient (#2) file
 S DGNAME=$P($G(^DPT(DFN,0)),"^"),DGSSN=$P($G(^(.36)),"^",3)
 S:DGNAME="" DGNAME=DFN
 S:DGSSN="" DGSSN="MISSING"
 ;
 S ^XTMP("DG53141G",DGPMTA,SORT,DGNAME_"_"_DFN)=DGPMTB_"^"_DGSSN_"^"_DGPCPA
 S ^(0)=$G(^(0))+1
 Q
