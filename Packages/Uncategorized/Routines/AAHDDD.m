%AAHDDD ;402,DJB,11/2/91,EDD**Data Look-up
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
 NEW D0,DA,DIC,DICHOLD,DIQ,DR
 NEW ANS,FILE,FILEUP,FLAGDASH,FLAGLONG,FLAGREF,FLAGT,FLAGWP,FLD,FLDUP,FNAM,I,II,NODE,REF,REF1,TEMP,TYPE,WP,XXUP,ZDIC,ZDIQ
 D ACCESS^%AAHDDD1 Q:FLAGQ
 K ^UTILITY("DIQ1",$J),^UTILITY($J,"DATA") S FLAGLONG=0 ;FLAGLONG set to 1 if DR string too long.
 D GETTYPE^%AAHDDD1 Q:FLAGQ  D GETREF^%AAHDDI4 Q:FLAGQ
 I REF'["-"&(REF'[",") S REF1=REF D SET,BUILD
 I REF["-" F REF1=$P(REF,"-"):1:$P(REF,"-",2) D SET,BUILD
 I REF["," F I=1:1:$L(REF,",") S REF1=$P(REF,",",I) D SET,BUILD
 D DR F  D DA Q:FLAGQ  D DIQ,PRINT^%AAHDDD1 K ^UTILITY("DIQ1",$J) Q:FLAGQ
KILL K ^UTILITY("DIQ1",$J),^UTILITY($J,"DATA"),D0,D1,D2,D3,D4,D5,D6
 Q
 ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SET ;Set Variables FILE & FLD
 S FILE=$P(^UTILITY($J,"LIST","REF",REF1),U),FLD=$P(^(REF1),U,2)
 I $P(^DD(FILE,FLD,0),U,2)["W" S FLAGWP(FILE)="" ;Word Processing Field. Used in DA
 Q
BUILD ;Set ^UTILITY($J,"DATA") to sort FILE and FLD to be used to build DR variable.
 S FLAGT=0 F  D  Q:FLAGT
 .I '$D(^DD(FILE,0,"UP")) S ^UTILITY($J,"DATA",FILE,FLD)="",FLAGT=1 Q
 .S ^UTILITY($J,"DATA",FILE,FLD)=""
 .S FILEUP=^DD(FILE,0,"UP"),FLDUP=$O(^DD(FILEUP,"SB",FILE,""))
 .S NODE(FILE)=$P($P(^DD(FILEUP,FLDUP,0),U,4),";") I +NODE(FILE)'=NODE(FILE) S NODE(FILE)=""""_NODE(FILE)_"""" ;If NODE(FILE) is a string, enclose in quotes.
 .S FILE=FILEUP,FLD=FLDUP
 Q
DR ;Build DR variable
 S (DR,FILE)="" F I=1:1 S FILE=$O(^UTILITY($J,"DATA",FILE)) Q:FILE=""!FLAGLONG  S:I=1 DR="" S:I>1 DR(FILE)="" S FLD="" F II=1:1 S FLD=$O(^UTILITY($J,"DATA",FILE,FLD)) Q:FLD=""!FLAGLONG  D
 .I I=1 S DR=DR_$S(II>1:";",1:"")_FLD S:$L(DR)>225 FLAGLONG=1 Q
 .S DR(FILE)=DR(FILE)_$S(II>1:";",1:"")_FLD S:$L(DR(FILE))>225 FLAGLONG=1
 Q
DA ;Set DA Variable for each layer
 S FLAGQ=0,DIC=ZGL,DIC(0)="QEAM" D ^DIC I Y<0 S FLAGQ=1 S:X="^^" FLAGE=1 Q
 S (DA,D0)=+Y,ZDIC(ZNUM)=DIC_+Y_"," ;EN^DIQ1 needs D0 defined
 S FILE="" F  S FILE=$O(DR(FILE)) Q:FILE=""!FLAGQ  D
 .I $D(FLAGWP(FILE)) S DA(FILE)=1 Q
 .S FILEUP=^DD(FILE,0,"UP") S TEMP=ZDIC(FILEUP)_NODE(FILE)_",0)" I $O(@TEMP)'>0 D  Q
 ..I ZDIQ'["N" F I=1:1:$L(DR(FILE),";") S ^UTILITY("DIQ1",$J,FILE,DA,$P(DR(FILE),";",I),TYPE)="" ;No data at this node. This will display each field as blank.
 ..S ZDIC(FILE)=ZDIC(FILEUP)_NODE(FILE)_",""EDD""," ;So any levels below this will be null.
 .S DIC=ZDIC(FILEUP)_NODE(FILE)_"," D ^DIC I Y<0 S FLAGQ=1 S:X="^^" FLAGE=1 Q
 .S DA(FILE)=+Y,ZDIC(FILE)=DIC_+Y_","
 Q
DIQ ;Call EN^DIQ1 to set up EDD array.
 S DIC=ZGL,DIQ(0)=ZDIQ D EN^DIQ1
 Q
