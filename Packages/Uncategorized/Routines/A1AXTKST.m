A1AXTKST ;SLL/ALB ISC; FACILIT TICKLER MAIL MSG FOR IN PROCESS RECOMMEND; 12/30/87
 ;;VERSION 1.0
 ;
 S A1AXQ=$N(^XMB(3.8,"B","EXT REV FAC",0))
 S A1AXRC="" F I=0:0 S A1AXRC=$O(^XMB(3.8,A1AXQ,1,"B",A1AXRC)) Q:A1AXRC=""!(A1AXRC'?.N)  S A1AXFC=0 F J=0:0 S A1AXFC=$O(^DIC(3,A1AXRC,2,A1AXFC)) Q:A1AXFC'?.N!(A1AXFC="")  D TKL
 K A1AXRC,A1AXFC,I,J
 K %,A1AXQ,D,Y,%H,%I,A1AXF,ER,I,K,X,XMKK,XMLOCK,XMQF,XMR,XMT,XMTEXT,XMZ
 Q
TKL ;
 F A=0:0 S A=$N(^DIZ(11830,"STS","I",A)) Q:A<0  F P=0:0 S P=$N(^DIZ(11830,"STS","I",A,P)) Q:P<0  F S=0:0 S S=$N(^DIZ(11830,"STS","I",A,P,S)) Q:S<0  F R=0:0 S R=$N(^DIZ(11830,"STS","I",A,P,S,R)) Q:R<0  D MSG
 K ^UTILITY($J,"TKL"),A,P,S,R,Y,XMDUZ,XMY,XMSUB,XMTXT,A1AXNM
 Q
MSG ;
 Q:A1AXFC'=+^DIZ(11830,A,"F")
 K ^UTILITY($J,"TKL")
 ;S A1AXNM=$P($P(^DIC(3,A1AXRC,0),"^",1),",",2)
 ;S ^UTILITY($J,"TKL",1,0)="Dear "_A1AXNM_","
 S ^UTILITY($J,"TKL",1.2,0)=" "
 S A1AXF=$S($D(^DIC(4,^DIZ(11830,A,"F"),0)):$P(^(0),"^",1),1:"") S ^UTILITY($J,"TKL",2,0)="VAMC at "_A1AXF_" has an Action Plan IN PROCESS  "
 S ^UTILITY($J,"TKL",2.2,0)="Please check into it and update the status."
 S ^UTILITY($J,"TKL",2.5,0)=""
 S Y="" I $D(^DIZ(11830,A,"P",P,"S",S,"R",R,11)) S Y=$P(^(11),"^",1) X ^DD("DD")
 S ^UTILITY($J,"TKL",3,0)="EXPECTED COMPLETION DATE IS "_Y
 S Y=$P(^DIZ(11830,A,0),"^",1) X ^DD("DD") S ^UTILITY($J,"TKL",6,0)="Ext Rev Date is "_Y
 S Y=+^DIZ(11830,A,"O"),^UTILITY($J,"TKL",7,0)="Ext Rev Organization is "_$P(^DIZ(11831,Y,0),"^",1)
 S Y=$S($D(^DIZ(11832,P,0)):$P(^(0),"^",1),1:""),^UTILITY($J,"TKL",8,0)="Program Surveyed is "_Y
 S Y=$S($D(^DIZ(11835,S,0)):$P(^(0),"^",2),1:""),^UTILITY($J,"TKL",9,0)="Service/Section is "_Y
 S ^UTILITY($J,"TKL",10,0)="Surveyer Recommend No. is "_+^DIZ(11830,A,"P",P,"S",S,"R",R,0)
 S ^UTILITY($J,"TKL",11,0)=" "
 S ^UTILITY($J,"TKL",12,0)="Recommendation:"
 S ^UTILITY($J,"TKL",13,0)=$S($D(^DIZ(11830,A,"P",P,"S",S,"R",R,1,1,0)):^(0),1:"")
 S ^UTILITY($J,"TKL",14,0)="Action Plan:"
 S ^UTILITY($J,"TKL",15,0)=$S($D(^DIZ(11830,A,"P",P,"S",S,"R",R,10,1,0)):^(0),1:"")
 S XMTEXT="^UTILITY($J,""TKL"","
 K XMY S XMY(A1AXRC)="" S XMDUZ=.5,XMSUB="*ACTION PLAN IN PROCESS AT "_A1AXF_"** (FACILITY COPY)"
 D ^XMD K XMY
 Q
