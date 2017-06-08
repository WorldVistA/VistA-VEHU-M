GMN4POST ;ISC-SLC/MJC;POST INIT FOR SITE PARAM PATCH;4-11-95 11:38am
 ;;2.5;Progress Notes;**37**;Jan 08, 1993
 ;turns on location required parameter
 ;
 W $C(7)
 W !!,"Important new features have been added to the [GMRPNMGR] menu..."
 H 1
 ;
 W !!,"Please let the Progress Notes ADPAC know this patch has been"
 W !,"installed and have them review the documentation provided in this"
 W " patch."
 H 1
 ;
 W !!,"I will now turn the 'REQUIRE LOCATION' parameter on."
 H 1
 ;
 S ^GMR(121.99,1,2)=1
 ;
 W !!,$C(7),"DONE."
 Q
