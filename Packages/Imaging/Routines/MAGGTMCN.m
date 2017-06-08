MAGGTMCN ;WIRMFO/GEK RPC Calls for Imaging/Medicine procedures [ 18-AUG-2000 14:47:56 ]
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
 Q
NEW(MAGRY,DATA) ;RPC call to Create NEW Procedure stub 
 ;       for a medicine procedure 
 ;
 ; DATA = DATETIME^PSIEN^DFN  ; same as old call
 S $P(DATA,"^",4)="^1" ; the 1 means we want a new procedure stub
 K MAGARR ; we are not passing any images.
 D FILE^MAGGTMC1(.MAGRY,DATA,.MAGARR)
 Q
