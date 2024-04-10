YTQRCDB3 ;BAL/KTL - MHA CLOUD DATABASE REPORT/NOTE RPC CALLS; 1/25/2017
 ;;5.01;MENTAL HEALTH;**239**;Dec 30, 1994;Build 16
 ;
 ;
 Q
SETNOTE(ARGS,DATA) ; save note in DATA("text") using ARGS("adminId")
 ;Expects DATA to be in the format returned from BLDRPT^YTQRRPT
 ;All instrument progress notes should be in DATA("text"), even for multiple instrument assignments
 N YS,YSDATA,ADMIN,CONSULT,WRP,ASGN,LSTASGN,PNOT,AGPROG
 S ADMIN=$G(DATA("adminId"))
 S ASGN=$G(DATA("assignmentId"))
 I ADMIN="" D SETERROR^YTQRUTL(404,"Admin not sent: "_ADMIN) QUIT ""
 I '$D(^YTT(601.84,ADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_ADMIN) QUIT ""
 S CONSULT=$P(^YTT(601.84,ADMIN,0),U,15)
 S PNOT=0
 I '$D(^YTT(601.84,ADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_ADMIN) QUIT ""
 D TXT2LN(.DATA,.YS) ; parse by CRLF and set YS(#) to note text
 D WRAP(.YS,79)  ;reformat lines to 79 max chars
 S YS("AD")=ADMIN
 I $G(DATA("cosigner"))]"" S YS("COSIGNER")=DATA("cosigner")
 I CONSULT S YS("CON")=CONSULT D CCREATE^YTQCONS(.YSDATA,.YS) I 1
 E  D PCREATE^YTQTIU(.YSDATA,.YS)
 I YSDATA(1)'="[DATA]" D SETERROR^YTQRUTL(500,"Note not saved") Q ""
 Q "/api/mha/instrument/note/"_$G(YSDATA(2))
 ;
TXT2LN(SRC,DEST) ; Move CRLF delimited text from .SRC into WP lines in .DEST
 N IDEST,CRLF,REMAIN
 S IDEST=0,CRLF=$C(10)
 S REMAIN=$$PARSLN(SRC("text"))
 I '$D(SRC("text","\",1)),$L(REMAIN) D  QUIT  ; done since no continue nodes
 . S IDEST=IDEST+1,DEST(IDEST)=REMAIN
 N J                                          ; handle continue nodes
 S J=0 F  S J=$O(SRC("text","\",J)) Q:'J  D
 . S REMAIN=$$PARSLN(REMAIN_SRC("text","\",J))
 I $L(REMAIN) S IDEST=IDEST+1,DEST(IDEST)=REMAIN
 Q
PARSLN(TXT) ; Return remainder after parsing text into lines
 ; expects: CRLF, DEST, IDEST
 N X S X=TXT
 I '$L(X) Q ""
 ; Break lines by CRLF. Depending on source line delim could be $c(13) or $c(13,10). CRLF=$c(10) so $TR $c(13) in case it is embedded
 F  S IDEST=IDEST+1,DEST(IDEST)=$P(X,CRLF),X=$P(X,CRLF,2,99999),DEST(IDEST)=$TR(DEST(IDEST),$C(13)) Q:X'[CRLF
 Q $TR(X,$C(13))
WRAP(OUT,MAX) ; Wrap text by space piece word MAX char width
 N TMP,STR,II,JJ,PCE,CNT
 I +$G(MAX)=0 S MAX=79
 M TMP=OUT Q:'$D(TMP)
 K OUT
 S (CNT,II)=0 F  S II=$O(TMP(II)) Q:II=""  D
 . S STR="" F JJ=1:1:$L(TMP(II)," ") D
 .. S PCE=$P(TMP(II)," ",JJ)
 .. I $L(STR_PCE_" ")>MAX D  Q
 ... S CNT=CNT+1,OUT(CNT)=$E(STR,1,$L(STR)-1),STR=PCE_" "
 .. S STR=STR_PCE_" "
 . I STR]"" S CNT=CNT+1,OUT(CNT)=$E(STR,1,$L(STR)-1)
 Q
 ;
