PXEDUINQ ;SLC/PKR - Education Topic Inquire. ;03/21/2022
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211,217**;Aug 12, 1996;Build 134
 ;
 ;==========================================
BEDUINQ(IEN) ;Display an Education Topic inquiry, defaults to the Browser.
 N BOP,DIR0,OUTPUT,TITLE,TYPE
 I '$D(^AUTTEDT(IEN)) Q
 S TITLE="Education Topic Inquiry"
 D EDUINQ(IEN,.OUTPUT)
 S BOP=$$BORP^PXUTIL("B")
 I BOP="" Q
 I BOP="B" D BROWSE^DDBR("OUTPUT","NR",TITLE)
 I BOP="P" D GPRINT^PXUTIL("OUTPUT")
 Q
 ;
 ;==========================================
EDUINQ(IEN,OUTPUT) ;Education Topic inquiry, return the formatted text
 ;in OUTPUT.
 ;Use 80 column output.
 N CODE,CODELIST,CODESYS,INDXDT,MAPDT,NL,IENSTR,NSP,RM,SEQ,SUBT
 N TEMP,TEXT,WPARRAY
 S RM=80
 S TEMP=^AUTTEDT(IEN,0)
 S IENSTR="No. "_IEN
 S OUTPUT(1)=$$REPEAT^XLFSTR("-",RM)
 S TEXT=$P(TEMP,U,1)
 S NSP=RM-$L(TEXT)-1
 S OUTPUT(2)=TEXT_$$RJ^XLFSTR(IENSTR,NSP," ")
 S OUTPUT(3)=$$REPEAT^XLFSTR("-",RM)
 S OUTPUT(4)="Print Name: "_$P(TEMP,U,4)
 S OUTPUT(5)="Class: "_$$GET1^DIQ(9999999.09,IEN,100)
 S OUTPUT(6)="Sponsor: "_$$GET1^DIQ(9999999.09,IEN,101)
 S OUTPUT(7)="Inactive Flag: "_$$GET1^DIQ(9999999.09,IEN,.03)
 S OUTPUT(8)=""
 S OUTPUT(9)="Description:"
 S NL=9
 S TEMP=$$GET1^DIQ(9999999.09,IEN,201,"","WPARRAY")
 I TEMP="" S NL=NL+1,OUTPUT(NL)=""
 I TEMP="WPARRAY" D
 . S IND=0
 . F  S IND=$O(WPARRAY(IND)) Q:IND=""  S NL=NL+1,OUTPUT(NL)=WPARRAY(IND)
 . K WPARRAY
 . S NL=NL+1,OUTPUT(NL)=""
 ;
 K TEMP,WPARRAY
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="Educational Outcome:"
 S TEMP=$$GET1^DIQ(9999999.09,IEN,11,"","WPARRAY")
 I TEMP="" S NL=NL+1,OUTPUT(NL)=""
 I TEMP="WPARRAY" D
 . S IND=0
 . F  S IND=$O(WPARRAY(IND)) Q:IND=""  S NL=NL+1,OUTPUT(NL)=WPARRAY(IND)
 . K WPARRAY
 . S NL=NL+1,OUTPUT(NL)=""
 ;
 K TEMP,WPARRAY
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="Educational Standards:"
 S TEMP=$$GET1^DIQ(9999999.09,IEN,12,"","WPARRAY")
 I TEMP="" S NL=NL+1,OUTPUT(NL)=""
 I TEMP="WPARRAY" D
 . S IND=0
 . F  S IND=$O(WPARRAY(IND)) Q:IND=""  S NL=NL+1,OUTPUT(NL)=WPARRAY(IND)
 . K WPARRAY
 . S NL=NL+1,OUTPUT(NL)=""
 ;
 ;Mapped Codes.
 S IND=0
 F  S IND=+$O(^AUTTEDT(IEN,210,IND)) Q:IND=0  D
 . S TEMP=^AUTTEDT(IEN,210,IND,0)
 . S CODESYS=$P(TEMP,U,1),CODE=$P(TEMP,U,2)
 . S MAPDT=$P(TEMP,U,3),INDXDT=$P(TEMP,U,4)
 . I CODE'="" S CODELIST(CODESYS,CODE)=MAPDT_U_INDXDT
 D MCDISP^PXMCODES(.CODELIST,.NL,.OUTPUT)
 ;
 ;Deleted code mappings.
 I $P($G(^AUTTEDT(IEN,230,0)),U,4)>0 D
 . S NL=NL+1,OUTPUT(NL)=""
 . S NL=NL+1,OUTPUT(NL)=""
 . S NL=NL+1,OUTPUT(NL)="Deleted Code Mappings"
 . S IND=0
 . F  S IND=+$O(^AUTTEDT(IEN,230,IND)) Q:IND=0  D
 .. S TEMP=^AUTTEDT(IEN,230,IND,0)
 .. S NL=NL+1,OUTPUT(NL)=""
 .. S NL=NL+1,OUTPUT(NL)=" Coding System: "_$P(TEMP,U,1)_"  Code: "_$P(TEMP,U,2)
 .. S NL=NL+1,OUTPUT(NL)=" Date deleted: "_$$FMTE^XLFDT($P(TEMP,U,3),"5Z")
 .. S OUTPUT(NL)=OUTPUT(NL)_"  Deleted by: "_$$GET1^DIQ(200,$P(TEMP,U,4),.01)
 .. S NL=NL+1,OUTPUT(NL)=" Mapped Source Entry removal completion date: "_$$FMTE^XLFDT($P(TEMP,U,5),"5Z")
 . S NL=NL+1,OUTPUT(NL)=""
 ;
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="                             Value Range"
 S TEMP=$G(^AUTTEDT(IEN,220))
 I TEMP="" S NL=NL+1,OUTPUT(NL)="Not defined"
 E  D
 . S NL=NL+1,OUTPUT(NL)=" Minimum Value                Maximum Value           UCUM Code"
 . S NL=NL+1,OUTPUT(NL)=$S($E(TEMP,1)="-":"",1:" ")_$P(TEMP,U,1)
 . S LEN=$L(OUTPUT(NL)),NSP=30-LEN
 . S OUTPUT(NL)=OUTPUT(NL)_$$REPEAT^XLFSTR(" ",NSP)_$P(TEMP,U,2)
 . N UCUMDATA,UCUMIEN
 . S UCUMIEN=+$P(TEMP,U,4)
 . I UCUMIEN>0 D
 ..;ICR #6225
 .. D UCUMDATA^LEXMUCUM(UCUMIEN,.UCUMDATA)
 .. S LEN=$L(OUTPUT(NL)),NSP=54-LEN
 .. S OUTPUT(NL)=OUTPUT(NL)_$$REPEAT^XLFSTR(" ",NSP)_UCUMDATA(UCUMIEN,"UCUM CODE")
 .. S NL=NL+1,OUTPUT(NL)=""
 .. S NL=NL+1,OUTPUT(NL)="UCUM Description: "_UCUMDATA(UCUMIEN,"DESCRIPTION")
 .. S NL=NL+1,OUTPUT(NL)="Prompt Caption: "_$P(TEMP,U,5)
 .. S NL=NL+1,OUTPUT(NL)="UCUM Display: "_$$EXTERNAL^DILFD(9999999.09,225,"",$P(TEMP,U,6))
 ;
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="      Subtopics"
 I +$P($G(^AUTTEDT(IEN,10,0)),U,4)=0 S NL=NL+1,OUTPUT(NL)=" None defined" Q
 S NL=NL+1,OUTPUT(NL)=" Seq    Subtopic"
 S IND=0
 F  S IND=+$O(^AUTTEDT(IEN,10,IND)) Q:IND=0  D
 . S TEMP=^AUTTEDT(IEN,10,IND,0)
 . S SUBT=$P(TEMP,U,1),SEQ=$P(TEMP,U,3)
 . S NL=NL+1,OUTPUT(NL)=$$RJ^XLFSTR(SEQ,4," ")_"   "_$$GET1^DIQ(9999999.09,SUBT,.01)
 Q
 ;
