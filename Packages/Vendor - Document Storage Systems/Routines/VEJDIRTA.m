VEJDIRTA ;DSS/DBB;IRT INCOMPLETE REPORTS - DATA ACCESS & SEARCH
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 Q
GETDATA(SUCCESS,IEN) ; Get IRT record
 ; SUCCESS(0) = 0
 ;         = -1^Explanatory message if no SUCCESS
 ; SUCCESS(1...N) = field# ^ field name ^ internal value ^ external value
 ; IEN = record # in IRT file to retrieve
 N X,X1,X2,FILE,FLD,TYPE,IFLD,J,MES
 D INIT Q:$D(SUCCESS)
 S IFLD=0,J=0 F  S IFLD=$O(^DD(FILE,IFLD)) Q:'IFLD  S X=^(IFLD,0) S TYPE=$P(X,"^",2) D:TYPE'["W"
 . S FLD=$P(X,"^")
 . S X1=$$GET1^DIQ(FILE,IEN_",",IFLD,"I","","MES") Q:$D(MES)
 . S X2=$$GET1^DIQ(FILE,IEN_",",IFLD,"","","MES") Q:$D(MES)
 . S X3="" I IFLD=.01 S X3=$$GET1^DIQ(FILE,IEN_",",".01:.09","","","MES") Q:$D(MES)
 . I IFLD=.02,X1'="" S X3=$$GET1^DIQ(FILE,IEN_",",".02:.02","","","MES") Q:$D(MES)
 . I IFLD=.04,X1'="" S X3=$$GET1^DIQ(FILE,IEN_",",".04:.01","I","","MES") Q:$D(MES)
 . I ".09,.1,.12,.14"[IFLD,X1'="" S X3=$$GET1^DIQ(FILE,IEN_",",IFLD_":53.3","I","","MES") Q:$D(MES)
 . S J=J+1,SUCCESS(J)=IFLD_"^"_FLD_"^"_X1_"^"_X2_"^"_X3
 I '$D(MES) S SUCCESS(0)=J Q
 D MES Q
MES N X
 S X="-1^" F I=1:1:MES("DIERR") S X=X_"^ "_MES("DIERR",I,"TEXT",1) Q:$L(X)>500
 S SUCCESS(0)=X
 Q
INIT N X S FILE=393 K SUCCESS
 Q:IEN="*"  I '$G(IEN) S SUCCESS(1)="-1^NO IEN SPECIFIED" Q
 S X=^DIC(FILE,0,"GL")_+IEN_",0)" I '$D(@X) S SUCCESS(0)="-1^RECORD #"_IEN_" IN FILE: "_FILE_" DOES NOT EXIST" Q
 S IEN=+IEN_","
 I '$G(FILE) S SUCCESS(1)="-1^NO FILE SPECIFIED" Q
 K ^TMP("VEJDIRTA",$J)
 Q
TESTG ;K  D GETDATA(.SUCCESS,2678) ZW
 Q
SRCHPAT(SUCCESS,IENPAT,BEGDAT,ENDDAT,IENDIV,INOUT) N ANSWER,BEGDAT0,ENDDAT0,II,JJ,P,X,MES
 ; SUCCESS(0) =0 if no records exist
 ;                        >0 is the count of existing records
 ;         = -1^Explanatory message if no SUCCESS
 ; SUCCESS(1...N) = IRT record numbers ^ EVENT DATE in Internal FM 
 ; BEGDAT = BEGINNING DATE
 ; ENDDAT = ENDING DATE
 ; IENPAT = patient # to retrieve deficiencies for.
 ; IENDIV = Internal Division # (optional - all divisions are returned if null)
 ; INOUT = I:Inpatients, O:Outpatients, B:Both - OPTIONAL - DEFAULT="B"
 I '$G(IENPAT) S SUCCESS(0)="-1^NO PATIENT IEN SPECIFIED" Q
 I '$G(IENDIV)'?.N S SUCCESS(0)="-1^INVALID DIVISION IEN SPECIFIED" Q
 S ANSWER=0 I $G(ENDDAT)'="" K MES D DT^DILF("T",ENDDAT,.ANSWER,"","MES") I $D(MES) D MES Q
 S ENDDAT0=ANSWER
 S ANSWER=0 I $G(BEGDAT)'="" K MES D DT^DILF("T",BEGDAT,.ANSWER,"","MES") I $D(MES) D MES Q
 S BEGDAT0=ANSWER
 S X=$G(INOUT) S X=$S("Bb"[X:"","Ii"[X:"I","Oo"[X:"O",1:"-1^Illegal IN/OUT specification - must be I,O,B or null")
 I X<0 S SUCCESS(0)=X Q
 S INOUT=X
 K MES S II=0,JJ=0 F  S II=$O(^VAS(393,"B",IENPAT,II)) Q:'II  D  Q:$D(MES)
 . S X=$G(^VAS(393,II,0))
 . I BEGDAT0,$P(X,"^",3)<BEGDAT0,$P(X,"^",3) Q
 . I ENDDAT0,$P(X,"^",3)\1>ENDDAT0 Q
 . I $G(IENDIV),$P(X,"^",6)'=IENDIV Q
 . I INOUT="I",'$P(X,"^",4) Q
 . I INOUT="O",$P(X,"^",4) Q
 . S X1=$$GET1^DIQ(393,II_",",.11,"E","","MES") Q:$D(MES)
 . S X2=$$GET1^DIQ(393,II_",",.02,"E","","MES") Q:$D(MES)
 . S X3=$$GET1^DIQ(393,II_",",".02:.02","E","","MES") Q:$D(MES)
 . S X=$G(^VAS(393,II,0))
 . S JJ=JJ+1,SUCCESS(JJ)=II_"^"_$P(X,"^",3)_"^"_$P(X,"^",11)_"^"_X1_"^"_$P(X,"^",2)_"^"_X2_"^"_X3
 I $D(MES) Q
 S SUCCESS(0)=JJ
 Q
TESTP ;K  D SRCHPAT(.SUCCESS,441,"1/1/99","T","","") ZW
 Q
SRCHDAT(SUCCESS,BEGDAT,ENDDAT,IENDIV,INOUT,IENATD) N ANSWER,BEGDAT0,ENDDAT0,II,JJ,X,MES
 ; SUCCESS(0) =0 if no records exist
 ;                        >0 is the count of existing records
 ;         = -1^Explanatory message if no SUCCESS
 ; SUCCESS(1...N) = IRT record numbers
 ; BEGDAT = BEGINNING DATE
 ; ENDDAT = ENDING DATE
 ; IENDIV = Internal Division # (optional - all divisions are returned if null)
 ; INOUT = I:Inpatients, O:Outpatients, B:Both - OPTIONAL - DEFAULT="B"
 ; IENATP = ATTENDING PHYSICIAN IEN (OPTIONAL)
 N MES
 I $G(BEGDAT)="" S SUCCESS(0)="-1^NO BEGINNING DATE SPECIFIED" Q
 I '$G(IENDIV)'?.N S SUCCESS(0)="-1^INVALID DIVISION IEN SPECIFIED" Q
 S X=$G(INOUT) S X=$S("Bb"[X:"","Ii"[X:"I","Oo"[X:"O",1:"-1^Illegal IN/OUT specification - must be I,O,B or null")
 I X<0 S SUCCESS(0)=X Q
 S INOUT=X,IENATD=$G(IENATD)
 I 'IENATD'?.N S SUCCESS(0)="-1^INVALID ATTENDING PHYSICIAN IEN SPECIFIED" Q
 I ENDDAT="" S ENDDAT="T+1"
 K MES D DT^DILF("T",ENDDAT,.ANSWER,"","MES") I $D(MES) D MES Q
 S ENDDAT0=ANSWER
 K MES D DT^DILF("T",BEGDAT,.ANSWER,"","MES") I $D(MES) D MES Q
 S BEGDAT0=ANSWER
 I BEGDAT0>ENDDAT0 S SUCCESS(0)="-1^Beginning date > Ending date" Q
 S JJ=0 F  S BEGDAT0=$O(^VAS(393,"C",BEGDAT0)) Q:BEGDAT0>ENDDAT0!'BEGDAT0  D
 . S II=0 F  S II=$O(^VAS(393,"C",BEGDAT0,II)) Q:'II  D
 .. S X=$G(^VAS(393,II,0))
 .. I $G(IENDIV),$P(X,"^",6)'=IENDIV Q
 .. I INOUT="I",'$P(X,"^",4) Q
 .. I INOUT="O",$P(X,"^",4) Q
 .. I IENATD,$P(X,"^",10)'=IENATD Q
 .. S JJ=JJ+1,SUCCESS(JJ)=II ;_"^"_^VAS(393,II,0)
 S SUCCESS(0)=JJ
 Q
TESTD ;K  D SRCHDAT(.SUCCESS,"T-500","3/09/02",2,"I",11830) ZW
 Q
SETDATA(SUCCESS,IEN,DATA) ; Set IRT record data
 ; SUCCESS(0) = 0^ if OK, or IEN^ if created new record
 ;         = -1^Explanatory message if no SUCCESS
 ; IEN = record # in IRT file to update
 ;       IF = "*" then this is a NEW record and all required fields must be present.
 ; DATA = array of data to set.  
 ; Each array value is a PAIR in the form: "field identifier ^ data"
 ;               field identifier = either numeric FIELD # or the FIELD NAME.
 ;               data = any legal date format (if a date field), textual data,
 ;                       or if a POINTER, prefaced with ` (left single quote)
 ;                       (e.g. '19 means pointer value = 19)
 N X,X1,X2,FILE,FLD,TYPE,I,J,MES
 D INIT Q:$D(SUCCESS)
 S II="",FLD="",Q=0 F  S II=$O(DATA(II)) Q:'II  S FLD=$$GETFLD(II) Q:FLD<0  D  Q:Q<0
 . S TYP=$P($G(^DD(FILE,FLD,0)),"^",2) ; GET FIELD DEFINITION
 . S Q=0 I IEN="*" D  Q
 .. S FDA(FILE,"+1,",FLD)=VAL Q
 . E  I 'IEN S Q="-1^NO IEN SPECIFIED" Q
 . S FDA(FILE,IEN,FLD)=VAL Q
 I FLD<0 S SUCCESS(0)=FLD Q
 I 'Q S SUCCESS(0)=Q
 I IEN="*" D  Q
 . D UPDATE^DIE("EK","FDA","IEN","MES") I $D(MES) D MES Q
 . S SUCCESS(0)=IEN(1)_"^" Q
 D FILE^DIE("EK","FDA","MES")
 I '$D(MES) S SUCCESS(0)="0^" Q
 D MES Q
GETFLD(II) S X=DATA(II),VAL=$P(X,"^",2),(X,FLD)=$P(X,"^")
 I 'X,X'="" S X=$O(^DD(FILE,"B",X,""))
 I 'X Q "-1^FIELD '"_FLD_"' IS NOT IN FILE: '"_FILE
 Q FLD
TESTS ;K  S DATA(1)="TYPE OF DEFICIENCY^ADDENDUM"
 S DATA(2)=".03^3021220.1230"
 S DATA(3)="SPECIALTY^`19"
 S DATA(4)=".06^`2"
 D SETDATA(.SUCCESS,2704,.DATA)
 ;ZW
 Q
