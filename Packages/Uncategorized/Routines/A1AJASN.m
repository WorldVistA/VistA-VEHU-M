A1AJASN ;isa\jas   TELL ME WHAT NODE
 S A1AJNODE=$ZU(110)
 D OUTPUT
 Q
 ; 
OUTPUT ;
 S DUZ=.5,XMDUZ=DUZ,U="^"
 S XMSUB="Currently Running Node"
 S XMY("Jerry.Sicard@med.va.gov")=""
 ;S XMY("SICARD@ISC-ALBANY.VA.GOV")=""
 S %H=$H D YX^%DTC
 S XMTEXT(1)="The running node has changed to "_A1AJNODE_" at "_$P(^DIC(4.2,$P(^XTV(8989.3,1,0),"^",1),0),"^",1)
 S XMTEXT(2)="This change occured at "_Y
 S XMTEXT="XMTEXT("
 S XMCHAN=1
 D ^XMD
 Q
  
