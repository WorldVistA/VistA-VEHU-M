YTPAI ;ASF/ALB- PAI TEST ;7/14/00  10:26
 ;;5.01;MENTAL HEALTH;**10,66,221,238**;Dec 30, 1994;Build 25
 ;
 ;Reference to $$SQRT^XLFMTH supported by IA #10105
 ;
 S YSLFT=0,YSNOITEM="DONE^YTPAI"
MAIN ;
 S (R,S)="^",YSMX=4
 D RD
 I $L(X,"X")>18 D DTA^YTREPT W !!!!,"PAI: Too many missing items to score" D:IOST?1"C".E SCR^YTREPT G OUT
 D SCOR,STND
 D ^YTPAI1 ;profile
 G DONE:YSLFT D:IOST?1"C-".E SCR^YTREPT
 D SUBS^YTPAI1
 G DONE:YSLFT D:IOST?1"C-".E SCR^YTREPT
 D ADDIT
 D FIT
 G DONE:YSLFT D:IOST?1"C-".E SCR^YTREPT
 D CRIT ;critical items
 G DONE:YSLFT D:IOST?1"C-".E SCR^YTREPT
OUT D DTA^YTREPT,IR^YTPAI1
DONE K S,R,A,YSXBAR,YSYBAR,YSXSD,YSYSD Q
RD S X="" Q
SCOR ;
 ;
FS ;full scales
 ;
ICNR ;score ICN
 S YSICN=0
 S X=""
 Q
A ;icn absolutes
 Q
KK S YSNUMX=0
 Q
STND ;stanard T scores
 Q
ADDIT ;additional indexes
XBAR ;
 Q
FIT ;coeff of fit
 Q
FITW ;
 Q
FIT1 ;
 Q
FITLOOP ;get individual items
 Q
CRIT ;
 Q
CRITW ; write critical items
 Q
