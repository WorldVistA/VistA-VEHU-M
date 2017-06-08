VEJDWPCJ ;wpb/gbh - routine modified for dental GUI;8/2/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;ORCXPND ; SLC/MKB - Expanded Display ;6/3/97  11:04
 ;
SETVIDEO(LINE,COL,WIDTH,ON,OFF) ; -- set video attributes
 S ^TMP("ORXPND",$J,"VIDEO",LINE,COL,WIDTH)=ON
 S ^TMP("ORXPND",$J,"VIDEO",LINE,COL+WIDTH,0)=OFF
 Q
 ;
BLANK ; -- blank line
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="   "
 Q
 ;
ITEM(X) ; -- set name of item into display
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X
 I $D(IORVON),$D(IORVOFF) D SETVIDEO(LCNT,1,$L(X),IORVON,IORVOFF)
 Q
