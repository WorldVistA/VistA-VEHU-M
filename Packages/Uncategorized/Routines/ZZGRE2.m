ZZGRE2 ;BUILDS A GLOBAL TO BE USED IN MY TESTING AND RESEARCHORD
 ;COMMENTS
 
TEST
 W !,"IN TEST"
 D SETUP
 ;D BGLOB
 D GETPAT
 Q
SETUP ;
 W !,"IN SETUP"
 S DUZ=1
 ;D ^XUP 
 Q
BGLOB ;
 N MYSTR
 S MYSTR=""
 SET ^Pe=""
 SET ^Pe(1)=$LB("DOE","JOHN","5545-89-2322","1234","LOS ANGELES","CA","95111")
 SET ^Pe(2)=$LB("DOE","JANE","5544-20-2232","2345","LOS ANGELES","CA","95111")
 SET ^Pe(3)=$LB("JACOBS","DAWN","7894-11-4545","3456","HARVARD","MA","01666")
 SET ^Pe(4)=$LB("DOVER","ILENE","1190-56-0933","4567","DALLAS","TX","75211")
 SET ^Pe(5)=$LB("JOHNSON","MIKE","3406-44-3344","5678","INK","AR","71933")
 SET ^Pe(6)=$LB("DOVER","BEND","3434-24-3344","91234","INKWELL","AR","71955")
 SET ^Pe(7)=$LB("TEST","TESTER","2323-20-2232","2345","LOS ANGELES","CA","95111")
 SET NUM="" DO {
         SET NUM=$O(^Pe(NUM)) Q:NUM=""
         SET Data=^Pe(NUM)
         SET Ln=$Li(Data,1)
         SET Fn=$Li(Data,2)
         SET SSN=$Li(Data,3)
         SET MRN=$Li(Data,4)
         SET CITY=$Li(Data,5)
         SET STATE=$Li(Data,6)
         SET ZIP=$Li(Data,7)
         SET ^PeIndex("Name",Ln_","_Fn,NUM)=""
         SET ^PeIndex("Ln",Ln,NUM)=""
         SET ^PeIndex("SSN",SSN,NUM)=NUM
         SET ^PeIndex("MRN",MRN,NUM)=NUM
         SET ^PeIndex("City",CITY,NUM)=""
         SET ^PeIndex("State",STATE,NUM)=""
         SET ^PeIndex("Zip",ZIP,NUM)=""
 }       While NUM'=""
 W !," ALL DONE - COMPLETE!!"
 Q
GETPAT  K PAT S PAT="100843^100844^100845^8^237^100840"
        W !,"NAME^SSN^DOB^AGE^GENDER"
        F I=1:1:6 S IEN=$P(PAT,"^",I) D ;W !,IEN ;Q:$P(IEN,"^",I)=""  W !,$G(IEN)
         .S PATNAME=$P(^DPT(IEN,0),"^",1),SSN=$P(^DPT(IEN,0),"^",9),DOB=$P(^DPT(IEN,0),"^",3),GENDER=$P(^DPT(IEN,0),"^",2)
         .S AGE=$E(DT,1,3)-$E(DOB,1,3),U="^"
         .W !,PATNAME_U_SSN_U_DOB_U_AGE_U_GENDER
         .K PATNAME,SSN,DOB,GENDER,AGE
        K PAT,IEN
 Q
GETCLOZ ; GET CLOZAPINE PATIENTS
 D SETUP
 
BLDDEA ; BUILD A DEA# USING ALGORITHM
    D SETUP
    S P1="", P2="", P3="", P4="", P5="",P6="",CS="", LN=""
    S DE1="",DE2="",DE21="0",DE3="",D4="",DE5="", N=""
    W !!, "PLEASE ANSWER QUESTIONS IN ORDER TO BUILD A DEA#"
    READ !,"ENTER A 6 DIGIT NUMBER := ",N
    READ !, "ENTER THE FIRST LETTER OF YOUR LAST NAME := ",I
    SET LN=$L(N)
    IF LN'=6 {
             W !, "ENTRY ERROR, YOU DID NOT ENTER 6 DIGITS AS INSTRUCTED"
             Q
    }
     SET P1=$E(N,1),P2=$E(N,2),P3=$E(N,3),P4=$E(N,4),P5=$E(N,5),P6=$E(N,6)
    
    WRITE !, N, A1="C", I, P1, P2, P3, P4, P5,P6, "DE21 = ",DE21
    SET DE1=(P1+P3+P5)
    SET DE2=(P2+P4+P6)
    SET DE21=(DE2*2)
    SET DE3=(DE1+DE21)
    SET DE4=$L(DE3)
    SET DE5=$E(DE3,DE4)
    SET DEA=(A1_I_N_DE5)
    W !, "de1 = " ,DE1,"  de2 = " , DE2, "  de21 = " ,DE21, "  de3 = " ,DE3, "  de4 = ",DE4, "  de5 = ",DE5
    W !, "A1 = ",A1, " I= ",I, " N = ",N, " DE5 = ",DE5
    W !, "dea = ",DEA
    Q
