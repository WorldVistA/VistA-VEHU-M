LR7OSMZ2 ;DALOI/STAFF - Silent Micro rpt - BACTERIA, SIC/SBC, MIC ;Jul 15, 2021@13:33
 ;;5.2;LAB SERVICE;**121,244,392,350,427,547**;Sep 27, 1994;Build 10
 ;
 ;
ANTI ;from LR7OSMZ1
 I $P(^LR(LRDFN,"MI",LRIDT,14,0),U,4)>0 D
 . D LINE,LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(28,CCNT,"Antibiotic Level(s):")
 . D LINE
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"ANTIBIOTIC")_$$S^LR7OS(20,CCNT,"CONC RANGE (ug/ml)")_$$S^LR7OS(42,CCNT,"DRAW TIME")
 . S B=0
 . F  S B=$O(^LR(LRDFN,"MI",LRIDT,14,B)) Q:B<1  S X=^(B,0) D
 . . D LINE
 . . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,$P(X,U))_$$S^LR7OS(20,CCNT,$P(X,U,3))_$$S^LR7OS(42,CCNT,$$EXTERNAL^DILFD(63.42,1,"",$P(X,U,2)))
 . . D LINE
 Q
 ;
MES ;LR*5.2*547: Display informational message if accession/test is currently being edited.
 Q:'$G(LR7SB)
 Q:'$D(^XTMP("LRMICRO EDIT",LRDFN,LRIDT,LR7SB))
 N LR7AREA
 S LR7AREA=$S(LR7SB=1:"Bacteriology",LR7SB=5:"Parasitology",LR7SB=8:"Mycology",LR7SB=11:"Mycobacteriology",1:"Virology")
 D LINE
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"                         *** ATTENTION ***")
 D LINE
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"          The "_LR7AREA_" Report is being edited by")
 D LINE
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"          tech code "_$G(^XTMP("LRMICRO EDIT",LRDFN,LRIDT,LR7SB))_" and current results")
 D LINE
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"          may not be visible until approved.")
 Q
 ;
BACT ;from LR7OSMZ1
 ;
 I '$L($P(^LR(LRDFN,"MI",LRIDT,1),U)) D  Q:'$D(LRWRDVEW)  Q:LRSB'=1
 . Q:'$D(^XTMP("LRMICRO EDIT",LRDFN,LRIDT,1))
 . ;LR*5.2*547: Display informational message if accession/test is currently being edited
 . ;            and results had previously been verified.
 . N LR7SB S LR7SB=1
 . D MES
 ;
 D BUG
 I $D(^LR(LRDFN,"MI",LRIDT,2,0)) D FH^LR7OSMZU Q:LREND  D GRAM
 ;
 I $D(^LR(LRDFN,"MI",LRIDT,25,0)) D FH^LR7OSMZU Q:LREND  D BSMEAR
 ;
 I $D(^LR(LRDFN,"MI",LRIDT,3,0)) D FH^LR7OSMZU Q:LREND  D BRMK Q:LREND  D BACT^LR7OSMZ5 Q:LREND
 ;
 I $O(^LR(LRDFN,"MI",LRIDT,4,0)) D  Q:LREND
 . D FH^LR7OSMZU Q:LREND
 . D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"Bacteriology Remark(s):") S B=0 D
 . F  S B=+$O(^LR(LRDFN,"MI",LRIDT,4,B)) Q:B<1  D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(3,CCNT,^LR(LRDFN,"MI",LRIDT,4,B,0))
 ;
 Q
 ;
 ;
BUG ;
 ;
 N LRNS,LRTUS,LRUS,X
 ;
 S X=^LR(LRDFN,"MI",LRIDT,1),LRTUS=$P(X,U,2),DZ=$P(X,U,3),LRUS=$P(X,U,6),LRNS=$P(X,U,5),Y=$P(X,U)
 D D^LRU,LINE
 ;
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"* BACTERIOLOGY "_$S(LRTUS="F":"FINAL",LRTUS="P":"PRELIMINARY",1:"")_" REPORT => "_Y_"   TECH CODE: "_DZ)
 S LRPRE=19
 D PRE^LR7OSMZU
 ;
 I LRUS'="" D
 . D LINE
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"URINE SCREEN: "_$S(LRUS="N":"Negative",LRUS="P":"Positive",1:LRUS))
 . I LRNS="" D LINE
 ;
 I LRNS'="" D
 . D LINE
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"SPUTUM SCREEN:  "_LRNS)
 . D LINE
 ;
 Q
 ;
 ;
GRAM ;
 N CNT,LRGRM
 ;
 D LINE
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"GRAM STAIN:")
 S (CNT,LRGRM)=0
 F  S LRGRM=+$O(^LR(LRDFN,"MI",LRIDT,2,LRGRM)) Q:LRGRM<1  D
 . S X=^LR(LRDFN,"MI",LRIDT,2,LRGRM,0),CNT=CNT+1
 . I CNT>1 D LN^LR7OSMZ1 S ^TMP("LRC",$J,GCNT,0)=""
 . S ^TMP("LRC",$J,GCNT,0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(13,CCNT,X)
 D LINE
 Q
 ;
 ;
BSMEAR ;
 ;
 D LINE
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"BACTERIOLOGY SMEAR/PREP:") S LRMYC=0
 F  S LRMYC=+$O(^LR(LRDFN,"MI",LRIDT,25,LRMYC)) Q:LRMYC<1  S X=^(LRMYC,0) D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(5,CCNT,X)
 D LINE
 Q
 ;
 ;
BRMK ;
 ;
 N LRAX,LRBUG
 ;
 S (LRBUG,LR2ORMOR)=0
 F LRAX=1,2 S LRBUG=+$O(^LR(LRDFN,"MI",LRIDT,3,LRBUG)) Q:LRBUG<1  S:LRAX=2 LR2ORMOR=1
 ;
 I LRAX'=1 D
 . S (LRBUG,LRTSTS)=0
 . F LRAX=1:1 S LRBUG=+$O(^LR(LRDFN,"MI",LRIDT,3,LRBUG)) Q:LRBUG<1  D LST,LINE
 ;
 Q
 ;
 ;
LST ;
 ;
 N LRX
 S LRX=^LR(LRDFN,"MI",LRIDT,3,LRBUG,0)
 S (LRBUG(LRAX),LRORG)=$P(LRX,U),LRQU=$P(LRX,U,2),LRSSD=$P(LRX,U,3,8),LRORG=$P(^LAB(61.2,LRORG,0),U)
 ;
 I LRSSD'?."^" S LRSIC1=$P(LRSSD,U),LRSBC1=$P(LRSSD,U,2),LRDRTM1=$P(LRSSD,U,3),LRSIC2=$P(LRSSD,U,4),LRSBC2=$P(LRSSD,U,5),LRDRTM2=$P(LRSSD,U,6),LRSSD=1
 ;
 I LRAX=1 D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"CULTURE RESULTS: ")
 ;
 I LRAX>1 D LN^LR7OSMZ1 S ^TMP("LRC",$J,GCNT,0)=""
 ;
 S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(18,CCNT,$S(LR2ORMOR:$J(LRBUG,2)_". ",1:" ")_LRORG)
 ;
 ; Display quantity/colony count
 I LRQU'="" D
 . N LRX
 . S LRX=" - Quantity: "_LRQU
 . I (GIOM-$X-1)<$L(LRX) D LINE S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(21,CCNT,LRX) Q
 . S ^TMP("LRC",$J,GCNT,0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(CCNT,CCNT,LRX)
 ;
 I LRSSD D SSD
 ;
 S:$D(^LR(LRDFN,"MI",LRIDT,3,LRBUG,2)) LRTSTS=LRTSTS+1
 ;
 I $O(^LR(LRDFN,"MI",LRIDT,3,LRBUG,3,0)) D MIC
 ;
 I $O(^LR(LRDFN,"MI",LRIDT,3,LRBUG,1,0)) D CMNT
 ;
 Q
 ;
 ;
SSD ;
 ;
 D LINE
 S LRDRTM1=$S(LRDRTM1="P":"PEAK",LRDRTM1="T":"TROUGH",1:LRDRTM1),LRDRTM2=$S(LRDRTM2="P":"PEAK",LRDRTM2="T":"TROUGH",1:LRDRTM2)
 ;
 I LRSIC1'="" D
 . D LINE
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(20,CCNT,"SIT ")
 . S:$L(LRDRTM1) ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(CCNT,CCNT,"("_LRDRTM1_")")
 . S ^(0)=^(0)_$$S^LR7OS(CCNT,CCNT,": "_LRSIC1)
 ;
 I LRSBC1'="" D
 . D LINE
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(20,CCNT,"SBT ")
 . S:$L(LRDRTM1) ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(CCNT,CCNT,"("_LRDRTM1_")")
 . S ^(0)=^(0)_$$S^LR7OS(CCNT,CCNT,": "_LRSBC1)
 ;
 I LRSIC2'="" D
 . D LINE
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(20,CCNT,"SIT ")
 . S:$L(LRDRTM2) ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(CCNT,CCNT,"("_LRDRTM2_")")
 . S ^(0)=^(0)_$$S^LR7OS(CCNT,CCNT,": "_LRSIC2)
 ;
 I LRSBC2'="" D
 . D LINE
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(20,CCNT,"SBT ")
 . S:$L(LRDRTM2) ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(CCNT,CCNT,"("_LRDRTM2_")")
 . S ^(0)=^(0)_$$S^LR7OS(CCNT,CCNT,": "_LRSBC2)
 ;
 Q
 ;
 ;
MIC ;
 ;
 D LINE
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(22,CCNT,"Antibiotic"),B=0
 F  S B=+$O(^LR(LRDFN,"MI",LRIDT,3,LRBUG,3,B)) Q:B<1  I $L($P(^(B,0),U,2,3))>0 S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(39,CCNT,"MIC (ug/ml)")_$$S^LR7OS(54,CCNT,"MBC (ug/ml)") Q
 ;
 S B=0
 F  S B=+$O(^LR(LRDFN,"MI",LRIDT,3,LRBUG,3,B)) Q:B<1  D
 . S X=^LR(LRDFN,"MI",LRIDT,3,LRBUG,3,B,0)
 . D LINE
 . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(22,CCNT,$P(X,U))_$$S^LR7OS(39,CCNT,$J($P(X,U,2),7))_$$S^LR7OS(54,CCNT,$J($P(X,U,3),7))
 ;
 Q
 ;
 ;
CMNT ;
 ;
 N LRX,X,DIWL,DIWR,DIWF,LRIDX
 S LRPC=0,DIWL=31,DIWR=GIOM,DIWF="|"
 F A=0:1 S LRPC=+$O(^LR(LRDFN,"MI",LRIDT,3,LRBUG,1,LRPC)) Q:LRPC<1  D
 . S LRX=^LR(LRDFN,"MI",LRIDT,3,LRBUG,1,LRPC,0),X=LRX
 . K ^UTILITY($J,"W")
 . D ^DIWP
 . I A=0,$D(^UTILITY($J,"W",31,1,0)) D
 . . D LN^LR7OSMZ1
 . . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(22,CCNT,"Comment: "_^UTILITY($J,"W",31,1,0))
 . . K ^UTILITY($J,"W",31,1,0)
 . S LRIDX=0
 . F  S LRIDX=$O(^UTILITY($J,"W",31,LRIDX)) Q:'LRIDX  D
 . . Q:'$D(^UTILITY($J,"W",31,LRIDX,0))
 . . D LN^LR7OSMZ1
 . . S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(22,CCNT,"         "_^UTILITY($J,"W",31,LRIDX,0))
 . K ^UTILITY($J,"W")
 Q
 ;
 ;
LINE ;
 D LINE^LR7OSUM4
 Q
