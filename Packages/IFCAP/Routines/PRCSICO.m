PRCSICO ;WISC/LEM-FIX C P ACTIVITY COMMENTS ;4/16/93  12:37 PM
V ;;4.0;IFCAP;;9/23/93
 ; This is a one-time routine to be run during IFCAP v.4.0 Post-Init.
 ; It will correct any format problems found in the Comments field
 ; of the Control Point Activity file (#410) which might have been
 ; created while splitting transactions under IFCAP 4.0 test
 ; versions 8 through 11.  Accordingly, only the Alpha and Beta
 ; test sites for v.4.0 T8 through T11 should run this routine.
 ; The entry numbers of any File 410 records which could not be
 ; repaired here will be logged into the global ^PRCSERR.
 ;
A S DIC="^PRC(411,",DIC(0)="X" F I=1:1:8 S PRCI=$T(Z+I),X=$P(PRCI,";",2),Y=-1 Q:X=""  D ^DIC Q:Y>0
 Q:Y<0
 S X="Hmmm, this looks like "_$P(PRCI,";",3)_" to me.  As I recall, you were a test site for IFCAP V4.0, so we may need to fix some of the COMMENTS fields in your CONTROL POINT ACTIVITY file.  Hold on . . . "
 D MSG^PRCFQ
EN S I=0 F  S I=$O(^PRCS(410,I)) Q:+I'=I  I $D(^PRCS(410,I,"CO")) D B
 S X="Comment checking and repair completed." D MSG^PRCFQ
 Q
 ;
B F J=1:1 Q:'$D(^PRCS(410,I,"CO",J,0))
 S H=$G(^PRCS(410,I,"CO",0)),J0=J-1
 I +$P(H,"^",3)=J0,+$P(H,"^",4)=J0,$O(^PRCS(410,I,"CO",J0))="" Q
 ;
 ; Any Comment that falls through to here needs a fix.
 ; First, close up the text to eliminate any skipped nodes:
 ;
 F  S J=$O(^PRCS(410,I,"CO",J)) Q:J=""!$D(^PRCSERR(I))  D C
 ;
 ; If all OK, reset line entry pointers in Comment header node:
 ;
 Q:$D(^PRCSERR(I))  S $P(^PRCS(410,I,"CO",0),"^",3,4)=J0_"^"_J0
 Q
 ;
C I '$D(^PRCS(410,I,"CO",J,0)) S ^PRCSERR(I)="" Q  ; Can't fix it here!
 S LN=^PRCS(410,I,"CO",J,0)
 K ^PRCS(410,I,"CO",J,0) S J0=J0+1,^PRCS(410,I,"CO",J0,0)=LN
 Q
Z ;List of stations needing to run this routine follows:
 ;452;Wichita
 ;460;Wilmington
 ;503;Altoona
 ;578;Hines
 ;581;Huntington
 ;590;Hampton
 ;614;Memphis
 ;673;Tampa
 ;;
