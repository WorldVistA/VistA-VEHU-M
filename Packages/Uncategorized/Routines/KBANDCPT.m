KBANDCPT ; VEN/SMH,VW/SO - Remove CPT codes except encounter codes. ; 10/11/12 12:51pm
 ;;not part of any package
 ;
 ; Purge data from CPT except for outpatient encounters
 N KBANI S KBANI=0
 N DIK S DIK="^ICPT("
 F  S KBANI=$O(^ICPT(KBANI)) Q:'KBANI  D
 . Q:((KBANI>99200)&(KBANI<99430))
 . W KBANI," "
 . N DA S DA=KBANI D ^DIK
 ;
 ; CPT CATEGORY - total deletion
 N % S %=^DIC(81.1,0)
 S $P(%,"^",3,4)=""
 K ^DIC(81.1)
 S ^DIC(81.1,0)=%
 ;
 ; CPT MODIFIER - total deletion
 N % S %=^DIC(81.3,0)
 S $P(%,"^",3,4)=""
 K ^DIC(81.3)
 S ^DIC(81.3,0)=%
 ;
ZZLEXP  ;PURGE CPT DATA FROM FILE #757.02 ; VW/SO
 N ASRC
 F ASRC="CPC","CPT" D
 . N IEN S IEN=0
 . F  S IEN=$O(^LEX(757.02,"ASRC",ASRC,IEN)) Q:'IEN  D
 .. ;SCREEN LOGIC GOES HERE FOR THOSE CPT CODES YOU WANT TO KEEP
 .. W "."
 .. N FDA
 .. S FDA(757.02,IEN_",",1)=""
 .. S FDA(757.02,IEN_",",2)=""
 .. N DIERR
 .. D FILE^DIE("","FDA")
 .. I $D(DIERR) S $EC=",U1,"
 QUIT
