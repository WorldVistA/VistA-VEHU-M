KBANDCPT ; VEN/SMH,VW/SO - Remove CPT codes except encounter codes; rm GCNSEQNO ; 1/11/18 11:38am
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
 .. I '$G(^LEX(757.02,IEN,0)) QUIT
 .. N CODE S CODE=$P(^LEX(757.02,IEN,0),U,2)
 .. Q:((CODE>99200)&(CODE<99430))
 .. W "."
 .. N FDA
 .. S FDA(757.02,IEN_",",1)=""
 .. S FDA(757.02,IEN_",",2)=""
 .. N DIERR
 .. D FILE^DIE("","FDA")
 .. I $D(DIERR) S $EC=",U1,"
 ;
GCNSEQNO ; Remove GCNSEQNO
 N FDA,DIERR,ERR
 N I F I=0:0 S I=$O(^PSNDF(50.68,I)) Q:'I  S FDA(50.68,I_",","GCNSEQNO")="@"
 D FILE^DIE("","FDA","ERR")
 I $D(DIERR) S $EC=",U1,"
 QUIT
