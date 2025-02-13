TIUCOP1 ;SLC/TDP - Copy/Paste Paste Tracking ;03/23/16  14:53
 ;;1.0;TEXT INTEGRATION UTILITIES;**290**;Jun 20, 1997;Build 548
 ;
 Q
GETPST(PIEN,INST,ARY,ZERO) ;Retrieve pasted text for a specific pasted text entry
 ;   Call using GETPST^TIUCOP(PASTED TEXT IEN,INSTITUTION IEN,.RETURN ARRAY)
 ;
 ;   Input
 ;     INST - Institution ien
 ;     PIEN - Pasted text ien
 ;     ARY - Array to return the pasted text data
 ;     ZERO - 1 = Return zero node only
 ;
 ;   Output
 ;     ARY(0,0) - Total number of unique entries
 ;                       Or
 ;                  Error condition "-1^Error Msg"
 ;
 ;     ARY(1..n,0) - (If ZERO = 1, then only node returned)
 ;        Piece 1: Date/Time of the paste
 ;        Piece 2: User who pasted text
 ;        Piece 3: Copy from location (ien;file)
 ;        Piece 4: Copy from document title
 ;        Piece 5: Copy from document author (duz;name(last,first m))
 ;        Piece 6: Copy from Patient (dfn;name(last,first m))
 ;        Piece 7: Percent match between copied text and pasted text
 ;        Piece 8: Number of lines of pasted text
 ;        Piece 9: Capturing Application
 ;        Piece 10: Date/Time of the copy from document
 ;        Piece 11: Saved Paste IEN
 ;        Piece 12: Parent IEN
 ;     ARY(1,0,0) - Copy text line count
 ;     ARY(1..n,0,1..n) - Copied text
 ;     ARY(1..n,1..n) - Pasted text
 ;
 N CNT,CPYDATA0,CPYDFN,CPYDUZ,CPYGBL,CPYIEN,CPYNAME,CPYFIL,CPYPTNAME
 N CPYPTSRC,CPYUSER,DATA0,DTPST,IEN,LN,PCT,FILE,PRFX,PSTDUZ,PSTUSER
 N TIUERR,PIENLN,TIUNMSPC,X,NODISP,CPYFILNM,CPYGBLEN,FILENM,CPYFTXT
 N CPYLOC,CAPP,CPYSRCDT,PRNTIEN,TEXTLNG,X,LP
 S TIUERR=""
 I $G(ARY)'["" S TIUERR="-1^Return array is required." G GTPSTQ
 I $G(INST)="" S TIUERR="-1^Institution is required" G GTPSTQ
 I +INST<1 S TIUERR="-1^Invalid institution" G GTPSTQ
 S INST=$$FIND1^DIC(4,"","","`"_INST,"","","ERR")
 I +INST<1 S TIUERR="-1^Invalid institution" G GTPSTQ
 I +$G(PIEN)=0 S TIUERR="-1^Pasted text ien is required." G GTPSTQ
 S CNT=$S(+$G(ARY(0,0))'<0:+$G(ARY(0,0)),1:0)
 S IEN=PIEN
 ;S X=""
 ;F  S X=$O(^TIUP(8928,"C",PIEN,X)) Q:X=""  D
 ;. S IEN=$G(IEN)_U_X
 ;F LP=1:1:$L(IEN,U) D
 ;. S PIEN=$P(IEN,U,LP)
 S DATA0=$G(^TIUP(8928,PIEN,0))
 I DATA0="" Q
 S PSTUSER=""
 S DTPST=$P(DATA0,U,1)
 S PSTDUZ=$P(DATA0,U,2)
 I +PSTDUZ>0 S PSTUSER=$$GET1^DIQ(200,PSTDUZ_",",.01)
 I PSTUSER="" S PSTUSER="UNKNOWN PASTER NAME"
 S CPYIEN=$P(DATA0,U,6)
 S CPYFIL=$P(DATA0,U,7)
 S CAPP=$P(DATA0,U,9)
 S PRNTIEN=$P(DATA0,U,11)
 I PRNTIEN="",$D(^TIUP(8928,"C",PIEN)) S PRNTIEN="+"
 ;S COMPLT=$P(DATA0,U,14)
 ;I COMPLT=0 Q
 S CPYLOC=""
 S CPYFILNM=""
 S CPYFTXT=""
 I CPYFIL'="" D
 . S CPYFILNM=$$GET1^DIQ(1,CPYFIL_",",.01)
 . S CPYGBL=$$GET1^DIQ(1,CPYFIL_",",1)
 . S CPYGBLEN=CPYGBL_CPYIEN_")"
 I CPYIEN="" D
 . S CPYFTXT=$P(DATA0,U,10)
 . I $P(CPYFTXT," - ",1)="ORDER DETAILS" D
 .. S CPYIEN=$P($P(CPYFIL," - ",2),";",1)
 .. S CPYFIL=100
 S PCT=$P(DATA0,U,8)
 S CPYPTSRC=""
 S CPYNAME=""
 S CPYUSER=""
 S CPYPTNAME=""
 S CPYDUZ=""
 S CPYUSER=""
 S CPYDFN=""
 S CPYSRCDT=""
 I CPYFILNM="TIU DOCUMENT" D
 . S CPYSRCDT=$P($G(^TIU(8925,CPYIEN,13)),U,1) ;REFERENCE DATE
 . S CPYDUZ=$P($G(^TIU(CPYFIL,CPYIEN,12)),U,2) ;AUTHOR/DICTATOR
 . I +CPYDUZ=0 S CPYDUZ=$P($G(^TIU(CPYFIL,CPYIEN,13)),U,2) ;ENTERED BY
 .  I +CPYDUZ>0 S CPYUSER=$$GET1^DIQ(200,CPYDUZ_",",.01)
 . I CPYUSER="" S CPYUSER="UNKNOWN AUTHOR"
 . S CPYDATA0=$G(^TIU(CPYFIL,CPYIEN,0))
 . I $G(CPYDATA0)="" Q
 . S CPYNAME=$P(CPYDATA0,U,1)
 . S CPYNAME=$P($G(^TIU(8925.1,CPYNAME,0)),U,1)
 . I CPYNAME="" S CPYNAME="UNKNOWN NOTE TITLE"
 . S CPYDFN=$P(CPYDATA0,U,2)
 . I +CPYDFN>0 S CPYPTNAME=$P($G(^DPT(CPYDFN,0)),U,1)
 . I CPYPTNAME="" S CPYPTNAME="UNKNOWN PATIENT NAME"
 I CPYFIL="100" D
 . S CPYDATA0=$G(^OR(CPYFIL,CPYIEN,0))
 . I $G(CPYDATA0)="" Q
 . S CPYSRCDT=$P(CPYDATA0,U,7)
 . S CPYDUZ=$P(CPYDATA0,U,6) ;WHO ENTERED
 . I +CPYDUZ>0 S CPYUSER=$$GET1^DIQ(200,CPYDUZ_",",.01)
 . I CPYUSER="" S CPYUSER="UNKNOWN AUTHOR"
 . S CPYNAME="ORDER #"_$P(CPYDATA0,U,1)
 . I +$P(CPYNAME,"#",2)=0 S CPYNAME="UNKNOWN ORDER NUMBER"
 . S CPYDFN=$P(CPYDATA0,U,2) ;ORDERABLE ITEMS (PATIENT/REFERRAL)
 . I +CPYDFN>0 D
 .. S CPYGBL=$P(CPYDFN,";",2)
 .. S CPYDFN=+CPYDFN
 . I CPYGBL="DPT(" S CPYPTNAME=$P($G(^DPT(CPYDFN,0)),U,1)
 . I CPYGBL="LRT(67," S CPYPTNAME=$P($G(^LRT(67,CPYDFN,0)),U,1),CPYPTSRC="R"
 . I CPYPTNAME="" S CPYPTNAME="UNKNOWN PATIENT NAME"
 I CPYFILNM="REQUEST/CONSULTATION" D
 . S CPYDATA0=$G(^GMR(CPYFIL,CPYIEN,0))
 . I $G(CPYDATA0)="" Q
 . S CPYSRCDT=$P(CPYDATA0,U,1)
 . S CPYDUZ=$P(CPYDATA0,U,14) ;SENDING PROVIDER
 . I +CPYDUZ>0 S CPYUSER=$$GET1^DIQ(200,CPYDUZ_",",.01)
 . I +CPYDUZ<1,$P($G(^GMR(CPYFIL,CPYIEN,12)),U,6)'="" S CPYUSER=$P($G(^GMR(CPYFIL,CPYIEN,12)),U,6),CPYDUZ="IFC"
 . I CPYUSER="" S CPYUSER="UNKNOWN AUTHOR"
 . S CPYNAME="CONSULT #"_CPYIEN
 . I +$P(CPYNAME,"#",2)=0 S CPYNAME="UNKNOWN CONSULT NUMBER"
 . S CPYDFN=$P(CPYDATA0,U,2) ;PATIENT NAME (IEN)
 . I +CPYDFN>0 S CPYPTNAME=$P($G(^DPT(CPYDFN,0)),U,1)
 . I CPYPTNAME="" S CPYPTNAME="UNKNOWN PATIENT NAME"
 I $G(CPYDATA0)="",CPYFTXT="" Q
 S CPYLOC=$S(CPYIEN'="":CPYIEN_";"_CPYFILNM,1:CPYFTXT)
 S CNT=CNT+1
 S ARY(CNT,0)=DTPST_U_$S(+PSTDUZ>0:+PSTDUZ_";"_PSTUSER,1:"")_U_CPYLOC
 S ARY(CNT,0)=$G(ARY(CNT,0))_U_CPYNAME_U
 S ARY(CNT,0)=$G(ARY(CNT,0))_$S(+CPYDUZ>0:+CPYDUZ_";"_CPYUSER,1:"")
 S ARY(CNT,0)=$G(ARY(CNT,0))_U_$S(+CPYDFN>0:+CPYDFN_";"_CPYPTNAME,1:"")
 S ARY(CNT,0)=$G(ARY(CNT,0))_$S(((CPYPTSRC="R")&(CPYPTSRC'="")):";"_CPYPTSRC,1:"")
 S ARY(CNT,0)=$G(ARY(CNT,0))_U_PCT_U_U_CAPP_U_CPYSRCDT_U_PIEN_U_PRNTIEN
 S ARY(0,0)=CNT
 I TIUERR'="" S ARY(0,0)=TIUERR
 IF +ZERO=1 Q
 S LN=0
 S X=""
 F  S X=$O(^TIUP(8928,PIEN,1,X)) Q:X=""  D
 . I X=0 S LN=$P($G(^TIUP(8928,PIEN,1,X)),U,4) Q
 . S ARY(CNT,X)=$G(^TIUP(8928,PIEN,1,X,0))
 S $P(ARY(CNT,0),U,8)=LN
 S LN=0
 S X=""
 F  S X=$O(^TIUP(8928,PIEN,2,X)) Q:X=""  D
 . I X=0 S LN=$P($G(^TIUP(8928,PIEN,2,X)),U,4) Q
 . S ARY(CNT,0,X)=$G(^TIUP(8928,PIEN,2,X,0))
 I +LN>0 S ARY(CNT,0,0)=LN
 S ARY(0,0)=CNT
GTPSTQ I TIUERR'="" S ARY(0,0)=TIUERR
 Q
