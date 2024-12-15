XTVSLPR2 ;ALBANY FO/GTS - VistA Package Sizing Manager; 23-JAN-2022
 ;;7.3;TOOLKIT;**152**;Apr 25, 1995;Build 3
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;APIs
SELLIST(SELARY,ITEMNUM,X,PARAMSTR) ; List the items for selection
 ; INPUT: SELARY   - Array of items [passed by parameter]
 ;        ITEMNUM  - Number of items in SELARY [passed by parameter]
 ;        X        - Value entered by user [passed by parameter, will be translated to uppercase,
 ;                    value returned will be: "" - TimeOut; KILLed X - nothing selected; number - SELARY node #]
 ;        PARAMSTR - Array of string parameters as follows:
 ;                      PARAMSTR("ADDITM")   - 1 : Allow adding new item
 ;                                              2nd ^ pce = 1: Allow duplicates
 ;                                                     [E.G. 1   - Do not allow duplicates
 ;                                                           1^1 - Allow duplicates]
 ;                                            0 : Do not allow adding new item [Default]
 ;                      PARMSTR("XTUPCASE") - 0 : Allow lowercase text [default] [Case matters]
 ;                                            1 : Convert all text to uppercase
 ;                      PARAMSTR("PATRN"))  - String the defines the pattern the item text
 ;                                              must match in a pattern match compare.
 ;                                                     [I.E. ?.ANP]
 ;                                            1 : Change user entry to uppercase
 ;                      PARAMSTR("MINLNG")  - Minumum length of entered string [Default 4]
 ;                      PARAMSTR("MAXLNG")  - Maximum length of entered string [Default 50]
 ;
 NEW CURITMNM,ITMNMEU,ITMNMEL,XUPPER,ITEMLIST,ITMCNT,XACTMAT,ADDANS,OKANS
 NEW MINLNG,MAXLNG,PATRN,ADDITM,XTUPCASE
 ;
 IF $G(PARAMSTR("PATRN"))="" SET PARAMSTR("PATRN")=".ANP" ;Default pattern
 IF +$G(PARAMSTR("MINLNG"))'>0 SET PARAMSTR("MINLNG")=4 ;Set default Min Length
 IF +$G(PARAMSTR("MAXLNG"))'>0 SET PARAMSTR("MAXLNG")=50 ;Set default Max Length
 SET MINLNG=PARAMSTR("MINLNG")
 SET MAXLNG=PARAMSTR("MAXLNG")
 SET PATRN=PARAMSTR("PATRN")
 SET ADDITM=$G(PARAMSTR("ADDITM"))
 IF +ADDITM=0 SET ADDITM=0 ;Set default ADDITM
 SET XTUPCASE=+$G(PARAMSTR("XTUPCASE"))
 ;
 DO CLNXEND(.X) ;Cleanup control chars, leading and trailing spaces in X
 ;
 IF +$G(XTUPCASE) SET X=$$UP^XLFSTR(X) SET PATRN=$$UP^XLFSTR(PATRN) ;Only upper case for user entry
 SET XUPPER=$$UP^XLFSTR(X)
 ;
 ;Count items in SELARY and find matches
 SET (XACTMAT,CURITMNM,ITMCNT)=0
 FOR  SET CURITMNM=$O(SELARY(CURITMNM)) Q:CURITMNM=""  DO
 . SET ITMNMEU=$$UP^XLFSTR($P(SELARY(CURITMNM),"^",1))
 . SET ITMNMEL=$P(SELARY(CURITMNM),"^",1)
 . IF ('XACTMAT) DO 
 .. IF +$G(XTUPCASE),(ITMNMEU)=XUPPER SET XACTMAT=CURITMNM ; Case doesn't matter
 .. IF '+$G(XTUPCASE),(ITMNMEL)=X SET XACTMAT=CURITMNM  ; Case matters
 . IF +$G(XTUPCASE),$E(ITMNMEU,1,$L(XUPPER))=XUPPER SET ITMCNT=ITMCNT+1 SET ITEMLIST(ITMCNT)=ITMNMEL_"^"_CURITMNM ; ITEMLIST = match array [case doesn't matter
 . IF '+$G(XTUPCASE),$E(ITMNMEL,1,$L(X))=X SET ITMCNT=ITMCNT+1 SET ITEMLIST(ITMCNT)=ITMNMEL_"^"_CURITMNM ; ITEMLIST = match array [case matters]
 ;
 IF ITMCNT>1 DO  ; Present list to user for selection when ITMCNT>1
 . NEW XVAL,XTOUT
 . SET XVAL=-1 ;Initialize selected Item #
 . SET (XTOUT,CURITMNM)=0
 . FOR  SET CURITMNM=$O(ITEMLIST(CURITMNM)) QUIT:+CURITMNM=0  Q:XTOUT  Q:($E(XVAL,1)="^")  QUIT:(XVAL?1.N)  DO  ;List items
 .. WRITE !,"   ",CURITMNM,": ",$P(ITEMLIST(CURITMNM),"^")
 .. IF '(CURITMNM#5)!(CURITMNM=ITMCNT) DO
 ... FOR  W:(CURITMNM'=ITMCNT) !,"Press <Enter> to see more items, '^' to exit,  OR" W !,"Choose 1-"_CURITMNM_": " READ XVAL:DTIME  SET:'$T XTOUT=1  Q:XTOUT  Q:$E(XVAL,1)="^"  Q:XVAL=""  Q:((XVAL?1.N)&((+XVAL>0)&(+XVAL<(CURITMNM+1))))  DO
 .... IF 'XTOUT,((XVAL'?1.N)!(+XVAL>(CURITMNM))!(+XVAL<1))  W:($E(XVAL,1)'="?") "  ??" W !,"Select an item from the list [Number 1 - "_CURITMNM_"]",!
 . ;
 . IF $E(XVAL,1)="^" KILL X ; ^ out
 . IF XTOUT SET X="" ; Timeout
 . ;
 . IF 'ADDITM,'XTOUT,($E(XVAL,1)'="^") DO
 .. IF (+XVAL=0) DO
 ... IF 'XACTMAT KILL X ; No item selected, Kill X for return to ^DIR
 ... IF XACTMAT DO
 .... SET OKANS=$$YNCHK^XTVSLAPI("       "_X_"  ...OK","YES")
 .... IF OKANS SET X=XACTMAT ; X = Exact match entry #
 .... IF 'OKANS,('$P(OKANS,"^",3)) KILL X
 .... IF 'OKANS,($P(OKANS,"^",3)) SET X="" ;Timeout
 . ;
 . IF ADDITM,'XTOUT,($E(XVAL,1)'="^") DO
 .. IF $P(ADDITM,"^",2),XACTMAT,(+XVAL=0) DO
 ... DO ASKADD(.ADDANS,.X,.SELARY,.ITEMNUM) ;ASKADD KILLs X on ^ or NO add
 ... IF 'ADDANS,($P(ADDANS,"^",3)) SET X="" ;Timeout
 ..;
 .. IF ('$P(ADDITM,"^",2)),XACTMAT,(+XVAL=0) KILL X
 .. ;
 .. IF 'XACTMAT,(+XVAL=0) DO
 ... IF '$$BADENT(MINLNG,MAXLNG,PATRN,.X) DO
 .... DO ASKADD(.ADDANS,.X,.SELARY,.ITEMNUM)
 .... IF 'ADDANS,($P(ADDANS,"^",3)) SET X="" ;Timeout
 . ;
 . IF ('XTOUT),(+XVAL>0) SET X=$P(ITEMLIST(XVAL),"^",2) ; X = SELARY selection #
 ;
 IF ITMCNT=1 DO
 . NEW ONEITMEN,ONEITMNM
 . SET ONEITMEN=$P(ITEMLIST(1),"^",2)
 . SET ONEITMNM=$P(ITEMLIST(1),"^",1)
 . WRITE $E(ONEITMNM,$L(X)+1,$L(ONEITMNM))
 . IF ADDITM DO
 .. SET OKANS=$$YNCHK^XTVSLAPI("         ...OK","YES")
 .. IF OKANS SET X=ONEITMEN
 .. ;
 .. IF 'OKANS,($P(OKANS,"^",2)=-1),('$P(OKANS,"^",3)) KILL X ; ^ out
 .. IF 'OKANS,('$P(OKANS,"^",2)),('$P(OKANS,"^",3)),('$$BADENT(MINLNG,MAXLNG,PATRN,.X)) DO
 ... IF ($P(ADDITM,"^",2)) DO ASKADD(.ADDANS,.X,.SELARY,.ITEMNUM) ;Dup's allowed
 ... IF ('$P(ADDITM,"^",2)),($G(X)'=ONEITMNM) DO ASKADD(.ADDANS,.X,.SELARY,.ITEMNUM)
 ... IF ('$P(ADDITM,"^",2)),($G(X)=ONEITMNM) KILL X ; No dup's
 .. ;
 .. IF ($P($G(OKANS),"^",3))!($P($G(ADDANS),"^",3)) SET X="" ; Timeout
 . ;
 . IF 'ADDITM DO
 .. SET OKANS=$$YNCHK^XTVSLAPI("         ...OK","YES")
 .. IF OKANS SET X=ONEITMEN
 .. IF 'OKANS,('$P(OKANS,"^",3)) KILL X
 .. IF 'OKANS,($P(OKANS,"^",3)) SET X="" ;Timeout
 ;
 IF ITMCNT=0 DO
 . IF ADDITM,'$$BADENT(MINLNG,MAXLNG,PATRN,.X) DO
 .. DO ASKADD(.ADDANS,.X,.SELARY,.ITEMNUM)
 .. IF 'ADDANS,($P(ADDANS,"^",3)) SET X="" ; Time out
 . IF 'ADDITM KILL X
 ;
 QUIT
 ;
ASKADD(ADDANS,X,SELARY,ITEMNUM) ; Query to Add item
 SET ADDANS=$$YNCHK^XTVSLAPI("  Are you adding "_X)
 IF ADDANS DO INSRTX^XTVSLAPI(.X,.SELARY,.ITEMNUM)
 IF 'ADDANS,('$P(ADDANS,"^",3)) KILL X  ; ^ or Not Adding
 QUIT
 ;
CLNXEND(XVAL) ; Removes control chars from end & spaces from beginning and end
 ; INPUT: XVAL - String to clean up [Passed by reference]
 ;                 (Removes control characters and trailing spaces from a string)
 ;
 NEW LPCNT,CLNX,CHKCHAR
 SET CLNX=X
 FOR LPCNT=1:1:$L(X) S CHKCHAR=$ASCII($E(X,LPCNT)) SET:((CHKCHAR<33)!(CHKCHAR>126)) X=$TRANSLATE(X,($E(X,LPCNT))," ")
 FOR LPCNT=$L(X):-1:1 S CHKCHAR=$ASCII($E(X,LPCNT)) QUIT:((CHKCHAR>32)&(CHKCHAR<127))  S CLNX=$E(X,1,LPCNT-1)
 ;
 S LPCNT=0
 FOR  S LPCNT=LPCNT+1 S CHKCHAR=$ASCII($E(CLNX,LPCNT)) QUIT:(CHKCHAR'=32)  S CLNX=$E(CLNX,LPCNT+1,$L(CLNX))
 ;
 SET X=CLNX
 QUIT
 ;
PTRNDESC(PATRN) ; Pattern Description
 ; Returns a description string for type of string
 NEW PATDESC,PTRNPARS,PTRNTXT,BEGTXT,ENDTXT
 SET (PTRNTXT,PATDESC)=""
 SET PATRNPARS=$$PTRNEXT(PATRN) ;Change pattern codes to uppercase, not strings in pattern
 SET BEGTXT=$P(PATRNPARS,"^",3)
 SET ENDTXT=$P(PATRNPARS,"^",4)
 SET PATRN=$P(PATRNPARS,"^",2)
 IF PATRN["A" SET PATDESC=PATDESC_" Alpha"
 IF PATRN["N" SET PATDESC=PATDESC_$S(PATDESC'["Alpha":" Numeric",1:"-Numeric")
 IF PATRN["P" SET PATDESC=PATDESC_$S((PATDESC'["Alpha")&(PATDESC'["Numeric"):" Punctuation",1:"-Punctuation")
 IF BEGTXT]"" SET PTRNTXT=$S(ENDTXT="":" and",1:",")_" begin with '"_BEGTXT_"'"
 IF ENDTXT]"" SET PTRNTXT=PTRNTXT_" and end with '"_ENDTXT_"'"
 SET PATDESC=PATDESC_PTRNTXT_"."
 QUIT PATDESC
 ;
PTRNEXT(PATRN) ; Extract PATTERN characters, Change lower case pattern codes to uppercase
 ;Return a 4 ^ pce result where: 
 ;        Pce 1 - PATRN with lower case patern codes changed to uppercase
 ;        Pce 2 - Uppercase Pattern Codes
 ;        Pce 3 - A string that the item must begin with
 ;        Pce 4 - A string that the item must end with
 ;
 NEW PTRNCHRS,QUOTOPEN,POSCTR,CHKCHAR,SETPCHAR,PTRNCODE,PTRNBEG,PTRNEND
 SET (PTRNCODE,PTRNCHRS,PTRNBEG,PTRNEND)=""
 SET (SETPCHAR,QUOTOPEN)=0
 FOR POSCTR=1:1:$L(PATRN) DO
 . SET CHKCHAR=$E(PATRN,POSCTR)
 . IF CHKCHAR="""",('QUOTOPEN) SET (SETPCHAR,QUOTOPEN)=1 SET PTRNCHRS=PTRNCHRS_CHKCHAR
 . ;
 . IF CHKCHAR="""",(QUOTOPEN),('SETPCHAR) DO
 .. SET QUOTOPEN=0
 .. SET SETPCHAR=1
 .. SET PTRNCHRS=PTRNCHRS_CHKCHAR
 . ;
 . IF CHKCHAR'="""",(QUOTOPEN),('SETPCHAR) DO
 .. SET PTRNCHRS=PTRNCHRS_CHKCHAR
 .. SET:PTRNCODE="" PTRNBEG=PTRNBEG_CHKCHAR
 .. SET:PTRNCODE'="" PTRNEND=PTRNEND_CHKCHAR
 . ;
 . IF CHKCHAR'="""",('QUOTOPEN),('SETPCHAR) DO
 .. SET PTRNCHRS=PTRNCHRS_$$UP^XLFSTR(CHKCHAR)
 .. IF "ANP"[$$UP^XLFSTR(CHKCHAR) SET PTRNCODE=PTRNCODE_$$UP^XLFSTR(CHKCHAR)
 . SET SETPCHAR=0
 QUIT PTRNCHRS_"^"_PTRNCODE_"^"_PTRNBEG_"^"_PTRNEND
 ;
BADENT(MINLNG,MAXLNG,PATRN,X) ;Evaluate X for String PATTERN and Length req's
 ; RESULT : 0 - entry meets requirements
 ;          1 - entry doesn't meet requirements
 ;
 NEW RESULT
 SET RESULT=0
 IF (($L(X)<MINLNG)!($L(X)>MAXLNG)!(X'?@PATRN)) DO
 . KILL X
 . WRITE !," Item must be "_MINLNG_" to "_MAXLNG_" characters made up of...",!,"   ",$$PTRNDESC(PATRN)
 . SET RESULT=1
 QUIT RESULT
