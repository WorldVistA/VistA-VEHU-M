YS233PST ;SLC/KCM - Patch 233 Post-init ; 12/10/2020
 ;;5.01;MENTAL HEALTH;**233**;Dec 30, 1994;Build 13
 ;
EDTDATE ; date used to update 601.71:18
 ;;3230609.1019
 Q
PRE ; nothing necessary
 Q
POST ; post-init
 D INSTALLQ^YTXCHG("XCHGLST","YS233PST")
 D NEWCAT("COVID")
 D SETCAT("C19-YRS","COVID")
 D SETCAT("EQ-5D-5L","COVID")
 D SETCAT("FSS","COVID")
 D SETCAT("MRC","COVID")
 D SETCAT("PCFS","COVID")
 N C19YRS,EQ5D5L
 S C19YRS=$O(^YTT(601.71,"B","C19-YRS",0))
 S EQ5D5L=$O(^YTT(601.71,"B","EQ-5D-5L",0))
 I C19YRS D QTASK^YTSCOREV(C19YRS_"~2",$H)
 I EQ5D5L D QTASK^YTSCOREV(EQ5D5L_"~2",$H)
 Q
 ;
NEWCAT(CATNM) ; add new category
 I $D(^YTT(601.97,"B",CATNM)) QUIT  ; already there
 N REC
 S REC(.01)=CATNM
 D FMADD^YTXCHGU(601.97,.REC)
 Q
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
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 ;I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS233PST")
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
 ;;YS*5.01*233 C19-YRS^06/09/2023@11:22:53
 ;;YS*5.01*233 EQ-5D-5L^06/09/2023@14:02:21
 ;;YS*5.01*233 FSS^06/09/2023@17:07:54
 ;;YS*5.01*233 MRC^06/09/2023@17:08:27
 ;;YS*5.01*233 PCFS^06/09/2023@17:09:48
 ;;zzzzz
