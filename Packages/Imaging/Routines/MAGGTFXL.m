MAGGTFXL ;WIRMFO/GEK Routine to fix lab Stain,Obj fields in Image file. [ 18-AUG-2000 14:47:56 ]
 ;;2.5T11;MAG;;18-Aug-2000
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a Class II medical device.  As such, it may not be changed    |
 ;; | in any way.  Modifications to this software may result in an  |
 ;; | adulterated medical device under 21CFR820, the use of which   |
 ;; | is considered to be a violation of US Federal Statutes.       |
 ;; +---------------------------------------------------------------+
 ;;
 ;Q
DESC W !,"You have to run GO^MAGGTFXL from programmer mode"
 W !," It modifies the image file data, in fields STAIN, and"
 W !," MICROSCOPIC OBJECTIVE, CHANGING THE DATA from pointers"
 W !," to free text.   100,000 entries takes about 5 minutes"
 W !," You can run it anytime."
 W !," <any key to continue>" R X:30
 Q
GO S U="^"
 W !,"THIS ROUTINE WILL: "
 W !," DISPLAY THE NODES NEEDING FIXED     IF 'TESTING' IS SELECTED"
 W !," MAKE THE CHANGE TO THE IMAGE FILE   IF 'YES'     IS SELECTED"
 W !," OR QUIT AND MAKE NO CHANGES         IF 'NO'      IS SELECTED"
 S TESTING=0
 W !,"This will loop backwards through the Image file and "
 W !," change Lab Histological Stain pointers and "
 W !," Lab Microscopic Objective pointers to FREE TEXT "
 W !," "
 W !," OK to continue : Yes/No/Test   Y/N/T   //N "
 R ANS:30 I "Nn"[ANS W !," QUITTING, NOTHING CHANGED" Q
 I "Tt"[ANS S TESTING=1 W !,"The Image file nodes needing changed will"
 I  W !," ONLY BE DISPLAYED.  NO UPDATING WILL OCCUR " H 4
 ;N MAGS,MAGO
 W !," Starting " D ^%T
 S I=0,CT=0,TOTAL=$P(^MAG(2005,0),U,4)
 F  S I=$O(^MAG(2005.4,I)) Q:'I  S MAGS(I)=$P(^MAG(2005.4,I,0),U,1)
 S I=0
 F  S I=$O(^MAG(2005.41,I)) Q:'I  S MAGO(I)=$P(^MAG(2005.41,I,0),U,1)
 S I=9999999999,DONE=0
 F  S I=$O(^MAG(2005,I),-1) Q:'I  D  Q:DONE
 . S CT=CT+1 IF '(CT#10000) W !,CT," of ",TOTAL,"  " D ^%T
 . I '(CT#1000) W "."
 . Q:'$D(^MAG(2005,I,"PATH"))
 . S Z=^MAG(2005,I,"PATH")
 . S CHANGE=0
 . I $P(Z,U,4) D
 . . S CHANGE=1,Z0=Z
 . . S $P(Z,U,4)=$G(MAGS($P(Z,U,4)))
 . . I $P(Z,U,5) S $P(Z,U,5)=$G(MAGO($P(Z,U,5)))
 . . I 'TESTING S ^MAG(2005,I,"PATH")=Z
 . . I CHANGE W ! W:TESTING "TEST " W:CHANGE ",Old ",?15,Z0,!,"New ",?15,Z
 W !,"DONE."
 Q
