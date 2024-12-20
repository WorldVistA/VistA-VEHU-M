LRMIPSZ3 ;DALOI/STAFF - MICRO PATIENT REPORT - STERILITY, PARASITES, VIRUS ;Jul 15, 2021@13:13
 ;;5.2;LAB SERVICE;**350,427,547**;Sep 27, 1994;Build 10
 ;
 ; Reference for DD global supported by ICR #999
 Q
 ;
 ;
STER ;
 ; from LRMIPSZ1
 ; also called from RPT^LROR4
 N I,LRBLDTMP,LRERR,LRFLAG,LRX,X
 S LRBLDTMP=0
 I '$D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT)) D
 . S LRBLDTMP=1
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)=^LR(LRDFN,"MI",LRIDT)
 . K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,32)
 ;
 I $P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,1),U,7)'="" D  Q:LRABORT
 . D NP Q:LRABORT
 . S LRX=$P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,1),U,7)
 . S LRX(0)=$$EXTERNAL^DILFD(63.05,11.51,"",LRX,"LRERR")
 . I $D(LRERR) S LRX(0)=LRX K LRERR
 . W !,"STERILITY CONTROL: ",LRX(0)
 ;
 S LRFLAG=$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,31,0))
 I LRFLAG W !
 S I=0
 F  S I=$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,31,I)) Q:I<1  D  Q:LRABORT
 . D NP Q:LRABORT
 . S LRX=$P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,31,I,0),"^")
 . S LRX(0)=$$EXTERNAL^DILFD(63.292,.01,"",LRX,"LRERR")
 . I $D(LRERR) S LRX(0)=LRX K LRERR
 . W !,"NUMBER: ",I,?20,"STERILITY RESULTS: ",LRX(0)
 I LRFLAG W !
 ;
 I LRBLDTMP K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)
 Q
 ;
 ;
PARA ;
 ; from LRMIPSZ1
 ; also called from RPT^LROR4
 N LRBLDTMP,LRQUIT
 S (LRBLDTMP,LRQUIT)=0
 I '$D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT)) D  ;
 . S LRBLDTMP=1
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)=^LR(LRDFN,"MI",LRIDT)
 . K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,32)
 ;
 I $P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,5),U)="",'$G(LRLABKY) D  S:'$D(LRWRDVEW) LRQUIT=1 S:LRSB'=5 LRQUIT=1
 . Q:'$D(^XTMP("LRMICRO EDIT",LRDFN,LRIDT,5))
 . ;LR*5.2*547: Display informational message if accession/test is currently being edited
 . ;            and results had previously been verified.
 . N LR7SB S LR7SB=5
 . D MES^LRMIPSZ2
 ;
 I LRQUIT D  Q
 . I LRBLDTMP K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)
 ;
 S LRTUS=$P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,5),U,2)
 S DZ=$P(^(5),U,3),Y=$P(^(5),U)
 D D^LRU
 I LRHC W ! D NP Q:LRABORT
 W !,"* PARASITOLOGY ",$S(LRTUS="F":"FINAL",LRTUS="P":"PRELIMINARY",1:"")," REPORT => ",Y,"   TECH CODE: ",DZ
 D NP Q:LRABORT
 S LRPRE=21 D PRE^LRMIPSU
 D NP Q:LRABORT
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,24)) D  ;
 . I LRHC W ! D NP Q:LRABORT
 . W !,"PARASITOLOGY SMEAR/PREP:"
 . D NP Q:LRABORT
 . S LRMYC=0
 . F I=0:0 S LRMYC=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,24,LRMYC)) Q:LRMYC<1  W !?5,^(LRMYC,0) D NP Q:LRABORT
 ;
 S LRPAR=0
 F  S LRPAR=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,LRPAR)) Q:LRPAR<1  Q:LRABORT  W:LRHC ! D NP Q:LRABORT  Q:'$D(^(LRPAR,0))  W !,"Parasite: ",$E($P(^LAB(61.2,^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,LRPAR,0),0),U),1,25),?30," " D STG D NP Q:LRABORT
 ;
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,7)) D  ;
 . W:LRHC ! D NP Q:LRABORT
 . W !,"Parasitology Remark(s):"
 . D NP Q:LRABORT
 . S LRPAR=0
 . F  S LRPAR=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,7,LRPAR)) Q:LRPAR<1  Q:LRABORT  W !,?3,^(LRPAR,0) D NP Q:LRABORT  ;
 ;
 I LRBLDTMP D  ;
 . K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)
 ;
 Q
 ;
 ;
STG ;
 N B
 D NP Q:LRABORT
 S LRBUG(LRPAR)=^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,LRPAR,0)
 S S1=6,LRTA=LRPAR
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,S1,LRTA,1)) D  ;
 . S B=0
 . F  S B=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,S1,LRTA,1,B)) Q:B<1  Q:LRABORT  S Y=^(B,0),Y1=$P(Y,U,2) W !,"   Stage: " D SET D NP Q:LRABORT  W:$L(Y1) !,"   Quantity: ",Y1 D LIST1 D NP Q:LRABORT
 ;
 Q
 ;
 ;
SET ;
 ; File DD/999
 S LRSET=$P(^DD(63.35,.01,0),U,3),%=$P($P(";"_LRSET,";"_$P(Y,U)_":",2),";") W:%]"" %
 Q
 ;
 ;
LIST1 ;
 N C
 D NP Q:LRABORT
 W !,"   Comment: "
 S C=0
 F  S C=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,S1,LRTA,1,B,1,C)) Q:C<1  W ?13,^(C,0),! D NP Q:LRABORT
 Q
 ;
 ;
VIR ;
 ; from LRMIPSZ1
 ; also called from RPT^LROR4
 N LRBLDTMP,LRQUIT
 S (LRQUIT,LRBLDTMP)=0
 I '$D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT)) D  ;
 . S LRBLDTMP=1
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)=^LR(LRDFN,"MI",LRIDT)
 . K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,32)
 ;
 I $P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,16),U)="",'$G(LRLABKY) D  S:'$D(LRWRDVEW) LRQUIT=1 S:LRSB'=16 LRQUIT=1
 . Q:'$D(^XTMP("LRMICRO EDIT",LRDFN,LRIDT,16))
 . ;LR*5.2*547: Display informational message if accession/test is currently being edited
 . ;            and results had previously been verified.
 . N LR7SB S LR7SB=16
 . D MES^LRMIPSZ2
 ;
 I LRQUIT D  Q
 . I LRBLDTMP K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)
 ;
 S LRTUS=$P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,16),U,2)
 S DZ=$P(^(16),U,3),Y=$P(^(16),U)
 D D^LRU
 I LRHC W ! D NP Q:LRABORT
 W !,"* VIROLOGY ",$S(LRTUS="F":"FINAL",LRTUS="P":"PRELIMINARY",1:"")," REPORT => ",Y,"   TECH CODE: ",DZ
 D NP Q:LRABORT
 S LRPRE=20
 D PRE^LRMIPSU
 S LRPAR=0
 F  S LRPAR=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,17,LRPAR)) Q:LRPAR<1  D  Q:LRABORT  ;
 . I LRHC W !
 . D NP Q:LRABORT
 . W !,"Virus: ",$P(^LAB(61.2,$P(^(LRPAR,0),U),0),U)
 . S LRBUG(LRPAR)=^TMP("LRMI",$J,LRDFN,"MI",LRIDT,17,LRPAR,0)
 ;
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,18)) D  ;
 . W:LRHC !
 . D NP Q:LRABORT
 . W !,"Virology Remark(s):"
 . D NP Q:LRABORT
 . S LRPAR=0
 . F  S LRPAR=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,18,LRPAR)) Q:LRPAR<1  W !,?3,^(LRPAR,0) D NP Q:LRABORT  ;
 ;
 I LRBLDTMP D  ;
 . K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)
 Q
 ;
 ;
NP ;
 ; Convenience method
 D NP^LRMIPSZ1
 Q
