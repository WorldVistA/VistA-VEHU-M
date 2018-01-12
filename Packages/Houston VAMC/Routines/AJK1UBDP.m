AJK1UBDP ;580/MRL - Collections, Display Parameters; 12-Dec-98
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This option is called to display current values for certain
 ;parameter options prior to going into the edit modes.  The
 ;tags are called as ENTRY ACTIONS to the option itself.
 ;
 ;
CAT(AJKI) ; --- AR Categories
 ;
 N C,I
 I +AJKI D
 .D CTR("ACCOUNTS RECEIVABLE CATEGORIES FLAGGED FOR TRANSMISSION",1)
 .D CTR("Only those AR Categories flagged are considered for Collections Transmission",0)
 S (C,I)=0 F  S I=$O(^PRCA(430.2,I)) Q:I'>0  S X=$P(^(I,0),"^",1) D
 .Q:'+$G(^PRCA(430.2,+I,"AJK1UB"))  S C=C+1
 .Q:'+AJKI
 .I C=1 W !?0,"Number",?15,"AR Category",!?0,"------",?15,"-----------"
 .W !,$J(I,4),?15,X
 I 'C D:+AJKI
 .W !!
 .W ?5,"*** WARNING *** WARNING *** WARNING *** WARNING *** WARNING ***"
 .W !?7,"There are no AR Categories flagged for transmission to the"
 .W !?7,"Collection agency.  Only new bills assigned categories which"
 .W !?7,"are flagged for transmission are sent to the agency for"
 .W !?7,"collections.  Usually, at least REIMBURSABLE INSURANCE is"
 .W !?7,"flagged."
 W:AJKI !
 Q +C
 ;
RATE(AJKI) ; --- Rate Types
 ;
 N C,I,Z
 I +AJKI D CTR("BILL/CLAIMS RATE TYPES SET TO TRANSMIT",1)
 S (C,I)=0 F  S I=$O(^DGCR(399.3,I)) Q:I'>0  S X=$P(^(I,0),"^",1) D
 .Q:'$D(^DGCR(399.3,+I,"AJK1UB"))  S C=C+1
 .Q:'AJKI
 .I C=1 W !?0,"Number",?15,"Rate Type",!?0,"------",?15,"---------"
 .W !,$J(I,4),?15,X
 I 'C D:AJKI
 .W !!
 .W ?5,"*** WARNING *** WARNING *** WARNING *** WARNING *** WARNING ***"
 .W !?7,"There are no RATE TYPES flagged for collection purposes.  This"
 .W !?7,"means that NO BILLS WILL EVER TRANSMIT TO THE COLLECTION"
 .W !?7,"AGENCY.  You will need to flag, using this option, those RATE"
 .W !?7,"Types which are considered reportable for collections."
 W:+AJKI !
 Q +C
 ;
TRANS(AJKI) ; --- AR Transaction Type
 ;
 N C,I
 I AJKI D
 .D CTR("AR TRANSACTION TYPES SET TO TRANSMIT STATUS UPDATES",1)
 .D CTR("Only those Types flagged generate a Status Update to Collections",0)
 S (C,I)=0 F  S I=$O(^PRCA(430.3,I)) Q:I'>0  S X=$P(^(I,0),"^",1) D
 .S Z=+$G(^PRCA(430.3,I,580000)) Q:'Z  S C=C+1
 .Q:'+AJKI
 .S Z(1)=$E($P($G(^DIZ(580950.8,+Z,0)),"^",1),1,4)
 .D:C=1
 ..W !?0,"Number",?8,"Transaction",?30,"Transmit"
 ..W ?40,"|Number",?49,"Transaction",?71,"Transmit"
 ..W !?0,"------",?8,"-----------",?30,"--------"
 ..W ?40,"|------",?49,"-----------",?71,"--------"
 .I (C#2) W !?0,$J(I,4),?8,$E(X,1,20),?30,Z(1)
 .E  W ?40,"|",$J(I,4),?49,$E(X,1,20),?71,Z(1)
 I 'C D:+AJKI
 .W !!
 .W !?5,"*** WARNING *** WARNING *** WARNING *** WARNING *** WARNING ***"
 .W !?7,"There are no Accounts Receivable Transaction Types set up to"
 .W !?7,"generate Status Updates to the Collection Agency.  This means"
 .W !?7,"that, if you're sending new records, they will never be closed"
 .W !?7,"because you haven't identified those Transaction Types which"
 .W !?7,"should updates the Collection Agency's files.  Please take the"
 .W !?7,"time to update those status' which you'd want to generate a"
 .W !?7,"status update with the code you'd like to be transmitted."
 W:AJKI !
 Q C
 ;
CTR(X,Y) ; --- center the passed data
 ;             X = text to center
 ;             Y = 1 is a header; 0 isn't
 ;
 N Z
 W:Y @IOF
 S:'Y X="("_X_")"
 S Z=$S($D(IOM):IOM,1:80)-$L(X)\2
 W !?Z,X
 I Y W !?Z F I=1:1:$L(X) W "="
 W:'Y !
 Q
