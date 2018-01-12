AJK1UBFY ;580/MRL - Collections, Statistics; 11-Jan-00
 ;;2.0T8;AJK1UB;;January 14, 2000
 ;
 ;Collect and transmit collection statistics.
 ;
EN ; --- entry point (process new first)
 ;
 D XMQ^AJK1UBTM,CPAR^AJK1UBCP
 G END:'$$DOW^AJK1UBCP ;not right dow
 G END:$$PIECE^AJK1UBCP(19)=DT ;quit if run today
 S MCCR=$$MCCR
 S LAST=$$LAST(MCCR)
 S FY=$$FY(DT)
 K AJK,CUM,FYTD,^TMP($J,"AJKZ")
 S DATE=0
 F  S DATE=$O(^AJK1UB("AT",DATE)),(CT,DA)=0  Q:DATE'>0!(DATE>LAST)  D
 . F  S DA=$O(^AJK1UB("AT",DATE,DA)) Q:DA'>0  D:$D(^AJK1UB(DA,0))
 . . S X=^AJK1UB(DA,0),CLOSE=0
 . . S Y=$G(^AJK1UBS(+$P(X,U,5),0))
 . . S SD=$P(Y,U,2) ;status date/closed
 . . D UP(1,1,2,DATE) ;new xmit's
 . . S:'$P(X,U,4) CLOSE=1 ;closed
 . . S CHARGE=+$P($G(^PRCA(430,+DA,0)),U,3) D UP(3,CHARGE,2,DATE) ;charge
 . . Q:'CLOSE  ;open
 . . I SD'>LAST,'$D(^TMP($J,"AJKZ",DA)) D UP(2,1,2,SD) ;closed ctr
 . . S ^TMP($J,"AJKZ",DA)="" ;don't double count closed
 . . S IEN=0,LD=$S(LAST>SD:SD,1:LAST)
 . . S C1=CHARGE,F1=$S(DATE<FY:"",1:CHARGE)
 . . F  S IEN=$O(^PRCA(433,"C",DA,IEN)) Q:IEN'>0  D
 . . . I '$D(^PRCA(433,+IEN,0)) Q
 . . . S Y=^PRCA(433,+IEN,1)
 . . . I +Y<DATE!(+Y>LD) Q  ;bad date
 . . . S C=$$C(+$P(Y,U,2))
 . . . Q:'C  ;no status code
 . . . S AMT=+$P(Y,U,5)
 . . . S:AMT<0 AMT=+(-AMT)
 . . . I C=3!(C=4) D  Q  ;payments
 . . . . S $P(C1,U,2)=$P(C1,U,2)+AMT Q:+Y<FY
 . . . . S $P(F1,U,2)=$P(F1,U,2)+AMT
 . . . S:C=5 C=1 S $P(C1,U,(C+2))=$P(C1,U,(C+2))+AMT
 . . . I +Y'<FY S $P(F1,U,(C+2))=$P(F1,U,(C+2))+AMT
 . . F I=2:1:5 D UP((I+2),$P(C1,U,I),1,0) ;update cum
 . . F I=2:1:5 D UP((I+2),$P(F1,U,I),3,0) ;update fytd
 F AJK="CUM","FYTD" D
 . S X=$P(@AJK,U,2),X1=$P(@AJK,U,4)
 . I +X,+X1 S X=X1/X,$P(@AJK,U,7)=X ;ave collected
 . S X=$P(@AJK,U,3)
 . I +X,+X1 S X=(X1/X)*100,$P(@AJK,U,8)=X ;percent
 F AJK=1:1:8 F AJK1="CUM","FYTD" D  ;enter $,%,decimal
 . S X=+$P(@AJK1,U,AJK),X2=$S(AJK>2&(AJK<8):"2$",AJK=8:2,1:""),X3=20
 . D COMMA^%DTC S:AJK=8 X=X_"%" S $P(@AJK1,U,AJK)=X
N1 D TXT
 S C=0 F I=1:1:8 S J=$P($T(W+I),";;",2) D
 . S J=$E(J_"                                         ",1,35)
 . F Z="CUM","FYTD" D  S J=J_X
 . . S X=$P(@Z,U,I)
 . . I Z="FYTD",I=8 S X=$E(X,2,99) Q
 . D SAVE(J)
 S XMTEXT="TXT("
 S X=$$GRP^AJK1UBTM($$RGP^AJK1UBCP)
 I MCCR D
 . S X=" " D SAVE(X)
 . S X="REPORT SENT TO MCCR PROGRAM OFFICE" D SAVE(X)
 . S XMY("90DAY@MED.VA.GOV")="",XMY("vadmin@TRANSWORLDSYSTEMS.COM")=""
 . S $P(^DIZ(580950.1,1,0),U,19)=DT
 S XMSUB=+AJKCP("C")_"-"_^DD("SITE")_", Collections"
 D ^XMD
 D XMQ^AJK1UBTM
 ;
END ; --- that's all folks
 ;
 K AJK,AJK1,AMT,C,C1,CHARGE,CLOSE,CT,CUM,D,DA,DATE,F1,FY,FYTD
 K I,IEN,J,LAST,LD,MCCR,SD,TXT,X,X1,X2,X3,Y,Z,^TMP($J,"AJKZ")
 K %I,%H,%T,%Y Q
 ;
C(C) ; --- get actual status code from transactions
 ;
 Q:'C 0
 I "^3^4^7^8^9^10^23^26^29^35^39^"[("^"_+C_"^") Q 1
 I "^19^40^47^"[("^"_+C_"^") Q 2
 I "^22^34^"[("^"_+C_"^") Q 3
 Q:C=2 4
 Q 0
 ;
UP(X,Y,Z,D) ; --- update counters
 ;             X = piece
 ;             Y = value
 ;             Z = 1:cumulative
 ;                 2:cumulative & fytd
 ;                 3:fytd only
 ;             D = date or status date
 ;
 I Z,Z<3 S $P(CUM,U,X)=$P($G(CUM),U,X)+Y
 I Z>1,$S('D:1,D'<FY:1,1:0) S $P(FYTD,U,X)=$P($G(FYTD),U,X)+Y
 Q
 ;
FY(X) ; --- start of current FY
 ;
 N Y
 S Y=$S(+$E(X,4,5)>9:0,1:"-1")
 Q ($E(X,1,3)+Y)_"1001"
 ;
MCCR() ; --- program office?
 ;
 S X=$$PIECE^AJK1UBCP(19) Q:'X 1 ;new
 I DT>3000201,+X,+X<3000220 Q 1
 I +$E(DT,1,5)=+$E(X,1,5) Q 0 ;sent
 Q 1 ;due
 ;
LAST(X) ; --- end date
 ;
 S X1=$S('X:DT,1:($E(DT,1,5)_"01")),X2=-1 D C^%DTC
 Q X
 ;
TXT ; --- message text
 ;
 K TXT
 S X="The following transmission activity has been recorded for Client "
 S X=X_AJKCP("C")_"." D SAVE(X)
 S X="Only those bills which are at least "_+AJKCP("B")_" days old are "
 S X=X_"transmitted.  The first " D SAVE(X)
 S X="column of data contains CUMULATIVE data starting with the date of "
 S X=X_"the initial " D SAVE(X)
 S X="transmission.  The second column shows data for the current "
 S X=X_"Fiscal Year." D SAVE(X)
 S X="The ending date for this report is " S Y=LAST X ^DD("DD")
 S X=X_Y_"." D SAVE(X)
 S X=" " D SAVE(X)
 S X="                                            CUMULATIVE                FYTD"
 D SAVE(X)
 Q
 ;
SAVE(X) ; --- save X in TXT(
 ;
 S TXT=$G(TXT)+1,TXT(TXT,0)=X
 Q
 ;
W ; --- data descriptions
 ;;Number of Bills Transmitted
 ;;     Number of Bills Closed
 ;;    Total Dollars Submitted
 ;;Cash Resolution (Collected)
 ;;        Cancelled (Dollars)
 ;;        Suspended (Dollars)
 ;;   Average Return (Dollars)
 ;;   Average Return (Percent)
