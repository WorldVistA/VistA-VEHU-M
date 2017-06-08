MAGGPRE1 ;WOIFO/LB - Imaging 2.5 Preinstall [ 14-NOV-2000 15:49:29 ]
 ;;3.0;IMAGING;;Mar 1, 2002
 ;; +---------------------------------------------------------------+
 ;; Property of the US Government.  No permission to copy or
 ;; redistribute this software is given. Use of this software
 ;; requires the user to execute a written test agreement with
 ;; the VistA Imaging Development Office of the Department of
 ;; Veterans Affairs, telephone (301) 734-0100.
 ;;
 ;; The Food and Drug Administration classifies this software as
 ;; a medical device.  As such, it may not be changed in any way.
 ;; Modifications of the software may result in an adulterated
 ;; medical device under 21CFR820 and may be a violation of US
 ;; Federal Statutes.
 ;; +---------------------------------------------------------------+
 ;
EN ;DELETE NECESSARY DD'S AND DATA
 K ^MAG(2006.1,"AWIN") ;REMOVE unused XREF
 K DQ
 D IM,OT,PF,SP,IU,I1,AQ,I2,I3,NT,WK,END,EXIT Q
 W @IOF,!!!?10,"************ CLEAN-UP ************",!!
 ; DIU(0)="D" - Delete data as well as DD
 ; DIU(0)="S" = Delete subfile DD
 ; The file 2005.02 now has subfile will need to take care of these
 ; 1st before removing DD.
OT N SUB S SUB="" F  S SUB=$O(^DD(2005.02,"SB",SUB)) Q:SUB'?1N.N.".".N  D
 . S DIU=SUB,DIU(0)="S" D EN^DIU2,G
 S DIU(0)="D",DIU="^MAG(2005.02," D EN^DIU2,G G EXIT
PF S DIU(0)="D",DIU="^MAG(2005.03," D EN^DIU2,G G EXIT
IU S DIU(0)="D",DIU="^MAG(2006.19," D EN^DIU2,G G EXIT
 ;File 2005.15 was IMAGE TELECONSULT - not used in 3.0
I1 S DIU(0)="D",DIU="2005.15" D EN^DIU2,G G EXIT
I2 S DIU(0)="D",DIU="2006" D EN^DIU2,G G EXIT
I3 S DIU(0)="D",DIU="^MAG(2006.71," D EN^DIU2,G G EXIT
IM S DIU="^MAG(2005,",DIU(0)="" D EN^DIU2,W G EXIT
NT S DIU="^MAG(2005.2,",DIU(0)="" D EN^DIU2,W G EXIT
SP S DIU="^MAG(2006.1,",DIU(0)="" D EN^DIU2,W G EXIT
WK S DIU="^MAG(2006.8,",DIU(0)="" D EN^DIU2,W G EXIT
 ;File 2006 was Message of the Day and had subfile 2006.04.
 ;For 3.0 file number 2006.04 is no longer a subfile but is now Acquisition Device. 
AQ N MAGRY,SNDX D FILE^DID(2006.04,"","NAME","MAGRY") Q:'$D(MAGRY("NAME"))
 I MAGRY("NAME")="ACQUISITION DEVICE" Q
 S SNDX="" S SNDX=$O(^DD(2006,"SB",SNDX)) Q:SNDX'?1N.N.".".N  D
 . S DIU=SNDX,DIU(0)="S" D EN^DIU2,G G EXIT
END W !!?10,"DONE CLEANUP!",!
ND Q
G W !,DIU_" and DD is deleted"
 Q
W W !,"DD("_$P(DIU,"(",2)_") is deleted"
 Q
EXIT ;
 K DIU,MAGRY Q
SY ;Special System files
 F I="SP","WK","NT","IU" D @I
 Q
POST ;Setup the data dictionary security.
 ; set security using FM calls
 N MAGFILE,MAGSEC
 S MAGSEC="" F I="DD","RD","WR","DEL","LAYGO" S MAGSEC(I)="@"
 F MAGFILE=2005,2005.02,2005.03,2005.1,2005.15,2005.2,2005.4,2005.41 D
 . D DDUPDT(MAGFILE,.MAGSEC)
 F MAGFILE=2005.81,2006.03,2006.031,2006.032,2006.033,2006.1 D
 . D DDUPDT(MAGFILE,.MAGSEC)
 F MAGFILE=2006.17,2006.18,2006.19,2006.5,2006.575,2006.592 D
 . D DDUPDT(MAGFILE,.MAGSEC)
 F MAGFILE=2006.599,2006.79,2006.8,2006.81,2006.82,2006.95 D
 . D DDUPDT(MAGFILE,.MAGSEC)
 Q
DDUPDT(MAGFL,MAGDDS) ;set the code using FM DB call
 Q:'MAGFL 
 Q:MAGFL>2006.99999!(MAGFL<2005)  ;not an Imaging file.
 Q:'$D(MAGDDS)
 I $D(MAGDDS)'=11 Q  ;Not an array
 D FILESEC^DDMOD(MAGFL,.MAGDDS)
 Q
