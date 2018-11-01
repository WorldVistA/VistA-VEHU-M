A5AOSIG ; SLC/KCM -- set up accounts with different hashing/encrypting
 ;
MAIN ;
 S U="^"
 D DOC2CLR ; documents to clear text
 D RAD2CLR ; imaging reports to clear text
 D REPLACE ; replace hashing/encrypting
 D DOC2ENC ; documents to encrypted
 D RAD2ENC ; imaging reports to encrypted
 D VEHUAV  ; set new hashes for VeHU AV
 W !,"Be sure to re-enter your own access/verify/e-sig."
 W !,"See STUFF entry point"
 Q
REPLACE ; replace the hashing algorithm with a different one
 ; GT.M version would be something like:  X "ZSYSTEM cp A5a0SSH.m XUSHSH.m"
 ; You would need full path, however.
 X "ZL A5AOSSH ZS XUSHSH"
 X "ZL A5AOSSHP ZS XUSHSHP"
 Q
DOC2CLR ; convert all names/titles to clear text
 N DA,NODE,PIECE
 S DA=0 F  S DA=$O(^TIU(8925,DA)) Q:'DA  D
 . S NODE=15 F PIECE=3,4,9,10 D CLRTEXT(DA,NODE,PIECE)
 . S NODE=16 F PIECE=4,5 D CLRTEXT(DA,NODE,PIECE)
 Q
DOC2ENC ; convert all names/titles to current encryption
 N DA,NODE,PIECE
 S DA=0 F  S DA=$O(^TIU(8925,DA)) Q:'DA  D
 . S NODE=15 F PIECE=3,4,9,10 D ENCRYPT(DA,NODE,PIECE)
 . S NODE=16 F PIECE=4,5 D ENCRYPT(DA,NODE,PIECE)
 Q
RAD2CLR ; convert radiology signatures to clear text
 N DA,X,X0,X1,X2,VER,ESIG
 S DA=0 F  S DA=$O(^RARPT(DA)) Q:'DA  D
 . S X0=$G(^RARPT(DA,0)),VER=$P(X0,"^",9),ESIG=$P(X0,"^",10)
 . Q:'$L(ESIG)  Q:'$L(VER)
 . S X=ESIG,X1=VER,X2=DA D DE^XUSHSHP
 . S $P(^RARPT(DA,0),"^",10)=X
 Q
RAD2ENC ; convert radiology signatures to current encryption
 N DA,X,X0,X1,X2,VER,ESIG
 S DA=0 F  S DA=$O(^RARPT(DA)) Q:'DA  D
 . S X0=$G(^RARPT(DA,0)),VER=$P(X0,"^",9),ESIG=$P(X0,"^",10)
 . Q:'$L(ESIG)  Q:'$L(VER)
 . S X=ESIG,X1=VER,X2=DA D EN^XUSHSHP
 . S $P(^RARPT(DA,0),"^",10)=X
 Q
SHOWALL ; show all the encrypted values
 N DA,NODE,PIECE
 S DA=0 F  S DA=$O(^TIU(8925,DA)) Q:'DA  D
 . S NODE=15 F PIECE=3,4,9,10 D SHOWONE(DA,NODE,PIECE)
 . S NODE=16 F PIECE=4,5 D SHOWONE(DA,NODE,PIECE)
 Q
 ;
CLRTEXT(DA,NODE,PIECE) ; set all fields to clear text for a document
 N X
 S X=$P($G(^TIU(8925,DA,NODE)),"^",PIECE) Q:'$L(X)
 S X=$$DECRYPT^TIULC1(X,1,$$CHKSUM^TIULC("^TIU(8925,"_+DA_",""TEXT"")"))
 S $P(^TIU(8925,DA,NODE),"^",PIECE)=X
 Q
ENCRYPT(DA,NODE,PIECE) ; set all fields to encrypted text for a document
 N X
 S X=$P($G(^TIU(8925,DA,NODE)),"^",PIECE) Q:'$L(X)
 S X=$$ENCRYPT^TIULC1(X,1,$$CHKSUM^TIULC("^TIU(8925,"_+DA_",""TEXT"")"))
 S $P(^TIU(8925,DA,NODE),"^",PIECE)=X
 Q
SHOWONE(DA,NODE,PIECE) ; set all fields to clear text for a document
 N X
 S X=$P($G(^TIU(8925,DA,NODE)),"^",PIECE) Q:'$L(X)
 W !,"DA:",DA," NODE:",NODE," PIECE:",PIECE," -- ",X
 Q
 ;
VEHUAV ; set VeHU access/verify/e-sig with new hash
 N I,INITIAL,DA,X0
 F I=10:1:99 S INITIAL="V"_I,DA=$O(^VA(200,"C",INITIAL,0)) Q:'DA  D
 . S X0=^VA(200,DA,0)
 . I $E(X0,1,4)'="VEHU" Q
 . W !,$P(X0,"^"),"   --------------------------",!
 . D AST^XUS2($$EN^XUSHSH(I_"VEHU"))
 . D VST^XUS2($$EN^XUSHSH("VEHU"_I),1)
 . D EST("VEHU"_I,DA)
 Q
EST(CODE,DA) ; store electronic signature hash
 N FDA,ERR,IEN,X
 S IEN=DA_",",X=CODE
 D HASH^XUSHSHP ; convert X to hash
 S FDA(200,IEN,20.4)=X D FILE^DIE("","FDA","ERR")
 I $D(ERR) W !,"E/S store error"
 Q
 ;
STUFF(DA,ACCESS,VERIFY,ESIG) ; Stuff access, verify, e-sig codes
 ; uses current encryption
 Q:'DA  S U="^"
 D AST^XUS2($$EN^XUSHSH(ACCESS))
 D VST^XUS2($$EN^XUSHSH(VERIFY),1)
 Q:'$L($G(ESIG))
 D EST(ESIG,DA)
 Q
 ;
 ;
VEHUAV2 ; - set VeHU access/verify/e-sig with new hash
 ; 1/29/15 AJC getting stuck looping on vehu 6. changing I to INT
 N INT,INITIAL,DA,X0
 F INT=10:1:99 S INITIAL="V"_INT,DA=$O(^VA(200,"C",INITIAL,0)) Q:'DA  D
 . S X0=^VA(200,DA,0)
 . I $E(X0,1,4)'="VEHU" Q
 . W !,$P(X0,"^"),"   --------------------------",!
 . D AST^XUS2($$EN^XUSHSH(INT_"VEHU"))
 . D VST^XUS2($$EN^XUSHSH("VEHU"_INT),1)
 . D EST("VEHU"_INT,DA)
 Q
 ;
 ;
NURSEAV ; set VeHU style access/verify/e-sig with new hash for nurses
 ; 1/29/15 ajc
 N INT,INITIAL,DA,X0
 F INT=1:1:99 S INITIAL="RN"_INT,DA=$O(^VA(200,"C",INITIAL,0)) Q:'DA  D
 . S X0=^VA(200,DA,0)
 . I $E(X0,1,5)'="NURSE" Q
 . W !,$P(X0,"^"),"   --------------------------",!
 . D AST^XUS2($$EN^XUSHSH(INT_"NURSE"))
 . D VST^XUS2($$EN^XUSHSH("NURSE"_INT),1)
 . D EST("NURSE"_INT,DA)
 Q
 ;
 ;
PROVAV  ; set VeHU style access/verify/e-sig with new hash for providers
 ; 1/29/15 ajc
 N INT,INITIAL,DA,X0
 F INT=1:1:99 S INITIAL="P"_INT,DA=$O(^VA(200,"C",INITIAL,0)) Q:'DA  D
 . S X0=^VA(200,DA,0)
 . I $E(X0,1,8)'="PROVIDER" Q
 . W !,$P(X0,"^"),"   --------------------------",!
 . D AST^XUS2($$EN^XUSHSH(INT_"PROVIDER"))
 . D VST^XUS2($$EN^XUSHSH("PROVIDER"_INT),1)
 . D EST("PROVIDER"_INT,DA)
 Q
 ;
 ;
