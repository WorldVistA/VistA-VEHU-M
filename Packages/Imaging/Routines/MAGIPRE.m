MAGIPRE ;WASHISC/SRR-CLEAN OUT SOME DD'S AND DATA [ 18-AUG-2000 14:47:56 ]
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
EN ;DELETE NECESSARY DD'S AND DATA
 K ^MAG(2006.1,"AWIN") ;REMOVE unused XREF
 K DQ
 D IM,OT,PF,SP,IU,NT,WK,END,PRE^MAGQST,EN^MAGGDEV Q
 W @IOF,!!!?10,"************ CLEAN-UP ************",!!
OT S DIU(0)="D",DIU="^MAG(2005.02," D EN^DIU2,G G EXIT
PF S DIU(0)="D",DIU="^MAG(2005.03," D EN^DIU2,G G EXIT
IU S DIU(0)="D",DIU="^MAG(2006.19," D EN^DIU2,G G EXIT
IM S DIU="^MAG(2005,",DIU(0)="" D EN^DIU2,W G EXIT
NT S DIU="^MAG(2005.2,",DIU(0)="" D EN^DIU2,W G EXIT
SP S DIU="^MAG(2006.1,",DIU(0)="" D EN^DIU2,W G EXIT
WK S DIU="^MAG(2006.8,",DIU(0)="" D EN^DIU2,W G EXIT
END W !!?10,"DONE CLEANUP!",!
ND Q
G W !,DIU_" and DD is deleted"
 Q
W W !,"DD("_$P(DIU,"(",2)_") is deleted"
 Q
EXIT ;
 K DIU Q
SY ;Special System files
 F I="SP","WK","NT","IU" D @I
 Q
