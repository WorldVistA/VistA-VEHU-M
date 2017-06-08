XTMRPAR1 ;jli/oifo-oak - list tags, find variables that aren't arguments or newed ;06/08/08  15:18
 ;;7.3;TOOLKIT;**101**;Apr 25, 1995;Build 10
 D EN^XTMUNIT("ZZUTXTM1") ; RUN UNIT TESTS
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ; CHEKTAGS(ROUNAME)
 ; list variables in routine ROUNAME which are not arguments or newed by code following a tag
 ; this analyzes only code between a tag and a final quit or go following the tag.
 ;
 ; GLOBAL is optional, and if present should be a closed global reference in which the
 ; text of the results will be returned. added 04/29/04
CHEKTAGS(ROUNAME,GLOBAL) ;
 N XALL,XTAGS,CNT,I,WORD,TCNT,GLOBREF,L
 S GLOBREF=$NA(^TMP("XTMRPAR1",$J)) K @GLOBREF
 S XALL=$NA(^TMP("XTMRXALL",$J)) K @XALL
 S XTAGS=$NA(^TMP("XTMRXTAGS",$J)) K @XTAGS
 D EN(ROUNAME,XALL)
 D GETTAGS(XALL,XTAGS)
 D XTAGS(XALL,XTAGS)
 S (TCNT,L)=0
 F I=1:1 Q:'$D(@XTAGS@(I))  I $D(@XTAGS@(I,"WRDS")) S L=L+1,@GLOBREF@(L)=@XTAGS@(I,"NAME")_":  " S CNT=0,WORD="" F  S WORD=$O(@XTAGS@(I,"WRDS",WORD)) Q:WORD=""  S CNT=CNT+1,TCNT=TCNT+1 S @GLOBREF@(L)=@GLOBREF@(L)_$S(CNT>1:",",1:"")_WORD
 I TCNT=0 S @GLOBREF@(1)="no tags with variables to list"
 I $G(GLOBAL)="" F I=0:0 S I=$O(@GLOBREF@(I)) Q:I=""  W !,@GLOBREF@(I)
 E  M @GLOBAL=@GLOBREF
 K @GLOBREF,@XALL,@XTAGS
 Q
 ;
LISTTAGS(ROUNAME,LOC) ; generates a list of tags in a routine, argument list if any, and if indicated SR or OPT
 N I,NAME
 S LOC=$G(LOC,"TAGS")
 I $D(ROUNAME)=1 W !!,ROUNAME,":" D EN(ROUNAME,LOC),LISTTAG1(ROUNAME,LOC) I 1
 E  S I="" F  S I=$O(ROUNAME(I)) Q:I=""  S NAME=$S(ROUNAME(I)="":I,1:ROUNAME(I)) W !!,NAME,":" D EN(NAME,LOC),LISTTAG1(NAME,LOC)
 Q
 ;
LISTTAG1(ROUNAME,LOC) ;
 N I,J,JC,K,X
 F I=0:0 S I=$O(@LOC@(I)) Q:I'>0  I $D(@LOC@(I,0,"TAG")) D
 . W !,@LOC@(I,0,"TAG") S JC=0
 . F J=0:0 S J=$O(@LOC@(I,0,"TAG","ARG",J)) W:(J'>0)&(JC>0) ")" Q:J'>0  D
 . . S JC=JC+1 W $S(JC=1:"(",1:","),@LOC@(I,0,"TAG","ARG",J)
 . . Q
 . F K=0:0 S K=$O(@LOC@(I,K)) Q:K'>0  S X=$G(@LOC@(I,K,"COMMENT")) I X'="" W:X["SR" "     SR" W:X["OPT" "    OPT" Q
 . Q
 Q
 ;
SHOWTAG(TAG,ROUNAME) ; lists parsed values for code for a specified tag.  May be run as D SHOWTAG("TAG","ROUTINE") or D SHOWTAG("TAG^ROUTINE")
 N XALL,XTAGS,I,START,END,XEND,XX
 S ROUNAME=$G(ROUNAME) I ROUNAME="" S ROUNAME=$P(TAG,U,2) I ROUNAME="" W !,"Need routine name.  D SHOWTAG^XTMRTEST(tag,rouname)" Q
 S TAG=$P(TAG,U)
 D EN(ROUNAME,"XALL")
 D GETTAGS("XALL","XTAGS")
 F I=1:1 Q:'$D(XTAGS(I))  I XTAGS(I,"NAME")=TAG S START=XTAGS(I),END=$G(XTAGS(I,"Q")) Q
 S XX="XALL("_START_")",XEND=$S(END>0:"XALL("_(END+1),1:"XALL(")
 F  S XX=$Q(@XX) Q:(END>0)&(XX[XEND)  Q:(END="")&(XX'[XEND)  W !,"LINE "_$E(XX,6,999)_" = "_@XX
 Q
 ;
 ; EN(ROUNAME,LOC)
 ; generates parsed structure for routine ROUNAME under the closed argument specified by LOC
 ;  (which may be local or global)
EN(ROUNAME,LOC) ;
 N GLOB,CNT,IVAL
 S GLOB=$NA(^TMP($J,0))
 D LOAD(ROUNAME,GLOB)
 S CNT=0,LOC=$G(LOC,"PARSLINE") K @LOC
 F IVAL=0:0 S IVAL=$O(@GLOB@(IVAL)) Q:IVAL'>0  S CNT=CNT+1 D PARSLINE(^(IVAL,0),CNT,LOC)
 Q
 ;
 ; XTAGS(LOC,TAGLOC)
 ; code that checks for variables that are not NEWed or arguments,
 ; LOC is the closed root under which the routine was parsed,
 ; TAGLOC is the closed root under which the tags were identified by GETTAGS
 ; Variables which are identified are returned under the location specified by TAGLOC
 ;    in @TAGLOC@(tagnum,"WRDS",variableid)=""
XTAGS(LOC,TAGLOC) ;
 N I,J,K,L,START,END,CMDTYPE,TERM,TYPE,VALUE,WORD,ARGVAL,EXCLUDES
 ; exclude basic kernel variables
 S EXCLUDES("DUZ")="",EXCLUDES("DT")="",EXCLUDES("U")="",EXCLUDES("IO")=""
 F I=0:0 S I=$O(@TAGLOC@(I)) Q:I'>0  D
 . N ARGS,NEWVAL,WORDS,EXCEPT
 . S START=@TAGLOC@(I),END=$G(@TAGLOC@(I,"Q"))
 . F J=START:1:END D
 . . D EXCEPT(START,END,LOC,"EXCEPT")
 . . I $D(@LOC@(J,0,"TAG")) F K=0:0 S K=$O(@LOC@(J,0,"TAG","ARG",K)) Q:K'>0  S ARGVAL=@LOC@(J,0,"TAG","ARG",K) I ARGVAL'="" S ARGS(ARGVAL)=""
 . . F K=0:0 S K=$O(@LOC@(J,K)) Q:K'>0  D
 . . . S CMDTYPE=$G(@LOC@(J,K,"CMD"))
 . . . I CMDTYPE="NEW" D  Q
 . . . . F L=0:0 S L=$O(@LOC@(J,K,"CMD","ARG",L)) Q:L'>0  S ARGVAL=@LOC@(J,K,"CMD","ARG",L) I ARGVAL'="" S NEWVAL(ARGVAL)=""
 . . . I (CMDTYPE="GO")!(CMDTYPE="DO") D  Q
 . . . . F L=0:0 S L=$O(@LOC@(J,K,"CMD","ARG",L)) Q:L'>0  S VALUE=@LOC@(J,K,"CMD","ARG",L) D
 . . . . . ; handle indirection
 . . . . . I $E(VALUE)="@" S VALUE=$E(VALUE,2,999) D  Q
 . . . . . . F  Q:VALUE=""  S VALUE=$$GETWORD(VALUE,.WORD,.TERM,.TYPE) I TYPE="WORD" S WORDS(WORD)=""
 . . . . . . Q
 . . . . . ; look for arguments inside parentheses
 . . . . . S VALUE=$P(VALUE,"(",2) D  Q
 . . . . . . F  Q:VALUE=""  S VALUE=$$GETWORD(VALUE,.WORD,.TERM,.TYPE) I TYPE="WORD" S WORDS(WORD)=""
 . . . . . . Q
 . . . . . Q
 . . . . Q
 . . . F L=0:0 S L=$O(@LOC@(J,K,"CMD","ARG",L)) Q:L'>0  S VALUE=@LOC@(J,K,"CMD","ARG",L) I VALUE'["$T(",VALUE'["$TEXT(" D  ; modified 4/30/06 to handle $TEXT
 . . . . F  Q:VALUE=""  S VALUE=$$GETWORD(VALUE,.WORD,.TERM,.TYPE) I TYPE="WORD" S WORDS(WORD)=""
 . . . . Q
 . . . Q
 . . S VALUE="" F  S VALUE=$O(NEWVAL(VALUE)) Q:VALUE=""  K WORDS(VALUE)
 . . S VALUE="" F  S VALUE=$O(ARGS(VALUE)) Q:VALUE=""  K WORDS(VALUE)
 . . S VALUE="" F  S VALUE=$O(EXCLUDES(VALUE)) Q:VALUE=""  K WORDS(VALUE)
 . . S VALUE="" F  S VALUE=$O(EXCEPT(VALUE)) Q:VALUE=""  K WORDS(VALUE)
 . . M @TAGLOC@(I,"WRDS")=WORDS
 . . Q
 . Q
 Q
 ;
GETWORD(LINE,WORD,TERM,TYPE) ;
 N X,START
 S WORD="",TYPE="NONE"
 S TERM=$E(LINE),LINE=$E(LINE,2,999) I $$ISWORD1(TERM) S WORD=WORD_TERM D  Q LINE
 . S TYPE="WORD"
 . F  S:LINE="" TERM="" Q:LINE=""  S TERM=$E(LINE),LINE=$E(LINE,2,999) S X=$$ISWORD(TERM) S:X WORD=WORD_TERM I 'X Q
 . Q
 I TERM="""" S WORD=TERM,LINE=$$GETQUOTE(LINE,.WORD,.TERM),TYPE="STRING" Q LINE
 ;
 I ((TERM=".")&$$ISNUM($E(LINE)))!$$ISNUM(TERM) S WORD=TERM,TYPE="NUMBER" D  Q LINE
 . F  S:LINE="" TERM="" Q:LINE=""  S TERM=$E(LINE),LINE=$E(LINE,2,999) S X=$$ISNUM1(TERM) S:X WORD=WORD_TERM I 'X Q
 . Q
 I TERM="$" S WORD=TERM,TYPE="FUNCTION" S:$E(LINE)="$" WORD="$$",LINE=$E(LINE,2,999) D  Q LINE
 . S START=1 F  S:LINE="" TERM="" Q:LINE=""  S TERM=$E(LINE),LINE=$E(LINE,2,999) S X=(START&$$ISWORD1(TERM))!$$ISWORD(TERM)!(TERM="^"),START=0 S:X WORD=WORD_TERM S:TERM="^" START=1 I 'X Q
 . Q
 I TERM="^",$$ISWORD1($E(LINE)) S WORD=TERM_$E(LINE),LINE=$E(LINE,2,999),TYPE="GLOBAL" D  Q LINE
 . F  S:LINE="" TERM="" Q:LINE=""  S TERM=$E(LINE),LINE=$E(LINE,2,999) S X=$$ISWORD(TERM) S:X WORD=WORD_TERM I 'X Q
 . Q
 Q LINE
 ;
ISWORD1(CHAR) ; first letter of variable, etc must be alpha or %
 I "%ABCDEFGHIJKLMNOPQRSTUVWXYZ"[$$UP^XLFSTR(CHAR) Q 1
 Q 0
 ;
ISWORD(CHAR) ; other chars of variable, etc must be alpha or numeric
 I "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"[$$UP^XLFSTR(CHAR) Q 1
 Q 0
 ;
ISNUM(CHAR) ;  need to add in proper handling of decimal point.
 I "0123456789"[CHAR Q 1
 Q 0
 ;
ISNUM1(CHAR) ;
 I (CHAR=".")!$$ISNUM(CHAR) Q 1
 Q 0
 ;
PARSLINE(LINE,LINENUM,LOC) ;
 N ARGNUM,INDNTCNT S ARGNUM=0,INDNTCNT=0
 I $E(LINE,1)'=" " S LINE=$$SETTAG(LINE,LINENUM,LOC)
 F  Q:($E(LINE,1)'=" ")&($E(LINE,1)'=".")  S:$E(LINE,1)=" " LINE=$E(LINE,2,999) I $E(LINE,1)="." S LINE=$E(LINE,2,999),INDNTCNT=INDNTCNT+1,@LOC@(LINENUM,0,"INDENT")=INDNTCNT
 F  Q:LINE=""  S LINE=$$GETCMD(LINE,LINENUM,.ARGNUM,LOC)
 Q
 ;
GETPAREN(LINE,VALUE,TERM) ;
 Q $$GETPAREN^XTMRPAR2(LINE,.VALUE,.TERM)
 ;
GETARGS(LINE,LOCSTOR,SUBSCRPT) ;
 Q $$GETARGS^XTMRPAR2(LINE,LOCSTOR,$G(SUBSCRPT))
 ;
ARGLIST(LINE,ARGVALUE,TERM) ;
 Q $$ARGLIST^XTMRPAR2(LINE,.ARGVALUE,.TERM)
 ;
GETCMD(LINE,LINENUM,ARGNUM,LOCSTOR) ;
 Q $$GETCMD^XTMRPAR2(LINE,LINENUM,.ARGNUM,LOCSTOR)
 ;
GETTAGS(LOC,TAGLOC) ;
 D GETTAGS^XTMRPAR2(LOC,TAGLOC)
 Q
 ;
LOAD(ROU,GLOB) ;
 D LOAD^XTMRPAR2(ROU,GLOB)
 Q
 ;
SETTAG(LINE,LINENUM,STORLOC) ;
 Q $$SETTAG^XTMRPAR2(LINE,LINENUM,STORLOC)
 ;
EXCEPT(STRTLINE,ENDLINE,LOC,TAGLOC) ;
 N I,J,K,LINE,WORD,TERM,XXX
 F I=STRTLINE:1:ENDLINE F J=1:1 Q:'$D(@LOC@(I,J))  S LINE=$G(@LOC@(I,J,"COMMENT")) I LINE["ZEXCEPT:" D
 . S LINE=$P(LINE,"ZEXCEPT:",2) F  Q:LINE=""  Q:$E(LINE)'=" "  S LINE=$E(LINE,2,999)
 . S LINE=$$GETARGS(LINE,"XXX") F K=0:0 S K=$O(XXX("ARG",K)) Q:K'>0  S @TAGLOC@(XXX("ARG",K))=""
 . Q
 Q
 ;
MARKERR(TEXT) ;
 D MARKERR^XTMRPAR2(TEXT)
 Q
 ;
NEXTTOKN(LINE,TOKEN,TERM,TERMCHRS) ;
 Q $$NEXTTOKN^XTMRPAR2(LINE,.TOKEN,.TERM,$G(TERMCHRS))
 ;
GETQUOTE(LINE,TOKEN,TERM) ;
 Q $$GETQUOTE^XTMRPAR2(LINE,.TOKEN,.TERM)
 ;
 ;
