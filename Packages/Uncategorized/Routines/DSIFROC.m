DSIFROC ;DSS/AMC - FEE BASIS REPORT OF CONTACT RPC'S ;03/01/2009
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ; 2053  FILE^DIE,UPDATE^DIE,WP^DIE
 ;
 ;COPIED LOGIC FROM INPUT TEMPLATES "FBCH EDIT ROC" AND "FBCH ADD ROC"
 ;
 Q
EDIT(AXY,IEN,CTPH,CTADDR,ATPHY,ATPHYPH,OTHINS,INSTYP,MOTR,APPOFF,DTOCT,NARR) ;RPC - DSIF INP EDIT ROC
 ;Input Parameters
 ;    IEN - Internal Entry Number of Contact/Fee Notification (Required - Pointer to file 162.2)
 ;        ************************************************
 ;        *** The below data share the following rules ***
 ;        *** "" - No update                           ***
 ;        *** @ - Removes existing data                ***
 ;        ************************************************
 ;    CTPH - Phone number of initial contact (Optional - Free Text 3 to 20 characters)
 ;    CTADDR - Contacts Address info (Optional - Multi-piece ";" delimited)
 ;        1 - Street Address 1 (Free Text 3 to 30 characters)
 ;        2 - Street Address 2 (Free Text 3 to 30 characters)
 ;        3 - City (Free Text 2 to 30 characters)
 ;        4 - State (Pointer to State File #5)
 ;        5 - Zip Code (Numeric 5 digits)
 ;    ATPHY - Attending Physician (Optional - Free Text 3 to 30 characters)
 ;    ATPHYPH - Attending Physician Phone (Optional - Free Text 3 to 20 characters)
 ;    OTHINS - Veteran Have Other Insurance (Optional - "Y" = Yes, "N" = No)
 ;        If OTHINS is "Y" INSTYP should be answered, if OTHINS is "N" or "@" INSTYP will be cleared out
 ;    INSTYP - Insurance Type (Optional as stated above - Free Text 3 to 30 characters)
 ;    MOTR - Mode of Transportation (Optional - Pointer to file 392.4 BENEFICIARY TRAVEL MODE OF TRANSPORTATION)
 ;    APPOFF - Approving Official (Optional - Pointer to file 200 NEW PERSON)
 ;    DTOCT - Date & Time of Contact (Optional - FileMan Date/Time)
 ;    NARR - Narrative (Optional - Word Processing Array)
 ;
 ;Return Values
 ;    -1 ^ Invalid Entry Number!
 ;    -1 ^ Other Insurance Inconsistant!
 ;    IEN = Internal Entry Number of Entry Updated (Input Parameter 1)
 ;    
 I '$D(^FBAA(161.5,+$G(IEN),0)) S AXY="-1^Invalid Entry Number!" Q
 S OTHINS=$G(OTHINS),INSTYP=$G(INSTYP)
 I OTHINS="Y","@"[INSTYP S AXY="-1^Other Insurance Inconsistant!" Q
 S CTPH=$G(CTPH),CTADDR=$G(CTADDR),ATPHY=$G(ATPHY),ATPHYPH=$G(ATPHYPH),MOTR=$G(MOTR),APPOFF=$G(APPOFF),DTOCT=$G(DTOCT),NARR=$D(NARR)
 K:CTPH="" CTPH K:ATHPY="" ATHPY K:ATPHYPH="" ATPHYPH K:MOTR="" MOTR K:APPOFF="" APPOFF
 N STRAD1,STRAD2,CITY,STATE,ZIP,IENS,FIL,DSIF,DSIF1,DSIF2,FIL2 S FIL=161.5,IENS=IEN_",",FIL2=162.2
 S ZIP=$P(CTADDR,";",5),STATE=$P(CTADDR,";",4),CITY=$P(CTADDR,";",3),STRAD2=$P(CTADDR,";",2),STRAD1=$P(CTADDR,";")
 S:$D(CTPH) DSIF(FIL,IENS,6.5)=CTPH
 S:STRAD1]"" DSIF(FIL,IENS,7)=STRAD1
 S:STRAD2]"" DSIF(FIL,IENS,8)=STRAD2
 S:CITY]"" DSIF(FIL,IENS,9)=CITY
 S:STATE]"" DSIF(FIL,IENS,10)=STATE
 S:ZIP]"" DSIF(FIL,IENS,11)=ZIP
 S:$G(ATPHY)]"" DSIF(FIL,IENS,12)=ATPHY,DSIF2(FIL2,IENS,6)=ATPHY
 S:$G(ATPHYPH)]"" DSIF(FIL,IENS,13)=ATPHYPH,DSIF2(FIL2,IENS,6.5)=ATPHYPH
 I OTHINS="Y" S DSIF(FIL,IENS,16.5)="Y",DSIF(FIL,IENS,15)=INSTYP
 I OTHINS="N" S DSIF(FIL,IENS,15)=""
 S:$D(MOTR) DSIF(FIL,IENS,16)=MOTR
 S:$D(APPOFF) DSIF(FIL,IENS,18)=APPOFF
 D FILE^DIE(,"DSIF") I $D(DSIF2) D FILE^DIE(,"DSIF2")
 S AXY=IEN
 Q:'DTOCT
 S FIL=161.517,IENS="+1,"_IENS K DSIF
 S DSIF(FIL,IENS,.01)=DTOCT,DSIF(FIL,IENS,2)=DUZ D UPDATE^DIE(,"DSIF","DSIF1")
 S IENS=DSIF1(1)_","_IEN_"," D WP^DIE(FIL,IENS,1,,"NARR")
 Q
ADD(AXY,IEN,DTOCT,NARR) ;RPC - DSIF INP ADD ROC
 ;Input Parameter
 ;    IEN - Internal Entry Number of Contact/Fee Notification (Required - Pointer to file 162.2)
 ;    DTOCT - Date & Time of Contact (Required - FileMan Date/Time)
 ;    NARR - Narrative (Optional - Word Processing Array)
 ;
 ;Return Values
 ;    -1 ^ Invalid Entry Number!
 ;    -1 ^ Missing Date of Contact!
 ;    1 = Contact Added
 ;    
 I '$D(^FBAA(161.5,+$G(IEN),0)) S AXY="-1^Invalid Entry Number!" Q
 I '$G(DTOCT) S AXY="-1^Missing Date of Contact!" Q
 N DSIF,DSIF1,IENS,FIL
 S FIL=161.517,IENS="+1,"_IENS_",",DSIF(FIL,IENS,.01)=DTOCT,DSIF(FIL,IENS,2)=DUZ
 D UPDATE^DIE(,"DSIF","DSIF1")
 S IENS=DSIF1(1)_","_IEN_"," D WP^DIE(FIL,IENS,1,,"NARR")
 S AXY=1
 Q
