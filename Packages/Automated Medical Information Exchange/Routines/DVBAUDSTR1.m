DVBAUDSTR1  ;ALB/CP - UTL Reusable String Functions #1 ; 10/11/18 2:03pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;     $$GET1^DIQ    ; IA # 2056
 ;     ^DIC(49,      ; IA # 2939
 ;       $$UP^XLFSTR ; IA #10104
 Q
 ;
FREETEXT(DVBTEXT) ; Extrinsic function: See Output below.
 ;
 S DVBTEXT=$$UP^XLFSTR(DVBTEXT) ; Change all lowercase to uppercase
 S DVBTEXT=$$STRIPSPA(DVBTEXT) ;. Strip any extra spaces found
 Q DVBTEXT ; FREETEXT
 ;
HOSTSITE(DVBFORMAT) ; Extrinsic function: See Output below.
 ;
 N DVBDEFINSTI
 ;
 S DVBFORMAT=$G(DVBFORMAT,"SN") ; Default output DVBFORMAT: STATION NUMBER #99
 S DVBFORMAT=$$UP^XLFSTR(DVBFORMAT) ; Allows uppercase of lowercase input
 S:"^E^I^SN^"'[("^"_DVBFORMAT_"^") DVBFORMAT="SN" ;In case garbage is passed
 S DVBDEFINSTI=$$GET1^DIQ(8989.3,"1,",217,"I") ; DEFAULT INSTITUTION #217
 I DVBFORMAT="I" Q DVBDEFINSTI ;.......................... Pointer to file 4
 I DVBFORMAT="SN" Q $$GET1^DIQ(4,DVBDEFINSTI_",",99,"E") ; Station number
 Q $$GET1^DIQ(4,DVBDEFINSTI_",",.01,"E") ; DVBNAME #.01 ; HOSTSITE
 ;
ISPARSVC(DVBSVCI) ; Extrinsic function: See Output below.
 ;
 Q $E(+$D(^DIC(49,"ACHLD",DVBSVCI))) ; ISPARSVC
 ;
 ;
LASTNAME(DVBNAME,DVBFORMAT) ; Extrinsic function: See Output below.
 ;
 S DVBFORMAT=$G(DVBFORMAT,1) I "^1^2^"'[DVBFORMAT S DVBFORMAT=1
 I DVBFORMAT=2 Q $P(DVBNAME,",")
 Q $E(DVBNAME,1,$F(DVBNAME,",")) ; Default DVBFORMAT of 1 ; LASTNAME
 ;
POSINT(DVBINPUT) ; Extrinsic function: See Output below.
 ;
 N DVBRETURN S DVBRETURN=0
 ; ZEXCEPT: N
 ;
 I DVBINPUT?1N.N S DVBRETURN=1
 I DVBINPUT<0 S DVBRETURN=0
 Q DVBRETURN ; POSINT
 ;
SPACETXT(DVBTEXT) ; Extrinsic function: See Output below.
 ;
 N DVBPOS,DVBVALUE
 Q:$G(DVBTEXT)="" ""
 Q:$L(DVBTEXT)=1 DVBTEXT
 S DVBVALUE=""
 F DVBPOS=1:1:$L(DVBTEXT) D  ;
 . S DVBVALUE=DVBVALUE_$E(DVBTEXT,DVBPOS,DVBPOS)
 . S:DVBPOS<$L(DVBTEXT) DVBVALUE=DVBVALUE_" " ; Don't add a space after last DVBCHAR
 Q DVBVALUE ; SPACETXT
 ;
STRIPSPA(DVBTEXT) ; Extrinsic function: See Output below.
 ;
 S DVBTEXT=$$STRIPSPL(DVBTEXT) ;. Strip leading spaces
 S DVBTEXT=$$STRIPSPE(DVBTEXT) ;. Strip spaces at the end
 S DVBTEXT=$$STRIPSPX(DVBTEXT) ;. Strip extra spaces between words
 Q DVBTEXT ; STRIPSPA
 ;
STRIPSPE(DVBTEXT) ; Extrinsic function: See Output below.
 ;
 N DVBCHAR,DVBPOS,DVBQUIT
 S DVBQUIT=0
 F DVBPOS=$L(DVBTEXT):-1:1 D  Q:DVBQUIT  ;
 . S DVBCHAR=$E(DVBTEXT,DVBPOS,DVBPOS)
 . I $A(DVBCHAR)=32 S DVBTEXT=$E(DVBTEXT,1,DVBPOS-1)
 . I $A(DVBCHAR)>32 S DVBQUIT=1 Q
 Q DVBTEXT ; STRIPSPE
 ;
STRIPSPL(DVBTEXT) ; Extrinsic function: See Output below.
 ;
 N DVBPOS,DVBVALUE
 I $E(DVBTEXT) Q DVBTEXT
 F DVBPOS=1:1:$L(DVBTEXT) Q:$E(DVBTEXT,DVBPOS,DVBPOS)'=" "
 S DVBVALUE=$E(DVBTEXT,DVBPOS,$L(DVBTEXT)) I DVBVALUE=" " S DVBVALUE=""
 Q DVBVALUE ; STRIPSPL
 ;
STRIPSPX(DVBTEXT) ; Extrinsic function: See Output below.
 ;
 N DVBPOS
 I $L(DVBTEXT)<2 Q DVBTEXT
 F DVBPOS=1:1:$L(DVBTEXT) I $E(DVBTEXT,DVBPOS,DVBPOS+1)="  " D  ;
 . S DVBTEXT=$E(DVBTEXT,1,DVBPOS)_$E(DVBTEXT,DVBPOS+2,999)
 . S DVBPOS=1
 Q DVBTEXT ; STRIPSPX
 ;
YESNO(DVBVALUE) ;  Extrinsic function: See Output below.
 ;
 S DVBVALUE=$$UP^XLFSTR(DVBVALUE)
 Q $S(DVBVALUE=0:"NO",DVBVALUE=1:"YES",DVBVALUE="N":"NO",DVBVALUE="Y":"YES",1:"") ; YESNO
 ;
