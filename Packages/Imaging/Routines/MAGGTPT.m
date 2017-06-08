MAGGTPT ;WIRMFO/GEK -Delphi-Broker :Patient API [ 18-AUG-2000 14:47:56 ]
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
INTINF(RY,DFN) ;RPC Call to Return internal patient info.
 ;Not used in Version 2.5, Kept for backward compatibility
 N Y,MAGGX,MAGGE,MAGDFN,Z
 D GETS^DIQ(2,+DFN,".01;.02;.03;.09;391;1901;.301","I","MAGGX","MAGGE")
 I $D(MAGGE("DIERR",1)) S RY="0^"_MAGGE("DIERR",1,"TEXT",1) Q
 S MAGDFN=+DFN_",",Z=""
 F X=.01,.02,.03,.09,391,1901,.301 D  ;
 . S Z=Z_MAGGX(2,MAGDFN,X,"I")_"^"
 S RY=$E(Z,1,$L(Z)-1)
 Q
