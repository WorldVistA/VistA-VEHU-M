AJK1UBS ;580/MRL - Collections, Transmission Check/Edit; 10-Apr-98
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This routine serves a couple of purposes.  The tag STR is called by
 ;AJK1UBM, the menu driver routine, to edit the transmission strings,
 ;or set them up locally.  The tag SHOW can be called, by itself, if
 ;you just want to display data, without editing.  It's also used,
 ;extensively, to determine whether the transmission string is 
 ;properly defined, such as prior to attempting to transmit in routine
 ;AJK1UBT.
 ;
STR(IEN) ; --- enter here to edit appropriate screen
 ;This tag is called by ^AJK1UBM, the menu driver routine, to permit
 ;editing and/or setup of the transmission strings.
 ;
 I '$$KEY^AJK1UBCP Q
 D EDIT
 K %,E,DIE,DIC,DA,DR Q
 ;
EDIT ;
 ;
 S X=$$SHOW(IEN,1) D:'X
 .W !!,"The transmission string on file is either missing or invalid."
 .W !,"You will not be able to transmit these transactions until the"
 .W !,"problem is corrected.  Try checking for overlapping elements."
 W !!,"Want to Edit this Transmission String" S %=2 D YN^DICN
 I %,%'=1 Q
 I '% D  H 2 G EDIT
 .W !?4,"Answer YES if you'd like to update this information.  Answer"
 .W !?4,"NO if the transmission string looks fine the way it is."
 S DIC="^DIZ(580950.6,",DIE=DIC,(DA,Y)=+IEN,DIE("NO^")=""
 S DR="[AJK1UB ELEMENT EDIT]"
 D ^DIE
 K DIE,DIE,DA,Y
 G EDIT
 ;
SHOW(IEN,W) ; --- show data set in screen
 ;     I(en):     1 = New Xmit String
 ;                2 = Status Change String
 ;     W(rite):   1 = write data
 ;                0 = check only, no write
 ;
 N X,Y
 G N1:'W
 S X=$P("NEW^STATUS CHANGE","^",+IEN)_" TRANSMISSION STRING ENTER/EDIT"
 W @IOF
 W !?(80-$L(X))\2,X,!?(80-$L(X))\2
 F I=1:1:$L(X) W "="
 W !!,"Position",?10,"Length",?18,"Element",?40,"Position",?50,"Length",?58,"Element"
 W !,"--------",?10,"------",?18,"-------",?40,"--------",?50,"------",?58,"-------"
 ;
N1 ; --- come here if only checking
 K AJK
 I $O(^DIZ(580950.6,+IEN,"D",0))'>0 D:W  G NQ
 .W !!!?10,"NO INFORMATION CURRENTLY ON FILE FOR THIS RECORD!"
 S (I,T(1),T(2),T(3))=0
 F  S I=$O(^DIZ(580950.6,+IEN,"D",I)) Q:I'>0  S X=^(I,0) D
 .S X=+$P(X,"^",5) S:'X X=1 S T(+X)=T(+X)+1
 I +T(3) S T(1)=T(1)+T(3),T(2)=T(2)+T(3)
 S MAX=+$P(^DIZ(580950.6,+IEN,0),"^",2)
 G NQ:'MAX ;maximum length zero
 S E=1 F L=1,2 D:T(L) S1
 ;
NQ ; --- quit show
 K C,I,J,Y,X,P,AJK,R,T,MAX
 Q E
 ;
S1 ; --- show (multiple line display)
 ;
 K AJK,P
 I W,L=2 W !
 S:(T(L)#2) T(L)=T(L)+1 S T=(T(L)\2)
 S R=1,(C,I)=0
 F  S I=$O(^DIZ(580950.6,+IEN,"D","AS",I)),J=0 Q:I'>0  D
 .F  S J=$O(^DIZ(580950.6,+IEN,"D","AS",I,J)) Q:J'>0  D
 ..S X=^DIZ(580950.6,+IEN,"D",+J,0)
 ..S L(1)=+$P(X,"^",5) S:'L(1) L(1)=1
 ..I $S(L(1)=3:0,L(1)=L:0,1:1) Q  ;match line #'s
 ..S C=C+1,Y=$P(X,"^",2,3)
 ..S Y=Y_" "_$P("LS^LZ^RS^RZ","^",+$P(X,"^",4))_"^" ;format
 ..S Y=Y_$P(^DIZ(580950.5,+X,0),"^",2)
 ..I C'>T,R=1 S AJK(I)=Y,P(C)=I Q
 ..S:C>T C=1,R=2
 ..S AJK(P(C))=AJK(P(C))_"^"_Y
 K P
 S I=0 F  S I=$O(AJK(I)) Q:I'>0  W:W ! D
 .F J=1:1:6 S (C,X)=$P(AJK(I),"^",J) D
 ..I J=1!(J=4),X]"" S Y=$P(AJK(I),"^",J+1)-1,Y=(X+Y) D
 ...S X=$E("000"_+X,0,3-$L(X))_+X_"-"_$E("000"_+Y,0,3-$L(Y))_+Y
 ...S P(+C)=+$P(AJK(I),"^",(J+1))
 ..I J=2!(J=5) S X=$J(X,6)
 ..I W W ?($P("0^10^18^40^50^58","^",J)),X
 S P="",I=0 F  S I=$O(P(I)) Q:I'>0!('E)  D
 .I $E(P,I,(I+(P(I)-1)))]"" S E=0 Q  ;overlap
 .S J="",$P(J,"1",100)="",P=P_$E(J,1,P(I))
 .I $L(P)>MAX S E=0 ;too long a string
 Q
