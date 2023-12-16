ISIRAR02 ; ISI/BT - RAD Report ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**102,110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 ;
 QUIT
 ;;
ERR ;
 N ERR S ERR=$$EC^%ZOSV S @MAGGRY@(0)="0^4~"_ERR
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
 ;
 ; ##### Given RAD Standard Report IEN(s), return the Impression and Report text
 ; 
 ; INPUT
 ;   ISIIENS      = RAD Standard Report IENs ("^" delimited)
 ;                  Example : 1^2^3
 ; OUTPUT
 ;   ISIOUT       = Global Array contains all of RAD 'Standard' reports
 ;   ISIOUT(0)    = Number of Records or 0^Error Message
 ;
 ;  Pattern for reply is:
 ;   *REPORT        Start for REPORT lines
 ;    (1:N lines of text follow)
 ;   *REPORT_END    End
 ;   *IMPRESSION    Start IMPRESSION lines
 ;    (1:N lines of text follow)
 ;   *IMPRESSION_END    end
 ;
 ;
GETSTDTX(ISIOUT,ISIIENS) ; RPC [ISI GET RAD STANDARD TEXT]
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIRAR02"
 S ISIOUT=$NA(^TMP("ISIRAR02",$J))
 K @ISIOUT
 ;
 ; -- transform IENS ("^" delimited to array)
 N IDX,RAIEN,RAIENS
 F IDX=1:1:$L(ISIIENS,U) S RAIEN=+$P(ISIIENS,U,IDX) S:RAIEN RAIENS(IDX)=RAIEN
 I '$D(RAIENS) S @ISIOUT@(0)=0_U_"At least one Standard Report IEN required" QUIT
 ;
 ; -- compile Impression and Report text sections. Add blank line between reports
 N CNT
 S CNT=0
 N FIL S FIL=74.1
 N RTYPES S RTYPES("I")=300,RTYPES("R")=200
 N IDX,TMPOUT,TYP,WP
 ;
 F TYP="R","I" D
 . S CNT(TYP)=0
 . S IDX=0
 . F  S IDX=$O(RAIENS(IDX)) Q:'IDX  S RAIEN=RAIENS(IDX) D
 . . K WP S WP=$$GET1^DIQ(74.1,RAIEN,RTYPES(TYP),,"WP")
 . . S WP=0 F I=0:1 S WP=$O(WP(WP)) Q:'WP  S CNT(TYP)=CNT(TYP)+1,TMPOUT(TYP,CNT(TYP))=WP(WP)
 . . S:I CNT(TYP)=CNT(TYP)+1,TMPOUT(TYP,CNT(TYP))=""
 F TYP="R","I" I CNT(TYP) D
 . S CNT=CNT+1,@ISIOUT@(CNT)=$S(TYP="R":"*REPORT",1:"*IMPRESSION")
 . F I=1:1:CNT(TYP) S CNT=CNT+1,@ISIOUT@(CNT)=TMPOUT(TYP,I)
 . S CNT=CNT+1,@ISIOUT@(CNT)=$S(TYP="R":"*REPORT_END",1:"*IMPRESSION_END")
 ;
 I 'CNT S @ISIOUT@(0)=0_U_"No text for the selected Standard Report IEN(s)" QUIT
 S @ISIOUT@(0)=CNT
 QUIT
