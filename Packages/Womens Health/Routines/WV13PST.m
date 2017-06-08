WV13PST ;HIOFO/FT-WV*1*13 POST INSTALLATION ROUTINE ;12/27/00  09:40
 ;;1.0;WOMEN'S HEALTH;**13**;Sep 30, 1998
EN1 ; Compare FILE 790 record number to the .01 field value. If not the
 ; same then set the .01 value equal to the record number. The .01 value
 ; must match the record number. Also, fix the B cross-reference.
 N WVDFN,WVIFN
 S WVIFN=0
 F  S WVIFN=$O(^WV(790,WVIFN)) Q:'WVIFN  D
 .S WVDFN=$P(^WV(790,WVIFN,0),U,1)
 .I WVIFN=WVDFN Q
 .Q:WVIFN=""
 .Q:WVDFN=""
 .K ^WV(790,"B",WVDFN,WVIFN)
 .S ^WV(790,"B",WVIFN,WVIFN)=""
 .S $P(^WV(790,WVIFN,0),U,1)=WVIFN
 .Q
 Q
