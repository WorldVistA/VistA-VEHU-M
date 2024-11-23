DGPMV36 ;ALB/MIR - TREATING SPECIALTY TRANSFER, CONTINUED ; 8/6/04 10:17am
 ;;5.3;Registration;**1104**;Aug 13, 1993;Build 59
 ; Reference to NEWEOC^PXCOMPACT, $$ASC^PXCOMPACT, $$GETEOCSEQ^PXCOMPACT, and $$GETSTDT^PXCOMPACT in ICR #7327
 ;
 I '$P(DGPMA,"^",9) S DGPMA="",DIK="^DGPM(",DA=DGPMDA D ^DIK K DIK W !,"Incomplete Treating Specialty Transfer...Deleted"
 Q
 ;
DICS ; -- check that it is a PROVIDER/SPECIALTY change
 S DGER=DGPMTYP'=20
 Q
 ;
ONLY ; -- determine if there is only one 'specialty xfr' type mvt
 N C,I S C=0
 F I=0:0 S I=$O(^DG(405.1,"AT",6,I)) Q:'I  I $D(^DG(405.1,I,0)),$P(^(0),"^",4) S C=C+1,DGPMSPI=I I C>1 K DGPMSPI Q
 Q
 ;
SPEC ; -- entry point to add/edit specialty mvt when adding/editing
 ;    a physical mvt
 ;
 ;       Input:     Y = ifn of mvt file ^ auto add specialty entry(1)
 ;      Output:     Y = ifn of spec mvt
 ;      
 ;    Variable: DGPMPHY = physical mvt IFN ; DGPMPHY0 = 0th node
 ;              DGPMSP  = specialty mvt IFN
 ;
 Q:'$D(^DGPM(+Y,0))
 N DGPMT,DGPMN S DGPMPHY=+Y,DGPMPHY0=^DGPM(+Y,0),DGPMT=6,DGPMN=0
 S DGPMSP=$S($D(^DGPM("APHY",DGPMPHY)):$O(^(DGPMPHY,0)),1:"")
 I 'DGPMSP S Y=+$P(Y,"^",2) D ASK:'Y G SPECQ:'Y D NEW
 D EDIT:DGPMSP
 ;Only call if doing a transfer
 I DGPMUC'="ADMISSION",$G(PTF)'="",$$ELIG^DGCOMPACTELIG(DFN,"DGPMV36")'="NOT ELIGIBLE" D COMPACT
SPECQ S Y=DGPMSP K DGPMPHY,DGPMPHY0,DGPMSP Q
 ;
ASK ; -- ask user if they want to make a special mvt also
 W ! S DIR(0)="YA",DIR("A")="Do you wish to associate a 'facility treating specialty' transfer? "
 S DIR("?",1)="If you would like to associate a facility specialty"
 S DIR("?",2)="transfer with this physical movement then answer 'Yes'."
 S DIR("?")="Otherwise, answer with a 'No'."
 D ^DIR K DIR
 Q
 ;
COMPACT ; -- ask user if the treatment for the movement was for Acute Suicidal Crisis
 N %,DGVAL,MVMTVAL,PXEOCNUM,PXEOCSEQ,STARTDT
 W !,"Was Treatment for Acute Suicidal Crisis" S %=2 D YN^DICN I %=-1 W !,"Answer must be 'Yes' or 'No'" G COMPACT
 I %=1 W !,"THIS ADMISSION WILL BEGIN THE COMPACT ACT BENEFIT. ARE YOU SURE" S %=2 D YN^DICN I %'=1 G COMPACT
 S DGVAL=$S(%=1:1,1:0),MVMTVAL=$S(%=1:"Y",1:"N")
 I %=1 D
 . S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN)
 . S PXEOCSEQ=$$GETEOCSEQ^PXCOMPACT(DFN)
 . S STARTDT=$$GETSTDT^PXCOMPACT(DFN)
 . ;handle scenario where current episode is Outpatient
 . I $$ASC^PXCOMPACT(DFN)="Y",$P(^PXCOMP(818,PXEOCNUM,0),"^",3)="O" D
 . . ;same day processing, flip episode to Inpatient
 . . I $P(DGPMY,".")=STARTDT D
 . . . S $P(^PXCOMP(818,PXEOCNUM,0),"^",3)="I"
 . . . S $P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",4)=$$FMADD^XLFDT($P(DGPMY,"."),29)
 . . . S $P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",5)=""
 . . . S $P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",7)="A"
 . . . D VISIT^PXCOMPACT(PTF,"I",PXEOCNUM,DFN)
 . . ;non-same day processing, end OP episode and create new IP episode using the date provided
 . . I $P(DGPMY,".")'=STARTDT D
 . . . D SETENDDT^PXCOMPACT(DFN,$P(DGPMY,"."),"PR")
 . . . D NEWEOC^PXCOMPACT(DFN,PTF,"I",$P(DGPMY,"."))
 . ;Reopen episode of care if the PTF is already associated with an episode and not currently in a crisis
 . I PXEOCNUM'="",PXEOCSEQ'="",$D(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,40,"B",PTF)),$$ASC^PXCOMPACT(DFN)="N" D
 . . D REOPNEOC^PXCOMPACT(PXEOCNUM,PXEOCSEQ,STARTDT)
 . ;otherwise start a new episode
 . I $$ASC^PXCOMPACT(DFN)="N" D NEWEOC^PXCOMPACT(DFN,PTF,"I",$P(DGPMY,"."))
 . D SETPTFFLG^DGCOMPACT(PTF,DGVAL)
 . S ^UTILITY($J,"PXCOMPACT-TRANS")=""
 Q
 ;
NEW ; -- add a specialty mvt
 S X=DGPMPHY0,Y=+X_U_DGPMT_U_$P(X,U,3),$P(Y,U,14)=$P(X,U,14),$P(Y,U,24)=DGPMPHY
 S X=+X,DGPM0ND=Y D NEW^DGPMV3
 S DGPMSP=$S(+Y>0:+Y,1:"") S DGPMN=(+Y>0)
 I DGPMSP,$P(DGPMPHY0,"^",2)=1,$P(DGPMPHY0,"^",10)]"" S DR="99///"_$P(DGPMPHY0,"^",10),DA=DGPMSP,DIE="^DGPM(" D ^DIE
 K DIE,DIC,DA,DR,DGPM0ND
 Q
EDIT ; -- edit specialty mvt
 N DGPMX,DGPMP
 I DGPMN S (DGPMP,^UTILITY("DGPM",$J,6,DGPMSP,"P"))="",DIE("NO^")=""
 I 'DGPMN S (DGPMP,^UTILITY("DGPM",$J,6,DGPMSP,"P"))=^DGPM(DGPMSP,0)
 S Y=DGPMSP D PRIOR
 S DGPMN=(+DGPMP=+DGPMPHY0) ;set to 1 no dt/time change to bypass x-refs
 S DGPMX=+DGPMPHY0,DA=DGPMSP,DIE="^DGPM(",DR="[DGPM SPECIALTY TRANSFER]"
 K DQ,DG D ^DIE
 S ^UTILITY("DGPM",$J,6,DGPMSP,"A")=$S($D(^DGPM(DGPMSP,0)):^(0),1:"")
 S Y=DGPMSP D AFTER
 Q
 ;
PRIOR ; -- set special 'prior' nodes for event driver
 I DGPMN S (^UTILITY("DGPM",$J,6,Y,"DXP"),^("PTFP"))=""
 I 'DGPMN S X=$P($S($D(^DGPM(Y,"DX",0)):^(0),1:""),"^",3,4),X=X_$S($D(^(1,0)):$E(^(0),1,245-$L(X)),1:""),^UTILITY("DGPM",$J,6,Y,"DXP")=X,^UTILITY("DGPM",$J,6,Y,"PTFP")=$S($D(^DGPM(Y,"PTF")):^("PTF"),1:"")
 Q
 ;
AFTER ; -- set special 'after' nodes for event driver
 S X=$P($S($D(^DGPM(Y,"DX",0)):^(0),1:""),"^",3,4),X=X_$S($D(^(1,0)):$E(^(0),1,245-$L(X)),1:""),^UTILITY("DGPM",$J,6,Y,"DXA")=X,^UTILITY("DGPM",$J,6,Y,"PTFA")=$S($D(^DGPM(Y,"PTF")):^("PTF"),1:"")
 Q
