%GRTINI ;27-Feb-84;Initializes vbls for %GRT routines; ISM ; 09 JAN 85  1:05 PM
 S RET=$C(13),ACK="(%)ACK(%)",NAK="(%)NAK(%)",SYNC="(%)SYNC(%)",ETX="(%)ETX(%)",EOT="(%)EOT(%)",MAX=500,T1=10,T2=10,TRIES=16,ME=0,ENQ="(%)ENQ(%)"
 S BUFLUSH="F BB=1:1 R *BF:0 Q:'$T"
 ;Flushes buffer
 S (B,ERROR)=0,NOLINK="Unable to set up link.",NOSYNC="Communcations got out of sync or lost link.",GOOD="Successful Transfer.",WX="U ME W X,! U DEV"
 ;MAX = # tries for sync, DEV = port device, ME = My device,
 ;WX = Display it, T1,T2 = Timeouts, TRIES = # Transmissons tries.
