RJTCHAR ;
 S D=0
 S ^UTILITY("RJT",$H,"F2")=F2,^UTILITY("RJT",$H,"DVBLEN")=DVBLEN
 ;F I=0:0 S D=$O(X(D)) Q:D=""  S ^UTILITY("RJT",$H,D)=X(D)
 F I=0:0 S D=$O(X(D)) Q:D=""  S ^UTILITY("RJT",$H,D+.1)=$E(X(D),1,100),^UTILITY("RJT",$H,D+.2)=$E(X(D),101,999)
 Q
 
