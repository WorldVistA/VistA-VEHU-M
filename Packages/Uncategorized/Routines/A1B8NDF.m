A1B8NDF ;NATIONAL DRUG FILE CLEAN-UP; ALBANY-ISC; VFR; 5/12/92
 ;;VERSION 1
 ;This routine is to fix the problems of null subscript errors during the post-inits of the National Drug File v.2.0  on the Manhattan VAMC test account.
 ;
START ;
 S XDRUG=0
 F I=0:0 S XDRUG=$O(^PSDRUG(XDRUG)) Q:XDRUG'>0  D LIST
 Q
LIST ;
 I $P(^PSDRUG(XDRUG,0),U,2)="",$D(^PSDRUG(XDRUG,"ND")) W !,^PSDRUG(XDRUG,"ND")_".....PSDRUG # = "_XDRUG
 Q
