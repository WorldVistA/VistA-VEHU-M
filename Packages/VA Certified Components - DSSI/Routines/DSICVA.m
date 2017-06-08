DSICVA ;DSS/SGM - UTILITIES FOR SUPPORTED VA* ITEMS ;07/22/2003 15:25
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  -------------------------------
 ; 10112      x      ^VASITE: $$PRIM, $$SITE
 ;
SITE(DSIC,DIV,DATE,FUN) ; RPC: DSIC VA DEFAULT SITE
 ;  This will return default Institution file data
 ;  DIV - optional - default to VAMC primary division
 ;                   must be pointer to file 40.8
 ; DATE - optional - default to TODAY
 ;                   Fileman date for division data as of that date
 ;  FUN - optional - I $G(FUN) then extrinsic function, else called by RPC
 ;
 ;  Returns p1^p2^p3^p4  where
 ;     p1 = pointer to Institution file (#4)
 ;     p2 = Institution file name
 ;     p3 = station number
 ;     p4 = primary medical center division as of date (pointer to 40.8)
 N X,PRIM,SITE
 S DATE=$G(DATE),DIV=$G(DIV),FUN=$G(FUN) S:'DATE DATE=DT
 S SITE=$S('DIV:$$SITE^VASITE(DATE),1:$$SITE^VASITE(DATE,DIV))
 S PRIM=$$PRIM^VASITE(DATE)
 I SITE<1 S DSIC="-1^error calling $$SITE^VASITE API"
 E  S DSIC=SITE_U_PRIM
OUT Q:$G(FUN) DSIC Q
