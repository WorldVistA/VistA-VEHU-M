ISIJLS2B ; ISI/JHC - ISIRAD exam list functions ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**99,105,106,107,109,110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 ; Reference to File #2006.69 in ICR #7410
 Q
 ;
FORMOUT(OUTPUT) ; Create form spec (XML formatting) for Dynamic Query dialog
 ;  Form contents are table-driven by entries in comment lines at bottom of routine.
 ;    If query exists for the session, populate defined prompts with stored values.
 N FLDID,IREGION,RGNS,RSL,INSPECS,INSPMULT,SESSION,OK,NEWQUERY
 S SESSION=MAGJOB("SESSION"),NEWQUERY=1
 I $D(^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION,"SPECS")) D  ; get currently defined specs for session
 . S I="",NEWQUERY=0
 . F  S I=$O(^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION,"SPECS",I)) Q:I=""  S X=^(I) D
 . . S FLDID=$P(X,U)
 . . I '$D(INSPECS(FLDID)) S INSPECS(FLDID)=$P(X,U,2,99)
 . . E  S T=$G(INSPMULT(FLDID))+1,INSPMULT(FLDID)=T,INSPMULT(FLDID,T)=$P(X,U,2,99) ; save multiple values
 S RGNS="PRHDR^PRLST^PRLSTOPT" ; form regions--see tables at these tags below
 F IREGION=0:1:$L(RGNS,U) D
 . I 'IREGION S OUTPUT(IREGION,1)="<DIALOG name=""Query_Dlg"" ver=""1.0"" title=""Create/Edit Query"" newquery="""_NEWQUERY_""">"
 . I  Q
 . D PROMPTS($P(RGNS,U,IREGION),.RSL) M OUTPUT(IREGION)=RSL K RSL
 S OUTPUT(IREGION+1,1)="</DIALOG>"
 Q
 ;
PROMPTS(REGION,RGSPEC) ; assemble prompts for the dialog form's region
 I "^PRHDR^PRLST^PRLSTOPT^"[U_$G(REGION)_U
 E  Q
 N END,ICT,IFLD,FLDID,RGNNAME,SAVICT
 N LIST,OPLIST,SPEC,STRING,TAGS  ;these are global to Prompts & Prompts2 subroutines
 N QUOTE,SP  ; these are global to all Prompts & "GETxxx" subroutines
 S QUOTE="""",SP=" "
 S TAGS="ID=^LABEL=^DATA_TYPE=^AUTOFILL=^REQUIRED=^DISPLAYONLY=^LOWER_LIMIT=^UPPER_LIMIT=^HELP_TEXT=^OPERATOR=^AUTOFILL_OP=^COL_WIDTH_PCT=^ALLOW_MULTIPLE="
 S END=0
 F IFLD=1:1 S X=$T(@REGION+IFLD)  D  Q:END
 . I X="" S END=1 Q  ; should never get here...
 . S SPEC=$P(X,";",3,999)
 . I IFLD=1 D  Q
 . . S RGNNAME=$P(SPEC,";"),T=$P(SPEC,";",2,99)
 . . S RGSPEC(IFLD)="<"_RGNNAME_SP_T_">"
 . I $E(SPEC,1,4)="*END" S END=1,RGSPEC(IFLD)="</"_RGNNAME_">" Q
 . I +SPEC=201,'($P($G(^MAG(2006.69,1,"ISI")),U,1)="Y") Q  ; Assign feature not enabled
 . D PROMPTS1()
 Q
PROMPTS1() ;
 N IFLDEXT,REPEAT
 S IFLDEXT=IFLD,REPEAT=0
 F  D  Q:'REPEAT  Q:REGION'="PRLSTOPT"  ; All multiples live in the prlstopt region only
 . I REPEAT S IFLDEXT=IFLD+(REPEAT/100)
 . S STRING="<PROMPT ",LIST=0,OPLIST=0,ICT=0
 . D PROMPTS2(.FLDID,.REPEAT)
 . S STRING=STRING_$S('(LIST!OPLIST):"/>",1:">"),RGSPEC(IFLDEXT)=STRING
 . I LIST S SAVICT=ICT D GETLIST(FLDID,.RGSPEC,IFLDEXT,.ICT) I ICT=SAVICT S LIST=0 K RGSPEC(IFLDEXT)
 . I OPLIST D GETOPS(FLDID,.RGSPEC,IFLDEXT,.ICT)
 . I (LIST!OPLIST) S RGSPEC(IFLDEXT,99999)="</PROMPT>"
 Q
PROMPTS2(FLDID,REPEAT) ;
 N AUTOFILL,AUTOFOP,ISPEC
 F ISPEC=1:1:$L(TAGS,U) S X=$P(SPEC,U,ISPEC) D
 . I ISPEC=1 D
 . . S FLDID=X,AUTOFILL="",AUTOFOP="",DATEVALU=0
 . . I $D(INSPECS(FLDID)) S AUTOFILL=$P(INSPECS(FLDID),U),AUTOFOP=$P(INSPECS(FLDID),U,2)
 . I $D(INSPECS(FLDID)) D
 . . I ISPEC=4 S X=AUTOFILL  ; autofill from user's prompt entries
 . . I ISPEC=11 S X=AUTOFOP  ; ditto the operator
 . E  I X="" Q
 . I ISPEC=3,(X="DATE") S DATEVALU=1  ; flag date data type for special default=TODAY
 . I X="" Q:'(ISPEC=4!ISPEC=11)  ; ignore spec unless is user-filled prompt/operator entry
 . I DATEVALU,(ISPEC=4),(X["TODAY") S X=$$TODAY(X)
 . I DATEVALU,(ISPEC=7),(FLDID=7.1) D  ; Site setting limits # days back for "Study Date From"
 . . S T=+$P($G(^MAG(2006.69,1,"ISI")),U,6)
 . . I T S X=$$TODAY("TODAY-"_T)
 . S T=$P(TAGS,U,ISPEC)_QUOTE_X_QUOTE_SP,STRING=STRING_T
 . I T["DATA_TYPE=",(X="LIST") S LIST=1 ; this is a "list" Data Type
 . I T["OPERATOR=",(X="OPLIST") S OPLIST=1 ; this has operators
 I $D(INSPECS(FLDID)) D
 . K INSPECS(FLDID)  ; already used this one; are there more?
 . I $D(INSPMULT(FLDID)) D  ; copy next multi value into field, set repeat flag
 . . S T=$O(INSPMULT(FLDID,""))
 . . I T S REPEAT=REPEAT+1,X=INSPMULT(FLDID,T),INSPECS(FLDID)=X K INSPMULT(FLDID,T)
 . . E  S REPEAT=0  ; no more multiples
 Q
TODAY(ARG) ; return today's date [plus/minus N] in YYYYMMDD format
 ; Default today's date unless ARG matches TODAY+N or TODAY-N
 N X,X1,X2,DATE,N,OP
 I $E(ARG,1,5)="TODAY"&(ARG["+"!(ARG["-")) D
 . S OP=$E(ARG,6),N=+$P(ARG,OP,2)
 . S X1=DT,X2=$S(OP="-":-N,1:N)
 . D C^%DTC S DATE=X
 E  S DATE=DT
 S X1=$E(DATE),X2=$E(DATE,2,7),X=$S(X1=2:19,X1=3:20,X1=4:21)_X2
 Q X
 ;
GETLIST(ID,RGSPEC,IFLD,ICT) ; build legal values list for input field ID
 N TAG
 S ID=ID\1,TAG="GET"_ID  ; strip decimal if present
 I $T(@TAG)]"" D @(TAG_"()")
 Q
GETLIST2(IDVAL,TXT) ; add one entry to the values list; called from each GETNN subrtn
 S ICT=ICT+1
 S RGSPEC(IFLD,ICT)="<ListValue ID="_QUOTE_IDVAL_QUOTE_">"_TXT_"</ListValue>"
 Q
 ;
GETNN ; return list of valid values for each given field ien 
 ;    NN = field ien inside the List subsystem;
GET5() ; Priority
 N ID,TXT,URGORD,VALSTR
 S X=$G(^MAG(2006.69,1,1)),URGORD=$P(X,U)
 S:URGORD="" URGORD="S,U,P,R" S URGORD=$TR(URGORD,",")
 S VALSTR=""
 F I=1:1:$L(URGORD) D
 . S X=$E(URGORD,I),T=$S(X="S":"Stat",X="U":"Urg",X="P":"PreOp",1:"Rout")
 . S T=I_"-"_T,T=T_"~"_T
 . S VALSTR=VALSTR_$S(VALSTR="":"",1:U)_T
 I VALSTR]"" D
 . D GETLIST2("","- -")
 . F I=1:1:$L(VALSTR,U) D
 . . S X=$P(VALSTR,U,I),ID=$P(X,"~"),TXT=$P(X,"~",2)
 . . D GETLIST2(ID,TXT)
 Q
GET8() ; Status
 N ID,TXT,VALSTR
 S X="READY FOR INTERP"
 I $$UJOCHECK^ISIJUTL9() S X="US WAITING"  ; Different string for Jordan
 S VALSTR="9~COMPLETE^I~INTERPRETED^E~EXAMINED^1~WAITING^R~"_X  ; P106 add R; P109 (X=Jordan string vs default)
 I VALSTR]"" D
 . D GETLIST2("","- -")
 . F I=1:1:$L(VALSTR,U) D
 . . S X=$P(VALSTR,U,I),ID=$P(X,"~"),TXT=$P(X,"~",2)
 . . D GETLIST2(ID,TXT)
 Q
GET11() ; Imaging Loc
 N DATA,IDAT,SCR
 S SCR="I $P($G(^(""DIV"")),U)=DUZ(2)"  ; filter for Locs at the user logon division
 D LIST^DIC(79.1,,"@;.01","P",,,,,SCR,,"DATA")
 I +$G(DATA("DILIST",0)) D
 . D GETLIST2("","- -")
 . S IDAT=0 F  S IDAT=$O(DATA("DILIST",IDAT)) Q:IDAT=""  S X=DATA("DILIST",IDAT,0) D GETLIST2($P(X,U),$P(X,U,2))
 Q
GET15() ; Modality
 N DATA,IDAT,TOPMDLS,I
 S TOPMDLS="CR^CT^DX^MR^MG^NM^RF^US^XA"
 D LIST^DIC(73.1,,"@;.01","P",,,,,"I $P(^(0),U,3)=""""",,"DATA")
 D GETLIST2("","- -")
 D GETLIST2("CR,DX","CR or DX")
 F I=1:1:$L(TOPMDLS,U) S X=$P(TOPMDLS,U,I),TOPMDLS(X)="" D GETLIST2(X,X)
 S IDAT=0 F  S IDAT=$O(DATA("DILIST",IDAT)) Q:IDAT=""  S X=$P(DATA("DILIST",IDAT,0),U,2) I '$D(TOPMDLS(X)) D GETLIST2(X,X)
 Q
GET17() ;  Type of Imaging
 N DATA,IDAT
 D LIST^DIC(79.2,,"@;3;.01","P",,,,,,,"DATA")
 I +$G(DATA("DILIST",0)) D
 . D GETLIST2("","- -")
 . S IDAT=0 F  S IDAT=$O(DATA("DILIST",IDAT)) Q:IDAT=""  S X=DATA("DILIST",IDAT,0) D GETLIST2($P(X,U),$P(X,U,3))
 Q
GET24() ; Radiologist
 N ID,TXT,VALSTR
 S VALSTR="1~Is me^0~Is NOT me^-1~Is not entered"
 D GETLIST2("","- -")
 F I=1:1:$L(VALSTR,U) S X=$P(VALSTR,U,I),ID=$P(X,"~"),TXT=$P(X,"~",2) D GETLIST2(ID,TXT)
 Q
GET201() ; Assigned to
 N ID,TXT,VALSTR
 S VALSTR="1~Me^0~NOT me^2~Anyone^-1~NOT entered"
 D GETLIST2("","- -")
 F I=1:1:$L(VALSTR,U) S X=$P(VALSTR,U,I),ID=$P(X,"~"),TXT=$P(X,"~",2) D GETLIST2(ID,TXT)
 Q
GET208() ; Patient Sex
 N IDVAL,TXT,VALSTR
 S VALSTR="F~FEMALE^M~MALE"
 D GETLIST2("","- -")
 F I=1:1:$L(VALSTR,U) S X=$P(VALSTR,U,I),IDVAL=$P(X,"~"),TXT=$P(X,"~",2) D GETLIST2(IDVAL,TXT)
 Q
 ;
GETOPS(ID,RGSPEC,IFLD,ICT) ; build legal Operator values list for input field ID
 N TAG
 S ID=ID\1,TAG="OPS"_ID  ; strip decimal if present
 I $T(@TAG)]"" D @(TAG_"()")
 Q
GETOPS2(IDVAL,TXT) ; add one entry to the operator list
 S ICT=ICT+1
 S RGSPEC(IFLD,ICT)="<OpValue ID="_QUOTE_IDVAL_QUOTE_">"_TXT_"</OpValue>"
 Q
 ;
OPSNN ; NN = field ien inside the Operator subsystem
 ;  * --> make sure operator values are accounted for in 
 ;        subrtn qrspecs2 &/or QRSNN codelets as applies
OPSSTR(VALSTR) ; 
 I VALSTR]"",(VALSTR["~") D
 . N ID,TXT,X
 . F I=1:1:$L(VALSTR,U) S X=$P(VALSTR,U,I),ID=$P(X,"~"),TXT=$P(X,"~",2) D GETOPS2(ID,TXT)
 Q
OPS6() ; Procedure operators
 N VALSTR
 S VALSTR="C~Contains^E~Equals"
 D OPSSTR(VALSTR)
 Q
OPS9() ; # Images operators
 N VALSTR
 S VALSTR="G~Greater than^L~Less than^E~Equals"
 D OPSSTR(VALSTR)
 Q
ZZOPS8() ; <*> Status operators (zz intentional--this used ONLY for TESTING of ops w/ List data type)
 N VALSTR
 S VALSTR="E~Equals^C~Contains"
 D OPSSTR(VALSTR)
 Q
 ;
 ; 3 tables below provide details for each prompt, w/in prompt regions
 ;    1st line has region tag name & optional parameters ();
 ;      lines 2:n have prompt specs
 ;    prompt specs as follows (MUST line up w/ "TAGS" variable in the "PROMPTS" subroutine)
 ;      note that the 1st 3 values are ALWAYS REQUIRED to be filled in
 ;  ID ^ LABEL ^ DATA_TYPE ^ AUTOFILL ^ REQUIRED ^ DISPLAYONLY ^ LOWER_LIMIT ^ UPPER_LIMIT
 ;     ^ HELP_TEXT ^ OPERATOR ^ AUTOFILL_OP ^ COL_WIDTH_PCT ^ ALLOW_MULTIPLE
 ;  Notes:
 ;    - COL_WIDTH_PCT values only in prhdr region & are REQUIRED & must total 100
 ;    - ALLOW_MULTIPLE values may only appear in prlstopt region
 ;    - PROMPTS_LIST_COLUMNS_PCT values only appears in prlst region;
 ;        values total 100; defines column-widths for the table
 ;        control where these prompts are rendered
 ;    - LOWER_LIMIT for Field ID 7.1 may be overridden by a 
 ;        Site Parameter setting; see code at tag prompts2
 ;
PRHDR ; ^3^5^6^7^8^9^11^15^17^24^201^207^208^
 ;;PROMPTS_HEADER;
 ;;7.1^Study Date From^DATE^TODAY^1^^19981001^TODAY^^^^10
 ;;7.2^Date To^DATE^TODAY^1^^19981001^TODAY^^^^10
 ;;17^ > Type of Imaging^LIST^^^^^^^^^10
 ;;208^ > Sex^LIST^^^^^^^^^7
 ;;3^ > Patient Name matches^FREE_TEXT^^^^^^Enter Last, First (partial name OK)^^^25
 ;;24^ > Radiologist^LIST^^^^^^^^^7
 ;;201^ > Assigned to^LIST^^^^^^^^^7
 ;;8^ > Status^LIST^^^^^^^^^5^1
 ;;11^ > Imaging Loc^LIST^^^^^^^^^10
 ;;*END
 ;; <*> below lines for test DB convenience--> copy into above spaces when testing
 ;;7.1^Study Date From^DATE^20080101^1^^20080101^TODAY^^^^12
 ;;7.2^Date To^DATE^TODAY^1^^20090101^TODAY^^^^12
PRLST ; 
 ;;PROMPTS_LIST;PROMPTS_LIST_COLUMNS_PCT="24,22,54" 
 ;;207.1^ > Patient Age from^NUMERIC^^^^0^130^Enter Patient 'age from'^^^
 ;;207.2^ > Patient Age to^NUMERIC^^^^0^130^Enter Patient 'age to'^^^
 ;;15^Modality^LIST
 ;;6^Procedure^FREE_TEXT^^^^^^Enter some portion of the Procedure name, e.g., CHEST^OPLIST^^^
 ;;9.1^# Images GREATER than or Equal to^NUMERIC^^^^0^99999^^
 ;;9.2^# Images LESS than or Equal to^NUMERIC^^^^0^99999^^
 ;;*END
PRLSTOPT ;  <*>  Note--> when adding new fields, insert in Alphabetical Order
 ;;PROMPTS_LIST_OPTIONAL;
 ;;11^ > Imaging Loc^LIST^^^^^^^^^1
 ;;15^Modality^LIST^^^^^^^^^^1
 ;;3^ > Patient Name matches^FREE_TEXT^^^^^^^^^^1
 ;;5^Priority^LIST^^^^^^^^^^1
 ;;6^Procedure^FREE_TEXT^^^^^^Enter some portion of the Procedure name, e.g., CHEST^OPLIST^^^1
 ;;8^ > Status^LIST^^^^^^^^^^1
 ;;17^ > Type of Imaging^LIST^^^^^^^^^^1
 ;;*END
