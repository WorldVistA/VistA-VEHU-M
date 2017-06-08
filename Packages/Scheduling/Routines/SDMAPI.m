SDMAPI ;RGI/VSL - APPOINTMENT API UTILS; 11/09/2012
 ;;5.3;scheduling;**260003**;08/13/93;Build 8
BLDLST(RETURN,LST,FLDS) ; Build simple list.
 N DL,IN,FLD
 S RETURN=0
 Q:'$D(LST)
 S RETURN(0)=LST("DILIST",0)
 S DL="DILIST"
 F IN=1:1:$P(RETURN(0),U,1) D
 . S RETURN(IN)=""
 . S RETURN(IN,"ID")=LST(DL,2,IN)
 . I $O(LST(DL,"ID",IN,".01",""))'="" D
 . . S RETURN(IN,"NAME")=$G(LST(DL,"ID",IN,".01","I"))_"^"_LST(DL,"ID",IN,".01","E")
 . E  S RETURN(IN,"NAME")=LST(DL,"ID",IN,".01")
 . I $D(FLDS) D
 . . F FLD=0:0 S FLD=$O(FLDS(FLD)) Q:FLD=""  D
 . . . I $O(LST(DL,"ID",IN,FLD,""))'="" D
 . . . . S RETURN(IN,FLDS(FLD))=$G(LST(DL,"ID",IN,FLD,"I"))_"^"_LST(DL,"ID",IN,FLD,"E")
 . . . E  S RETURN(IN,FLDS(FLD))=LST(DL,"ID",IN,FLD)
 S RETURN=1
 Q
 ;
DTS(SD) ; Return formated date (07/16/2012)
 Q $TR($$FMTE^XLFDT(SD,"5DF")," ","0")
 ;
