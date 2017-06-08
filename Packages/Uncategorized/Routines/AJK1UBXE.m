AJK1UBXE ;580/MRL - Collections, Environment Check; 21-Jan-99
 ;;2.0;Collections;**1**
 ;
 ;Checks to make sure that you're up-to-date with versions prior
 ;to permitting installation of this KIDS release (patch or
 ;otherwise).  Can't use the KIDS file to check for existance of
 ;prior install because it seems to be dependent on an entry in
 ;the patch file and this stuff doesn't update patch file.
 ;
 I '$D(^DIZ(580950.1,1,0)) S XPDQUIT=2 Q
