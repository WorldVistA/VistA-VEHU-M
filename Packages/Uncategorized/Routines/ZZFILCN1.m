ZZFILCNT ;2/19/88;NP-ISC1;count the B x-ref for each file between two numbers and match against FM number of entries, print out results
 S U="^" W !!,"Interactively re-do x-ref on discrepant files" S %=2 D YN^%DICN S ANS=$S(%=1:%,1:0)
 R !!,"Enter beginning file number --> ",BEG:60 G:BEG=""!(BEG["^") EXIT
 R !!,"Enter ending file number --> ",END:60 G:END=""!(END["^") EXIT
 S BEG=$S(BEG<6:6,1:BEG),END=$S(END>900:900,1:END)
 S X=BEG F I=1:1 S X=$O(^DIC(X)) Q:+X>END  S FN=X,FIL=^DIC(X,0,"GL") I $D(@(FIL_"""B"")")) D COUNT D:CNT KILXREF
EXIT K FN,FIL Q
COUNT S (CN,K)="" F J=1:1 S K=$O(@(FIL_"""B"","_"K)")) Q:K=""  S CN=CN+1
 I $P(@(FIL_"0)"),U,4)'=CN W !,$P(^(0),U),?25,"X-REF = ",CN,?40,"FM = ",$P(^(0),U,4)
 Q
KILXREF I $D(^DD(X,.01,1,"B",3)) W !,*7,"B x-ref is protected, cannot re-index!!" H 1 Q
 W !!,"X-ref is ",FIL,"""B"")  Are you sure you want to kill it" S %=1 D YN^%DICN Q:%'=1
 K @(FIL_"""B"")" S DIK=FIL
