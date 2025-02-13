LEX2044P ; ISL/KER - Pre/Post Install LEX*2.0*44 ; 05/31/2006
 ;;2.0;LEXICON UTILITY;**44**;Sep 23, 1996;Build 2
 ;
POST ; Main Entry for LEX*2.0*44
 D MES^XPDUTL(" ") D C1,C2,C3,C4,MES^XPDUTL(" ")
 Q
 ;
C1 ; Change #1 - Adjust Activation from 03/15/2006 to 01/01/2006
 D DL(" Adjust Activation for 82 HCPCS codes to 01/01/2006")
 N CODE
 F CODE="G8054","G9050","G9051","G9052","G9053","G9054","G9055","G9056","G9057","G9058","G9059" D U1(CODE)
 F CODE="G9060","G9061","G9062","G9063","G9064","G9065","G9066","G9067","G9068","G9069","G9070" D U1(CODE)
 F CODE="G9071","G9072","G9073","G9074","G9075","G9076","G9077","G9078","G9079","G9080","G9081" D U1(CODE)
 F CODE="G9082","G9083","G9084","G9085","G9086","G9087","G9088","G9089","G9090","G9091","G9092" D U1(CODE)
 F CODE="G9093","G9094","G9095","G9096","G9097","G9098","G9099","G9100","G9101","G9102","G9103" D U1(CODE)
 F CODE="G9104","G9105","G9106","G9107","G9108","G9109","G9110","G9111","G9112","G9113","G9114" D U1(CODE)
 F CODE="G9115","G9116","G9117","G9118","G9119","G9120","G9121","G9122","G9123","G9124","G9125" D U1(CODE)
 F CODE="G9126","G9127","G9128","G9129","G9130" D U1(CODE)
 Q
U1(CODE) ; Update #1 - Adjust Activation from 03/15/2006 to 01/01/2006
 N LEXDA,DA,ND,OD,IENS,FDA,SIEN,IENR,MSG
 S CODE=$G(CODE) Q:'$L(CODE)  S OD=3060315,ND=3060101
 K IENS,FDA S (SIEN,LEXDA,DA)=$$CODEN^ICPTCOD(CODE) Q:+DA'>0  S IENS=$$IENS^DILF(.LEXDA)
 S FDA(81,IENS,8)=ND K IENR,MSG D UPDATE^DIE("","FDA","IENR","MSG") S (LEXDA(1),DA(1))=DA
 K IENS,FDA S (LEXDA,DA)=$O(^ICPT(+DA(1),60,"B",OD,0)) I DA(1)>0,+DA>0 D
 . S IENS=$$IENS^DILF(.LEXDA),FDA(81.02,IENS,.01)=ND K IENR,MSG
 . D UPDATE^DIE("","FDA","IENR","MSG")
 K IENS,FDA S (LEXDA,DA)=$O(^ICPT(+DA(1),61,"B",OD,0)) I DA(1)>0,+DA>0 D
 . S IENS=$$IENS^DILF(.LEXDA),FDA(81.061,IENS,.01)=ND K IENR,MSG
 . D UPDATE^DIE("","FDA","IENR","MSG")
 K IENS,FDA S (LEXDA,DA)=$O(^ICPT(+DA(1),62,"B",OD,0)) I DA(1)>0,+DA>0 D
 . S IENS=$$IENS^DILF(.LEXDA),FDA(81.062,IENS,.01)=ND K IENR,MSG
 . D UPDATE^DIE("","FDA","IENR","MSG")
 D N0D(SIEN) K LEXDA,DA
 K IENS,FDA S SIEN=0  F  S SIEN=$O(^LEX(757.02,"CODE",(CODE_" "),SIEN))  Q:+SIEN'>0  D
 . S (LEXDA(1),DA(1))=SIEN  S DA=0 F  S DA=$O(^LEX(757.02,DA(1),4,"B",OD,DA)) Q:+DA'>0  D
 . . K IENS,FDA S LEXDA=DA,IENS=$$IENS^DILF(.LEXDA),FDA(757.28,IENS,.01)=ND
 . . K IENR,MSG D UPDATE^DIE("","FDA","IENR","MSG")
 Q
 ;            
C2 ; Change #2 - Inactivate 93 HCPC Codes
 D DL(" Inactivate 90 HCPCS Codes as of 04/02/2006")
 N CODE
 F CODE="C9117","C9118","C9124","C9125","C9204","C9213","C9214","C9215","C9216","C9217","C9219" D U2(CODE)
 F CODE="C9226","C9412","C9712","C9714","C9715","C9717","E1019","E1021","K0548","K0549","K0550" D U2(CODE)
 F CODE="K0560","K0561","K0562","K0563","K0564","K0565","K0566","K0567","K0568","K0569","K0570" D U2(CODE)
 F CODE="K0571","K0572","K0573","K0574","K0575","K0576","K0577","K0578","K0579","K0580","K0610" D U2(CODE)
 F CODE="K0611","K0612","K0613","K0614","K0615","K0616","K0617","K0621","K0622","K0623","K0624" D U2(CODE)
 F CODE="K0625","K0626","K0627","K0650","K0651","K0652","K0653","K0654","K0655","K0656","K0657" D U2(CODE)
 F CODE="K0658","K0659","K0660","K0661","K0662","K0663","K0664","K0665","K0666","K0667","K0668" D U2(CODE)
 F CODE="Q3030","Q4052","Q4053","Q4078","S0112","S0163","S0165","S0193","S2131","S2255","S8002" D U2(CODE)
 F CODE="S8003","S8470" D U2(CODE)
 Q
U2(CODE) ; Update #2 - Inactivate 93 HCPC Codes
 N LEXDA,DA,ND,OD,IENS,FDA,SIEN,LIEN,IENR,MSG,LAYGO S LAYGO=""
 S CODE=$G(CODE) Q:'$L(CODE)  S OD=3060401,ND=3060402
 S (LEXDA,DA,SIEN)=$$CODEN^ICPTCOD(CODE) I +DA>0 D
 . S (LEXDA(1),DA(1))=DA,(LEXDA,DA)=+($O(^ICPT(+DA(1),60,"B",OD,0)))+1 S:DA=1 (LEXDA,DA)=$O(^ICPT(+DA(1),60," "),-1)+1
 . S IENS=$$IENS^DILF(.LEXDA),IENS="+"_IENS
 . N FDA S FDA(81.02,IENS,.01)=ND,FDA(81.02,IENS,.02)=0
 . K IENR,MSG D UPDATE^DIE("","FDA","IENR","MSG")
 D N0D(SIEN) K LEXDA,DA
 S SIEN=0 F  S SIEN=$O(^LEX(757.02,"CODE",(CODE_" "),SIEN)) Q:+SIEN'>0  D
 . S LIEN=$O(^LEX(757.02,SIEN,4," "),-1)
 . I $G(^LEX(757.02,SIEN,4,LIEN,0))=(OD_"^1") D
 . . S (LEXDA(1),DA(1))=SIEN,(LEXDA,DA)=LIEN+1,IENS=$$IENS^DILF(.LEXDA),IENS="+"_IENS
 . . N FDA S FDA(757.28,IENS,.01)=ND,FDA(757.28,IENS,1)=0
 . . K IENR,MSG D UPDATE^DIE("","FDA","IENR","MSG")
 Q
 ;               
C3 ; Change #3 - Adjust Activation from 04/03/2006 to 01/01/2001
 D DL(" Adjust Activation for 3 HCPCS codes to 01/01/2001")
 N CODE F CODE="S0190","S0191","S0199" D U3(CODE)
 Q
U3(CODE) ; Update #3 - Adjust Activation from 04/03/2006 to 01/01/2001
 N LEXDA,DA,ND,OD,IENS,FDA,SIEN,IENR,MSG S CODE=$G(CODE) Q:'$L(CODE)  S OD=3060401,ND=3010101
 K IENS,FDA S (SIEN,LEXDA,DA)=$$CODEN^ICPTCOD(CODE) Q:+DA'>0  S (LEXDA(1),DA(1))=DA
 K IENS,FDA S (LEXDA,DA)=$O(^ICPT(+DA(1),60,"B",OD,0)) I DA(1)>0,+DA>0 D
 . S IENS=$$IENS^DILF(.LEXDA),FDA(81.02,IENS,.01)=ND K IENR,MSG S:+IENS>0 IENS="+"_IENS
 . D UPDATE^DIE("","FDA","IENR","MSG")
 K IENS,FDA S (LEXDA,DA)=$O(^ICPT(+DA(1),61,"B",OD,0)) I DA(1)>0,+DA>0 D
 . S IENS=$$IENS^DILF(.LEXDA),FDA(81.061,IENS,.01)=ND K IENR,MSG S:+IENS>0 IENS="+"_IENS
 . D UPDATE^DIE("","FDA","IENR","MSG")
 K IENS,FDA S (LEXDA,DA)=$O(^ICPT(+DA(1),62,"B",OD,0)) I DA(1)>0,+DA>0 D
 . S IENS=$$IENS^DILF(.LEXDA),FDA(81.062,IENS,.01)=ND K IENR,MSG S:+IENS>0 IENS="+"_IENS
 . D UPDATE^DIE("","FDA","IENR","MSG")
 D N0D(SIEN) K LEXDA,DA
 K IENS,FDA S SIEN=0  F  S SIEN=$O(^LEX(757.02,"CODE",(CODE_" "),SIEN))  Q:+SIEN'>0  D
 . S (LEXDA(1),DA(1))=SIEN  S DA=0 F  S DA=$O(^LEX(757.02,DA(1),4,"B",OD,DA)) Q:+DA'>0  D
 . . K IENS,FDA S LEXDA=DA,IENS=$$IENS^DILF(.LEXDA),FDA(757.28,IENS,.01)=ND K IENR,MSG S:+IENS>0 IENS="+"_IENS
 . . D UPDATE^DIE("","FDA","IENR","MSG")
 K LEXDA,DA S (LEXDA,DA)=$$CODEN^ICPTCOD(CODE) Q:+DA'>0  S IENS=$$IENS^DILF(.LEXDA) S FDA(81,IENS,8)=ND K IENR,MSG
 D UPDATE^DIE("","FDA","IENR","MSG")
 Q
 ;                             
C4 ; Change #4 - Reactivate 4 codes 01/02/2006
 D DL(" Reactivate 4 HCPCS Codes on 01/02/2006")
 N CODE F CODE="E1239","G0252","J7317","J7320" D U4(CODE)
 Q
U4(CODE) ; Update #4 - Reactivate 4 codes 01/02/2006
 N LEXDA,DA,ND,OD,RD,RT,IENS,FDA,SIEN,LIEN,IENR,MSG,LAYGO S LAYGO=""
 S CODE=$G(CODE) Q:'$L(CODE)  S OD=3050101,ND=3060102
 S (LEXDA,DA,SIEN)=$$CODEN^ICPTCOD(CODE) I +DA>0 D
 . N RD,OD,SD,ID,ND,NS S (SD,ID)=""
 . S RD=" " F  S RD=$O(^ICPT(SIEN,60,"B",RD),-1) Q:+RD'>0  D  Q:$L(SD)
 . . N RI S RI=1 F  S RI=$O(^ICPT(SIEN,60,"B",RD,RI)) Q:+RI'>0  D  Q:$L(SD)
 . . . S ND=$G(^ICPT(SIEN,60,RI,0)),NS=$P(ND,"^",2),ND=$P(ND,"^",1)
 . . . S:+NS'>0 SD=ND
 . I +SD>0 S RI=0 F  S RI=$O(^ICPT(SIEN,60,RI)) Q:+RI'>0  D
 . . S ND=$P($G(^ICPT(SIEN,60,RI,0)),"^",1)
 . . I ND=SD!(ND>SD) D
 . . . N DA,DIK S DA(1)=SIEN,DA=RI,DIK="^ICPT("_DA(1)_",60,"
 . . . D ^DIK
 . D N0D(SIEN)
 S SIEN=0 F  S SIEN=$O(^LEX(757.02,"CODE",(CODE_" "),SIEN)) Q:+SIEN'>0  D
 . N RD,OD,SD,ID,ND,NS S (SD,ID)=""
 . S RD=" " F  S RD=$O(^LEX(757.02,+SIEN,4,"B",RD),-1) Q:+RD'>0  D  Q:$L(SD)
 . . N RI S RI=1 F  S RI=$O(^LEX(757.02,+SIEN,4,"B",RD,RI)) Q:+RI'>0  D  Q:$L(SD)
 . . . S ND=$G(^LEX(757.02,+SIEN,4,RI,0)),NS=$P(ND,"^",2),ND=$P(ND,"^",1)
 . . . S:+NS'>0 SD=ND
 . I +SD>0 S RI=0 F  S RI=$O(^LEX(757.02,+SIEN,4,RI)) Q:+RI'>0  D
 . . S ND=$P($G(^LEX(757.02,+SIEN,4,RI,0)),"^",1)
 . . I ND=SD!(ND>SD) D
 . . . N DA,DIK S DA(1)=SIEN,DA=RI,DIK="^LEX(757.02,"_DA(1)_",4,"
 . . . D ^DIK
 Q
N0D(X) ; Node 0 Date
 N IEN,DA,DIK,EFF,EFI,STA
 S IEN=$G(X),EFF=$O(^ICPT(+IEN,60,"B"," "),-1) Q:+EFF'>0  Q:EFF'?7N  S EFI=$O(^ICPT(+IEN,60,"B",EFF,0)) Q:+EFI'>0
 S STA=$G(^ICPT(+IEN,60,EFI,0)),EFF=$P(STA,"^",1),STA=$P(STA,"^",2) Q:EFF'?7N  Q:STA'?1N
 S $P(^ICPT(+IEN,0),"^",7)="",$P(^ICPT(+IEN,0),"^",8)=""
 S:+STA=0 $P(^ICPT(+IEN,0),"^",7)=EFF S:+STA=1 $P(^ICPT(+IEN,0),"^",8)=EFF
 I EFI>1,STA=0 F  S EFI=$O(^ICPT(+IEN,60,EFI),-1) Q:+EFI'>0  Q:$P($G(^ICPT(+IEN,60,+EFI,0)),"^",2)=1
 I EFI>0 S EFF=$P($G(^ICPT(+IEN,60,EFI,0)),"^",1) S:EFF?7N $P(^ICPT(+IEN,0),"^",8)=EFF
 Q
 ;                           
DL(X,I) ; Display Line
 S X=$G(X),I=+($G(I)) S:+I'>0 I=1 N SP S SP=$J(" ",I) S X=SP_X D MES^XPDUTL(X)
 Q
SC(X) ; Show CPT
 N IEN,NN,NC S IEN=+($G(X)) Q:IEN'>0  S NN="^ICPT("_IEN_")",NC="^ICPT("_IEN_","
 F  S NN=$Q(@NN) Q:NN=""!(NN'[NC)  W !,NN,"=",@NN
 Q
SL(X) ; Show LEX
 N IEN,NN,NC S IEN=+($G(X)) Q:IEN'>0  S NN="^LEX(757.02,"_IEN_")",NC="^LEX(757.02,"_IEN_","
 F  S NN=$Q(@NN) Q:NN=""!(NN'[NC)  W !,NN,"=",@NN
 Q
