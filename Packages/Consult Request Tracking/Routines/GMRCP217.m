GMRCP217 ;BP/CMF  - ADD 'AVPR' CROSS REFERENCE ; 03/15/18
 ;;3.0;CONSULT/REQUEST TRACKING;**217**;FEB 27, 2018;Build 2
 ;
 Q
POST  ; Post Install Action for patch 217
 D IDX
 Q
 ;
IDX ; -- add AVPR index to #123, fulfills DBIA #7610
 N GMRCR,GMRCRES,GMRCOUT
 D BMES^XPDUTL("Building 'AVPR' action cross reference of the Referral file, #123")
 D MES^XPDUTL("This could take several minutes....")
 S GMRCR("FILE")=123
 S GMRCR("ROOT FILE")=123
 S GMRCR("NAME")="AVPR"
 S GMRCR("TYPE")="MU"
 S GMRCR("USE")="A"
 S GMRCR("EXECUTION")="F"
 S GMRCR("SHORT DESCR")="Trigger updates to VPR"
 S GMRCR("DESCR",1)="This is an action index that updates the Virtual Patient Record (VPR)"
 S GMRCR("DESCR",2)="when this record is updated. No actual cross-reference nodes are set"
 S GMRCR("DESCR",3)="or killed."
 S GMRCR("SET")="D:$L($T(REFCOM^VPREVNT)) REFCOM^VPREVNT(DA)"
 S GMRCR("KILL")="Q"
 S GMRCR("WHOLE KILL")="Q"
 S GMRCR("VAL",1)=9
 D CREIXN^DDMOD(.GMRCR,"fW",.GMRCRES,"GMRCOUT")
 Q
 ;
