XVEMS ;DJB,VSHL**Setup VShell [11/17/96 12:47pm]
 ;;14.0;VICTORY PROG ENVIRONMENT;;Feb 27, 2017
 ;
 Q
NOTES ;General notes
 ;;XVV File numbers: 19200-19204
 ;;************** SCROLLING **************
 ;;Keep Scroll arrays from clashing. Any array originating in ^XVEMKT
 ;;can't allow branching (to Help for example) which will call ^XVEMKT
 ;;and start another array that will clash. Only external users of the
 ;;scroller (like VGL) which have a different subscript, can do this.
 ;;^XVEMKT - Scroller
 ;; IMPORT          ^TMP("XVV","K",$J,
 ;; RTN                    ""
 ;; GLB                    ""
 ;;External IMPORTING - Subscript starts with "I" when IMPORTING.
 ;; VGL                     ^TMP("XVV","IG"_GLS,$J,
 ;; VGL(Piece)              ^TMP("XVV","IGP",$J,
 ;; VEDD(Global Location)   ^TMP("XVV","ID"_VEDDS,$J,
 ;;VRR(Rtn Edit)           ^TMP("XVV","IR"_VRRS,$J,
 ;;
 ;;XVVT("HD") + XVVT("FT") - 1 = Top $Y
 ;;Top $Y + XVVT("S2") - XVVT("S1") = Bottom $Y
 ;;************** NEW VPE VERSION **************
 ;;Notes for changing version number and doing updates.
 ;;XVV File number range: 19200-19204
 ;;NEW VERSION: 1. VPE_xx.DOC.....in DOS..Update version number
 ;;             2. Change 2nd line of ^XVEM*
