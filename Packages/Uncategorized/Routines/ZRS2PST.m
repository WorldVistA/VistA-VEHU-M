ZRS2PST ; RWS/WASH POSTINIT ROUTINE TO COMPILE LOG TEMPLATE MAPS ;6/28/91  08:59
V ;;
 W !,"Now beginning the Post Init sequence. "
 S DIK="^PRCD(420.4,",DA=92927 D ^DIK
 W !
 D INIT^PRCFACX5
 W !,"Post Init is complete. " 
 QUIT
