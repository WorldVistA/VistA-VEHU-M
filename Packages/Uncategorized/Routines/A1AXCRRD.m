A1AXCRRD ;SLL/ALB ISC; CONTINGENCY REMOVED TRIGGERED MSG FOR RD; 12/30/87
 ;;VERSION 1.0
 ;
 D TKL
 S A1AXQ=$N(^XMB(3.8,"B","EXT REV RD",0))
 S A1AXRC="" F A1AXI=0:0 S A1AXRC=$O(^XMB(3.8,A1AXQ,1,"B",A1AXRC)) Q:A1AXRC=""!(A1AXRC'?.N)  D SENT
 K ^UTILITY($J,"CR"),P,S,R,Y,XMDUZ,XMY,XMSUB,XMTXT,A1AXNM,A1AXRC,A1AXI,A1AXQ,A1AXR1,I
 Q
TKL ;
 ;S A1AXNM=$P($P(^DIC(3,A1AXRC,0),"^",1),",",2)
 S P=+^DIZ(11830,D0,"P",D1,0),S=+^("S",D2,0),R=+^("R",D3,0)
MSG K ^UTILITY($J,"CR")
 ;S ^UTILITY($J,"CR",1,0)="Dear "_A1AXNM_","
 S ^UTILITY($J,"CR",1.2,0)=" "
 S A1AXF=$S($D(^DIC(4,^DIZ(11830,D0,"F"),0)):$P(^(0),"^",1),1:"") S ^UTILITY($J,"CR",2,0)="VAMC at "_A1AXF_" has CONTINGENCY REMOVED for the following recommendation:  "
 S ^UTILITY($J,"CR",2.5,0)=""
 S Y=$P(^DIZ(11830,D0,0),"^",1) X ^DD("DD") S ^UTILITY($J,"CR",6,0)="Ext Rev Date is "_Y
 S Y=+^DIZ(11830,D0,"O"),^UTILITY($J,"AC",7,0)="Ext Rev Organization is "_$P(^DIZ(11831,Y,0),"^",1)
 S Y=$S($D(^DIZ(11832,P,0)):$P(^(0),"^",1),1:""),^UTILITY($J,"CR",8,0)="Program Surveyed is "_Y
 S Y=$S($D(^DIZ(11835,S,0)):$P(^(0),"^",2),1:""),^UTILITY($J,"CR",9,0)="Service/Section is "_Y
 S ^UTILITY($J,"CR",10,0)="Surveyer Recommend No. is "_+^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,0)
 S ^UTILITY($J,"CR",11,0)=" "
 S ^UTILITY($J,"CR",12,0)="RECOMMENDATION:"
 S A1AXR1=0 F I=1:1 S A1AXR1=$O(^DIZ(11830,D0,"P",D1,"S",D2,"R",D3,1,A1AXR1)) Q:A1AXR1=""  S ^UTILITY($J,"CR",12+I,0)=^(A1AXR1,0)
 S XMTEXT="^UTILITY($J,""CR"","
 Q
SENT ;
 K XMY S XMY(A1AXRC)="" S XMDUZ=.5,XMSUB="*CONTINGENCY REMOVED AT "_A1AXF_""
 D ^XMD K XMY
 Q
