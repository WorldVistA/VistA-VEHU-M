XTECLIPS ;JLI/FO-OAK - Eclipse Interface Via VistA Link ;05/25/08  18:28
 ;;7.3;TOOLKIT;**101**;Apr 25, 1995;Build 10
 ;;Per VHA Directive 2004-038, this routine should not be modified
RPC(XTECRES,XTECFUNC,XTECLINE,XTECFROM,XTECTO,XTECOPT) ;
 ; XTECRES = this is the return value from the RPC call, will contain a global reference
 ; XTECFUNC = this is the type of function that is being done.
 ;       = RD Routine directory passed back in ARRAY
 ;       = RL Routine Load into ARRAY
 ;       = RS Routine Save Save the routine from XTECLINE
 ;       = GD Global directory Passed Back in ARRAY
 ;       = GL Global List in ARRAY
 ; XTECLINE = This is the total number of line that are requested at a time
 ; XTECFROM = This is the starting point or the one to be listed
 ; XTECTO =  this is the ending point
 N TMPGLOB
 S TMPGLOB=$NA(^TMP("XTECLIPS",$J)) K @TMPGLOB
 S XTECRES=TMPGLOB
 S XTECFUNC=$G(XTECFUNC),XTECFROM=$G(XTECFROM),XTECTO=$G(XTECTO)
 ;
 I XTECFUNC="RD" D DIR^XTECROU(TMPGLOB,$G(XTECLINE),XTECFROM,XTECTO) Q
 I XTECFUNC="RL" D LOAD^XTECROU(TMPGLOB,XTECFROM) Q
 I XTECFUNC="RS" D SAVE^XTECROU(TMPGLOB,.XTECLINE,XTECFROM,XTECTO) Q
 I XTECFUNC="RI" D INFO^XTECROU(TMPGLOB,XTECFROM,XTECTO) Q
 I XTECFUNC="GD" D LIST^XTECGLO(TMPGLOB,$G(XTECLINE),XTECFROM,XTECTO) Q
 I XTECFUNC="GL" D LNODE^XTECGLO(TMPGLOB,$G(XTECLINE),XTECFROM,$G(XTECTO),$G(XTECOPT)) Q
 ;
 S @TMPGLOB@(0)="-1^INVALID FUNCTION"
 Q
