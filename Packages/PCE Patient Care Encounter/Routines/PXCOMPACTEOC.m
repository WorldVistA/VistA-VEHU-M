PXCOMPACTEOC ;ALB/BPA,CMC - Supporting routine for editing COMPACT EPISODE OF CARE file ;02/05/2024@13:25
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**240**;Aug 12, 1996;Build 55
 ; Reference to SETPTFFLG^DGCOMPACT and SETPTFMVMT^DGCOMPACT in ICR #7463
 ;
 Q
 ;
EDIT ;
 N DIR,DIC,DFN,ENDSRC,PXEOCNUM,PXIEN,PXSEQ,STARTDATE,ENDDATE,Y
 W ! S DIC="^PXCOMP(818,",DIC(0)="AEQMZ" D ^DIC
 Q:Y=-1
 S PXEOCNUM=+Y,DFN=$P(Y,"^",2)
 S PXSEQ="B",PXSEQ=$O(^PXCOMP(818,PXEOCNUM,10,PXSEQ),-1)
 S PXIEN=PXSEQ_","_PXEOCNUM_","
 ; Get external formats for display
 S STARTDATE=$$GET1^DIQ(818.01,PXIEN,.01),ENDDATE=$$GET1^DIQ(818.01,PXIEN,2)
 W !!,"Episode Start Date: ",STARTDATE
 W !,"Episode End Date: ",ENDDATE
 N DIR
 S DIR("A")="Do you wish to edit the Episode Start Date"
 S DIR("B")="YES",DIR(0)="Y"
 W ! D ^DIR
 Q:Y="^"
 I Y D SDTEDIT(DFN,PXEOCNUM,PXSEQ)
 K DIR
 S DIR("A")="Do you wish to edit the Episode End Date"
 S DIR("B")="YES",DIR(0)="Y"
 W ! D ^DIR
 Q:Y="^"
 I Y D EDTEDIT(DFN,PXEOCNUM,PXSEQ,PXIEN)
 ;
 ; Display Source of Crisis End data here, since changing the end date could have changed this field
 ; Get external format for display
 S ENDSRC=$$GET1^DIQ(818.01,PXIEN,3)
 W !!,"Source of Crisis End: ",ENDSRC
 K DIR
 S DIR("A")="Do you wish to edit the Source of Crisis End"
 S DIR("B")="YES",DIR(0)="Y"
 W ! D ^DIR
 Q:Y="^"
 I Y D SRCEDIT(PXEOCNUM,PXSEQ)
 K DIC,DIR
 Q
SDTEDIT(DFN,PXEOCNUM,PXSEQ) ;
 N DIR,FMENDDATE,X,Y
S1 S FMENDDATE=$P(^PXCOMP(818,PXEOCNUM,10,PXSEQ,0),"^",2) I FMENDDATE="" S FMENDDATE=DT
 S DIR("A")="Enter new Episode Start Date"
 S DIR(0)="DO^3230117:"_FMENDDATE_":EX"
 S DIR("?")="Date must be no earlier than Jan 17, 2023 and no later than "_$$FMTE^XLFDT(FMENDDATE) W ! D ^DIR
 I (Y="")!(Y="^") Q
 I (Y>DT) W !,"Start date cannot be in the future." G S1
 ; if validation passes, update the Episode Start Date
 D SETSTDT^PXCOMPACT(DFN,Y)
 W !,"Episode Start Date updated!"
 Q
 ;
EDTEDIT(DFN,PXEOCNUM,PXSEQ,PXIEN) ;
 N DIR,FMSTDATE,X,Y
 S FMSTDATE=$P(^PXCOMP(818,PXEOCNUM,10,PXSEQ,0),"^",1)
 S DIR("A")="Enter new Episode End Date"
 S DIR(0)="DO^"_FMSTDATE_":"_DT_":EX"
 S DIR("?")="End date must be no earlier than "_$$FMTE^XLFDT(FMSTDATE)_" and no later than today's date"
 W ! D ^DIR
 I (Y="")!(Y="^") Q
 ; if validation passes, update the Episode End Date
 D SETENDDT^PXCOMPACT(DFN,Y,"PR")
 W !,"Episode End Date updated!"
 Q
SRCEDIT(PXEOCNUM,PXSEQ) ;
 N DIR,X,Y
 S DIR("A")="Enter new Source of Crisis End"
 S DIR(0)="SO^PR:PROVIDER;PA:PATIENT"
 S DIR("?")="Enter PR for Provider or PA for Patient"
 W ! D ^DIR
 I (Y="")!(Y="^") Q
 ; if validation passes, update the Source of Crisis End
 S $P(^PXCOMP(818,PXEOCNUM,10,PXSEQ,0),"^",3)=$$UP^XLFSTR(Y)
 W !,"Source of Crisis End updated!"
 Q
 ;
RETRACTMENU ;
 N DIC,DIR,DFN,Y
 W ! S DIC="^PXCOMP(818,",DIC(0)="AEQMZ" D ^DIC
 Q:Y=-1
 S DFN=$P(Y,"^",2)
 ;
 K DIR
 S DIR("A")="Do you wish to retract the current inpatient episode of care"
 S DIR("B")="YES",DIR(0)="Y"
 W ! D ^DIR
 I (Y=0)!(Y="^") G RETRACTMENU
 K DIR,Y
 S DIR("A")="Retracting will remove the COMPACT Act benefit for this inpatient stay. Are you sure"
 S DIR("B")="YES",DIR(0)="Y"
 W ! D ^DIR
 I (Y="^")!(Y=0) G RETRACTMENU
 I Y D RETRACT(DFN,"",1)
 W !,"COMPACT Act Episode of Care retracted"
 Q
 ;
RETRACT(DFN,PXENC,MENU) ;
 ; Call in DG input templates: D RETRACT^PXCOMPACTEOC(DFN,PTF)
 ;
 ; Only allow retraction for the most current episode of care open or closed
 ; DFN - Internal Patient ID (required)
 ; PXENC - PTF internal ID (NOT required) {Used for inpatient processing}
 ; MENU - Used to differentiate between a RETRACTMENU call and a call from elsewhere
 ;
 N DA,PXEOCNUM,PXEOCSEQ,PXPTF,PXPTFSEQ,PXVST,PXVSTSEQ
 S (PXEOCNUM,PXEOCSEQ,PXPTF,PXPTFSEQ,PXVST,PXVSTSEQ)=""
 I $G(PXENC)="" S PXENC=""
 I $G(MENU)="" S MENU=""
 I DFN="" W !,"Internal Patient ID can not be null." Q
 I '$D(^PXCOMP(818,"B",DFN)) W !,"Patient "_DFN_" not in the COMPACT Act episode of care file." Q
 S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN)
 I PXEOCNUM'="" D
 . S PXEOCSEQ=$$GETEOCSEQ^PXCOMPACT(DFN) I PXEOCSEQ="" W !,"Patient does not have an episode in the COMPACT Episode of Care file." Q
 . I MENU'=1,$P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",4)="" Q
 . I MENU=1,$P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",4)="" W !,"This is not an inpatient episode of care, cannot be retracted from this menu." G RETRACTMENU
 . ; For inpatient processing, check for PTF before retraction.  If the PTF passed in is not part of the Episode
 . ; of Care, do not retract the Episode. 
 . I PXENC'="",'$D(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,40,"B",PXENC)) Q
 . ; Set the EPISODE FINAL STATUS to Entered in Error (E) and EPISODE SOURCE to NULL
 . S $P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",6)="E",$P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",7)=""
 . I $$ASC^PXCOMPACT(DFN)="Y" D SETENDDT^PXCOMPACT(DFN,DT,"")
 . ; Loop through 40 and 41 levels
 . S PXPTFSEQ=0,PXPTF=""
 . F  S PXPTFSEQ=$O(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,40,PXPTFSEQ)) Q:(PXPTFSEQ="B")!(PXPTFSEQ="")  D
 . . S PXPTF=$P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,40,PXPTFSEQ,0),"^",1) D 
 . . . I $D(^DGPT(PXPTF)) D SETPTFFLG^DGCOMPACT(PXPTF,"")
 . . . N PTFMVTSEQ S PTFMVTSEQ=0
 . . . I $D(^DGPT(PXPTF,"M")) D
 . . . . F  S PTFMVTSEQ=$O(^DGPT(PXPTF,"M",PTFMVTSEQ)) Q:(PTFMVTSEQ["A")!(PTFMVTSEQ="")  D SETPTFMVMT^DGCOMPACT(PXPTF,"",PTFMVTSEQ)
 . S PXVSTSEQ=0,PXVST=""
 . F  S PXVSTSEQ=$O(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,41,PXVSTSEQ)) Q:(PXVSTSEQ="B")!(PXVSTSEQ="")  D
 . . S PXVST=$P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,41,PXVSTSEQ,0),"^",1) D SETVSTFLG^PXCOMPACT(DFN,PXVST,"")
 Q
