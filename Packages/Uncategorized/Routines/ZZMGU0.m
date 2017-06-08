ZZMGU0 ; B'ham ISC/CML3 - MOVE GLOBALS, WORK DONE HERE ;1/22/92  14:18 [ 02/05/92  3:04 PM ]
 ;;1T4
 ;
ERR ; come here if an error occurs
 S $P(^ZZMG(DA,0),"^",6)="" I $G(NF),$G(SND),$D(C) S $P(^(1,NF,1,SND,0),"^",2,3)=C_"^"_$H
 D NOW^%DTC S ^ZZMG(DA,"E")=%_"^"_$ZERROR I '$G(AR) ZQUIT
 H 30 G M1
 ;
MOVE(DA) ; entry for initial move and manual restart
 ;
M1 ;
 K C S ND=$G(^ZZMG(DA,0)) D NOW^%DTC I ND="" S ^ZZMG(DA,"E")=%_"^"_"DATA NODE NOT FOUND FOR "_DA G MD
 S EDA=DA,$P(^(0),"^",6)=$J,$P(^(0),"^",$P(ND,"^",7)>0+7)=%,LG=$G(^("LG")),VOL=$P(ND,"^",2),AR=$P(ND,"^",3),DORT=$P(ND,"^",4),NF=+$P(ND,"^",10),UCI=$P(VOL,","),VOL=$P(VOL,",",2)
 S $ZTRAP="ERR^ZZMGU0" I LG]"",LG?1"["11E1"]"1.E S LG=$P(LG,"]",2,99)
 F  S NF=$O(^ZZMG(DA,1,NF)) Q:'NF  S SG=$P($G(^(NF,0)),"^") I SG]"" D  
 .S C=0,SND=$G(^ZZMG(DA,1,NF,1,0)) F SND=$P(SND,"^",3)+1:1 I '$D(^ZZMG(DA,1,NF,1,SND,0)) S ^(0)=$H Q
 .I SND=1 S ^ZZMG(DA,1,NF,1,0)="^521521.0101^1^1"
 .E  S $P(^ZZMG(DA,1,NF,1,0),"^",3,4)=SND_"^"_SND
 .S:SG?1"["11E1"]"1.E SG=$P(SG,"]",2,99) I LG]"",$E(LG,1,$L(SG))=SG S SG=LG
 .S TG=SG,GBL="^["""_UCI_""","""_VOL_"""]"_SG I $D(@GBL)#2 S @("^"_TG)=@GBL,C=C+1
 .F C=C+1:1 S GBL=$Q(@GBL) Q:GBL=""  S TG=$P(GBL,"]",2,99) S @("^"_TG)=@GBL I '(C#100) W:DORT="D" !,$H,"  ",GBL S ^ZZMG(DA,"LG")=TG
 .S LG="",$P(^ZZMG(DA,0),"^",10)=NF,$P(^(1,NF,1,SND,0),"^",2,3)=C_"^"_$H,SND=0
 D NOW^%DTC S $P(^ZZMG(DA,0),"^",9)=%
 ;
MD ;
 K C,DA,EDA,GBL,LG,ND,NF,SND,SG,TG,UCI,VOL Q
 ;
ENGNC ;
 W *7,*7,!!,"PLEASE MAKE SURE YOUR SLAVE PRINTER IS ON.",!,"Press RETURN when ready, or enter a '^' to abort this count: " R X:60 W:'$T *7 S:'$T X="^" I X="^" K X Q
 K ^ZZGNC S X="^" F  S X=$O(@X) Q:X=""  W !,X,"..." S:$E(X)'="^" X="^"_X S C=0 S:$D(@X)#2 C=C+1 D  
 .S Y=X F C=C:1 S Y=$Q(@Y) Q:Y=""  I '(C#1000) W "."
 .S ^ZZGNC($E(X,2,99))=C
GNCL ; 
 W #,!?29,"GLOBAL NODE COUNT LIST",! S X="" F  S X=$O(^ZZGNC(X)) Q:X=""  W !,X,?10,^(X)
 R !!,"End of list.  Press RETURN to continue. ",X:600 Q
