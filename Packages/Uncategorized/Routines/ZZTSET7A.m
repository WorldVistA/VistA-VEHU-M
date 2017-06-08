ZZTSET7A        ;ciofo-compute scrambled data for patient file ;10/1/97
 ;;1.0;test system reset utilities;
 ;
 ; this routine is called by ZZTSET7 to scramble various patient name and address data.
 ;
 ; set up a bogus name...
 S FNAME=""
 ;
 ; if sex is female, get a female first name...
 I $P(^DPT(DA,0),U,2)["F" D
 .S RND=$R(15)+1
 .S LIN=$R(NFN)+1
 .S FNAME=$P(^TMP($J,"FENAME",LIN),U,RND)
 ;
 I FNAME="" D
 .S RND=$R(15)+1
 .S LIN=$R(NMN)+1
 .S FNAME=$P(^TMP($J,"FNAME",LIN),U,RND)
 .S RND=$R(14)+1
 .S LIN=$R(NLN)+1
 .S LNAME=$P(^TMP($J,"LNAME",LIN),U,RND)
 .S MI=$E("ABCDEFGHIJKLMNOPQRSTUVWXYZ ",$R(27)+1)
 .S NNAME=LNAME_","_FNAME_$S(MI?1A:" "_MI_".",1:"")
 ;
 ; county and state...
 S NSTATE=$R(51)+1
 S NSTATE=$S($D(^DIC(5,NSTATE,0)):NSTATE,1:$O(^DIC(5,NSTATE)))  
 S NCOUNTY=$S($P(^DIC(5,NSTATE,1,0),U,3)>1:$R($P(^DIC(5,NSTATE,1,0),U,3)-1)+1,1:1)
 I '$D(^DIC(5,NSTATE,1,NCOUNTY,0)) S NCOUNTY=$S($O(^DIC(5,NSTATE,1,NCOUNTY))'?1A.E:$O(^(5)),1:1)
 ;
 ; city...
 S NCITY=""
 I $P(^DIC(5,NSTATE,0),"^",1)["COLUMBIA" S NCITY="WASHINGTON D.C."
 I NCITY="" D
 .S C1=$R(5),C2=$R(20) S:C2=0 C2=1
 .S NCITY=$P(^TMP($J,"CITY",C1),U,C2)
 .K C1,C2
 ;
 ; zip code...
 S NZIP=$R(99999)_$R(99999)
 S NZIP=$E(NZIP,1,5)
 ;
 ; telephone number...
 S NPHONE=""
 S OPHONE=$P($G(^DPT(DA,.13)),U)
 I OPHONE]"" D
 .F I=1:1:$L(OPHONE) S NPHONE=NPHONE_$S($E(OPHONE,I)?1N:$R(9),1:$E(OPHONE,1))
 ;
 K X,Y,C1,C2,FN,LN,I,SCR,OCNO,OPHONE
 Q
