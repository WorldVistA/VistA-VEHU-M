LRWRKINC ;SLC/DCM/CJS - INCOMPLETE STATUS REPORT ;Mar 22, 2021@17:48
 ;;5.2;LAB SERVICE;**153,201,221,453,536,543,562,566**;Sep 27, 1994;Build 12
 ;
EN ;
 K ^TMP($J),^TMP("LR",$J),^TMP("LRWRKINC",$J)
 K %ZIS,DIC
 S Y=$$NOW^XLFDT D DD^LRX S LRDT=Y
 S (LRCNT,LRCUTOFF,LREND,LREXD,LREXTST,LRNOCNTL,LREXNREQ)=0,LRSORTBY=1
 S DIC="^LRO(68,",DIC(0)="AEMOQZ"
 F  D  Q:$G(LRAA)<1!(LREND)
 . N LAST,LRAD,LRAN,LRFAN,LRLAN,LRWDTL,LRSTAR,LRUSEAA,X,Y,LRDIP
 . D ^DIC
 . I $D(DUOUT) S LREND=1 Q
 . S LRAA=+Y,LRAA(0)=$G(Y(0))
 . I LRAA<1 Q
 . D CHKAA^LRWRKIN1
 . I LREND Q
 . I '$L(LRUSEAA) D PHD Q:LREND
 . S LRCNT=LRCNT+1,^TMP("LRWRKINC",$J,$P(LRAA(0),"^")_"^"_LRAA,LRCNT,0)=LRAA(0)
 . I $G(LRDIP) S LAST=LRDIP
 . I $L(LRUSEAA) D
 . . N X
 . . S X=$P($G(^LRO(68,LRUSEAA,0)),"^")_"^"_LRUSEAA
 . . S ^TMP("LRWRKINC",$J,$P(LRAA(0),"^")_"^"_LRAA,LRCNT,1)=^TMP("LRWRKINC",$J,$P(LRUSEAA,"^",1,2),$P(LRUSEAA,"^",3),1)
 . E  S ^TMP("LRWRKINC",$J,$P(LRAA(0),"^")_"^"_LRAA,LRCNT,1)=$G(LRAD)_"^"_$G(LRFAN)_"^"_$G(LRLAN)_"^"_$G(LRSTAR)_"^"_$G(LAST)_"^"_$G(LRWDTL)
 . W !
 I LREND!('$D(^TMP("LRWRKINC",$J))) D LREND^LRWRKIN1 Q
 K DIC
 N DIR,DIRUT,DTOUT,DUOUT
 I LRCNT>1 D
 . S DIR(0)="SO^1:ACCESSION AREA;2:TEST NAME",DIR("A")="Sort Report By",DIR("B")=1
 . S DIR("?",1)="ACCESSION AREA will separate tests by accession area, then by test name."
 . S DIR("?")="TEST NAME will list tests alphabetically without regard to accession area."
 . D ^DIR
 . I $D(DIRUT) S LREND=1 Q
 . S LRSORTBY=+Y
 I LREND D LREND^LRWRKIN1 Q
 S DIR(0)="YO",DIR("A")="Specify detailed sort criteria",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' if you WANT to specify detailed criteria."
 S DIR("?",2)="Examples are excluding controls, specifying a lab arrival cut-off time,"
 S DIR("?",3)="selecting or excluding specific tests, or excluding non-required tests."
 S DIR("?")="Answer 'NO' if you DO NOT want to specify detailed criteria."
 D ^DIR
 I $D(DIRUT) D LREND^LRWRKIN1 Q
 I Y=1 D
 . K DIR
 . S DIR(0)="DO^::EXT",DIR("A")="Lab Arrival Cut-off"
 . S DIR("?",1)="Entering a date/time will exclude uncollected specimens and"
 . S DIR("?")="specimens with a lab arrival time after the time specified."
 . D ^DIR
 . I $D(DUOUT)!($D(DTOUT)) Q
 . I Y>0 S LRCUTOFF=+Y
 . K DIR
 . S DIR(0)="YO",DIR("A")="Do you want to exclude controls",DIR("B")="YES"
 . S DIR("?",1)="Answer 'NO' if you WANT accessions for LAB CONTROLS included on"
 . S DIR("?")="the report. 'YES' if you DO NOT want accessions for LAB CONTROLS."
 . D ^DIR
 . I $D(DIRUT) Q
 . S LRNOCNTL=+Y
 . K DIR
 . S DIR(0)="YO",DIR("A")="Do you want a specific test",DIR("B")="NO"
 . D ^DIR
 . I $D(DIRUT) Q
 . I Y=1 D
 . . N I,LRY
 . . K DIR
 . . S DIR(0)="YO",DIR("A")="Check tests on panels also",DIR("B")="YES"
 . . S DIR("?",1)="If you select a panel test do you want to also check"
 . . S DIR("?")="the tests that make up the panel for an incomplete status."
 . . D ^DIR
 . . I $D(DIRUT) Q
 . . S LRY=+Y
 . . N DIC
 . . S DIC="^LAB(60,",DIC(0)="AEFOQZ"
 . . F  D  Q:+Y<1
 . . . N LRTEST,LRTSTS
 . . . D ^DIC Q:+Y<1
 . . . S ^TMP("LR",$J,"T",+Y)=Y(0)
 . . . I LRY S LRTEST=+Y,LREXPD="D LREXPD^LRWRKINC" D ^LREXPD
 . I $D(DIRUT) Q
 . K DIR
 . S DIR(0)="YO"
 . S DIR("A")="Do you want to exclude a specific test",DIR("B")="NO"
 . D ^DIR
 . I $D(DIRUT) Q
 . I Y=1 D
 . . N DIC
 . . S DIC="^LAB(60,",DIC(0)="AEFOQ",DIC("S")="I '$D(^TMP(""LR"",$J,""T"",Y))"
 . . F  D ^DIC Q:+Y<1  S LREXTST(+Y)="",LREXTST=1
 . K DIR
 . S DIR(0)="YO",DIR("A")="Exclude non-required tests",DIR("B")="YES"
 . S DIR("?",1)="Answer 'NO' if you WANT incomplete non-required test included on"
 . S DIR("?")="the report. 'YES' if you DO NOT want non-required tests."
 . D ^DIR
 . I $D(DIRUT) Q
 . S LREXNREQ=+Y
 I $D(DIRUT) D LREND^LRWRKIN1 Q
 S DIR(0)="YO",DIR("A")="Do you want an extended display",DIR("B")="NO"
 S DIR("?")="Extended display will show UID and other referral information"
 D ^DIR
 I $D(DIRUT) D LREND^LRWRKIN1 Q
 S LREXD=+Y
 S %ZIS="Q" D ^%ZIS
 I POP D LREND^LRWRKIN1 Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="DQ^LRWRKINC",ZTDESC="Lab incomplete test list",ZTSAVE("LR*")=""
 . S ZTSAVE("^TMP(""LRWRKINC"",$J,")=""
 . I $D(^TMP("LR",$J,"T")) S ZTSAVE("^TMP(""LR"",$J,""T"",")=""
 . D ^%ZTLOAD,^%ZISC
 . W !,"Request ",$S($G(ZTSK):"Queued - Task #"_ZTSK,1:"NOT Queued")
 . D LREND^LRWRKIN1
 ;
DQ ;
 U IO
 ;LR*5.2*536: Variable LRMI* variables in next line indicate Microbiology accession
 N LRMIFLG,LRMIARX,LRMIPND
 S (LRAA,LRINDEX,LRPAGE)=0,(LRX,LRY)=""
 F  S LRX=$O(^TMP("LRWRKINC",$J,LRX)) Q:LRX=""  D
 . N LRZ
 . S LRZ=0
 . F  S LRZ=$O(^TMP("LRWRKINC",$J,LRX,LRZ)) Q:'LRZ  D
 . . N LRFAN,LRLAN,LRSTAR,LRLAST,LRY
 . . F I=0,1 S LRZ(I)=$G(^TMP("LRWRKINC",$J,LRX,LRZ,I))
 . . S LRFAN=$P(LRZ(1),"^",2),LRLAN=$P(LRZ(1),"^",3),LRSTAR=$P(LRZ(1),"^",4),LRLAST=$P(LRZ(1),"^",5)
 . . I $P(LRZ(1),"^",7)'="" S LRLAST=$P(LRZ(1),"^",7)
 . . I LRSTAR,LRLAST S LRY="From Date: "_$$FMTE^XLFDT(LRSTAR,"5DZ")_"    To: "_$$FMTE^XLFDT(LRLAST,"5DZ")
 . . E  S LRY=" For Date: "_$$FMTE^XLFDT(LRLAST,"5DZ")_"  From: "_LRFAN_"  To: "_LRLAN
 . . S LRINDEX=LRINDEX+1,LRNAME(LRINDEX)=$$LJ^XLFSTR($E($P(LRZ(0),"^"),1,20),22)_LRY
 S LRINDEX=LRINDEX+1,LRNAME(LRINDEX)=$S(LRINDEX>1:"Sorted by "_$S(LRSORTBY=1:"Accession Area",1:"Test Name")_"; ",1:"")_"Controls Excluded: "_$S(LRNOCNTL:"YES",1:"NO")_"; Specific Tests: "_$S($D(^TMP("LR",$J,"T")):"YES",1:"NO")
 S LRINDEX=LRINDEX+1,LRNAME(LRINDEX)="Exclude Specific Tests: "_$S(LREXTST:"YES",1:"NO")_"; Required Tests Only: "_$S(LREXNREQ:"YES",1:"NO")
 I LRCUTOFF S LRINDEX=LRINDEX+1,LRNAME(LRINDEX)="For Tests Received Before: "_$$FMTE^XLFDT(LRCUTOFF,"5MZ")
 D HED^LRWRKIN1 D URG^LRX
 S LRX=""
 F  S LRX=$O(^TMP("LRWRKINC",$J,LRX)) Q:LRX=""  D
 . S LRZ=0
 . F  S LRZ=$O(^TMP("LRWRKINC",$J,LRX,LRZ)) Q:'LRZ  D
 . . I LRSORTBY=1 S LRAA("NAME")=$P(LRX,"^")
 . . S X=^TMP("LRWRKINC",$J,LRX,LRZ,1)
 . . S LRAA=$P(LRX,"^",2),LRAD=$P(X,"^"),LRFAN=$P(X,"^",2),LRLAN=$P(X,"^",3),LRSTAR=$P(X,"^",4),LAST=$P(X,"^",5),LRWDTL=$P(X,"^",6)
 . . S:LAST'>LRAD LRAD=LAST-1
 . . N LRX,LRZ
 . . F  S LRAD=$O(^LRO(68,LRAA,1,LRAD)) Q:LRAD<1!(LRAD>LAST)  D
 . . . I $G(LRSTAR) D AC Q
 . . . S LRAN=LRFAN-1
 . . . F  S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) Q:'LRAN!(LRAN>LRLAN)  D
 . . . . S LREND=0
 . . . . D TD Q:LREND
 . . . . I 'LRVERVER D LST1^LRWRKIN1,TESTS
 D X^LRWRKIN1
 I LREND D LREND^LRWRKIN1 Q
 D EQUALS^LRX D WAIT^LRWRKIN1:$E(IOST,1,2)="C-"
 K LRDIP D LREND^LRWRKIN1
 Q
 ;
TD ;
 N LRMIAREA,LRDFNX,LRIDTX,LRTST68
 K LRMIARX,LRMIPND
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) S LREND=1 Q
 I LRNOCNTL,$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,0)),"^",2)=62.3 S LREND=1 Q
 S LRVERVER=1,(I,LRMIFLG)=0
 F  S I=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,I)) Q:I<.5  I $D(^(I,0)) S LRVERVER=(LRVERVER&$P(^(0),U,5))
 ;LR*5.2*536 - if "RPT DATE APPROVED" has not been populated for Microbiology accessions,
 ;             display accession on the Incomplete list
 ;             (considered combining logic below with lines above, but decided to keep
 ;              Microbiology logic separate in case further changes are needed.)
 I $P(^LRO(68,LRAA,0),U,2)="MI" D
 . S LRDFNX=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U)
 . S LRIDTX=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U,5)
 . ;Subscripts: 1 = Bacteriology; 5=Parasitology; 8=Mycology; 11=TB; 16=Virology
 . I LRIDTX>1 F LRMIAREA=1,5,8,11,16 D
 . . ;using a different flag for Micro so that this change will only affect Micro
 . . ;in the TESTS subsection of this routine
 . . ;LRMIFLG = "[area] RPT DATE APPROVED" is not populated
 . . I $D(^LR(LRDFNX,"MI",LRIDTX,LRMIAREA)),$P(^(LRMIAREA),U)="" D
 . . . S LRVERVER=0,LRMIFLG=1
 . . . S LRMIARX(LRMIAREA)=""
 . Q:'$D(LRMIARX)
 . ;determine which tests on the accession are defined for the pending Microbiology
 . ;area subscript
 . S LRTST68=0
 . F  S LRTST68=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTST68)) Q:LRTST68<.5  D
 . . ;LR*5.2*543: Do not list if test marked "not performed" or "merged".
 . . I $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTST68,0),U,6)]"" Q
 . . N LREXCODE
 . . S LREXCODE=$P($G(^LAB(60,LRTST68,0)),"^",14)
 . . I LREXCODE]"" S LREXCODE=$G(^LAB(62.07,LREXCODE,.1))
 . . ;Logic below is the same as the logic in result verification routine LRMIEDZ2 which
 . . ;determines which Microbiology area is defined for a Microbiology test
 . . S LRMIAREA=$S(LREXCODE["11.5":1,LREXCODE["23":11,LREXCODE["19":8,LREXCODE["15":5,LREXCODE["34":16,1:"")
 . . ;setting an array because more than one test on the accession might be defined for the
 . . ;Microbiology area
 . . I LRMIAREA]"",$D(LRMIARX(LRMIAREA)) S LRMIPND(LRTST68)=""
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0)) S LREND=1
 Q
 ;
TESTS Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0))
 N LRI
 S LRI=0
 F  S LRI=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI)) Q:LRI<.5  D
 . N LR60,LRURG,LRTSTN
 . S LRI(0)=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI,0)),LRURG=+$P(LRI(0),U,2)
 . S LR60=+LRI(0)
 . I $D(^TMP("LR",$J,"T")),'$D(^TMP("LR",$J,"T",LR60)) Q  ; Not specific test
 . I LREXTST,$D(LREXTST(LR60)) Q  ; Exclude specific test
 . ;LR*5.2*536:
 . ;LRMIFLG of 1 indicates this is a pending Microbiology accession even though
 . ;a "complete" date has been set at LRI(0),U,5) by the prompt "[test name] completed:"
 . ;(i.e. the "[area] RPT DATE APPROVED:" prompt has not been answered.
 . I $P(LRI(0),U,5),'$G(LRMIFLG) Q
 . ;LR*5.2*536: This is a Microbiology pending accession but the test being evaluated
 . ;            is not pending. (There may be more than one Micro test on an accession.)
 . ;The check for LRI(0) is necessary because the area subscript may not yet exist in file 63.
 . I $G(LRMIFLG),'$D(LRMIPND(LR60)),$P(LRI(0),U,5) Q
 . I LRCUTOFF,'LRDLA Q  ; Uncollected
 . I LRCUTOFF,LRCUTOFF<LRDLA Q  ; After cut-off date/time
 . S LR60(0)=$G(^LAB(60,LR60,0)) ; Get zeroth node from file #60
 . I LREXNREQ,'$P(LR60(0),"^",17) Q  ; Exclude non-required tests
 . S LRTSTN=$P(LR60(0),U) ; Test name
 . I $P(LR60(0),"^")="" S LRTSTN="MISSING FILE 60 - "_LR60
 . I LRSORTBY=1 S LRTSTN=LRAA("NAME")_"^"_LRTSTN
 . S Y=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,3))
 . S LRST=$S($L($P(LRI(0),U,3)):"Load/work list",$L($P(Y,U,3)):"In lab",1:"Not in lab")
 . D REF
 . S ^TMP($J,LRTSTN,LRURG,$P(LRACC," ",1)_"^"_+$P(LRDX,"^",3),LRAN)=LRST_U_SSN_U_PNM_U_$P(LRDX,U,7)_U_$P(LRDLA,"^",2)_U_LRMAN_U_LRACC
 . I $G(LREXD) S ^TMP($J,LRTSTN,LRURG,$P(LRACC," ",1)_"^"_+$P(LRDX,"^",3),LRAN,.3)=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3))
 Q
 ;
REF ; if referred test, get referral status
 N LREVNT,LRUID
 S LRUID=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),"^"),LRMAN=$P(LRI(0),"^",10)
 I LRMAN S LRMAN=$P($G(^LAHM(62.8,LRMAN,0)),"^")
 S LREVNT=$$STATUS^LREVENT(LRUID,LR60,LRMAN)
 I LREVNT'="" S LRST=$P(LREVNT,"^")
 ;LR*5.2*562 begin
 ;NOTE: Amended results do not display a status of "Results received"
 ;      on the Incomplete report by design. The report should only
 ;      display tests which currently do not contain a verified result.
 ;
 ;Only checking "CH" subscripted tests (i.e. not Microbiology).
 ;Microbiology will require an NSR due to the amount of code
 ;which must be written. Also, according to some SME's, panels
 ;should not be defined in Microbiology, even though some sites do.
 ;(Anatomic Pathology results are not transmitted through LEDI.)
 Q:$P(^LAB(60,LR60,0),"^",4)'="CH"
 ;
 ;Only display "Results received" status if results are currently
 ;waiting in ^LAH waiting to be verified. The previous results
 ;received might have been equal to "pending".
 ;LRMNF=shipping manifest ien
 N LRMNF
 S LRMNF=$P(LRI(0),"^",10)
 I LRMNF,LRST["Results" D LAH
 Q:LRMNF
 D PROF
 Q
 ;
PROF ;
 ;Shipping manifest identifier is still null.
 ;Is the test a profile component and is the profile on a
 ;shipping manifest?
 ;LRPRF=parent (profile) indicator
 N LRPRF,LRXTST
 S LRPRF=$P(LRI(0),"^",9)
 ;Should not be null, but checking just in case.
 Q:LRPRF=""
 ;Quit if test is not a profile component.
 I LRPRF'=LR60 D PROFMAN
 Q
 ;
PROFMAN ;
 ;Is the profile on a shipping manifest.
 S LRMNF=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRPRF,0)),"^",10)
 I LRMNF="" D ORIG(LRPRF)
 ;Does the profile contain another profile?
 I LRMNF="" D
 . N LRPRFCHK,LRPRFZ,LRPROFX
 . S LRPRFCHK=LRPRF,LRPRFZ=0
 . F  S LRPRFZ=$O(^LAB(60,LRPRFCHK,2,LRPRFZ)) Q:'LRPRFZ  Q:LRMNF  D
 . . ;check if a profile within a profile
 . . S LRPROFX=$P($G(^LAB(60,LRPRFCHK,2,LRPRFZ,0)),"^")
 . . Q:LRPROFX=""
 . . I $O(^LAB(60,LRPROFX,2,0))="" Q
 . . ;This is a profile within a profile.
 . . ;Is "profile within profile" on shipping manifest.
 . . S LRMNF=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRPROFX,0)),"^",10)
 . . I LRMNF]"" S LRPRF=LRPROFX Q
 . . ;Continue searching for shipping manifest.
 . . D ORIG(LRPROFX)
 . . I LRMNF]"" S LRPRF=LRPROFX Q
 . . ;Check atomic tests.
 . . N LRATOMIC
 . . S LRATOMIC=0
 . . F  S LRATOMIC=$O(^LAB(60,LRPROFX,2,LRATOMIC)) Q:'LRATOMIC  Q:LRMNF  D
 . . . I $P($G(^LAB(60,LRPROFX,2,LRATOMIC,0)),"^")=LR60 D
 . . . . S LRMNF=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRPROFX,0)),"^",10)
 . . . . S LRPRF=LRPROFX
 I LRMNF]"" D PROFSTAT
 Q
 ;
ORIG(LRXTST) ;
 ;The shipping manifest might be on the original order date
 ;for the accession if the accession rolled over.
 N LRORIG
 S LRORIG=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),"^",3)
 Q:LRORIG=LRAD
 S LRMNF=$P($G(^LRO(68,LRAA,1,LRORIG,1,LRAN,4,LRXTST,0)),"^",10)
 Q
 ;
PROFSTAT ;
 ;Determine profile's status on shipping manifest.
 ;LRMNSQ=sequence on shipping manifest
 ;LRMNTST=file 60 test ien on shipping manifest
 ;LRSTPR=profile's status
 N LRMNSQ,LRMNTST,LRSTPR
 S (LRMNSQ,LRSTPR)=""
 F  S LRMNSQ=$O(^LAHM(62.8,LRMNF,10,"UID",LRUID,LRMNSQ)) Q:'LRMNSQ  Q:LRSTPR]""  D
 . S LRMNTST=$P($G(^LAHM(62.8,LRMNF,10,LRMNSQ,0)),"^",2)
 . ;Check the status of the profile on the shipping manifest.
 . I LRMNTST=LRPRF D
 . . S LREVNT=$$STATUS^LREVENT(LRUID,LRPRF,LRMNF)
 . . ;Probably do not need both LRSTPR and LRST at this point,
 . . ;but keeping so that won't inadvertently cause other issues.
 . . I LREVNT'="" S (LRSTPR,LRST)=$P(LREVNT,"^")
 . ;Further checking needed if status of the profile is "Results
 . ;received".
 . I LRSTPR["Results" D LAH
 Q
 ;
LAH ;
 ;If "Results received" status, are results waiting to be verified.
 ;Results might have previously been verified for the profile,
 ;but no results are currently waiting to be verified on
 ;remaining components. Laboratory personnel use the "Results 
 ;received" status as an indicator that results are waiting 
 ;to be manually verified.
 ;Need to drill down through globals (re-using variable LRWKLST).
 N LRWKLST,LRLAHSQ,LRLAHTST,LRHIT
 ;Retrieve shipping configuration ien.
 S LRWKLST=$P(^LAHM(62.8,LRMNF,0),"^",2)
 ;Retrieve LAB MESSAGING LINK (#.07) field.
 S LRWKLST=$P(^LAHM(62.9,LRWKLST,0),"^",7)
 ;Retrieve the name of the link.
 S LRWKLST=$P(^LAHM(62.48,LRWKLST,0),"^")
 ;Finally, retrieve Load/Worklist ien.
 S LRWKLST=$O(^LAB(62.4,"B",LRWKLST,""))
 Q:LRWKLST=""
 S LRWKLST=$P(^LAB(62.4,LRWKLST,0),"^",4)
 Q:LRWKLST=""
 ;Are any results waiting to be verified for this UID.
 I '$D(^LAH(LRWKLST,1,"U",LRUID)) S LRST="Test shipped" Q
 ;Check the results.
 S LRLAHSQ="",LRHIT=0
 F  S LRLAHSQ=$O(^LAH(LRWKLST,1,"U",LRUID,LRLAHSQ)) Q:LRLAHSQ=""  D
 . S LRLAHTST=.3
 . F  S LRLAHTST=$O(^LAH(LRWKLST,1,LRLAHSQ,LRLAHTST)) Q:'LRLAHTST  Q:LRHIT  D
 . . ;Do any tests in ^LAH have the same data name as the test being
 . . ;evaluated. (Considered screening out results of "pending". But comments
 . . ;might have been transmitted for pending results which need verification.)
 . . I LRLAHTST=$P($P(^LAB(60,LR60,0),"^",5),";",2) S LRHIT=1
 . . ;Check profile components.
 . . N LRSUB,LRSUBTST
 . . S LRSUB=0
 . . F  S LRSUB=$O(^LAB(60,LR60,2,LRSUB)) Q:'LRSUB  D
 . . . S LRSUBTST=$P($G(^LAB(60,LR60,2,LRSUB,0)),"^")
 . . . I LRLAHTST=$P($P(^LAB(60,LRSUBTST,0),"^",5),";",2) S LRHIT=1
 ;No match found in ^LAH, so revert status to "Test shipped".
 I 'LRHIT S LRST="Test shipped"
 Q
 ;
PHD ;
 S LREND=0
 I $P(LRAA(0),"^",3)="Y" D STAR^LRWU3
 I $G(LRSTAR) Q
 D ADATE^LRWU Q:LREND
 ;LR*5.2*566: Reset LRAD if accession area has rolled over.
 ;            Only Daily accession areas roll over - not Yearly, Monthly,
 ;            or Quarterly.
 ;            10th piece indicates if Bypass Rollover is set to yes.
 ;            Adding $G because 1 subscript might not be set yet
 ;            for new accession areas.
 I LRAD<DT,$P(LRAA(0),"^",3)="D",'$P(LRAA(0),"^",10) D  Q:LREND
 . K DIR
 . S DIR(0)="YO",DIR("A")="Are you sure you want to proceed?",DIR("B")="NO"
 . S DIR("A",1)="Rollover completed on "_$$DDDATE^LRAFUNC1($$CDHTFM^LRAFUNC1(^LAB(69.9,1,"RO")),1)
 . S DIR("A",2)="You are selecting a date in the past."
 . S DIR("?")="Answer 'YES' if you want to continue."
 . D ^DIR
 . I $D(DIRUT)!'Y S LREND=1 Q
 . S LRDIP=LRAD
 I $P(LRAA(0),"^",3)="D",'$P(LRAA(0),"^",10),$P($G(^LRO(68,LRAA,1,0)),"^",3)>LRAD S LRAD=$P(^LRO(68,LRAA,1,0),"^",3)
 S LAST=LRAD,LRAD=LRAD-1
 D LRAN^LRWU3
 Q
 ;
AC S LRTK=LRSTAR-.00001
 F  S LRTK=$O(^LRO(68,LRAA,1,LRAD,1,"E",LRTK)) Q:LRTK<1!(LAST>1&(LRTK\1>LAST))  D
 . S LRAN=0
 . F  S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,"E",LRTK,LRAN)) Q:'LRAN  D
 . . S LREND=0
 . . I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) S LREND=1 Q
 . . D TD Q:LREND
 . . ;I LRUNC!('LRVERVER) D LST,TESTS
 . . I 'LRVERVER D LST1^LRWRKIN1,TESTS
 Q
 ;
% R %:DTIME Q:%=""!(%["N")!(%["Y")  W !,"Answer 'Y' or 'N': " G %
 Q
 ;
LREXPD ;Include panel test in list when selecting specific tests
 I $G(S1(+$G(S1))) S ^TMP("LR",$J,"T",S1(S1))=^LAB(60,S1(S1),0)
 Q
