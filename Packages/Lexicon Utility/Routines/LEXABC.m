LEXABC ;ISL/KER - Look-up by Code ;04/19/2020
 ;;2.0;LEXICON UTILITY;**4,25,26,29,38,73,51,80,103,127**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^ICPT("BA")         ICR   5408
 ;    ^LEX(757            SACC 1.3
 ;    ^LEX(757.01         SACC 1.3
 ;    ^LEX(757.02         SACC 1.3
 ;    ^LEX(757.03         SACC 1.3
 ;    ^LEX(757.21         SACC 1.3
 ;    ^LEXT(757.2         SACC 1.3
 ;    ^TMP("LEXFND")      SACC 2.3.2.5.1
 ;    ^TMP("LEXHIT")      SACC 2.3.2.5.1
 ;    ^TMP("LEXL")        SACC 2.3.2.5.1
 ;    ^TMP("LEXLE")       SACC 2.3.2.5.1
 ;    ^TMP("LEXSCH")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$CODEABA^ICDEX     ICR   5747
 ;    $$DT^XLFDT          ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     DIC                Global Root
 ;     LEXAFMT            Display Format
 ;     LEXFIL             Filter
 ;     LEXISCD            Input is a Code
 ;               
EN(LEXSO,LEXVDT) ; Entry from LEXA
 ;
 ;   Input
 ;     LEXSO   Code     Preferred terms only
 ;             Code+    All terms
 ;     LEXVDT  Version  Date to screen against (default = today)
 ;     
 ;   Output
 ;     $$EN    1        Code found
 ;             0        Code not found
 ;             
 S LEXSO=$$UP^XLFSTR($G(LEXSO)) Q:'$L(LEXSO) 0  Q:$L(LEXSO)>40 0
 S:$D(LEXISCD) LEXISCD=$$IS(LEXSO)  N LEXLL,LEXSOA
 S:$G(^TMP("LEXSCH",$J,"LEN",0))>0 LEXLL=$G(^TMP("LEXSCH",$J,"LEN",0)) S:$G(LEXLL)'>0 LEXLL=5
 I $D(^TMP("LEXSCH",$J,"FMT",0)) S:'$D(LEXAFMT)!($G(LEXAFMT)'?1N) LEXAFMT=$G(^TMP("LEXSCH",$J,"FMT",0))
 D VDT^LEXU,BLD K ^TMP("LEXL",$J),^TMP("LEXLE",$J)
 S:$L($G(^TMP("LEXSCH",$J,"NAR",0))) LEX("NAR")=$G(^TMP("LEXSCH",$J,"NAR",0))
 Q:$D(^TMP("LEXHIT",$J)) 1
 Q 0
BLD ;   Build List
 N LEXSO2 D CLR K ^TMP("LEXSCH",$J,"LST",0),^TMP("LEXSCH",$J,"TOL",0),LEX S ^TMP("LEXSCH",$J,"NUM",0)=0,LEXSO=$G(LEXSO)
 S LEXSO2="" S:$E(LEXSO,$L(LEXSO))="+" LEXSO2=$E(LEXSO,$L(LEXSO)),LEXSO=$$TM(LEXSO,"+")
 I (LEXSO2="+"&($L(LEXSO)'>2))!(LEXSO2=""&($L(LEXSO)'>1)) D CLR Q
 I '(+($$IN(LEXSO))) D CLR Q
 D FND D:$D(^TMP("LEXFND",$J)) BEG^LEXAL Q:$D(^TMP("LEXFND",$J))  D:'$D(^TMP("LEXFND",$J)) CLR
 Q
FND ;   Find expressions
 K ^TMP("LEXL",$J),^TMP("LEXLE",$J)
 N LEXSIEN,LEXMIEN,LEXEIEN,LEXDESF,LEXDSPL,LEXDSPLA,LEXFORM,LEXFMTY,LEXS,LEXSAB,LEXSRC,LEXSDATA
 N LEXP,LEXTP,LEXTYPE,LEXFILR,LEXFORM,LEXC,LEXCSTAT,LEXDSAB,LEXSSAB,LEXLKT S LEXLKT="ABC"
 S LEXSSAB=$G(^TMP("LEXSCH",$J,"DIS",0)),U="^",LEXS=$$SCH(LEXSO)_" "
 S:'$L($G(LEXFIL))&($L($G(DIC("S")))) LEXFIL=DIC("S")
 S:'$L($G(LEXFIL))&($L($G(^TMP("LEXSCH",$J,"LEXFIL",0)))) LEXFIL=$G(^TMP("LEXSCH",$J,"LEXFIL",0))
 F  S LEXS=$O(^LEX(757.02,"AVA",LEXS)) Q:$E(LEXS,1,$L(LEXSO))'=LEXSO  D
 . S LEXEIEN=0 F  S LEXEIEN=$O(^LEX(757.02,"AVA",LEXS,LEXEIEN)) Q:+LEXEIEN=0  D
 . . I $L($G(LEXFIL)) D  Q:+($G(LEXFILR))=0
 . . . I LEXFIL'["$$SO^LEXU(Y",LEXFIL'["ONE^LEXU" D  Q
 . . . . S LEXFILR=$$EN^LEXAFIL($G(LEXFIL),+($G(^LEX(757,+($G(^LEX(757.01,LEXEIEN,1))),0))))
 . . . S LEXFILR=$$EN^LEXAFIL($G(LEXFIL),+LEXEIEN)
 . . S LEXSAB="" F  S LEXSAB=$O(^LEX(757.02,"AVA",LEXS,LEXEIEN,LEXSAB)) Q:LEXSAB=""  D
 . . . S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.02,"AVA",LEXS,LEXEIEN,LEXSAB,LEXSIEN)) Q:+LEXSIEN=0  D
 . . . . N LEXEXI,LEXSTAC,STATI,STATT S LEXSDATA=$G(^LEX(757.02,LEXSIEN,0))
 . . . . S LEXC=$P(LEXSDATA,"^",2),LEXSRC=$P(LEXSDATA,"^",3),LEXEXI=$P(LEXSDATA,"^",1)
 . . . . Q:$$INSUB(+LEXSDATA)=0
 . . . . S LEXSTAC=+$$STATCHK^LEXSRC2(LEXC,$G(LEXVDT),,LEXSRC)
 . . . . Q:'$D(LEXIGN)&(+LEXSTAC'=1)
 . . . . S LEXTYPE=+$P(LEXSDATA,"^",3)
 . . . . S LEXDSAB=$E($G(^LEX(757.03,+LEXTYPE,0)),1,3)
 . . . . S LEXMIEN=+$P(LEXSDATA,"^",4),(LEXP,LEXTP)=+$P(LEXSDATA,"^",5)
 . . . . S STATI=$$STATIEN(LEXSIEN)
 . . . . S STATT=$P(STATI,"^",2),STATI=+($P(STATI,"^",1))
 . . . . Q:'$D(LEXIGN)&(+STATI=0)
 . . . . S LEXDESF=$$DC(LEXEIEN,LEXTP)
 . . . . S LEXDSPL=$$DP(LEXS,LEXTYPE,LEXSSAB)
 . . . . S LEXDSPLA=$$DSO(+LEXEIEN,$G(LEXVDT),$G(LEXSSAB),$G(LEXDSAB))
 . . . . S LEXDSPL=$$TM($$MDS(LEXDSPL,LEXDSPLA),"/")
 . . . . S:$D(LEXIGN)&("^Pending^Inactive^"[("^"_STATT_"^")) LEXDSPL=LEXDSPL_"/"_STATT
 . . . . S LEXFORM=$$F(LEXEIEN),LEXFMTY=$P(LEXFORM,"^",1),LEXFORM=$P(LEXFORM,"^",2)
 . . . . ; NEW
 . . . . I "^1^2^3^4^17^30^31^"'[("^"_LEXTYPE_"^") D NP Q
 . . . . ; OLD
 . . . . ;I LEXTYPE>3,LEXTYPE'=17 D NP Q
 . . . . D PF
 D:$D(^TMP("LEXL",$J)) REO^LEXABC2,ADD^LEXABC2
 Q
 ; ^TMP("LEXL",$J,LEXS,LEXTYPE,LEXTP,LEXSIEN)
 ; ^TMP("LEXL",$J,(code_" "),+source,LEXTP,LEXSIEN)
PF ;     Preferred
 S:LEXP=0 LEXTP=2 Q:LEXTP=2&($G(LEXSO2)'["+")
 S ^TMP("LEXL",$J,LEXS,LEXTYPE,LEXTP,LEXSIEN)=LEXMIEN_"^"_LEXEIEN_"^"_LEXDESF_"^"_LEXDSPL_"^"_LEXFMTY_"^"_LEXFORM
 S ^TMP("LEXLE",$J,LEXEIEN)=LEXS_"^"_LEXTYPE_"^"_LEXTP_"^"_LEXSIEN
 Q
NP ;     Not Preferred
 N LEXICD S:LEXP=0 LEXTP=1
 I $D(^TMP("LEXLE",$J,LEXEIEN)) D  Q
 . N LEX1,LEX2,LEX3,LEX4,LEXD,LEXDP
 . S LEXD=^TMP("LEXLE",$J,LEXEIEN),LEX1=$P(LEXD,"^",1) Q:'$L(LEX1)  S LEX2=$P(LEXD,"^",2) Q:'$L(LEX2)
 . S LEX3=$P(LEXD,"^",3) Q:'$L(LEX3)  S LEX4=$P(LEXD,"^",4) Q:'$L(LEX4)
 . S LEXD=$G(^TMP("LEXL",$J,LEX1,LEX2,LEX3,LEX4)) Q:'$L(LEXD)
 . S LEXDP=$P(LEXD,"^",4) S:$L(LEXDP) LEXDP=LEXDP_"/"_LEXDSPL S:'$L(LEXDP) LEXDP=LEXDSPL
 . S $P(LEXD,"^",4)=LEXDP,^TMP("LEXL",$J,LEX1,LEX2,LEX3,LEX4)=LEXD
 ; NEW
 S LEXICD=$$D10ONE^LEXU(LEXEIEN)
 ; OLD
 ;S LEXICD=$$ICDONE^LEXU(LEXEIEN)
 I '$L(LEXICD) D  Q
 . S ^TMP("LEXL",$J,LEXS,LEXTYPE,LEXTP,LEXSIEN)=LEXMIEN_"^"_LEXEIEN_"^"_LEXDESF_"^"_LEXDSPL_"^"_LEXFMTY_"^"_LEXFORM
 . S ^TMP("LEXLE",$J,LEXEIEN)=LEXS_"^"_LEXTYPE_"^"_LEXTP_"^"_LEXSIEN
 I $L(LEXICD) D  Q
 . ; NEW
 . I $L(LEXDSPL),LEXSO2["+",LEXDSPL'[("ICD-10-CM "_LEXICD) D
 . . S LEXDSPL=LEXDSPL_"/ICD-10-CM "_LEXICD S LEXDSPL=$$TM(LEXDSPL,"/")
 . ; OLD
 . ;S:$L(LEXDSPL)&(LEXSO2["+") LEXDSPL=LEXDSPL_"/ICD-9-CM "_LEXICD
 . I LEXSO2["+",$D(^TMP("LEXL",$J,LEXS,1)) D  Q
 . . S ^TMP("LEXL",$J,LEXS,1,4,LEXSIEN)=LEXMIEN_"^"_LEXEIEN_"^"_LEXDESF_"^"_LEXDSPL_"^"_LEXFMTY_"^"_LEXFORM
 . . S ^TMP("LEXLE",$J,LEXEIEN)=LEXS_"^1^3^"_LEXSIEN
 . S LEXTP=1,^TMP("LEXL",$J,LEXS,LEXTYPE,LEXTP,LEXSIEN)=LEXMIEN_"^"_LEXEIEN_"^"_LEXDESF_"^"_LEXDSPL_"^"_LEXFMTY_"^"_LEXFORM
 . S ^TMP("LEXLE",$J,LEXEIEN)=LEXS_"^"_LEXTYPE_"^"_LEXTP_"^"_LEXSIEN
 Q
 ; 
 ; Miscellaneous
F(X) ;   Form
 N LEX S LEX=$G(X) S LEX=+($G(LEX)),LEX=+($P($G(^LEX(757.01,LEX,1)),"^",2))
 S X=$S(LEX=1:"A^Concept:  ",LEX=2:"B^Synonym:  ",LEX=3:"C^Variant:  ",LEX=4:"D^Related:  ",LEX=5:"E^Modified: ",1:"F^Other:    ")
 Q X
DE(X) ;   Deactivated 757.01
 N LEX S LEX=+($G(X)) Q:'$D(^LEX(757.01,LEX,0)) 1
 Q:'$D(LEXIGN)&(+($P($G(^LEX(757.01,LEX,1)),"^",5))=1) 1
 S LEX=+($G(^LEX(757.01,LEX,1))) Q:'$D(^LEX(757,LEX,0)) 1
 S LEX=+($G(^LEX(757,LEX,0))) Q:'$D(^LEX(757.01,LEX,1)) 1
 Q:'$D(LEXIGN)&(+($P($G(^LEX(757.01,LEX,1)),"^",5))=1) 1
 Q 0
DC(X,Y) ;   Description Flag
 N LEX,LEXT,LEXD,LEXM S LEX=$G(X),LEXT=$G(Y),LEXD="",LEX=+($G(LEX))
 S LEXM=$P($G(^LEX(757.01,+($G(LEX)),1)),"^",1),LEXM=+($G(^LEX(757,+($G(LEXM)),0)))
 S:$D(^LEX(757.01,LEXM,3))&(+($G(LEXT))'=2) LEXD="*" S X=$G(LEXD)
 Q X
DP(X,Y,A) ;   Display
 N LEXA,LEXS,LEXT,LEXD S LEXS=$G(X),LEXT=+($G(Y)),LEXD=$G(A)
 S LEXA=$E($P($G(^LEX(757.03,LEXT,0)),"^",1),1,3)
 Q:'$L(LEXD) ""  Q:'$L(LEXA) ""  Q:LEXD'[LEXA ""
 S LEXT=$P($G(^LEX(757.03,LEXT,0)),"^",2)
 S LEXS=$G(LEXS) S:$E(LEXS,$L(LEXS))=" " LEXS=$E(LEXS,1,($L(LEXS)-1))
 S:$L(LEXS)&($L(LEXT)) LEXS=LEXT_" "_LEXS Q:$L(LEXS)&($L(LEXT)) LEXS
 Q ""
DSO(X,Y,A,B) ;   Display Sources String
 N LEXT,LEXS,LEXD,LEXIEN,LEXSAB,LEXVDT S LEXVDT=$G(Y),LEXS=$G(A),LEXD=$G(B),LEXIEN=+($G(X)) Q:+LEXIEN'>0 ""
 S LEXT=$G(LEXS),LEXSAB=$G(LEXD) S LEXT=$$TM(LEXT,"/") S X=$$SO^LEXASO(LEXIEN,LEXT,1,$G(LEXVDT)) Q:$L(X) X
 S:$L(LEXSAB)=3&(LEXT'[LEXSAB) LEXT=LEXT_"/"_LEXSAB S LEXT=$$TM(LEXT,"/")
 Q X
MDS(X,Y) ;   Merge Display Strings
 N LEXD,LEXA S LEXD=$G(X),LEXA=$G(Y) F  Q:LEXA'[") ("  S LEXA=$P(LEXA,") (",1)_"/"_$P(LEXA,") (",2,4000)
 S LEXA=$TR(LEXA,"(",""),LEXA=$TR(LEXA,")","")
 Q:'$L($G(LEXD)) LEXA S:LEXA'[$G(LEXD) LEXA=LEXD_"/"_LEXA S X=$G(LEXA)
 Q X
CLR ;   Clear
 K ^TMP("LEXFND",$J),^TMP("LEXHIT",$J),^TMP("LEXL",$J),LEX S LEX=0 Q
CLR2 ;   Clear 2
 N LEXIGN
 Q
IN(X) ;   Flag in/not in file 757.02
 Q:$O(^LEX(757.02,"AVA",(($$SCH($E($G(X),1,61)))_" ")))[$G(X) 1
 Q 0
SCH(X) ;   Search
 S X=$E($G(X),1,($L($G(X))-1))_$C($A($E($G(X),$L($G(X))))-1)_"~" Q X
INSUB(X) ;   Check if selected code in vocab
 N LEXFLN,LEXVOC,SUBIEN,LEXEIEN S LEXEIEN=$G(X)
 S LEXFLN=$G(^TMP("LEXSCH",$J,"FLN",0)) Q:LEXFLN=""!(LEXFLN="757.01") 1
 S LEXVOC=$G(^TMP("LEXSCH",$J,"VOC",0)) Q:LEXVOC=""!(LEXVOC="WRD") 1
 Q:$D(^LEXT(757.2,"AA",LEXVOC))'=10 1
 S SUBIEN=$O(^LEXT(757.2,"AA",LEXVOC,"")) Q:+SUBIEN'>0 1
 Q:$$INPSUB(LEXEIEN,SUBIEN) 1
 Q 0
INPSUB(X,Y) ;   Check if concept X is member of subset Y
 N LEXPRF,LEXSUB S LEXPRF=$G(X),LEXSUB=$G(Y) S LEXPRF=$G(X) Q:'$L(LEXPRF) 0
 N LEXIN,LEXSIEN S LEXSIEN="",LEXIN=0
 F  S LEXSIEN=$O(^LEX(757.21,"B",LEXPRF,LEXSIEN)) Q:LEXSIEN=""  D  Q:LEXIN=1
 . I $P(^LEX(757.21,LEXSIEN,0),U,2)=$G(LEXSUB) S LEXIN=1
 S X=LEXIN
 Q X
STATIEN(X) ;   Status of code-expression pairing based on code IEN
 N STATDAT,STATIEN,LEXH,LEXI,LEXT,LEXTD,LEXCIEN S LEXT="",LEXCIEN=+($G(X))
 Q:'$D(^LEX(757.02,LEXCIEN)) 0  I $D(LEXIGN) D
 . N LEXTD S LEXTD=$G(DT) S:LEXTD'?7N LEXTD=$$DT^XLFDT
 . S LEXH=$O(^LEX(757.02,LEXCIEN,4,"B",(LEXTD+.00001)),-1)
 . I LEXH'?7N,$O(^LEX(757.02,LEXCIEN,4,"B",(LEXTD-.00001)))>0 S LEXT="Pending" Q
 . S LEXI=$O(^LEX(757.02,LEXCIEN,4,"B",+LEXH," "),-1)
 . S LEXT=$P($G(^LEX(757.02,LEXCIEN,4,+LEXI,0)),"^",2)
 . S LEXT=$S(LEXT="1":"",LEXT="0":"Inactive",1:"")
 I $D(LEXIGN) Q:LEXT="Pending" "0^Pending"
 S STATDAT=$O(^LEX(757.02,LEXCIEN,4,"B",$S($G(LEXVDT)'="":(LEXVDT+.001),1:"")),-1)
 S STATIEN=$O(^LEX(757.02,LEXCIEN,4,"B",+STATDAT,""),-1)
 S STATDAT=+$P($G(^LEX(757.02,LEXCIEN,4,+STATIEN,0)),"^",2)
 S:$D(LEXIGN)&($L($G(LEXT))) STATDAT=STATDAT_"^"_LEXT S X=$G(STATDAT)
 Q X
NONPLUS(X) ;   Remove trialing plus (+)
 Q $$TM($G(X),"+")
IS(X) ;   Is X a Code
 N CODE,ISACODE S CODE=$G(X),ISACODE=0
 ;     If the user searched for a VA code then $$IS=1
 Q:$O(^LEX(757.02,"ADX",(CODE_" ")))[CODE 1
 Q:$O(^LEX(757.02,"APR",(CODE_" ")))[CODE 1
 Q:$O(^LEX(757.02,"AVA",(CODE_" ")))[CODE 1
 ;     If the user input is a valid code then $$IS=1
 Q:$D(^ICPT("BA",(CODE_" "))) 1
 Q:$$CODEABA^ICDEX(CODE,80,1)>0 1
 Q:$$CODEABA^ICDEX(CODE,80,30)>0 1
 Q:$$CODEABA^ICDEX(CODE,80.1,2)>0 1
 Q:$$CODEABA^ICDEX(CODE,80.1,31)>0 1
 ;     If the user input is a valid pattern match then $$IS=1
 Q:(CODE?5N)!(CODE?1A4N)!(CODE?4N1"T")!(CODE?4N1"F") 1
 Q:(CODE?3N1"."2N)!(CODE?3N1"."1N)!(CODE?3N1".") 1
 Q:(CODE?1"E"3N1"."2N)!(CODE?1"E"3N1"."1N)!(CODE?1"E"3N1".") 1
 Q:(CODE?1"V"2N1"."2N)!(CODE?1"V"2N1"."1N)!(CODE?1"V"2N1".") 1
 Q:(CODE?2N1"."2N)!(CODE?2N1"."1N)!(CODE?2N1".") 1
 S X=+ISACODE Q X
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" " F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
