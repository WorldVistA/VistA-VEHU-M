SDMUTL ;RGI/CBR - UI UTILS; 10/19/2012
 ;;5.3;scheduling;**260003**;08/13/93;Build 8
SELECT(ROUTINE,PRMPT,FILE,FLDS,FLDOR,HLP1,HLP2,ROU1) ;
 N LNAME,Y,RETURN,R1,R2,R3,EXS,L
 S R1=ROUTINE_"(.LSTS)"
 S:$D(ROU1) R3=ROU1_"(.EXS)"
 S L="L",R2=ROUTINE_"(.LSTS,.X)"
LS ;
 S Y=-1
 W !,PRMPT R X:$S($D(DTIME):DTIME,1:300) I "^"[X!($G(X)="") S Y=-1 Q "^"
 I X="?" D
 . D @R1
 . I $$LSTSH1(.LSTS,FILE,.FIELDS)  D
 . . I $L($G(R3))>0 D @R3 D PRINTALL(.EXS,0)
 . . D:$L(L)>0&($G(HLP1(0))'="") @HLP1(0)
 . . D PRINTALL(.LSTS,1,.FLDOR)
 . D:$L(L)>0&($G(HLP1)'="") @HLP1
 I X?1"??".E D
 . I X="??"  D
 . . I $L($G(R3))>0 D @R3 D PRINTALL(.EXS,0)
 . . D:$L(L)>0&($G(HLP2(0))'="") @HLP2(0)
 . . D @R1 D PRINTALL(.LSTS,1,.FLDOR) D:$L(L)>0&($G(HLP2)'="") @HLP2
 E  D:X'="?"
 . D @R2
 . S Y=$$SELLST(.LSTS,.X,.FLDOR)
 G:Y<0 LS I Y=0,$L(L)'>0 W " ??",! G LS
 I Y=0 D
 . I $L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E) W " ??",! G LS
 S:Y<0 Y(1)=Y,Y="^"
 Q Y
 ;
SELLST(LSTS,X,FLDOR) ;
 N CNT,Y,MAXP,CLINE,SEL,OUT,RE
 I $D(LSTS)=0 Q -1
 S CNT=$P(LSTS(0),U,1)
 Q:CNT=0 0
 I CNT=1 W $E(LSTS(1,"NAME"),$L(X)+1,$L(LSTS(1,"NAME"))) Q LSTS(1,"ID")_U_LSTS(1,"NAME")
 S MAXP=5,CLINE=1,SEL=0,OUT=0,RE=0
 F IND=1:1:CNT  D  Q:OUT
 . S CLINE=CLINE+1,STR=""
 . I $D(FLDOR) S STR="   "_IND F FIND=1:1 S FLD=$P(FLDOR,U,FIND) Q:'$L(FLD)  S STR=STR_"   "_LSTS(IND,FLD)
 . E  S STR=$C(9)_IND_$C(9)_LSTS(IND,"NAME")
 . W !,STR
 . I CLINE>MAXP D
 . . W !,"Press <RETURN> to see more, '^' to exit this list, OR"
 . I CLINE>MAXP!(IND=CNT) D
 . . S RE=1
 . . W !,"CHOOSE 1-"_IND_": " R SEL:$S($D(DTIME):DTIME,1:300) S:'$T OUT=1 Q
 . I RE D  Q
 . . S RE=0
 . . I SEL="^" S OUT=1 Q
 . . I $G(SEL)="" S CLINE=1 Q
 . . I $G(SEL)>IND S SEL=0,OUT=1 Q
 . . E  S OUT=1 Q
 Q:SEL>0 LSTS(SEL,"ID")_U_LSTS(SEL,"NAME") Q -1
 ;
PRINTALL(LSTS,CHOOSE,FLDOR) ;
 N IND,CNT,GMPQUIT,LINE,STR,FLD,FIND
 S GMPQUIT=0,LINE=1
 I $D(LSTS)=0 Q
 S CNT=$P(LSTS(0),U,1) Q:CNT=0
 W:$G(CHOOSE) !,"   Choose from:"
 F IND=1:1:CNT D
 . S LINE=LINE+1,STR=""
 . I $D(FLDOR) F FIND=1:1 S FLD=$P(FLDOR,U,FIND) Q:'$L(FLD)  S STR=STR_"   "_LSTS(IND,FLD)
 . E  S STR="   "_LSTS(IND,"NAME")
 . W !,STR
 . I LINE>(IOSL-4) S LINE=1 S:'$$CONTINUE GMPQUIT=1 Q:$D(GMPQUIT)  Q
 W !
 Q
 ;
CONTINUE() ; -- end of page prompt
 N DIR,X,Y
 S DIR(0)="E",DIR("A")=$C(9)_"'^' TO STOP"
 D ^DIR
 Q +Y
 ;
LSTSH1(LSTS,FILE,FIELDS) ; All items ??
 N DIR,X,Y,CNT
 S CNT=$P(LSTS(0),U,1) Q:CNT=0 1
 W !," Answer with "_FILE_" "_$G(FIELDS)
 Q:CNT<(IOSL-4) 1
 S:CNT>(IOSL-4) DIR("A")=" Do you want the entire "_CNT_"-Entry "_FILE_" List"
 S DIR(0)="YO"
 D ^DIR Q Y
 ;
SELSLST(LST,SLST,NAME,ALL) ; Select from list
 N SCNT,HLP S SCNT=0 K SLST
 D FIRST
 Q
 ;
SELL(LST,X) ;
 N I,Y S Y=-1
 F I=0:0 S I=$O(LST(I)) Q:I=""!(Y>0)  D
 . I X?.N,I=+X,$D(LST(+X)) W LST(+X,"NAME") S %=$$ASK() Q:%'>0  S Y=+X Q
 . I $E(LST(I,"NAME"),1,$L(X))[X S Y=I
 Q Y
 ;
FIRST S HLP="Select "_NAME_": "
REDO ;
 W !,HLP W:'$D(ALL) "ALL// "
 R X:DTIME
 G ERR:(X="^")!'$T D:X["?" QQ
 I X="" G:$D(ALL) ERR M SLST=LST G CQUIT
 S HLP="Select another "_NAME_": "
 S Y=$$SELL(.LST,X) G:Y'>0 FIRST D SET(.LST,.SLST,Y)
 S ERR=0
 F VAI=1:0:19 Q:ERR>0  D
 . W !,HLP R X:DTIME
 . G ERR:(X="^")!'$T K Y S:X=""!((X="^")) ERR=1 Q:X=""
 . D QQ:X["?" N VAUTX S:$E(X)="-" VAUTX=X,X=$E(VAUTX,2,999)
 . S Y=$$SELL(.LST,X) I Y>0 D SET(.LST,.SLST,Y) G REDO
 . S VAI=VAI+1
 G CQUIT
SET(LST,SLST,IDX) ;
 N ERR,IDXS
 S ERR=0
 F IDXS=0:0 S IDXS=$O(SLST(IDXS)) Q:IDXS=""  D
 . I SLST(IDXS,"ID")=LST(IDX,"ID") S ERR=1
 I ERR W !?3,*7,"You have already selected that ",NAME,".  Try again." Q
 S SCNT=SCNT+1
 M SLST(SCNT)=LST(IDX)
 Q
QQ W !,"ENTER:" W:'$D(ALL) !?5,"- Return for all ",NAME,"s, or" W !?5,"- A ",NAME," and return when all ",NAME,"s have been selected--limit 20"
 W !?5,"Imprecise selections will yield an additional prompt."
 W !?5,"(e.g. When a user enters 'A', all items beginning with 'A' are displayed.)"
 I $O(SLST(0))]"" W !?5,"- An entry preceeded by a minus [-] sign to remove entry from list."
 I $O(SLST(0))]"" W !,"NOTE, you have already selected:" S VAJ=0 F VAJ1=0:0 S VAJ=$O(SLST(VAJ)) Q:VAJ=""  W !?8,VAJ,*9,SLST(VAJ,"NAME")
 W ! W:X="?" ?4,"Answer with ENROLLMENT CLINIC, or NUMBER"
 W !?3,*7,"Choose from:"
 F IDX=0:0 S IDX=$O(LST(IDX)) Q:IDX=""  D
 . W !?3,IDX,*9,LST(IDX,"NAME")
 Q
ASK() ;
 S %=1 W !,"   ...OK" D YN^DICN I %=0 W "   Answer with 'Yes' or 'No'"
 Q %
 ;
ERR S Y=-1
CQUIT K DIC,J,VAERR,VAI,VAJ,VAJ1,VAX,VAUTNALL,VAUTNI,NAME,VAUTVB,X
 Q
FLDNAME(FLDS,NAMES,FLD)    ; Returns field name for display
 N NAME,I,J,S
 S J=0,NAME="",S=";"
 F I=1:1:$L(FLDS,S) I +$P(FLDS,S,I)=+FLD S J=I Q
 G:J'>0 FNQ
 S NAME=$P(NAMES,S,J)
FNQ Q NAME
 ;
READ(TYPE,PROMPT,DEFAULT,HELP) ; Calls reader, returns response
 N DIR,DA,X,Y
 S DIR(0)=TYPE,DIR("A")=PROMPT I $D(DEFAULT) S DIR("B")=DEFAULT
 I $D(HELP) S DIR("?")=HELP
 D ^DIR
 Q Y
 ;
SELPAT(PRMT) ; Select patient
 N ROU,PRMPT,FILE,FLDOR,Y
 S ROU="LSTPATS^SDMLST",PRMPT="Select "_$S($D(PRMT):PRMT,1:"PATIENT NAME")_": "
 S FILE="PATIENT"
 S FIELDS=" NAME, or SOCIAL SECURITY NUMBER, or last 4 digits"_$C(10,13)
 S FIELDS=FIELDS_"   of SOCIAL SECURITY NUMBER, or first initial of last name with last"_$C(10,13)
 S FIELDS=FIELDS_"   4 digits of SOCIAL SECURITY NUMBER"
 S FLDOR="NAME^BIRTHDATE^SSN^VETERAN^TYPE"
 S Y=$$SELECT^SDMUTL(ROU,PRMPT,FILE,FIELDS,FLDOR)
 Q $S(Y="^":-1,1:Y)
 ;
SELCLN(PRMT) ; Select clinic
 S ROU="LSTCLNS^SDMLST",PRMPT="Select "_$S($D(PRMT):PRMT,1:"CLINIC")_": "
 S FILE="HOSPITAL LOCATION",FIELDS="NAME, or ABBREVIATION, or TEAM"
 S Y=$$SELECT^SDMUTL(ROU,PRMPT,FILE,FIELDS)
 Q $S(Y="^":-1,1:Y)
 ;
