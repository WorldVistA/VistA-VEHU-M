ISIIMP07 ;ISI Group/MLS -- Problem Create Utility
 ;;1.0;;;Jun 26,2012;Build 30
 Q
VALIDATE() 
 ; Validate import array contents
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++Read in values+++ (07)",!
 . I $D(ISIMISC) W $G(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,ISIMISC(X)
 . W !,"<HIT RETURN TO PROCEED>" R X
 . Q
 S ISIRC=$$VALPROB^ISIIMPU4(.ISIMISC)
 Q ISIRC
 ;
MAKEPROB()
 ; Create Problem entry
 S ISIRC=$$CREATE(.ISIMISC)
 Q ISIRC
 ;
CREATE(ISIMISC)
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("PROVIDER")=126 
 ;
 ; Output - ISIRC [return code]
 ;          ISIRESUL(0)=1
 ;          ISIRESUL(1)=IEN
 ;    
 N GMPDFN,GMPPROV,GMPVAMC,GMPFLD
 K GMPDFN,GMPPROV,GMPVAMC,GMPFLD
 S GMPDFN=ISIMISC("DFN") ; patient dfn
 S GMPPROV=ISIMISC("PROVIDER") ;Provider IEN
 S GMPVAMC=$$KSP^XUPARAM("INST")  
 S GMPFLD(".01")=ISIMISC("ICDIEN") ;Code IEN
 S GMPFLD(".03")=0 ;hard set
 S GMPFLD(".05")="^"_ISIMISC("EXPNM") ;Expression text
 S GMPFLD(".08")=DT ; today's date (entry?)
 S GMPFLD(".12")=ISIMISC("STATUS") ;Active/Inactive
 S GMPFLD(".13")=ISIMISC("ONSET") ;Onset date
 S GMPFLD("1.01")=ISIMISC("EXPIEN")_"^"_ISIMISC("EXPNM") ;^LEX(757.01 ien,descip
 S GMPFLD("1.03")=ISIMISC("PROVIDER") ;Entered by
 S GMPFLD("1.04")=ISIMISC("PROVIDER") ;Recording provider
 S GMPFLD("1.05")=ISIMISC("PROVIDER") ;Responsible provider
 S GMPFLD("1.06")=1018 ;MEDICAL SERVICE (#49)
 S GMPFLD("1.07")="" ; Date resolved
 S GMPFLD("1.08")="" ; Clinic (#44)
 S GMPFLD("1.09")=DT ;entry date
 S GMPFLD("1.1")=0 ;Service Connected
 S GMPFLD("1.11")=0 ;Agent Orange exposure
 S GMPFLD("1.12")=0 ;Ionizing radiation exposure
 S GMPFLD("1.13")=0 ;Persian Gulf exposure
 S GMPFLD("1.14")=ISIMISC("TYPE") ;Accute/Chronic (A,C)
 S GMPFLD("1.15")="" ;Head/neck cancer
 S GMPFLD("1.16")="" ;Military sexual trauma
 S GMPFLD("10",0)=0 ;auto set ""
 D NEW^GMPLSAVE
 I '$D(DA) Q "-1^Error creating problem"
 S ISIRESUL(0)=1
 S ISIRESUL(1)=DA
 Q 1
