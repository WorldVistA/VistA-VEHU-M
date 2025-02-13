PXRMISF ;SLC/PKR - Index size estimating scale factor routines. ;09/09/2020
 ;;2.0;CLINICAL REMINDERS;**17,42**;Feb 04, 2005;Build 245
 ;
 ;===============================================================
ERRORMSG(SF) ;Send an error message indicating the estimate could not
 ;be made.
 N FROM,TO,VERSION,XMSUB
 S VERSION=$P(SF,U,2)
 S ^TMP("PXRMXMZ",$J,1,0)="Size Estimate for ^PXRMINDX cannot be made!"
 S ^TMP("PXRMXMZ",$J,2,0)=VERSION_" is an unknown system."
 S XMSUB="Size estimate for index global cannot be made"
 S FROM=$$GET1^DIQ(200,DUZ,.01)
 S TO(DUZ)=""
 D SEND^PXRMMSG("PXRMXMZ",XMSUB,.TO,FROM)
 S ZTREQ="@"
 Q
 ;
 ;===============================================================
LSF(SF) ;Load the blocks/index entry scale factors.
 N VERSION
 N SFC,SFD
 ;Cache scale factors
 S SFC(45)=0.034578654
 S SFC(52)=0.044820784
 S SFC(55)=0.047974217
 S SFC(63)=0.075656684
 S SFC(70)=0.053003195
 S SFC(100)=0.046423473
 S SFC(120.5)=0.01879364
 S SFC(601.2)=0.04392942
 S SFC(9000011)=0.023941427
 S SFC(9000010.07)=0.022569777
 S SFC(9000010.11)=0.023919113
 S SFC(9000010.12)=0.022938475
 S SFC(9000010.13)=0.02297879
 S SFC(9000010.16)=0.023290489
 S SFC(9000010.18)=0.022636608
 S SFC(9000010.23)=0.024028924
 ;DSM scale factors
 S SFD(45)=0.099921811
 S SFD(52)=0.138842661
 S SFD(55)=0.138609592
 S SFD(63)=0.163250688
 S SFD(70)=0.136531655
 S SFD(100)=0.136755671
 S SFD(120.5)=0.063012241
 S SFD(601.2)=0.111356128
 S SFD(9000011)=0.07777772
 S SFD(9000010.07)=0.022441328
 S SFD(9000010.11)=0.077488311
 S SFD(9000010.12)=0.069942116
 S SFD(9000010.13)=0.079978059
 S SFD(9000010.16)=0.080224754
 S SFD(9000010.18)=0.07300721
 S SFD(9000010.23)=0.082573858
 S VERSION=$$VERSION^%ZOSV(1)
 S VERSION=$$UP^XLFSTR(VERSION)
 I (VERSION["IRIS")!(VERSION["CACHE") M SF=SFC S VERSION="",SF=1
 I VERSION["DSM" M SF=SFD S VERSION="",SF=1
 I VERSION'="" D
 . W !,VERSION," is an unknown system cannot make size estimate!"
 . S SF=-1_U_VERSION
 Q
 ;
