YS241PST ;NTX/LGM - Patch 241 Post-init ; 12/10/2020
 ;;5.01;MENTAL HEALTH;**241**;Dec 30, 1994;Build 5
 ;
EDTDATE ; date used to update 601.71:18
 ;;3230921.1019
 Q
PRE ; nothing necessary
 Q
POST ; post-init
 D INSTALLQ^YTXCHG("XCHGLST","YS241PST")
 D SETCAT("WBS_V2","Screening")
 D SETCAT("WBS_V2","Quality of Life")
 ;N C19YRS,EQ5D5L
 D DROPTST("WBS")
 ;D UPDURL
 Q
 ;
SETCAT(TEST,CATNM) ; add CATegory to TEST if not already there
 N CAT
 I TEST'=+TEST S TEST=$O(^YTT(601.71,"B",TEST,0)) QUIT:'TEST
 S CAT=$O(^YTT(601.97,"B",CATNM,0)) QUIT:'CAT
 I $D(^YTT(601.71,TEST,10,"B",CAT))=10 QUIT  ; already there
 ;
 N YTFDA,YTIEN,DIERR
 S YTFDA(601.71101,"+1,"_TEST_",",.01)=CATNM
 D UPDATE^DIE("E","YTFDA","YTIEN")
 I $D(DIERR) D MES^XPDUTL(CATNM_": "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
DROPTST(NAME) ; Change OPERATIONAL to dropped
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(10)="D"
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 ;I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS241PST")
 ;Q
 ;
XCHGLST(ARRAY) ; return array of instrument exchange entries
 ; ARRAY(cnt,1)=instrument exchange entry name
 ; ARRAY(cnt,2)=instrument exchange entry creation date
 ;
 N I,X
 F I=1:1 S X=$P($T(ENTRIES+I),";;",2,99) Q:X="zzzzz"  D
 . S ARRAY(I,1)=$P(X,U)
 . S ARRAY(I,2)=$P(X,U,2)
 Q
ENTRIES ; New MHA instruments^Exchange Entry Date
 ;;YS*5.01*241 WBS_V2^09/19/2023@16:13
 ;;zzzzz
