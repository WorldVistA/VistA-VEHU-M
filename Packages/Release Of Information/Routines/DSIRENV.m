DSIRENV ;AMC/EWL - Document Storage Systems Inc - ROI Environment Check Routine ;04/14/2011 11:18
 ;;8.2;RELEASE OF INFORMATION - DSSI;;Nov 08, 2011;Build 25
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;10141 $$VERSION^XPDUTL
 ;10141 MES^XPDUTL
 ;
 ; Version checks
 N VER S VER=+$$VERSION^XPDUTL("DSIR")
 I (VER<8.1)&(VER'=0) S XPDQUIT=1 D 
 .D MES^XPDUTL("You must have installed ROI version 8.1 first!!!")
 .S XPDQUIT=1
 Q
