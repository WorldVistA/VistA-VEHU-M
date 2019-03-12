ISIIMPU3 ;ISI GROUP/MLS -- Data Import Utility
 ;;1.0;;;Jun 26,2012;Build 30
 Q
CHNGNAME(DFN,NAME)
 ;Additonal utility for patient import called by ISIIMP03
 N MSG,FDA,tempFILE,tempFIELD,tempDFN
 K FDA
 S tempDFN=DFN
 S tempFILE="2"
 S tempFIELD=".01"
 S FDA(tempFILE,DFN_",",tempFIELD)=NAME
 D FILE^DIE("K","FDA","MSG")
 I $D(MSG) Q "-1^"_MSG
 Q 1
 ;
ADDALIAS(DFN,ALIAS)     
 ;Additonal utility for patient import called by ISIIMP03
 N MSG,FDA,tempFILE,tempFIELD,tempDFN
 k FDA
 S tempDFN=DFN
 s tempFILE="2"
 s tempFIELD=".01"
 s FDA(42,2.01,"+1,"_tempIEN_",",.01)=ALIAS
 d UPDATE^DIE("","FDA(42)","","MSG")
 I $D(MSG) Q "-1^"_MSG
 Q 1
 
