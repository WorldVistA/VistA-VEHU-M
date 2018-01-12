DENTVGUI ;DSS/AJ - DENTAL GUI Version Checks;10/31/2013
 ;;1.2;DENTAL;**66**;Aug 10, 2001;Build 36
 ;Copyright 1995-2014, Document Storage Systems, Inc., All Rights Reserved
 ;
 Q
VERSION(RET) ;RPC: DENTVGUI VERSION GET
 ; This RPC returns the current required GUI Version and KID Build
 ;
 ; RET = GUI Version ^ KID Build
 ;
 S RET=$P($T(LIST+1),";",3)
 Q
LIST ;A History of GUI/KID Versions
 ;;6.6.0.47^DENT*1.2*66
 Q
