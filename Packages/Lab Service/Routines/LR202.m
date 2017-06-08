LR202 ;slc/dcm - Pre-install check for patch LR*5.2*202
 ;;5.2;LAB SERVICE;**202**;Sep 27, 1994
 Q:$$PATCH^XPDUTL("LR*5.2*153")
 S XPDQUIT("LR*5.2*209")=1
 Q
