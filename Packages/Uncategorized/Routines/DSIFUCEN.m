DSIFUCEN ;DSS/RED - RPC FOR FEE BASIS UNAUTHORIZED ;09/13/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
GETVAL(DSIFOUT) ; RPC: DSIF UNA GET REASONS 
 ;Get values from 162.93
 K DSIFOUT,^TMP("FBAR",$J) S DSIFOUT=$NA(^TMP("FBAR",$J))
 D DISP9^FBUCUTL5(162.93)
 Q
 ;  Possible use for further development
 ;
