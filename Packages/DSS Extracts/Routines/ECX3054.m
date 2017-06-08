ECX3054 ;BPFO/JRP - PATCH 54 STUFF;8/29/2003
 ;;3.0;DSS EXTRACTS;**54**;Dec 22, 1997
 ;
PRE ;Pre-installation checks
 N TEXT,X,Y
 ;Don't allow installation if site didn't enter correct pass phrase
 S TEXT(1)=" "
 S TEXT(2)="Ensuring that pass phrase was entered correctly ..."
 D MES^XPDUTL(.TEXT)
 S Y=$G(XPDQUES("PRE PASS PHRASE")) I (Y="")!(Y["^") D  Q
 .K TEXT
 .S TEXT(1)=" "
 .S TEXT(2)="   ** INSTALLATION WILL BE ABORTED **"
 .S TEXT(3)="   Pass phrase was not correctly entered by installer"
 .S TEXT(4)=" "
 .D MES^XPDUTL(.TEXT)
 .S XPDQUIT=2
 K TEXT
 S TEXT(1)="OK"
 S TEXT(2)=" "
 D MES^XPDUTL(.TEXT)
 Q
 ;
QUES ;INSTALL QUESTION TEST LOGIC
 S DIR(0)="FA^3:100^D HASH^XUSHSHP I X'=""s`;{ 2('yq`0j!=w>0Ex"" K X"
 S DIR("A")="Enter pass phrase: "
 S DIR("?",1)="Enter the pass phrase that was obtained from the DSS"
 S DIR("?",2)="Help Desk.  Installation of this patch is only allowed"
 S DIR("?",3)="after successfully entering this pass phrase."
 S DIR("?")=" "
 D ^DIR
 I (Y="")!(Y["^") W !!,"** FAILED **" Q
 W !!,"- Passed -"
 Q
HASH(PHRASE)    ;Return hashed value for phrase
 N X
 S X=$G(PHRASE)
 D HASH^XUSHSHP
 Q $G(X)
