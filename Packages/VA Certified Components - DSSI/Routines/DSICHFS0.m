DSICHFS0 ;DSS/SGM - HOST FILE UTILITIES ;05/08/2007 15:20
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
INIT ; parse input params and initialize
 ; expects ARR(varname)=value or ARR=var1^var2^var3
 ; allowable varnames (O:optional; R:required)
 ;        |-------------  LINE LABELS  ----------------|
 ; Varname|CLOSE|DEL|DELALL|FTG|GET|LIST|OPEN|STRIP|VER|
 ; -------|-----|---|------|---|---|----|----|-----|---|
 ; CTRL   |     |   |      | O | O |    |    |  O  |   |
 ; DEL    |     |   |      | O | O |    |    |     |   |
 ; DSIDEL |     | R |      |   |   |    |    |     |   |
 ; FILE   |     |   |      | R | O |  O |  O |     | R |
 ; FUN    |     | O |      |   |   |    |    |     |   |
 ; HANDLE |  O  |   |      |   |   |    |  O |     |   |
 ; MODE   |     |   |      |   | O |    |  O |     |   |
 ; PATH   |     | O |   O  | O | O |  O |  O |     | O |
 ; RTN    |     |   |      |   | R |    |    |     |   |
 ; VPG    |     |   |      |   | O |    |  O |     |   |
 ; VRM    |     |   |      |   | O |    |  O |     |   |
 ;   CTRL - Boolean, if 1 strip ctrl chars from data, default=0
 ;    DEL - Default to 2
 ;            0: do not delete file created
 ;            1: delete file if transferred to global
 ;            2: delete file always
 ;   FILE - name of file to open or create.  If temp file is required
 ;          and FILE not passed then FILE will be generated
 ;    FUN - Boolean - if allowed & equal to 1 then TAG was called as
 ;          an extrinsic function, else it was called a DO (w/params)
 ; HANDLE - string to be used when opening and closing files if the
 ;          %ZISUTL utility is called
 ;   MODE - default value is W [W:write  R:read  A:append]
 ;   PATH - directory where file resides or is to be placed
 ;          default to $$PWD^%ZISH
 ;    RTN - required only for GET call.  Indirect argument of DO
 ;          command.  Entry invoked must have no user interactions
 ;    VPG - page length, default to 66
 ;    VRM - right margin, default to 80
 ;NOTE: If you wish the right margin or page length to be whatever
 ;  the device is opened with from the DEVICE file, then pass
 ;  VRM=-1 and/or VPG=-1
 ;
I ;;^CTRL^DEL^FILE^FUN^HANDLE^INC^MODE^PATH^REORDER^RTN^VPG^VRM^
 N I,X,Y,Z,STR,TMP
 S DSICMSG=0,STR=$P($T(I),";",3)
 I $G(RETREQ),$G(DSICHFS)="" D ERR^DSICHFS(4) Q
 I $G(ARR)'="" F I=1:1:$L(ARR,U) S X=$P(ARR,U,I),ARR(X)=$G(@X)
 S X="" F  S X=$O(ARR(X)) Q:X=""  S Y=X D
 .S:Y?.E1L.E Y=$$UP^XLFSTR(Y)
 .S:STR[(U_Y_U) TMP(Y)=ARR(X)
 .Q
 I "FTG;GET;"[TAG D I2("CTRL",1)
 I "FTG;GET;"[TAG D I2("DEL",,2)
 I "FTG;GET;LIST;OPEN;VER"[TAG S FILE=$$FILE^DSICHFS1
 I "GET;OPEN;"[TAG D I2("MODE",,"W")
 I "DEL;DELALL;FTG;GET;LIST;OPEN;VER"[TAG S PATH=$$PATH^DSICHFS1
 I "GET;"[TAG D I2("RTN")
 I "GET;OPEN;"[TAG D I2("VPG",,66)
 I "GET;OPEN;"[TAG D I2("VRM",,80)
 I "CLOSE;GET;OPEN;"[TAG S HANDLE=$$HANDLE^DSICHFS1
 I "DEL;"[TAG D I2("FUN",1)
 Q
 ;
I2(X,P,D) ;
 ; X - req - $name of local variable to be set
 ; P - opt - if +P then variable interpreted numerically
 ; D - opt - if $D(D), then D is default value
 S @(X_"=$G(TMP(X))")
 I +$G(P) S @(X_"=+"_X)
 I $D(D),@X="" S:D'=+D D=""""_D_"""" S @(X_"="_D)
 Q
 ;
Q ; if dsichfs* needs to flush routine buffer, come here
 Q
