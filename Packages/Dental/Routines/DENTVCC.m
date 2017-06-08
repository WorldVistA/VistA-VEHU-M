DENTVCC ;DSS/BD - DENTAL CANNED COMMENTS ;11/17/2003 15:17
 ;;1.2;DENTAL;**59**;Aug 10, 2001;Build 19
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  DBIA#  Supported  description
 ;  -----  ---------  --------------------------------------
 ;  2056       x      GETS^DIQ and $$GET1^DIQ
 ;  2053       x      FILE^DIE, WP^DIE and UPDATE^DIE
 ;
 ;
 Q  ; No direct calls
GET(DENTV,PROV,TYP,CAT) ; DENTV GET CANNED COMMENTS
 ;
 ; Input - PROV, provider ien
 ;         TYP, "S","U", OR "A"
 ;              S - system, U - user, A - all
 ;         CAT, category 1,2,3,4,5
 ; Output- ien^type^text
 N II,III,CIEN,SORT,CNT,XX,YY,CCAT,CPROV,CNTR S CNT=1,YY=0,CNTR=0
 I "SA"[TYP D
 .;DO SYS TYPE RETURN
 .S II=$NA(^DENT(227,"AD",CAT)) F  S II=$Q(@II),CCAT=$QS(II,3),SORT=$QS(II,4),CIEN=$QS(II,5) N DENTWP Q:CCAT'=CAT  D
 ..;W !,"Order: "_SORT_"  IEN: "_CIEN
 ..S XX=$$GET1^DIQ(227,CIEN,1,"","DENTWP")
 ..I CNTR=12 Q
 ..I CNT'=1,CIEN'=$P(DENTV(CNT-1),U) S CNTR=CNTR+1
 ..I CNT=1 S CNTR=CNTR+1
 ..F  S YY=$O(DENTWP(YY)) Q:'YY  D
 ...S DENTV(CNT)=CIEN_"^"_SORT_"^"_$G(DENTWP(YY)),CNT=CNT+1
 ..I '$D(DENTV) S DENTV(1)="-1^System has no comments"
 I "UA"[TYP D
 .;DO USER RETURN
 .I '$D(PROV) S DENTV(1)="-1^No provider sent"
 .S II=$NA(^DENT(227,"AC",PROV,CAT)) F  S II=$Q(@II),CPROV=$QS(II,3),SORT=$QS(II,5),CIEN=$QS(II,6),CCAT=$QS(II,4) N DENTWP Q:CCAT'=CAT  D
 ..;W !,"Order: "_SORT_"  IEN: "_CIEN
 ..I CPROV'=PROV Q  ;Quit if a provider changes in loop
 ..S XX=$$GET1^DIQ(227,CIEN,1,"","DENTWP")
 ..I CNTR=12 Q
 ..I CNT'=1,CIEN'=$P(DENTV(CNT-1),U) S CNTR=CNTR+1
 ..I CNT=1 S CNTR=CNTR+1
 ..F  S YY=$O(DENTWP(YY)) Q:'YY  D
 ...S DENTV(CNT)=CIEN_"^"_SORT_"^"_$G(DENTWP(YY)),CNT=CNT+1
 .I '$D(DENTV) S DENTV(1)="-1^User has no comments"
 Q
FILE(RET,DENTV) ; DENTV FILE CANNED COMMENTS
 ; Input - DENTV("PROV")* - provider ien
 ; Input - DENTV("TYP")* - 1: system, 2:user
 ; Input - DENTV("CAT")* - 1:radio,2:summary,3:treatment,4:educ,5:disp
 ; Input - DENTV(n) - n number of records for the WP field (the comment).
 ; Input - DENTV("IEN") - Only send IEN for a record update, null IEN means "add"
 N II,III,CIEN,DENT,DENTWP,DENTER,DENTIEN
 S III=0 F  S III=$O(DENTV(III)) Q:'III  D
 .S DENTWP(III)=DENTV(III)
 I DENTV("IEN") S CIEN=DENTV("IEN") D
 .I '$D(^DENT(227,DENTV("IEN"))) S RET="-1^Cannot update record. Record does not exist" Q
 .I DENTV("TYP")=2,'$D(DENTV("PROV")) S RET="-1^Provider required for a user based comment" Q
 .I CIEN'=$P(^DENT(227,CIEN,0),U) S RET="-1^Error processing request" Q
 .S DENT(227,CIEN_",",.02)=DENTV("PROV")
 .S DENT(227,CIEN_",",.03)=DENTV("TYP")
 .S DENT(227,CIEN_",",.05)=DENTV("CAT")
 .;M DENT(227,CIEN_",",1,1)=DENTWP
 .D FILE^DIE(,"DENT","DENTER")
 .D WP^DIE(227,CIEN_",",1,,"DENTWP","DENTER")
 I DENTV("IEN")="" S CIEN=1+$P(^DENT(227,0),U,3) D
 .I DENTV("TYP")=2,'$D(DENTV("PROV")) S RET="-1^Provider required for a user based comment" Q
 .S DENT(227,"+1,",.01)=CIEN
 .S DENT(227,"+1,",.02)=DENTV("PROV")
 .S DENT(227,"+1,",.03)=DENTV("TYP")
 .I DENTV("TYP")=2 S DENT(227,"+1,",.04)=1+$O(^DENT(227,"AC",DENTV("PROV"),DENTV("CAT"),"~"),-1)
 .I DENTV("TYP")=1 S DENT(227,"+1,",.04)=1+$O(^DENT(227,"AD",DENTV("CAT"),"~"),-1)
 .S DENT(227,"+1,",.05)=DENTV("CAT")
 .;M DENT(227,"+1,",1,1)=DENTWP
 .D UPDATE^DIE(,"DENT","DENTIEN","DENTER")
 .I CIEN=DENTIEN(1) D WP^DIE(227,CIEN_",",1,,"DENTWP","DENTER")
 .E  D WP^DIE(227,DENTIEN(1)_",",1,,"DENTWP","DENTER")
 .;N DENT S DENT(227,$G(DENTIEN(1))_",",.01)=DENTIEN(1)
 .;D FILE^DIE(,"DENT")
 I '$D(DENTER) S RET="1^Save complete^"_CIEN_"^"
 I $D(DENTER) S RET="-1^Error occured on save"
 Q
UPDATE(RET,DENTV) ; DENTV UPDATE COMMENT SORT
 ; Input - A list of CAT^SORT ORDER^IEN
 ;      DENTV(1)="1^1^14"
 ;      DENTV(2)="1^2^5"
 ; Output - Complete/Error message
 N II,DENT,CIEN,CAT,SORT
 S II=0 F  S II=$O(DENTV(II)) Q:'II  D
 .S CIEN=$P(DENTV(II),U,3),CAT=$P(DENTV(II),U),SORT=$P(DENTV(II),U,2)
 .I $P(^DENT(227,CIEN,0),U,5)=CAT D
 ..S DENT(227,CIEN_",",.04)=SORT
 ..D FILE^DIE(,"DENT","DENTER") K DENT
 I '$D(DENTER) S RET="1^Sort updated"
 I $D(DENTER) S RET="-1^Error updating sort"
 Q
DEL(RET,CIEN) ; DENTV DEL CANNED COMMENT
 ; Input - CIEN, Comment IEN
 ; Output - Complete/Error
 ;
 ; should I loop through the remaining comments and reset sort order (by filling in gaps??)
 N II,SORT,DA,DIK,NXT,TYP,PROV,CAT,DENT,DENTER S NXT=0
 I '$D(^DENT(227,CIEN,0)) S RET="-1^No record to delete" Q
 S SORT=$$GET1^DIQ(227,CIEN_",",.04),CAT=$$GET1^DIQ(227,CIEN_",",.05,"I")
 S TYP=$$GET1^DIQ(227,CIEN_",",.03,"I") I TYP=2 S PROV=$$GET1^DIQ(227,CIEN_",",.02,"I")
 S DA=CIEN,DIK="^DENT(227," D ^DIK
 I TYP=2 D
 .S NXT=CIEN F  S NXT=$O(^DENT(227,"AC",PROV,CAT,SORT+1,NXT)) Q:'NXT  D
 ..S DENT(227,NXT_",",.04)=SORT
 ..D FILE^DIE(,"DENT","DENTER")
 ..S SORT=SORT+1,NXT=0
 .S RET="1^Record deleted and remaining records resorted"
 I TYP=1 D
 .S NXT=CIEN F  S NXT=$O(^DENT(227,"AD",CAT,SORT+1,NXT)) Q:'NXT  D
 ..S DENT(227,NXT_",",.04)=SORT
 ..D FILE^DIE(,"DENT","DENTER")
 ..S SORT=SORT+1,NXT=0
 .S RET="1^Record deleted and remaining records resorted"
 Q
