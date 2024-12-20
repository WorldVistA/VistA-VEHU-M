ORACCES3 ;SLC/JNM - User Read/Write Access to CPRS ;Mar 03, 2023@13:11:21
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**588**;Dec 17, 1997;Build 29
 ;
 Q
 ;
DISPLAY(USER,CARRAY,DIV,NOPRINT,DSPLVL,DSPNAME) ;
 N ARRAY,ORPARAM,ORTABS,TABS,OTHER,ORDERS,ERROR,DARRAY,LVL
 N PNAME,L,MAX,SPACES,INDENTSIZE,INSTANCE,INSTNAME,PARAM,TYPE,X,LEN
 N TXT,TYPETXT,VALUETXT,TXTLEN,FIRST,ILVL,BUMP,NUMSPACES,DASHES
 N VMODE,MAXLEN,TXT2,DONE,SINGLE,BLANKLINE
 S USER=+$G(USER),DIV=+$G(DIV),NOPRINT=+$G(NOPRINT)
 S DSPLVL=$G(DSPLVL),DSPNAME=$G(DSPNAME)
 S SINGLE=$S((USER>0)!(DIV>0)!(DSPLVL>0):1,1:0)
 I SINGLE,(DSPLVL<1)!(DSPNAME="") D
 . I USER S DSPLVL=4,DSPNAME=$$GET1^DIQ(200,USER_",",.01)
 . I DIV S DSPLVL=3,DSPNAME=$$GET1^DIQ(4,DIV_",",.01)
 D GETPARAMS^ORACCESS(1)
 I 'NOPRINT D
 . S LVL(1,1)="Package",LVL(1,2)=LVL(1,1)
 . S LVL(2,1)="System",LVL(2,2)=LVL(2,1)_"s"
 . S LVL(3,1)="Division",LVL(3,2)=LVL(3,1)
 . S LVL(4,1)="User",LVL(4,2)=LVL(4,1)_"s"
 . S PNAME(1)="CPRS Write Access Error Message"
 . S PNAME(2)="CPRS Tabs Write Access"
 . S PNAME(3)="CPRS Other Action Write Access"
 . S PNAME(4)="CPRS Orders Tab Write Access"
 . S MAX=78,SPACES=" ",NUMSPACES=$L(SPACES),INDENTSIZE=3
 . S (ILVL,BUMP,VMODE,BLANKLINE)=0
 . S DASHES="" F X=1:1:(MAX\2)+1 S DASHES=DASHES_"-"
 . S TYPETXT="Type",VALUETXT="Value",TXTLEN=$L(TYPETXT)+$L(VALUETXT)
 I 'USER D
 . D DATA^ORACCESS(.ARRAY,ERROR,USER,DIV),DSPMERGE(1)
 . K ARRAY
 D DATA^ORACCESS(.ARRAY,TABS,USER,DIV),DSPMERGE(2)
 I USER>0 M CARRAY(1)=ARRAY
 K ARRAY
 D DATA^ORACCESS(.ARRAY,OTHER,USER,DIV),DSPMERGE(3)
 I USER>0 M CARRAY(2)=ARRAY
 K ARRAY
 D DATA^ORACCESS(.ARRAY,ORDERS,USER,DIV),DSPMERGE(4)
 I USER>0 M CARRAY(3)=ARRAY
 Q:NOPRINT
 W !,$$CJ^XLFSTR("CPRS WRITE ACCESS DISPLAY SETTINGS",MAX)
 I SINGLE,$D(DARRAY)=0 D  Q
 . I ('DSPLVL)!(DSPNAME="") Q
 . S (ILVL,BUMP,VMODE)=0,TXT=LVL(DSPLVL,1)_": "_DSPNAME
 . D TXTLINE(TXT)
 . W !,?INDENTSIZE,"No Write Access Settings Defined."
 . D TXTLINE("")
 S L=0 F  S L=$O(LVL(L)) Q:'L  D
 . I +DSPLVL,L'=DSPLVL Q
 . S (ILVL,BUMP,VMODE)=0
 . D DOBLANKLINE
 . I $D(DARRAY(L))=0 D  Q
 . . I L<3 D  I 1
 . . . D GETINST^ORACCESS(L,"",.TXT)
 . . . S TXT=LVL(L,1)_": "_TXT_" Level Settings"
 . . . D TXTLINE(TXT)
 . . . W !,?INDENTSIZE,"No Write Access Settings Defined."
 . . E  D
 . . . I 'SINGLE S TXT=LVL(L,1)_" Level Settings"
 . . . D TXTLINE(TXT)
 . . . W !,?INDENTSIZE,"No "_LVL(L,1)_"s have Write Access Settings Defined."
 . . S BLANKLINE=1
 . S INSTANCE="",FIRST=1
 . F  S INSTANCE=$O(DARRAY(L,INSTANCE)) Q:INSTANCE=""  D
 . . S (ILVL,BUMP)=0,INSTNAME=$P(INSTANCE,U)
 . . D DOBLANKLINE
 . . I FIRST D  I 1
 . . . S TXT=LVL(L,1)
 . . . I (L<3)!SINGLE S TXT=TXT_": "_INSTNAME
 . . . S TXT=TXT_" Level Settings",FIRST=0
 . . . D TXTLINE(TXT)
 . . I (L>2)&('SINGLE) D
 . . . S TXT=LVL(L,1)_": "_INSTNAME,BUMP=1
 . . . D TXTLINE(TXT)
 . . S PARAM=0 F  S PARAM=$O(PNAME(PARAM)) Q:'PARAM  D
 . . . S ILVL=1
 . . . I USER,PARAM=1 Q
 . . . I $D(DARRAY(L,INSTANCE,PARAM))=0,'SINGLE Q
 . . . D DOBLANKLINE
 . . . D TXTLINE(PNAME(PARAM))
 . . . S ILVL=2
 . . . I PARAM=1 S TXT=-1
 . . . E  S TXT=TYPETXT,VMODE=1
 . . . D DSPVALUE(TXT,VALUETXT),TXTLINE("")
 . . . S MAXLEN=MAX-($$INDENT*2),BLANKLINE=1
 . . . S TYPE="" F  S TYPE=$O(DARRAY(L,INSTANCE,PARAM,TYPE)) Q:TYPE=""  D
 . . . . S TXT=DARRAY(L,INSTANCE,PARAM,TYPE)
 . . . . I PARAM=1 D  I 1
 . . . . . K TXT2 D WRAP^ORUTL(TXT,"TXT2",1,1,2,,MAXLEN)
 . . . . . F X=1:1:TXT2 D DSPVALUE(-1,TXT2(X))
 . . . . E  D DSPVALUE(TYPE," "_TXT)
 . . . S VMODE=0
 S (ILVL,BUMP,VMODE)=0 D TXTLINE("")
 Q
 ;
DSPMERGE(SORT) ;
 Q:NOPRINT
 N L,INSTANCE,SORTIDX
 S L=0 F  S L=$O(LVL(L)) Q:'L  D
 . I DSPLVL>0,L'=DSPLVL Q
 . S INSTANCE="" F  S INSTANCE=$O(ARRAY(LVL(L,2),INSTANCE)) Q:INSTANCE=""  D
 . . I L<4 S SORTIDX=INSTANCE
 . . E  S SORTIDX=$P($G(^VA(200,+INSTANCE,0)),U)_U_INSTANCE
 . . M DARRAY(L,SORTIDX,SORT)=ARRAY(LVL(L,2),INSTANCE)
 Q
 ;
INDENT() ;
 I VMODE Q 20
 Q INDENTSIZE*(ILVL+BUMP)
 ;
TXTLINE(TXT) ;
 N LEN,D1,D2,X,STR,IND,IND2,S1,S2
 S IND=$$INDENT,IND2=IND*2
 S LEN=$L(TXT),D1=(MAX-LEN-IND2)\2,D2=MAX-LEN-IND2-D1
 I LEN>0 S D1=D1-NUMSPACES,D2=D2-NUMSPACES
 S STR=""_$E(DASHES,1,D1)
 I LEN>0 D
 . I D1>0 S STR=STR_SPACES
 . S STR=STR_TXT
 . I D2>0 S STR=STR_SPACES
 S STR=STR_$E(DASHES,1,D2)
 W !,?IND,STR
 Q
 ;
DSPVALUE(TYPE,VALUE) ;
 N IND,VALIND
 S IND=$$INDENT
 I TYPE=-1 S TYPE="",VALIND=IND
 E  S VALIND=MAX-IND-$L(VALUETXT)
 W !,?IND,TYPE,?VALIND,VALUE
 Q
 ;
DOBLANKLINE ;
 I BLANKLINE W ! S BLANKLINE=0
 Q
 ;
VIEW ;
 N FINAL,ORPARAM,ORPIEN,ORTABS,USER,TABS,OTHER,ORDERS,ERROR
 S USER=$$SELECT^ORACCESS("Select user: ",0)
 I USER<1 Q
 S FINAL=$$ASKYN^ORACCESS("No","View final settings","ORACCES3",1)
 I +FINAL=1 D OVERALL(+USER) Q
 D GETPARAMS^ORACCESS(1)
 S DSPLVL=4,DSPNAME=$P($G(^VA(200,+USER,0)),U)
 D DISPLAY(USER,"")
 Q
 ;
OVERALL(USER) ;
 N ARRAY,ASKLVL,BLANKLINE,BUMP,DASHES,DIC,DIV,DIVNAME,DSPLVL,DSPNAME,DTOUT,DUOUT,ENT,IDX,ILVL,INDENTSIZE
 N MAX,NODE,NUMSPACES,ORPARAM,ORTABS,OUTPUT,SPACES,USERNAME,VMODE,X,Y,TABS,OTHER,ORDERS,ERROR
 S DIC=4,DIC(0)="AEMQ",DIC("A")="Select Division: "
 D ^DIC I $D(DTOUT)!$D(DUOUT)!(Y<1) Q
 S DIV=+Y
 I DIV>0 S DIVNAME=$$GET1^DIQ(4,DIV_",",.01)
 S USERNAME=$$GET1^DIQ(200,USER_",",.01)
 D GETPARAMS^ORACCESS(1)
 F IDX=1:1:3 D
 .K ARRAY
 .D DATA^ORACCESS(.ARRAY,IDX,0,0)
 .F DSPLVL="Package","Systems","Division","Users" D
 ..I DSPLVL="Package" D  Q
 ...S DSPNAME=""
 ...F  S DSPNAME=$O(ARRAY(DSPLVL,"ORDER ENTRY/RESULTS REPORTING",DSPNAME)) Q:DSPNAME=""  D
 ....S OUTPUT(IDX,DSPNAME)=ARRAY(DSPLVL,"ORDER ENTRY/RESULTS REPORTING",DSPNAME)_U_DSPLVL
 ..S ENT=$S(DSPLVL="Division":DIVNAME,DSPLVL="Users":USER,1:$$KSP^XUPARAM("WHERE"))
 ..S DSPNAME="" F  S DSPNAME=$O(ARRAY(DSPLVL,ENT,DSPNAME)) Q:DSPNAME=""  D
 ...S OUTPUT(IDX,DSPNAME)=ARRAY(DSPLVL,ENT,DSPNAME)_U_DSPLVL
 I '$D(OUTPUT) W !,"No settings defined" Q
 W !,"Write access setting for user: "_USERNAME
 W !,"Write access setting for division: "_DIVNAME
 W !,$$RJ^XLFSTR("Tab/Action",50)_$$RJ^XLFSTR("Level",25),!
 F IDX=1:1:80 W "-"
 W !
 S MAX=78,SPACES=" ",NUMSPACES=$L(SPACES),INDENTSIZE=3
 S (ILVL,BUMP,VMODE,BLANKLINE)=0
 S DASHES="" F X=1:1:(MAX\2)+1 S DASHES=DASHES_"-"
 F IDX=1:1:3 D
 .I IDX>1 W !
 .D TXTLINE(ORPARAM(IDX))
 .W !
 .S DSPNAME="" F  S DSPNAME=$O(OUTPUT(IDX,DSPNAME)) Q:DSPNAME=""  D
 ..S NODE=$G(OUTPUT(IDX,DSPNAME)) I NODE="" Q
 ..W !,$$RJ^XLFSTR(DSPNAME_": "_$P(NODE,U),50)_$$RJ^XLFSTR("("_$P(NODE,U,2)_")",25)
 Q
 ;
HELP(HELP) ;
 I HELP=1 D  Q
 .W !,"Select Yes to return the user final settings including settings"
 .W !,"from all levels. Select No to only view the specific user settings."
 Q
 ;
