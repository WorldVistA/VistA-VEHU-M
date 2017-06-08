VEJDWPB8 ;WPB/CAM routine modified for dental GUI;8/1/98;7/10/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;; SLC/MKB -- Problem List callable utilities ;6/25/97
 ;GMPLUTL;2.0;Problem List;**3,6,8,10**;Aug 25, 1994
ACTIVE(GMPDFN,GMPL) ; Returns list of active problems for patient GMPDFN
 ; -- Values will be returned in an array that must be passed in
 ; -- by reference; see page 19 of the PL Tech Manual for output
 ; -- array definition.
 ;
 N I,IFN,CNT,GMPL0,GMPL1,SP,NUM,ONSET,GMPLIST,GMPLVIEW,GMPARAM,GMPTOTAL
 Q:$G(GMPDFN)'>0  S CNT=0,SP=""
 S GMPARAM("QUIET")=1,GMPARAM("REV")=$P($G(^GMPL(125.99,1,0)),U,5)="R"
 S GMPLVIEW("ACT")="A",GMPLVIEW("PROV")=0,GMPLVIEW("VIEW")=""
 D GETPLIST^VEJDWPB7(.GMPLIST,.GMPTOTAL,.GMPLVIEW)
 F NUM=0:0 S NUM=$O(GMPLIST(NUM)) Q:NUM'>0  D
 . S IFN=+GMPLIST(NUM) Q:IFN'>0
 . S GMPL0=$G(^AUPNPROB(IFN,0)),GMPL1=$G(^(1)),CNT=CNT+1,GMPL(CNT,0)=IFN
 . S GMPL(CNT,1)=+GMPL1_U_$$PROBTEXT^GMPLX(IFN)
 . S GMPL(CNT,2)=+GMPL0_U_$P($G(^ICD9(+GMPL0,0)),U),ONSET=$P(GMPL0,U,13)
 . S GMPL(CNT,3)=$S(ONSET:ONSET_U_$$EXTDT^GMPLX(ONSET),1:"")
 . S GMPL(CNT,4)=$S(+$P(GMPL1,U,10):"SC^SERVICE-CONNECTED",$P(GMPL1,U,10)=0:"NSC^NOT SERVICE-CONNECTED",1:"")
 . F I=11,12,13 S:$P(GMPL1,U,I) SP=$S(I=11:"A",I=12:"I",1:"P")
 . S GMPL(CNT,5)=$S(SP="A":"AO^AGENT ORANGE",SP="I":"IR^RADIATION",SP="P":"EC^ENV CONTAMINANTS",1:"")
 S GMPL(0)=CNT
 Q
 ;
CREATE(PL,PLY) ; Creates a new problem
 ; -- Values must be set into an array and passed by reference
 ; -- Results array must also be passed by reference
 ; -- see page 20 of the PL Technical Manual for array definitions
 ;
 N GMPI,GMPQUIT,GMPVAMC,GMPVA,GMPFLD,GMPSC,GMPAGTOR,GMPION,GMPGULF,DA,GMPDFN,GMPROV
 K PLY S PLY=-1,PLY(0)="" ; error flags
 S GMPVAMC=+$G(DUZ(2)),GMPVA=$S($G(DUZ("AG"))="V":1,1:0)
 I '$L($G(PL("NARRATIVE"))) S PLY(0)="Missing problem narrative" Q
 I '$D(^DPT(+$G(PL("PATIENT")),0)) S PLY(0)="Invalid patient" Q
 I '$D(^VA(200,+$G(PL("PROVIDER")),0)) S PLY(0)="Invalid provider" Q
 S GMPDFN=+PL("PATIENT"),(GMPSC,GMPAGTOR,GMPION,GMPGULF)=0
 D:GMPVA VADPT^GMPLX1(GMPDFN)
 F GMPI="DIAGNOSI","LEXICON","DUPLICAT","LOCATION","STATUS","ONSET","RESOLVED","RECORDED","SC","AO","IR","EC" D @(GMPI_"^GMPLUTL1") Q:$D(GMPQUIT)  ; validate
 Q:$D(GMPQUIT)
CR1 ; Ok to save!
 S GMPFLD(.01)=PL("DIAGNOSIS"),GMPFLD(1.01)=PL("LEXICON")
 S GMPFLD(.05)=U_$E(PL("NARRATIVE"),1,80)
 S (GMPROV,GMPFLD(1.04),GMPFLD(1.05))=+PL("PROVIDER")
 S GMPFLD(1.06)=$$SERVICE^GMPLX1(+PL("PROVIDER"))
 S GMPFLD(.13)=PL("ONSET"),GMPFLD(1.09)=PL("RECORDED")
 S GMPFLD(1.02)=$S($P(^GMPL(125.99,1,0),U,2):"T",1:"P")
 S GMPFLD(.12)=PL("STATUS"),GMPFLD(1.14)="",GMPFLD(1.07)=PL("RESOLVED")
 S GMPFLD(10,0)=0,GMPFLD(1.03)=$G(DUZ),GMPFLD(1.08)=PL("LOCATION")
 S:$L($G(PL("COMMENT"))) GMPFLD(10,"NEW",1)=$E(PL("COMMENT"),1,60)
 S GMPFLD(1.1)=PL("SC"),GMPFLD(1.11)=PL("AO"),GMPFLD(1.12)=PL("IR"),GMPFLD(1.13)=PL("EC")
 D NEW^GMPLSAVE S PLY=DA ; IFN or -1 if error
CRQ Q
 ;
UPDATE(PL,PLY) ; Update a problem, or create a new entry if not found
 ; -- Values must be set into an array and passed by reference
 ; -- Null values assume no change, @ to delete current value
 ; -- Results array must also be passed by reference
 ; -- see page 21 of the PL Technical Manual for array definitions
 ;
 N GMPORIG,GMPFLD,FLD,ITEMS,SUB,GMPI,DIFFRENT,GMPIFN,GMPVAMC,GMPVA,GMPROV,GMPQUIT,GMPDFN
 S GMPVAMC=+$G(DUZ(2)),GMPVA=$S($G(DUZ("AG"))="V":1,1:0),PLY=-1,PLY(0)=""
 S GMPIFN=$G(PL("PROBLEM")) I GMPIFN="" D CREATE(.PL,.PLY) Q  ; new
 I '$D(^AUPNPROB(GMPIFN,0)) S PLY(0)="Invalid problem" Q
 I '$D(^VA(200,+$G(PL("PROVIDER")),0)) S PLY(0)="Invalid provider" Q
 S GMPROV=+$G(PL("PROVIDER")),GMPDFN=+$P(^AUPNPROB(GMPIFN,0),U,2)
 D GETFLDS^GMPLEDT3(GMPIFN) I '$D(GMPFLD) S PLY(0)="Invalid problem" Q
 I +$G(PL("PATIENT")),+PL("PATIENT")'=GMPDFN S PLY(0)="Patient does not match for this problem" Q
 I $L($G(PL("RECORDED"))) S PLY(0)="Date Recorded is not editable" Q
 S (GMPSC,GMPAGTOR,GMPION,GMPGULF)=0 D:GMPVA VADPT^GMPLX1(GMPDFN)
 S ITEMS="LEXICON^DIAGNOSIS^LOCATION^PROVIDER^STATUS^ONSET^RESOLVED^SC^AO^IR^EC^",FLD="1.01^.01^1.08^1.05^.12^.13^1.07^1.1^1.11^1.12^1.13"
 F GMPI=1:1 S SUB=$P(ITEMS,U,GMPI) Q:SUB=""  D  Q:$D(GMPQUIT)
 . I '$L($G(PL(SUB))) S PL(SUB)=$P(GMPFLD($P(FLD,U,GMPI)),U) Q
 . I SUB="STATUS",PL(SUB)="@" S GMPQUIT=1,PLY(0)="Cannot delete problem status" Q
 . I PL(SUB)'="@" D @($E(SUB,1,8)_"^GMPLUTL1") Q:$D(GMPQUIT)
 . S GMPFLD($P(FLD,U,GMPI))=$S(PL(SUB)="@":"",1:PL(SUB)),DIFFRENT=1 ; new
 Q:$D(GMPQUIT)  ; error in loop
 I +GMPFLD(1.07),GMPFLD(1.07)<GMPFLD(.13) S PLY(0)="Date Resolved cannot be prior to Date of Onset" Q
 I +GMPFLD(1.09),GMPFLD(1.09)<GMPFLD(.13) S PLY(0)="Date Recorded cannot be prior to Date of Onset" Q
 S:$L($G(PL("NARRATIVE"))) GMPFLD(.05)=U_PL("NARRATIVE"),DIFFRENT=1
 S:$L($G(PL("COMMENT"))) GMPFLD(10,"NEW",1)=$E(PL("COMMENT"),1,60),DIFFRENT=1
 D:$D(DIFFRENT) EN^GMPLSAVE S PLY=GMPIFN,PLY(0)=""
 Q
