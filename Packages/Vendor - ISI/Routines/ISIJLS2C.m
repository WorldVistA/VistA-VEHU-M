ISIJLS2C ; ISI/JHC - ISIRAD exam list functions ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**99,105,107,110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 ;
 Q
 ;
ERR N ERR S ERR=$$EC^%ZOSV S ^TMP($J,"RET",0)="0^4~"_ERR
 S MAGGRY=$NA(^TMP($J,"RET"))
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
QRSPECS(SCAN,ERRMSG,DATA) ;  * * *  CALLed from isijls2  * * *
 ; this is used for the list Compile, and for the Query validate rpc
 ;    SCAN -- True if this call is for the Query Compile; false for Validate Query specs
 ;  ERRMSG -- return reason for error if detected
 ;    DATA -- input for Validate only, contains specs values defined by user in Client
 ; for the Compile only (SCAN=1), initializes all "special" vars=0,
 ;   then traverses input array & sets values per input in DATA
 ; remaining input vals are configured for List Sys search logic in QRMD...
 N ERROR,IMD,IMD2,ISPEC,OPERATOR,QRMD,QRMDCHK,VALUE,SESSION
 S SESSION=MAGJOB("SESSION")
 ; new these vars only if NOT running the scan (validate only)
 ;   else the variables are set here for use in the compile code
 I 'SCAN N QAGE,QDATFR,QDATTO,QIMGTYP,QPTNAME,QRIST,QSEX,QSTATUS,QNIMG,QASSN
 I 'SCAN N AGE1,AGE2,PTNAME,RISTCHK,SEX,STATTEST,NIMG1,NIMG2,NIMGSPEC,ASSNCHK
 I 'SCAN N QIMGLOC
 ;
 S (QAGE,QDATFR,QDATTO,QIMGTYP,QPTNAME,QRIST,QSEX,QSTATUS,QNIMG,QASSN)=0
 S QIMGLOC=0
 S ISPEC="",ERRMSG=""
 I SCAN F  S ISPEC=$O(^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION,"SPECS",ISPEC)) Q:ISPEC=""  S X=^(ISPEC) D QRSPECS2(X)
 I 'SCAN D
 . F  S ISPEC=$O(DATA(ISPEC)) Q:ISPEC=""  S X=DATA(ISPEC) D QRSPECS2(X)
 ;  Some query fields require further validation &/or data prep
 I +QDATFR,+QDATTO,(QDATFR<QDATTO)
 E  S ERRMSG="Invalid FROM/TO date range"_$S(ERRMSG="":". ",1:"; ")_ERRMSG
 I QAGE D  ; age from/to values
 . S:AGE1="" AGE1=0 S:AGE2="" AGE2=130
 . I ('AGE1&'AGE2)!(AGE1=0&(AGE2=130)) S QAGE=0 Q  ; age not matter; 
 . I '(AGE1!AGE2) S ERRMSG=ERRMSG_$S(ERRMSG="":"",1:"; ")_"Invalid AGE specification",QAGE=0
 . S:(AGE2'[".") AGE2=AGE2+0.99
 I QNIMG D  ; # Images range values
 . I (NIMG1=""!(NIMG1?1.N))&(NIMG2=""!(NIMG2?1.N))
 . E  S ERRMSG=ERRMSG_$S(ERRMSG="":"",1:"; ")_"Invalid # Images specification",QNIMG=0 Q
 . I NIMG1,NIMG2 D  Q:'QNIMG
 . . I NIMG1>NIMG2 S ERRMSG=ERRMSG_$S(ERRMSG="":"",1:"; ")_"# Images values in wrong sequence.",QNIMG=0
 . N T1,T2,EXP S (T1,T2)=""
 . S:NIMG1]"" T1="(MD(9)'<"_NIMG1_")" S:NIMG2]"" T2="(MD(9)'>"_NIMG2_")"  ; 9 = field IEN for # Images
 . I T1="",(T2="") S QNIMG=0 Q  ; # images not matter;
 . I T1]"" S EXP=T1_$S(T2]"":"&"_T2_"",1:"")
 . E  S EXP=T2
 . D QRMDSET(NIMGSPEC,9,EXP,"STUFF")
 ; data prep finished--if inside the Validation step, & query spec is clean, continue
 I 'SCAN,(ERRMSG="") D
 . ;  init scan for session
 . F I="RSL","SPECS","SPECFLDS","SPECQRMD" K ^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION,I)
 . ;  save query details for use in the compile step
 . M ^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION,"SPECS")=DATA
 . I $D(QRMD) M ^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION,"SPECQRMD")=QRMD
 . S I="" F  S I=$O(DATA(I)) Q:I=""  S X=+DATA(I)\1,^XTMP("MAGJ2","ISIQUERY",DUZ,SESSION,"SPECFLDS",X)=""
 Q
 ;
QRSPECS2(X) ; X = Field_IEN ^ Value ^ Operator
 ;  process input either indirect Tag call, or "generic" qrmdset call
 S IMD=$P(X,U),VALUE=$P(X,U,2),OPERATOR=$P(X,U,3),IMD2="",ERROR=""
 I IMD["." S IMD2=$P(IMD,".",2),IMD=$P(IMD,".")
 I $T(@("QRS"_IMD))]"" D @("QRS"_IMD) I 1
 E  D  ; <*> update valid imd list here when adding new fields
 . I $F("^3^5^6^7^8^9^15^17^24^201^207^208^",U_IMD_U) D QRMDSET(ISPEC,IMD,VALUE,OPERATOR) Q
 . E  S ERROR="Invalid Query ID ["_IMD_"]--call support"
 I ERROR]"" S ERRMSG=ERRMSG_$S(ERRMSG="":"",1:"; ")_ERROR
 Q
QRMDSET(ISPEC,IMD,VALUE,OPERATOR) ; Create "If" logic statements for input fields
 ;  Operator "STUFF"--pass in just the argument
 ;    otherwise, pass in components to build the full statement
 N ISPECPRV
 I VALUE="" Q
 S VALUE=$$STRIP^ISIJLS2(VALUE)
 I OPERATOR="STUFF"
 E  S OPERATOR=$S(OPERATOR="E":"=",OPERATOR="G":">",OPERATOR="L":"<",OPERATOR="C":"[",1:"=")
 I $D(QRMDCHK(IMD)) S ISPECPRV=QRMDCHK(IMD) D   ; Multiple values for this field, set up "OR" logic
 . I OPERATOR="STUFF" S QRMD(ISPECPRV)=QRMD(ISPECPRV)_"!"_VALUE
 . E  S QRMD(ISPECPRV)=QRMD(ISPECPRV)_"!(MD("_IMD_")"_OPERATOR_""""_VALUE_""")"
 E  D
 . I OPERATOR="STUFF" S QRMD(ISPEC)=IMD_U_" I "_VALUE,QRMDCHK(IMD)=ISPEC
 . E  S QRMD(ISPEC)=IMD_U_" I (MD("_IMD_")"_OPERATOR_""""_VALUE_""")",QRMDCHK(IMD)=ISPEC
 Q
 ;
QRSNN ; process input selection fields for data validation or scan
 ; --> variables NOT newed inside the codelets are global to qrspecs ep;
 ; --> codelets for 3, 7, 8, 17, 24, 201, 207 & 208 set the "special"
 ;       variables used in the query scanning subroutines (qrscan...)
QRS3 ; Pt Name
 I $L(VALUE) D
 . S VALUE=$$NAMEFMT^ISIJLS2(VALUE)
 . I VALUE?.E1C.E S ERROR="Invalid Name specification--control characters not allowed." Q
 I ERROR="",$L(VALUE) S PTNAME(0)=$G(PTNAME(0))+1,PTNAME(PTNAME(0))=VALUE,QPTNAME=1
 Q
QRS5 ; Priority
 I '$L(VALUE) S ERROR="Invalid Priority specification"
 E  I VALUE'="" D QRMDSET(ISPEC,IMD,VALUE,"C")
 Q
QRS7 ; From/To Dates
 N VAR,VALUINT S VAR=$S(IMD2=1:"QDATFR",IMD2=2:"QDATTO",1:"")
 S VALUINT=VALUE
 I VALUINT]"" S X=VALUINT D ^%DT S VALUINT=$S(Y=-1:"",1:Y)
 I VALUINT?7N D
 . I IMD2=1 S VALUINT=VALUINT-1  ; From-date
 . S VALUINT=VALUINT_".2401"
 S @VAR=VALUINT
 Q
QRS8 ; exam status * --> structure allows multiple values
 S QSTATUS=VALUE
 I $L(QSTATUS) S STATTEST(QSTATUS)="",QSTATUS=1
 E  S QSTATUS=0
 Q
QRS9 ; # Images (range)
 S NIMG1=$G(NIMG1),NIMG2=$G(NIMG2),NIMGSPEC=$G(NIMGSPEC)  ; inits to nil if not yet processed the #Imgs
 N VAR S VAR=$S(IMD2=1:"NIMG1",IMD2=2:"NIMG2",1:"")
 I VAR]"",(VALUE?1.5N) S @VAR=VALUE,QNIMG=1 S:NIMGSPEC="" NIMGSPEC=ISPEC ; ispec needed beyond primary loop
 E  S ERROR="Invalid # Images specification ",QNIMG=0
 Q
QRS11 ; imaging loc * --> structure allows multiple values
 S QIMGLOC=VALUE
 I +QIMGLOC,(QIMGLOC'="") S QIMGLOC(VALUE)="",QIMGLOC=1
 E  S QIMGLOC=0
 Q
QRS15 ; Modality
 N I,VALUESTR
 I '$L(VALUE) Q
 E  S VALUESTR=VALUE D
 . F I=1:1:$L(VALUESTR,",") S VALUE=$P(VALUESTR,",",I) I VALUE]"" D QRMDSET(ISPEC,IMD,VALUE,"C")
 Q
QRS17 ; imaging type * --> structure allows multiple values
 S QIMGTYP=VALUE
 I +QIMGTYP,(QIMGTYP'="") S QIMGTYP(VALUE)="",QIMGTYP=1
 E  S QIMGTYP=0
 Q
QRS24 ; interp rist
 S QRIST=VALUE
 I $L(QRIST) S RISTCHK=QRIST,QRIST=1
 E  S QRIST=0
 Q
QRS201 ; assigned to
 S QASSN=VALUE
 I $L(QASSN) S ASSNCHK=QASSN,QASSN=1
 E  S QASSN=0
 Q
QRS207 ; Pt age (range)
 S AGE1=$G(AGE1),AGE2=$G(AGE2)  ; inits to nil if not yet processed the age
 N VAR S VAR=$S(IMD2=1:"AGE1",IMD2=2:"AGE2",1:"")
 I VAR]"",(VALUE?1.3N0.1(1"."1.2N)) S @VAR=VALUE,QAGE=1
 E  S ERROR="Invalid AGE specification ("_$S(IMD2=1:"From age)",1:"To age)"),QAGE=0
 Q
QRS208 ; Pt sex
 S QSEX=VALUE
 I $L(QSEX) S SEX=QSEX,QSEX=1
 E  S QSEX=0
 Q
 ;
