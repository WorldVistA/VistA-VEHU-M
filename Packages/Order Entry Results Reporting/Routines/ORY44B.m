ORY44B ; SLC/PKS-KR Remove Terminated Users (get DD info) ; [11/8/99 1:45pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**44**;Dec 17, 1997
 Q
 ;          
INFO(FILE,FIELD,ORA) ;
 ;          
 ;     DIC       Global Root for <FILE>
 ;     LOC       Global Subscript Location  (#;#) for <FIELD>
 ;          
 ;     INFO(<file #>,<field #>,.ARRAY)
 ;           
 ;       Returns
 ;            
 ;         ARRAY("DIC",0)=Global Root
 ;         ARRAY("DIC",1)=File Root
 ;         ARRAY("DIC",2)=Subfile Root
 ;         ARRAY("DIC",..)=Subfile Root
 ;         ARRAY("FILE")=Target File/Subfile Number
 ;         ARRAY("FIELD")=Target Field
 ;         ARRAY("NAME")=Target Field Name
 ;         ARRAY("LOC")=Subscript and Piece
 ;            
 N DIC,LOC,SUB,SUBI,SFS,SNS S (DIC,LOC)="",FILE=+($G(FILE)),FIELD=+($G(FIELD))
 Q:FILE=0!(FIELD=0)  Q:'$D(^DD(FILE))
 S ORA("FILE")=FILE,ORA("FIELD")=FIELD
 D GETDD
 S:$L(DIC) ORA("DIC",0)=$P(DIC,"(",1)_"(",ORA("DIC",1)=DIC
 S:$L($G(SFS)) ORA("DIC",1,"P")=SFS
 S:$L(LOC) ORA("LOC")=LOC
 Q
GETDD ; Get file roots from DD
 ;          
 ;     FILE      Current File #
 ;     FIELD     Current Field #
 ;     DIC       Current Global Root
 ;     LOC       Current Global Subscript Location  (#;#)
 ;     ARY(      Temporay Storage Array (contains DD)
 ;     ORA(      Output Array
 ;          
 N ARY M ARY(FILE,FIELD,0)=^DD(FILE,FIELD,0)
 M ARY(FILE,0,"UP")=^DD(FILE,0,"UP")
 S ORA("NAME")=$P($G(ARY(FILE,FIELD,0)),"^",1)
 S:'$L($G(LOC))&($D(ARY(FILE,FIELD,0))) LOC=$P(ARY(FILE,FIELD,0),"^",4)
 D CURRDD:'$D(ARY(FILE,0,"UP")),NEXTDD:$D(ARY(FILE,0,"UP"))
 Q
CURRDD ; Current DD
 ;          
 ;     FILE      Current File #
 ;     DIC       Current Global Root
 ;     SFS       Subfile Specifier Array
 ;     ARY(      Temporary Storage Array (contains DD)
 ;               
 S DIC=$$ROOT^DILFD(FILE,0,"GL")
 S SFS=$P($$ROOT^DILFD(FILE,0),"^",2)
 Q
NEXTDD ; Next DD Level (for subfiles)
 ;          
 ;     OLDFILE   Previous File #
 ;     OLDFIELD  Previous Field #
 ;     OLDDIC    Previous Global Root
 ;     OLDLOC    Previous Global Subscript Location  (#;#)
 ;     FILE      Current File #
 ;     FIELD     Current Field #
 ;     DIC       Current Global Root
 ;     SNS       Subfile Number and Subfile Specifier
 ;     LOC       Current Global Subscript Location  (#;#)
 ;     ARY(      Temporay Storage Array (contains DD)
 ;     ORA(      Output Array
 ;     SUB(      Subscript Array
 ;     SFS(      Subfile Specifier Array
 ;     SUBI      Subscript Counter
 ;     SS        Subscript
 ;     DA        Internal Entry Number Array
 ;     CT1       Miscellaneous Counter #1
 ;     CT2       Miscellaneous Counter #2
 ;          
 N FILE2,FIELD2,DIC2,LOC2,CT1,CT2
 S LOC2=LOC,(FILE2,FIELD2)=FILE N FILE,FIELD,DIC
 S FILE=$G(ARY(FILE2,0,"UP"))
 N ARY M ARY(FILE,"SB",FIELD2)=^DD(FILE,"SB",FIELD2)
 S FIELD=$O(ARY(FILE,"SB",FILE2,0))
 M ARY(FILE,FIELD,0)=^DD(FILE,FIELD,0)
 S SNS=$P($G(ARY(FILE,FIELD,0)),"^",2)
 S SUBI=+($O(SUB(" "),-1)),SUBI=SUBI+1
 S SUB(SUBI)=$P($P($G(ARY(FILE,FIELD,0)),"^",4),";",1),DIC=""
 S SFS(SUBI)=SNS
 D GETDD
 S LOC=LOC2 I $L(DIC) D
 . S ORA("DIC",0)=$P(DIC,"(",1)_"(",ORA("DIC",1)=DIC
 . N DA,SS F CT1=SUBI:-1:1 S DA="DA("_CT1_")",DIC=DIC_DA_"," D
 . . F CT2=SUBI:-1:1 D
 . . . S SS=$G(SUB(CT2)),DIC=DIC_SS_",",ORA("DIC",(CT2+1))=DIC S:$L($G(SFS(CT2))) ORA("DIC",(CT2+1),"P")=$G(SFS(CT2))
 Q
 ;
TERM(X) ; Terminated
 ;          
 ;    Returns:    Status^Explanation - 
 ;             
 ;       2 = Terminated
 ;       1 = Future Termination
 ;       0 = Not Terminated
 ;      -1 = Error^Error Text
 ;            
 ;     USR       New Person
 ;     NAM       New Person Name
 ;     NOW       Today's Date
 ;     %         Fileman Date and Time
 ;     %I(       Fileman Date Array
 ;     %H        $H Date and Time
 ;     X         Today
 ;     ORLPERR   Error Array
 ;     ORLPUSR   New Person Holder
 ;
 N USR,USRITD,NAM,NOW,%,%I,%H,ORLPERR,ORLPUSR S USR=+($G(X)) Q:USR=0 "-1^Invalid User"
 Q:'$D(^VA(200,+USR,0)) "-1^User not found"
 Q:'$L($P($G(^VA(200,+USR,0)),"^",1)) "-1^Invalid User (no name)"
 S NAM=$P($G(^VA(200,+USR,0)),"^",1)
 D NOW^%DTC S NOW=X
 S ORLPUSR=USR
 S USRITD=$$GET1^DIQ(200,ORLPUSR,9.2,"I",,.ORLPERR) Q:$D(ORLPERR) "-1^Invalid User"
 Q:USRITD="" ("0^User ("_NAM_") is an active user")
 Q:+USRITD=0 ("0^User ("_NAM_")  is an active user")
 Q:+USRITD'>NOW ("2^User ("_NAM_") has been terminated")
 Q:+USRITD<NOW ("1^User ("_NAM_") will be terminated on "_$$FMTE^XLFDT(USRITD))
 Q "-1^Undetermined"
 ;
