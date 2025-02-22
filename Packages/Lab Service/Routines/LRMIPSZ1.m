LRMIPSZ1 ;DALOI/STAFF - MICRO PATIENT REPORT ;Aug 14, 2019@10:00
 ;;5.2;LAB SERVICE;**283,350,520,536**;Sep 27, 1994;Build 18
 ;
 ;
DQ ;tasked from LRTASK from IMMEDIATE INTERIM REPORTING thru LRTP
 ;
 S LRPATLOC=$G(LRLLOC),LRIDT=$G(LRIDT,0),LRSS="MI",LRONETST="",LRONESPC="",LREND=0
 D EN^LRPARAM
 S LRLLT=^LR(LRDFN,"MI",LRIDT,0),LRACC=$P(LRLLT,U,6),LRAD=$E(LRLLT)_$P(LRACC," ",2)_"0000"
 S X=$P(LRACC," "),DIC=68,DIC(0)="M"
 I X'="" D ^DIC S LRAA=+Y,LRAN=+$P(LRACC," ",3)
 ;
 ; ^TMP("LRMI",$J,LRDFN,"MI",LRIDT) will already exist if this is a LEDI result being processed (rtn LRVRMI1)
 I '$D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT)) D
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)=^LR(LRDFN,"MI",LRIDT)
 . K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,32)
 ;
 S LRCMNT=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,99))
 S LRPG=0
 D EN
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
 ;
EN ;
 ; from LRMINEW2, LRMIPC, LRMIPLOG, LRMIPSZ, LRMIVER1
 ; ^TMP("LRMI",$J,LRDFN,"MI",LRIDT) will already exist if this is a LEDI result being processed (rtn LRVRMI1)
 I '$D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT)) D  ;
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)=^LR(LRDFN,"MI",LRIDT)
 . K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,32)
 ;
 S LRUID=$P($G(^LR(LRDFN,"MI",LRIDT,"ORU")),U)
 I '$D(LRONESPC) S LRONESPC="",DIC="^LAB(61,",DIC("A")="Select SPECIMEN/SOURCE: ANY//",DIC(0)="AEMOQ" D ^DIC S:Y>0 LRONESPC=+Y K DIC("A")
 I '$D(LRONETST) S LRONETST="",DIC="^LAB(60,",DIC(0)="AEOQ",DIC("S")="I $P(^(0),U,4)=""MI"")"_$S('$D(LRLABKY):",""BO""[$P(^(0),U,3)",1:""),D="E" D IX^DIC Q:Y<1  I Y>0 S LRONETST=+Y
 S LRSPEC=$P(LRLLT,U,5) I LRONESPC'="",LRSPEC'=LRONESPC Q
 D RPT
 I '$G(EAMODE) K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)
 K %,A8,A,AB,B,B1,B2,B3,C,IA,LR1PASS,LR2ORMOR,LRABCNT,LRACNT,LRADM,LRADX,LRAFS,LRAMT,LRAX,LRBN,LRBRR,LRBUG,LRCOMTAB,LRCS,LRDCOM,LRDOC,LRDRTM1,LRDRTM2,LREF,LRFLIP,LRFMT,LRGRM,LRHC,LRIFN,LRINT,LRPATLOC,LRMYC,LRNS,LRNUM
 K LRORG,LRPAR,LRPC,LRPRE,LRPRINT,LRQU,LRRC,LRRES,LRSBC1,LRSBC2,LRSET,LRSIC1,LRSIC2,LRSPEC,LRSSD,LRST,LRTA,LRTB,LRTBA,LRTBC,LRTBS,LRTK,LRTS,LRTSTS,LRTUS,LRUS,LRWRD,N
 Q
 ;
 ;
RPT ;
 ;
 N LRABORT,LRPGDATA,LRPRNTED,LRDISP
 ;
 ; If called by another process, i.e. interim reports, then don't reset current page number
 S LRPG=$G(LRPG,0)
 ;
 S LRPGDATA("HDR")="D HDR2^LRMIPSU(.LRPRNTED,.LRABORT,.LRPGDATA)"
 S LRPGDATA("BM")=8
 S LRPGDATA("FTR")="D FOOT2^LRMIPSU"
 ; Dont print the footer when console device
 I $E($G(IOST),1,2)="C-" D  ;
 . S LRPGDATA("BM")=0
 . S LRPGDATA("FTR")=""
 S LRPGDATA("PROMPTX")="S X=$$PROMPT^LRMIPSU()"
 S LRPGDATA("ERASE")=1
 S LRPGDATA("PGNUM")=0
 S LRABORT=0
 ;
 S:'$D(LRSB) LRSB=0
 S LRPRINT=$S($D(^LRO(68,LRAA,1,LRAD,1,LRAN,4)):"",1:1),LRHC=$S($E(IOST,1,2)'="C-":1,1:0),LRFLIP=$S(LRHC:11,1:6)
 ;
 K DIC
 D DT^LRX
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 D PT^LRX
 S:$G(VAIN(3)) DOB=$P(VADM(3),U) S LRPATLOC=$P(LRLLT,U,8)
 S (LRADM,LRADX)=""
 I +$G(LRDPF)=2,'$G(VAERR) S LRADM=$P(VAIN(7),U,2),LRADX=VAIN(9)
 S LRCS=$S($D(^LAB(62,+$P(LRLLT,U,11),0)):$P(^(0),U),1:"")
 S LRTK=$P(LRLLT,U),LRRC=$P(LRLLT,U,10),LRST=$S(LRSPEC:$P(^LAB(61,LRSPEC,0),U),1:"")
 S Y=LRTK D D^LRU S LRTK=Y
 S Y=LRRC D D^LRU S LRRC=Y
 S X=$P(LRLLT,U,7) D DOC^LRX
 ;
 K ^TMP("LR",$J,"T"),LRTSTS
 ;
 S (LRBRR,LRTESTCOMPLE)=0
 F  S LRBRR=+$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRBRR)) Q:LRBRR<1  D EN1
 I 'LRPRINT,LRONETST Q
 ;
 ;
 D HDR2^LRMIPSU(.LRPRNTED,.LRABORT,.LRPGDATA)
 S LREND=LRABORT
 Q:LRABORT
 ; display audit log
 D BANNER^LRMIAU2(.LRABORT,.LRPGDATA)
 S LREND=LRABORT
 Q:LRABORT
 ;
 I $D(^TMP("LR",$J,"T")) D  Q:LRABORT
 . N J,LRX,LRY,X,Y
 . W !?2,"Test(s) ordered:"
 . S J=0
 . F  S J=$O(^TMP("LR",$J,"T",J)) Q:J=""  D  Q:LRABORT
 . . S X=^TMP("LR",$J,"T",J)
 . . S LRX=$P(X,"^")
 . . I LRTESTCOMPLE S LRX=$$LJ^XLFSTR(LRX,30,".")
 . . W ?19,LRX
 . . I '$P(X,U,2) W ! D NP Q
 . . S Y=$P(X,U,2)
 . . ; LR*5.2*520 and LR*5.2*536
 . . S LRDISP=$P(X,U,3)
 . . D D^LRU S LRY=$S(LRDISP["Not Performed":"canceled: ",1:"completed: ")_Y
 . . I (19+$L(LRX)+$L(LRY))>IOM W !
 . . W ?50,LRY,! D NP
 ;
 K ^TMP("LR",$J,"T"),LRTSTS W:LRHC !
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,14)) D  Q:LRABORT  ;
 . D NP Q:LRABORT
 . D ANTI^LRMIPSZ2
 . D NP Q:LRABORT
 ;
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,1)) D  Q:LRABORT  ;
 . D NP Q:LRABORT
 . D BACT^LRMIPSZ2 Q:LREND
 . D NP Q:LRABORT
 . D REFS^LRMIPSU Q:LREND
 . D NP Q:LRABORT
 ;
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,31)) D  Q:LRABORT  ;
 . D NP Q:LRABORT
 . D STER^LRMIPSZ3
 . D NP Q:LRABORT
 ;
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,5)) D  Q:LRABORT  Q:LREND  ;
 . D NP Q:LRABORT
 . D PARA^LRMIPSZ3
 . D NP Q:LRABORT
 . D REFS^LRMIPSU
 . Q:LREND
 . D NP Q:LRABORT
 ;
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,16)) D  Q:LREND  Q:LRABORT  ;
 . D NP Q:LRABORT
 . D VIR^LRMIPSZ3
 . D REFS^LRMIPSU Q:LREND  Q:LRABORT  ;
 ;
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,11)) D  Q:LREND  Q:LRABORT  ;
 . D NP Q:LRABORT
 . D TB^LRMIPSZ4
 . D NP Q:LRABORT
 . D REFS^LRMIPSU
 . D NP Q:LRABORT
 ;
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,8)) D  Q:LREND  Q:LRABORT  ;
 . D NP Q:LRABORT
 . D FUNG^LRMIPSZ4
 . D NP Q:LRABORT
 . D REFS^LRMIPSU
 . Q:LREND  Q:LRABORT
 ;
 Q:LRABORT
 ;
 ; Print any performing labs listing
 I $G(LRMODE)'="LDSI" D PPL
 ;
 ; Write last footer if needed
 I 'LRABORT,'$G(LRPGDATA("WFTR")) D  ;
 . I $G(LRPGDATA("FTR"))="" Q
 . I $E($G(IOST),1,2)'="C-" D  ;
 . . N I,BM
 . . S BM=$G(LRPGDATA("BM"))
 . . F I=$Y+1:1:($G(IOSL,60)-BM-1) W !
 . X LRPGDATA("FTR")
 ;
 I 'LRABORT D  ;
 . N PAD,STR,I,II
 . S X="  End of Report  ",PAD="+ ",STR=""
 . S I=IOM-($L(X)*3),I=I/4/$L(PAD)
 . F II=1:1:3 S STR=STR_$$REPEAT^XLFSTR(PAD,I)_X
 . S STR=STR_$$REPEAT^XLFSTR(PAD,I)
 . W !,$$CJ^XLFSTR(STR,IOM)
 . F I=$Y+1:1:($G(IOSL,60)-$G(LRPGDATA("BM"))-1) W !
 . S (LRABORT,LREND)=$$MORE^LRUTIL($$PROMPT^LRMIPSU(),0)
 . ; LRMLTRPT indicates multi report (set in SENDUP^LRMIPLOG)
 . I $G(LRMLTRPT),$E($G(IOST),1,2)="P-",$G(IOF)'="" W @IOF
 ;
 Q
 ;
 ;
EN1 ;
 ; LR*5.2*520 Set disposition to LRDISP
 S LRTS=+^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRBRR,0),LRTS(1)=$P(^(0),U,5),LRDISP=$P(^(0),U,6)
 Q:'$L($P($G(^LAB(60,LRTS,0)),U,3))
 I '$D(LRLABKY),"BO"'[$P($G(^LAB(60,LRTS,0)),U,3) Q
 ;
 ; Set flag that at least one test is completed
 I LRTS(1) S LRTESTCOMPLE=1
 ;
 S:LRTS=LRONETST LRPRINT=1
 S LRTSTS=$S($D(^LAB(60,LRTS,0)):$P(^(0),U),1:"deleted test"),^TMP("LR",$J,"T",$S($D(^LAB(60,LRTS,.1)):$P(^(.1),U,6),1:"")_","_LRBRR)=LRTSTS_U_LRTS(1)_U_LRDISP
 Q
 ;
 ;
NP ;
 ; Convenience method
 ; Some methods in these report routines may be called by a different parent so need to handle this if needed.
 I '$D(LRABORT) S LRABORT=0
 Q:'$D(LRPGDATA)
 D NP^LRUTIL(.LRABORT,.LRPGDATA)
 S LRPG=$G(LRPGDATA("PGNUM"),1)
 ;
 ; backward compatability (for SENDUP^LRMIPLOG)
 S LREND=LRABORT
 Q
 ;
 ;
PPL ; Print any performing laboratories
 ;
 N LRPL,LRI,LRX,LRY
 ;
 D RETLST^LRRPL(.LRPL,LRDFN,"MI",LRIDT,0)
 I $G(LRPL)<1 Q
 ;
 ; Start new page if space on existing page too small to display a significant portion of labs
 S LRY=IOSL-$Y S:LRY<1 LRY=1
 I (LRPL/LRY)>1 D
 . F LRI=$Y+1:1:($G(IOSL,60)-$G(LRPGDATA("BM"))-1) W !
 . D NP
 E  S LRX="=--" W !!,$$REPEAT^XLFSTR(LRX,IOM/$L(LRX))
 ;
 W !,"Performing Laboratory:",!
 S LRI=0
 F  S LRI=$O(LRPL(LRI)) Q:'LRI  D  Q:LRABORT
 . W !,LRPL(LRI)
 . D NP
 . I 'LRABORT,LRPGDATA("NP") W !,"Performing Laboratory (cont'd):",!
 ;
 I 'LRABORT W !
 ;
 Q
