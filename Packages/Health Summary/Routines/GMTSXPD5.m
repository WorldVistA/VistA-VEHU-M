GMTSXPD5 ;SLC/KER - Health Summary Dist (PDX) ;Jun 05, 2023@17:01
 ;;2.7;Health Summary;**35,56,144**;Oct 20, 1995;Build 17
 ;
 ; External References
 ;   DBIA  1023  $$FIRSTUP^VAQUTL50
 ;   DBIA  1023  $$ADDSEG^VAQUTL50
 ;   DBIA 10086  HOME^%ZIS
 ;   DBIA 10060  ^VA(200,
 ;   DBIA  2056  $$GET1^DIQ (file 200)
 ;   DBIA 10141  BMES^XPDUTL
 ;   DBIA 10141  MES^XPDUTL
 ;                     
 Q
PDX(GMTSCOMP,GMTSTIM,GMTSOCC,GMTSACT) ; Install PDX Data Segment
 ;                    
 ;  PDX( )
 ;          GMTSCOMP   Component Name (.01 of 142.1)
 ;          GMTSTIM    Time Limits Applicable
 ;          GMTSOCC    Occurrence Limits Applicable
 ;          GMTSACT    Action to perform; INSTALL (default) or UPDATE
 ;               
 N GMTSENV S GMTSENV=$$ENV Q:'GMTSENV  N GMTSNAME,GMTSERR,GMTS Q:'$L(GMTSCOMP)
 S (GMTS,GMTSERR)="",GMTSTIM=$G(GMTSTIM),GMTSOCC=$G(GMTSOCC),GMTSACT=$G(GMTSACT,"INSTALL")
 S GMTSNAME=$$FIRSTUP^VAQUTL50(GMTSCOMP)
 D INSP S GMTS=+$O(^GMT(142.1,"B",GMTSCOMP,0)) I ('GMTS) D NOPDX Q
 I GMTSACT="INSTALL" S GMTSERR=$$ADDSEG^VAQUTL50(GMTS,GMTSTIM,GMTSOCC)
 I GMTSACT="UPDATE" S GMTSERR=$$UPDSEG^VAQUTL50(GMTS,GMTSTIM,GMTSOCC)
 I (GMTSERR<0) D PDXER Q
 D PDXOK Q
 ;                    
 ; PDX Messages
INSP ;   Installing PDX Segment
 N GMTST,GMTSA,GMTSG
 I GMTSACT="UPDATE" S GMTSA=" Updating",GMTSG="in"
 E  S GMTSA=" Adding",GMTSG="to"
 S GMTST=GMTSA_" """_$$UP(GMTSNAME)_""" component "_GMTSG_" the PDX package" D BM(GMTST) Q
NOPDX ;   No PDX Segment Installed
 N GMTST
 S GMTST="   Component not found in Health Summary" D M(GMTST)
 S GMTST="   and not added to PDX package" D M(GMTST),M("") Q
PDXER ;   Error filing PDX Segment
 N GMTST
 S GMTST=$P($G(GMTSERR),"^",2) Q:'$L(GMTST)
 S GMTST="   "_GMTST D M(GMTST),M("") Q
PDXOK ;   PDX Segment filled ok
 N GMTST,GMTSA
 S GMTSA=$S(GMTSACT="UPDATE":"updated",1:"added")
 S GMTST="   Component successfully "_GMTSA D M(GMTST),M("") Q
 ;                    
 ; Misc
ENV(X) ;   Environment check
 D HOME^%ZIS I +($G(DUZ))=0 D BM("    User (DUZ) not defined"),M(" ") Q 0
 I '$L($$GET1^DIQ(200,(+($G(DUZ))_","),.01)) D BM("    Invalid User defined (DUZ)"),M(" ") Q 0
 Q 1
BM(X) ;   Blank Line with Message
 Q:$D(GMTSQT)  D:$D(XPDNM) BMES^XPDUTL($G(X)) W:'$D(XPDNM) !!,$G(X) Q
M(X) ;   Message
 Q:$D(GMTSQT)  D:$D(XPDNM) MES^XPDUTL($G(X)) W:'$D(XPDNM) !,$G(X) Q
UP(X) ;   Uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
