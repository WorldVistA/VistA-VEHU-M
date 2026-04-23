XOBV8P ;RTW/HDSO - VistaLink Post-Init ; 06/11/2025  13:00
 ;;1.6;VistALink;**8**;May 08, 2009;Build 17
 ;
 ;
PARMS ; -- add parameter entry XOBV*1.6*8
 NEW DIE,DA,DR
 ;
 ;
 ; -- set J2EECONNECTION TIMEOUT parameter
 DO
 . SET DA=1
 . SET DR=".04////86400"
 . SET DIE="^XOB(18.01,"
 . DO ^DIE
 Q
