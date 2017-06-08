ZZTSET7B        ;ciofo-scramble patient data ;10/1/97
 ;;1.0;test system reset utilities;
 ;
 ; call FileMan to reset patient name with the scrambled one...
 S (DIC,DIE)=2
 S DIC(0)="MF"
 S DR=".01////^S X=NNAME"
 D ^DIE
 ;
 ; retrieve the zero-eth node that now contains the bogus patient name...
 S ZZDATA(0)=^DPT(DA,0)
 ;
 ; increment bogus ssn and hard-set into zero-eth node variable (we'll re-index the
 ; ssn field later)...
 S NSSN=NSSN+1
 S $P(ZZDATA(0),U,9)=NSSN
 ;
 ; pull the other data nodes we want to work with...
 F ZZX=.11,.111,.12,.121,.13,.24 S ZZDATA(ZZX)=$G(^DPT(DA,ZZX))
 ;
 ; change city and state in the zero-eth node...
 I $P(ZZDATA(0),U,11)'="" S $P(ZZDATA(0),U,11)=NCITY
 I $P(ZZDATA(0),U,12)'="" S $P(ZZDATA(0),U,12)=NSTATE
 ;
 ; change current address node...
 I ZZDATA(.11)'="" D
 .I $P(ZZDATA(.11),U,4)'="" S $P(ZZDATA(.11),U,4)=NCITY
 .I $P(ZZDATA(.11),U,5)'="" S $P(ZZDATA(.11),U,5)=NSTATE
 .I $P(ZZDATA(.11),U,6)'="" S $P(ZZDATA(.11),U,6)=NZIP
 .I $P(ZZDATA(.11),U,7)'="" S $P(ZZDATA(.11),U,7)=NCOUNTY
 ;
 ; change legal residence node...
 I ZZDATA(.111)'="" D
 .I $P(ZZDATA(.111),U,4)'="" S $P(ZZDATA(.111),U,4)=NCITY
 .I $P(ZZDATA(.111),U,5)'="" S $P(ZZDATA(.111),U,5)=NSTATE
 .I $P(ZZDATA(.111),U,6)'="" S $P(ZZDATA(.111),U,6)=NZIP
 .I $P(ZZDATA(.111),U,7)'="" S $P(ZZDATA(.111),U,7)=NCOUNTY
 ;
 ; change prior address node...
 I ZZDATA(.12)'="" D
 .I $P(ZZDATA(.12),U,4)'="" S $P(ZZDATA(.12),U,4)=NCITY
 .I $P(ZZDATA(.12),U,5)'="" S $P(ZZDATA(.12),U,5)=NSTATE
 .I $P(ZZDATA(.12),U,6)'="" S $P(ZZDATA(.12),U,6)=NZIP+$R(1000)
 .I $P(ZZDATA(.12),U,7)'="" D
 ..;
 ..; up to now, NCOUNTY=a number, this county field requires free text...
 ..I $D(^DIC(5,NSTATE,1,+NCOUNTY,0)) S $P(ZZDATA(.12),U,7)=$P(^DIC(5,NSTATE,1,+NCOUNTY,0),U) Q
 ..S $P(ZZDATA(.12),U,7)=$O(^DIC(5,NSTATE,1,"B","A"))
 ;
 ; change temporary address node...
 I ZZDATA(.121)'="" D
 .I $P(ZZDATA(.121),U,4)'="" S $P(ZZDATA(.121),U,4)=NCITY
 .I $P(ZZDATA(.121),U,5)'="" D
 ..S $P(ZZDATA(.121),U,5)=+$O(^DIC(5,NSTATE))
 ..I $P(ZZDATA(.121),U,5)=0 S $P(ZZDATA(.121),U,5)=+$O(^DIC(5,1))
 .I $P(ZZDATA(.121),U,6)'="" S $P(ZZDATA(.121),U,6)=NZIP+$R(1000)
 .I $P(ZZDATA(.121),U,10)'="" S $P(ZZDATA(.121),U,10)="(800) "_(100+$R(800))_" "_(1000+$R(9000))
 ;
 ; change phone number(s) node...
 I ZZDATA(.13)'="" D
 .I $P(ZZDATA(.13),U)'="" S $P(ZZDATA(.13),U)=$E(NPHONE,1,3)_" "_$E(NPHONE,4,7)
 .I $P(ZZDATA(.13),U,2)'="" S $P(ZZDATA(.13),U,2)="(800) "_($E(NPHONE,1,3)+$R(100))_" "_($E(NPHONE,4,7)+$R(1000))
 .I $P(ZZDATA(.13),U,3)'="" S $P(ZZDATA(.13),U,3)="(800) "_(100+$R(800))_" "_(1000+$R(9000))
 .I $P(ZZDATA(.13),U,4)'="" S $P(ZZDATA(.13),U,4)="(800) "_(100+$R(800))_" "_(1000+$R(9000))
 ;
 ; change parents' names node...
 I ZZDATA(.24)'="" D
 .I $P(ZZDATA(.24),U)'="" D
 ..S LIN=$R(22)+1
 ..S RND=$R(15)+1
 ..S $P(ZZDATA(.24),U)=$P(NNAME,",",1)_","_$P(^TMP($J,"FENAME",LIN),U,RND)
 .I $P(ZZDATA(.24),U,2)'="" D
 ..S LIN=$R(22)+1
 ..S RND=$R(15)+1
 ..S $P(ZZDATA(.24),U,2)=$P(NNAME,",",1)_","_$P(^TMP($J,"FENAME",LIN),"^",RND)
 .I $P(ZZDATA(.24),U,3)'="" D
 ..S LIN=$R(22)+1
 ..S RND=$R(15)+1
 ..S $P(ZZDATA(.24),U,3)=$P(^TMP($J,"LNAME",RND),U,LIN)
 .K LIN,RND
 ;
 ; file the changed data...
 F ZZX=0,.11,.111,.12,.121,.13,.24 D
 .I ZZDATA(ZZX)'="" S ^DPT(ZZDFN,ZZX)=ZZDATA(ZZX)
 ;
 ; finally, deal with reindexing of social security number.  Only specific x-refs will
 ; be executed...
 S DA=ZZDFN
 S DIK="^DPT("
 S DIK(1)=".09^ATP^AVADPT6^BS^BS5^SSN"
 D EN^DIK
 K DIK,ZZDATA,ZZX
 Q        
