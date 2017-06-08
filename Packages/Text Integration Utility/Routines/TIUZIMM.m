TIUZIMM ;Hines VAMC; Lynn Rosebur; Immunizations
 ;
IMMUN(DFN,TYPE) ; retrieve results of last immunizations
 ;  called by S X=$$IMMUN^TIUZIMM(DFN,TYPE) and test routine ^ATTEMP2
 ;  TYPE:  pointer value to Skin Test file or wild card "*", for all/any type
 ; E.G. S X=$$IMMUN^TIUZIMM(DFN,"*") ; last immunizations of any kind
 ; E.G. S X=$$IMMUN^TIUZIMM(DFN,"CHICKENPOX") ; last 'CHICKENPOX' result
 ; E.G. S X=$$IMMUN^TIUZIMM(DFN,"CHICKENPOX PLACED") ; last 'CHICKENPOX PLACED' result
 ; E.G. S X=$$IMMUN^TIUZIMM(DFN,"INFLUENZA");  last 'INFLUENZA' immunizations result
MAIN I TYPE'?1.A.1"-".A,TYPE'?1.A." ".A,TYPE'?1"*" S RESULT="Bad TYPE value passed: "_TYPE Q RESULT
 I '$D(^AUPNVIMM("C",DFN)) S RESULT="No immunizations found in computerized Immunizations file as of this date." Q RESULT
 I TYPE'="*",'$D(^AUTTIMM("B",TYPE)) S RESULT="No "_TYPE_" found in computerized Immunizations file as of this date." Q RESULT
 S TYPEIEN=$O(^AUTTIMM("B",TYPE,0)) I TYPE'="*",TYPEIEN'?1.N S RESULT="No "_TYPE_" entries found in computerized Immunizations file as of this date." Q RESULT
 I TYPE'="*",'$D(^AUPNVIMM("AA",DFN,TYPEIEN)) S RESULT="No "_TYPE_" tests found in computerized Immunizations file as of this date." Q RESULT
 N IEN,VDATE,VDATEOUT,DA,NODE S STIEN=0 K ARRAY,FOUND
 F  S STIEN=$O(^AUPNVIMM("C",DFN,STIEN)) Q:STIEN'?1.N  I $D(^AUPNVIMM(STIEN,0)) S NODE=^(0) D
 .  S VISIT=$P(NODE,U,3),VISIT=$P(^AUPNVSIT(VISIT,0),U)
 .  S TYPEDB=$P(NODE,U),TYPEDB=$P($G(^AUTTIMM(TYPEDB,0)),U) Q:TYPE'="*"&(TYPE'=TYPEDB)  S ARRAY(VISIT,STIEN)=""
 I '$D(ARRAY) S RESULT="No results found in computerized Immunizations file as of this date." Q RESULT
 S VISIT=999999999 K FOUND
 F  S VISIT=$O(ARRAY(VISIT),-1) Q:VISIT=""  S STIEN=999999999 D  Q:$D(FOUND)
 . F  S STIEN=$O(ARRAY(VISIT,STIEN),-1) Q:STIEN=""  S NODE=$G(^AUPNVIMM(STIEN,0)) I NODE'="" S FOUND=1 D  Q:$D(FOUND)
 ..  S Y=VISIT D DD^%DT S VISIT=$P(Y,"@"),TYPEDB=$P(NODE,U),RSLT=$P(NODE,U,4),READING=$P(NODE,U,5)
 ..  S TYPEDB=$P(^AUTTIMM(TYPEDB,0),U)
 ..  S RESULT=TYPEDB_" done on "_VISIT
 S:'$D(FOUND) RESULT="No tests found at all."
 Q RESULT
TYPES ; Here are the types used, with pointer value.
 ; ;SMALLPOX             1
 ; ;CHICKENPOX              2
 ; ;DIP.,PERT.,TET. (DPT)            3
 ; ;INFLUENZA           4
 ; ;TYPHOID         5
 ; ;ORAL POLIOVIRUS        6
 ; ;SALK          7
 Q
