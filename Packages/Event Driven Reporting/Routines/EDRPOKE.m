EDRPOKE ;  [ 10/28/93  5:19 PM ]
 ;
 W !,"Called by Entry Point Only!..."
 W !,"d CLRSTATS^EDRPOKE clears historical MAILMAN/TALKMAN stats"
 W !,"d MAKELIST^EDRPOKE make a list of domains in ^EDRUTIL(""DOMAINS"
 W !,"   TO POKE"") from which we received NO MAILMAN messages."
 W !,"d POKELIST^EDRPOKE send a MAILMAN message to all the domains"
 W !,"   in ^EDRUTIL(""DOMAINS TO POKE"")"
 W !,"d POKETHEM^EDRPOKE calls MAKELIST and POKELIST and would usually"
 W !,"   be tasked to run in the background by TASKMAN"
 QUIT
 ;
CLRSTATS ; Clear the Historical messages statistics from MAILMAN/TALKMAN
 N DOMNUM,X
 S DOMNUM=0
 F  S DOMNUM=$O(^XMBS(4.2999,DOMNUM)) Q:+DOMNUM'=DOMNUM  DO  ;
 . S X=$G(^XMBS(4.2999,DOMNUM,0)) ; retrieve info
 . S $P(X,"^",5)=0,$P(X,"^",7)=0 ; alter info
 . S ^XMBS(4.2999,DOMNUM,0)=X ; "file"
 . S X=$G(^XMB(3.7,.5,2,(DOMNUM+1000),0)) ; retrieve info
 . S $P(X,"^",5)=0 ; alter info
 . S ^XMB(3.7,.5,2,(DOMNUM+1000),0)=X ; "file"
 S ^EDRUTIL("EDRPOKE CLRSTATS",$H)=$J ; log our completion
 QUIT
 ;
POKETHEM ; Makes a list of domains to "poke" then uses the list to send a
 ;  MAILMAN message to each.  The goal is to receive ALL of THEIR
 ;  messages which are awaiting a free line to transmit
 D MAKELIST
 D POKELIST
 S ^EDRUTIL("EDRPOKE POKETHEM",$H)=$J ; log our completion
 QUIT
 ;
MAKELIST ; Make a list of Domains which did not send anything to this machine
 ; through MAILMAN/TALKMAN
 N DOMNUM,X
 K ^EDRUTIL("DOMAINS TO POKE")
 S DOMNUM=0
 F  S DOMNUM=$O(^XMBS(4.2999,DOMNUM)) Q:+DOMNUM'=DOMNUM  DO  ;
 . S X=$G(^XMBS(4.2999,DOMNUM,0))
 . I '(+$P(X,"^",7)) S ^EDRUTIL("DOMAINS TO POKE",DOMNUM)=$P($G(^DIC(4.2,DOMNUM,0)),"^")
 QUIT
 ;
POKELIST ; Using list in ^EDRUTIL("DOMAINS TO POKE") send short MAILMAN
 ;  messages to them all...
 ;  The goal is to get all awaiting messages from the domain
 ;  Required:
 ;   1) We have "TURN ENABLED" in our domain file for the domain
 ;      in question
 ;   2) We can make a MAILMAN remote connection
 N DOMNAME,DOMNUM,X
 S DUZ=.5,DUZ(0)="@",%H=$H,DTIME=999,IO(0)=$I,U="^"
 S X=$ZD(%H)
 S DT="2"_$P(X,"/",3)_$E($P(X,"/")+100,2,3)_$E($P(X,"/",2)+100,2,3)
 O 53:("/tmp/trash":"W") U 53 S ZA=$ZA I ZA QUIT  ;unable to open output
 S DOMNUM=0
 F  S DOMNUM=$O(^EDRUTIL("DOMAINS TO POKE",DOMNUM)) Q:DOMNUM=""  DO  ;
 . S DOMNAME=^EDRUTIL("DOMAINS TO POKE",DOMNUM)
 . D SEND(DOMNUM,DOMNAME)
 QUIT
 ;
SEND(domnum,domname) ; Send a networked mail message to a domain
 ; format of the VAMC domain names is XXXX.VA.GOV  (XXXX may have "-")
 I domname="" QUIT
 I $L(domname,".")'=3 QUIT
 I domname'?.AP1".VA.GOV" QUIT
 K XMY S XMY("G.RCP-EDR REPORTS@"_$P(^DIC(4.2,domnum,0),"^"))=""
 S XMSUB="Message from RCP-"_^XMB("NETNAME")_" to evoke ""TURN"""
 S XMSUB=$E(XMSUB,1,65)
 K POKETXT
 S POKETXT(1)="(Note: This message is deletable...)"
 S POKETXT(2)="This message has been sent in order to start a MAILMAN"
 S POKETXT(3)=" transmission with your site.  The RCPs have enabled"
 S POKETXT(4)=" TURN so that a successful MAILMAN connection should"
 S POKETXT(5)=" receive any messages waiting for the RCP."
 S XMTEXT="POKETXT(",XMDUZ=.5
 U 53 D ^XMD
 QUIT
