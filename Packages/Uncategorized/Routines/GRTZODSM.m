%GRTZO ;Simulate $ZO with Standard MUMPS for GRT routines ; 08 FEB 85  11:01 AM
 ;returns one node at a time does not return pointer nodes
 ;Inputs
 ;BEG = beginning level (1 for now)
 ;LVL = current level (starts at one for now)
 ;Example setup line (NM="^Globalname")
 ; X is my calling routine's local variable, if needed
 ;
 ;Q:'$D(@NM)  S OS=NM_"(",N=NM_"("""")",S X=NM,DUN=$O(@N) D STR^%GRTZO S (BEG,LVL)=1,(OS(LVL))=OS_DUN,(UP,DUN)=0 I '($D(@NM)#10) D ^%GRTZO S X=ZO
 ;
 ;Returns
 ;ZO as next node
 ;
 S ZO="" F I=1:1 Q:ZO]""!(LVL<BEG)  D:'UP WRIT S DUN=$O(@(OS(LVL)_")")) D STR,@$S($D(@(OS(LVL)_")"))>1&'UP:"DOWN",1:"OVER") S UP=0 I DUN="" S LVL=LVL-1,UP=1
 Q
DOWN S LVL=LVL+1 S DUN=$O(@(OS(LVL-1)_","""")")) D STR S OS(LVL)=OS(LVL-1)_","_DUN,DUN=0 Q
OVER Q:DUN=""  S LPP=$P(OS(LVL),"(",2,255),Q=0
OVER1 S LP=$P(LPP,",",$L(LPP,",")-Q,255) I '($L(LP,"""")#2) S Q=Q+1 G OVER1
 S OS(LVL)=$E(OS(LVL),1,$L(OS(LVL))-$L(LP))_DUN Q
WRIT S:$D(@(OS(LVL)_")"))#10 ZO=OS(LVL)_")" Q
STR S:DUN'=+DUN&(DUN]"") DUN=""""_DUN_"""" Q
