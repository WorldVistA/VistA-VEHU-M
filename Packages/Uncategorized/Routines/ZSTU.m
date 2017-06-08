ZSTU ; Cache calls this routine at startup to perform these tasks automatically
 ; version: TEST - v5.2 (compatible with v5.0,v5.2,v4.1) - 01-AUG-2007 ;
 ;
 ; The following module calls can be enabled or disabled as desired.
 ; To disable a module, place a semi-colon in front of the command...
 ; To enable a module, remove the semi-colon in front of the command...
 ;
 S $ZT="ERR"
 ;
 ; START BROKER - OLD STYLE
 ;J STRT^XWBTCP(9200):"CPM"
 ;
 ; START BROKER - NEW STYLE
 J ZISTCP^XWBTCPM1(9000):"CPM"
 ;
 ; START TaskMan UNLESS on a hybrid front end server
 J ^ZTMB:"CPM"
 ;
 ; START VistALink
 J START^XOBVLL(8000):"CPM"
ERR Q
 
