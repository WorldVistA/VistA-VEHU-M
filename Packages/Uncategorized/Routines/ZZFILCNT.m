ZZFILCNT ;2/19/88;NP-ISC1;count the B x-ref for each file between two numbers and match against FM number of entries, print out results
 S U="^"
 R !!,"Enter beginning file number --> ",BEG:60 G:BEG=""!(BEG["^") EXIT
 R !!,"Enter ending file number --> ",END:60 G:END=""!(END["^") EXIT
 S BEG=$S(BEG<6:5.99,1:BEG-.01),END=$S(END>999999:999999,1:END)
 S X=BEG F I=1:1 S X=$O(^DIC(X)) Q:+X>END  S FN=X,FIL=^DIC(X,0,"GL") I $D(@(FIL_"""B"")")) W !,FIL D COUNT
EXIT K FN,FIL W !!,"DONE!" Q
COUNT S (CN,K)="" F J=1:1 S K=$O(@(FIL_"""B"","_"K)")) Q:K=""  S DA=$O(@(FIL_"""B"","_"K,0)")) D CHKDATA
 I CN'=$P(@(FIL_"0)"),U,4) W !,"#",FN,?10,$P(@(FIL_"0)"),U),?30,"B x-ref = ",CN,?45,"Descriptor = ",$P(@(FIL_"0)"),U,4)
 Q
CHKDATA I $D(@(FIL_"DA,0)"))#2 S CN=CN+1 Q
 K @(FIL_"""B"",K)") W !,?5,FIL,"""B""",K,")" Q
