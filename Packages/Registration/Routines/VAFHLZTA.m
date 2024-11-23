VAFHLZTA ;ALB/ESD,TDM,KUM - Creation of ZTA segment ;7/18/24 4:29PM
 ;;5.3;Registration;**68,653,688,806,1121**;Aug 13, 1993;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This generic extrinsic function returns the HL7 VA-Specific Temporary Address (ZTA) segment.
 ;
 ;
EN(DFN,VAFSTR,VAFNUM,HL) ; Returns HL7 ZTA segment containing temporary address
 ;                 data.
 ;
 ;  Input - DFN as internal entry number of the PATIENT file
 ;          VAFSTR as string of fields requested separated by commas.
 ;          VAFNUM as SetId - set to 1.
 ;          HL *** NOT USED, WILL BE REMOVED AT A LATER TIME ***
 ;
 ; Output - string of components forming the ZTA segment.
 ;
 N VAFNODE,VAFY,X,X1
 N COMP,HLES,VAFNODE1,HL7STRG,SQ5,CNTRY
 I '$G(DFN)!($G(VAFSTR)']"") G QUIT
 I $G(HLFS)="" N HLFS S HLFS="^"
 I $G(HL("FS"))="" S HL("FS")=HLFS
 I $G(HLQ)="" N HLQ S HLQ=""""""
 I $G(HLECH)="" N HLECH S HLECH="~|\&"
 I $G(HL("ECH"))="" S HL("ECH")=HLECH
 S COMP=$E(HLECH,1),HLES=$E(HLECH,3)
 S VAFNODE=$G(^DPT(DFN,.121)),VAFNODE1=$G(^DPT(DFN,.122))
 S $P(VAFY,HLFS,9)="",VAFSTR=","_VAFSTR_","
 S $P(VAFY,HLFS,1)=1 ; SetId equal to 1
 I VAFSTR[",2," S X=$P(VAFNODE,"^",9),$P(VAFY,HLFS,2)=$$YN^VAFHLFNC(X) ; Temporary Address Enter/Edit?
 I VAFSTR[",3," S X=$$HLDATE^HLFNC($P(VAFNODE,"^",7)),$P(VAFY,HLFS,3)=$S(X]"":X,1:HLQ) ; Temporary Address Start Date
 I VAFSTR[",4," S X=$$HLDATE^HLFNC($P(VAFNODE,"^",8)),$P(VAFY,HLFS,4)=$S(X]"":X,1:HLQ) ; Temporary Address End Date
 I VAFSTR[",5," D
 . K HL7STRG S HL7STRG=$P(VAFNODE,"^",1) D HL7TXT^VAFCQRY1(.HL7STRG,.HL,HLES) S SQ5=$S(HL7STRG="":HLQ,1:HL7STRG)
 . K HL7STRG S HL7STRG=$P(VAFNODE,"^",2) D HL7TXT^VAFCQRY1(.HL7STRG,.HL,HLES) S $P(SQ5,COMP,2)=$S(HL7STRG="":HLQ,1:HL7STRG)
 . K HL7STRG S HL7STRG=$P(VAFNODE,"^",3) D HL7TXT^VAFCQRY1(.HL7STRG,.HL,HLES) S $P(SQ5,COMP,8)=$S(HL7STRG="":HLQ,1:HL7STRG)
 . S CNTRY=$$GET1^DIQ(2,DFN_",",.1223)  ;RETURN EXTERNAL VALUE
 . I CNTRY="US" S CNTRY="USA"
 . K HL7STRG S HL7STRG=$P(VAFNODE,"^",4),$P(SQ5,COMP,3)=$S(HL7STRG="":HLQ,1:HL7STRG)
 . I CNTRY=""!(CNTRY="USA") D    ;have USA address
 . . S X=$$GET1^DIQ(5,+$P(VAFNODE,"^",5)_",",1),$P(SQ5,COMP,4)=$S(X="":HLQ,1:X)
 . . S X=$P(VAFNODE,"^",12),$P(SQ5,COMP,5)=$S(X="":HLQ,1:X)
 . I CNTRY'="",(CNTRY'="USA") D  ;Check for foreign address fields
 . . S X=$P(VAFNODE1,"^",1),$P(SQ5,COMP,4)=$S(X="":HLQ,1:X)
 . . S X=$P(VAFNODE1,"^",2),$P(SQ5,COMP,5)=$S(X="":HLQ,1:X)
 . S $P(SQ5,COMP,6)=$S(CNTRY="":HLQ,1:CNTRY)
 . S X=$$GET1^DIQ(2,DFN_",",.12111),$P(SQ5,COMP,9)=$S(X="":HLQ,1:X)
 . S $P(VAFY,HLFS,5)=SQ5
 I VAFSTR[",6," S X=$$GET1^DIQ(2,DFN_",",.12111),$P(VAFY,HLFS,6)=$S(X="":HLQ,1:X)
 I VAFSTR[",7," S X=$$HLPHONE^HLFNC($P(VAFNODE,"^",10)),$P(VAFY,HLFS,7)=$S(X]"":X,1:HLQ) ; Temporary Address Phone
 I VAFSTR[",8," S X=$$HLDATE^HLFNC($P(VAFNODE,"^",13)),$P(VAFY,HLFS,8)=$S(X]"":X,1:HLQ) ; Temp Addr Last Updated
 I VAFSTR[",9," D   ; Temp Addr Site of Change
 . S X=$P(VAFNODE,"^",14),X=$$GET1^DIQ(4,(+X)_",",99)
 . S $P(VAFY,HLFS,9)=$S(X]"":X,1:HLQ)
 ;DG*5.3*1121 - Accommodate country code, area code, phone number and extension in Sequence number 10 
 I VAFSTR[",10," D
 . S X=$P(VAFNODE,"^",10)
 . I X]"" D
 . . N DGINTPH,DGEXT,DGEXT2,DGCNTRY,DGAREA,DGPH
 . . S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 . . S COMP="~" S DGEXT="" S DGEXT2="" S DGAREA="" S DGPH=""
 . . S DGEXT=$P(X,"X",2)
 . . S DGEXT=$$CONVPHAN^VAFCQRY3(DGEXT)
 . . S DGEXT2=$$GET1^DIQ(2,DFN_",",.12117)
 . . S DGEXT2=$$CONVPHAN^VAFCQRY3(DGEXT2)
 . . I DGEXT2'="" S DGEXT=DGEXT2
 . . S DGEXT=$E(DGEXT,1,6)
 . . S DGCNTRY=$$GET1^DIQ(2,DFN_",",.12116,"I")
 . . S DGCNTRY=$$CONVPHAN^VAFCQRY3(DGCNTRY)
 . . I $G(DGCNTRY)="" S DGCNTRY=1
 . . S DGPH=$P(X,"X",1)
 . . S DGPH=$$CONVPHAN^VAFCQRY3(DGPH)
 . . S DGAREA=$E(DGPH,1,3)
 . . S DGPH=$E(DGPH,4,10)
 . . I DGPH="" S DGEXT="" S DGCNTRY="" S DGAREA=""
 . . S DGINTPH=DGCNTRY_COMP_DGAREA_COMP_DGPH_COMP_DGEXT
 . . S $P(VAFY,HLFS,10)=$S(DGINTPH]"":DGINTPH,1:HLQ)
QUIT Q "ZTA"_HLFS_$G(VAFY)
 ;
NUM(DGNUMBER,DGDIGIT,DGDEC) ; DG*5.3*1121 - Added new function NUM to determine if valid numeric value
 ; 
 ; Input:  DGNUMBER as data element to evaluate
 ;         DGDIGIT as number of digits allowed
 ;         DGDEC as number of decimal places
 ;
 N DGERROR
 S DGERROR=0
 I DGNUMBER'?.N.1".".2N S DGERROR=1 G NUMQ
 I $L($P(DGNUMBER,".",1))>DGDIGIT S DGERROR=1 G NUMQ
 I DGNUMBER<0 S DGERROR=1
NUMQ Q DGERROR
 ;
