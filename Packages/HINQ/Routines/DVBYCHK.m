DVBYCHK ;ALB/JLU;Mini init to update DVBHINQ UPDATE;4/21/92
 ;;V4.0;HINQ;**2**;03/25/92 
 ;
EN I $S('$D(^DD(395,0,"VR")):1,^("VR")'>3.2:1,1:0) W *7,*7,!,"Your version of HINQ is not greater than 3.2, this mini init is not needed.",!,"Please be sure to run this mini init after you have installed HINQ V4.0." Q
 D ^DVBYINIT
 Q
