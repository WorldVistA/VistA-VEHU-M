PSOVCC0 ;ORLFO/FJF/WC - PSO Activity Logs ; Mar 20, 2023@12:57:56
 ;;7.0;OUTPATIENT PHARMACY;**707**;DEC 1997;Build 18
 ; 
 ; External calls:
 ;
 ; Description       ICR     Notes
 ; -----------       ------  -------
 ; Reference to ENCODE^XLFJSON in #6682      
 ; Reference to GET^DDE in #7008     
 ; Reference to FMTHL7^XLFDT, HTFM^XLFDT in #10103    
 ; Reference to FIND1^DIC in #2051    
 ; Reference to UPD^DGENDBS in #7350    
 ; Reference to GETDFN^MPIFAPI,GETADFN^MPIFAPI in #2702
 ; Reference to UPDATE^MPIFAPI in #2706
 ; Reference to UP^XLFSTR in #10103
 ; Reference to ^%DT in #10003
 ;
 ;
PSOVPADDR(PSOVRTN,PSOVICN,PSOVADDR,PSOVATYP) ; Update temporary address in Patient file (#2)
 ; Input:  PSOVICN     (required) - Patient ICN
 ;         PSOVADDR   (required) - Address
 ;           - format ARRAY(fieldname)=field_value
 ;           - e.g. addr("City")="Alexandria"
 ;                  addr("Country")="Canada"
 ;                  addr("County")="Yorkshire"
 ;                  addr("EndDate")="10/31/2022"
 ;                  addr("PhoneNumber")="987-654-3219"
 ;                  addr("PostCode")="SK37 4ED9"
 ;                  addr("Province")="Saskatchewan"
 ;                  addr("StartDate")="09/01/2022"
 ;                  addr("State")="TX"
 ;                  addr("StreetL1")="Flat 9"
 ;                  addr("StreetL2")="The Orchards"
 ;                  addr("StreetL3")="Sharp Avenue"
 ;                  addr("Zip")=95739
 ;                  addr("Zip+4")="95739-0001"
 ;          PSOVATYP   (required) - Indicator of which address is to be updated
 ;                  T - temporary address
 ;                  O - Other, yet to be determined
 ;         
 ; Output: PSOVRTN - Return Value
 ;                1 for success
 ;               -1 - error message for failure
 ;
 ; check for required input parameters
 I $G(PSOVICN)="" S PSOVRTN="-1 - ICN is required" Q
 I '$D(PSOVADDR) S PSOVRTN="-1 - Address is required" Q
 I '$D(PSOVATYP) S PSOVRTN="-1 - Address type is required" Q
 ;
 ; check ICN is valid
 N DFN
 S DFN=$$GETADFN^MPIFAPI($P(PSOVICN,"V"))
 ;
 I +DFN=-1 S PSOVRTN="-1 - ICN not recognised" Q
 ;
 ; convert input json to M array PSOVM
 D J2MAR(.PSOVADDR,.PSOVM)
 ;
 N FDA,PSOVERR
 S FDA(.1211)=$G(PSOVM("StreetL1"))
 S FDA(.1212)=$G(PSOVM("StreetL2"))
 S FDA(.1213)=$G(PSOVM("StreetL3"))
 S FDA(.1214)=$G(PSOVM("City"))
 I $D(PSOVM("State")) D
 .N PSOVSTATE
 .S PSOVSTATE=$$UP^XLFSTR(PSOVM("State"))
 .S FDA(.1215)=$O(^DIC(5,"B",PSOVSTATE,""))
 S FDA(.1216)=$G(PSOVM("Zip"))
 S FDA(.1217)=$$EX2FM($G(PSOVM("StartDate")))
 S FDA(.1218)=$$EX2FM($G(PSOVM("EndDate")))
 S FDA(.1219)=$G(PSOVM("PhoneNumber"))
 S FDA(.1221)=$G(PSOVM("Province"))
 S FDA(.1222)=$G(PSOVM("PostCode"))
 N CNTRY
 S CNTRY=$$CNTCHK($G(PSOVM("Country")))
 I CNTRY=0 S CNTRY=""
 S FDA(.1223)=CNTRY
 I $D(PSOVADDR("County")) D
 .N PSOVCOUNTY
 .S PSOVCOUNTY=$$UP^XLFSTR(PSOVM("County"))
 .S FDA(.12111)=PSOVCOUNTY
 S FDA(.12112)=$G(PSOVM("Zip+4"))
 ;
 S PSOVRTN=$$UPD^DGENDBS(2,DFN,.FDA,.PSOVERR)
 I +PSOVRTN'=1 S PSOVRTN=-1_" - "_PSOVERR
 S PSOVRTN="1 - Temporary Address Updated"
 Q
 ;
J2MAR(JARR,PSOVM) ; convert passed json into M array
 ; Input:
 ;   JARR   - json
 ;   PSOVM - M array
 N LSUB,I
 S LSUB=$O(PSOVADDR(""),-1)
 F I=2:2:LSUB-2 S PSOVM(PSOVADDR(I))=PSOVADDR(I+1)
 Q 1
 ;
 ; Convert external date to FileMan date
EX2FM(X) ; Conversion
 ;
 ; Input:
 ;   X - external date or FileMan Date 
 ;
 ; Output:
 ;   Y - FileMan Date or -1 
 ;
 N Y
 S X=$G(X)
 D ^%DT
 K X,%DT
 Q Y
 ;
 ;
PSOVGTADDR(PSOVRTN,PSOVICN,PSOVATYP) ; Retrieve address in Patient file (#2)
 ;
 ; Input:  PSOVICN   (required) - Patient ICN
 ;         PSOVATYP  (required) - Indicator of which address is to be retrieved
 ;                  T - temporary address
 ;                  O - Other, yet to be determined
 ; Output: PSOVRTN - Return Value
 ;                temporary address in json format
 ;               -1 - error message for failure
 ;
 ;
 ; check for required input parameters
 I $G(PSOVICN)="" S PSOVRTN="-1 - ICN is required" Q
 I '$D(PSOVATYP) S PSOVRTN="-1 - Address type is required" Q
 ;
 ; check ICN is valid
 N DFN
 S DFN=$$GETDFN^MPIF001(PSOVICN)
 ;
 I +DFN=-1 S PSOVRTN="-1 - ICN not recognised" Q
 ;
 N QUERY
 S QUERY("PATIENT")=DFN
 N PSOVTMP D GET^DDE("PSO TEMPORARY ADDRESS",DFN,,0,,"PSOVTMP")
 S PSOVRTN=$G(PSOVTMP(1))
 I PSOVRTN="" S PSOVRTN="0 - No data - there is no temporary address data for ICN "_PSOVICN
 Q
 ;
CNTCHK(CNTRY) ;
 ;
 N COUNTRY
 S COUNTRY=$$FIND1^DIC(779.004,"","MX",CNTRY,"D","","ERROR")
 I COUNTRY=0 D
 .S COUNTRY=$$FIND1^DIC(779.004,"","MX",CNTRY,"B","","ERROR")
 Q COUNTRY
 ;
 ; --------
 ; 
ECME(PSOVO,PSOVRXN)  ; ECME Log
 ;
 ; Input:  PSOVRXN   (required) - Prescription number  
 ;         
 ; Output: PSOVRTN - Return Value
 ;                   ECME log in json format
 ;               -1 - error message for failure
 ;
 ; check for required input parameters
 I $G(PSOVRXN)="" D NORXNER("-1 - Prescription number is required") Q
 ;
 I '$$RXVAL^PSOUTCRM(PSOVRXN) D NORXNER("-2^ Prescription Number is not recognized") Q
 N ERR,PSOVIEN
 S PSOVIEN=$O(^TMP($J,"PSOV",-1))
 D GET^DDE("PSO ECME M",PSOVIEN,,0,,"PSOVO","ERR")
 I $D(ERR) D NORXNER("-1^Error in Retrieval") Q
 I $L(PSOVO(1),"}")<3 D NORXNER("0^No data - there are no ECME entries for this prescription") Q
 D TIDY()
 Q
 ;
 ; ---------
 ;
ERX(PSOVO,PSOVRXN)  ; eRx Log
 ;
 ; Input:  PSOVRXN   (required) - Prescription number  
 ;
 ; Output: PSOVRTN - Return Value
 ;                   ERX log in json format
 ;               -1 - error message for failure
 ;
 ; check for required input parameters
 I $G(PSOVRXN)="" D NORXNER("-1 - Prescription number is required") Q
 ;
 I '$$RXVAL^PSOUTCRM(PSOVRXN) D NORXNER("-2^ Prescription Number is not recognized") Q
 N ERR,PSOVIEN
 S PSOVIEN=$O(^TMP($J,"PSOV",-1))
 ;
 D GET^DDE("PSO ERX M",PSOVIEN,,0,,"PSOVO","ERR")
 I $D(ERR) D NORXNER("-1^Error in Retrieval") Q
 I $L(PSOVO(1),"}")<3 D NORXNER("0^No data - there are no ERX entries for this prescription") Q
 D TIDY()
 Q
 ;
 ; --------
 ;
LELF(PSOVO,PSOVRXN)  ; Lot/Expiration Log File
 ;
 ; Input:  PSOVRXN   (required) - Prescription number
 ;
 ; Output: PSOVRTN - Return Value
 ;                   Lot/Expiration log in json format
 ;               -1 - error message for failure
 ;
 ; check for required input parameters
 I $G(PSOVRXN)="" D NORXNER("-1 - Prescription number is required") Q
 ;
 I '$$RXVAL^PSOUTCRM(PSOVRXN) D NORXNER("-2^ Prescription Number is not recognized") Q
 N ERR,PSOVIEN
 S PSOVIEN=$O(^TMP($J,"PSOV",-1))
 ;
 D GET^DDE("PSO LOT EXP M",PSOVIEN,,0,,"PSOVO","ERR")
 I $D(ERR) D NORXNER("-1^Error in Retrieval") Q 
 I $L(PSOVO(1),"}")<3 D NORXNER("0^No data - there are no Lot_Expiration entries for this prescription") Q
 D TIDY()
 Q
 ;
 ; --------
NORXNER(ERROR) ; handle messages for input parameter issue or no data
 ;
 N ZXC,PSOVRT
 S PSOVRT="PSOVO"
 S ECMER=ERROR
 D MERGE(0)
 K PSOVO(0)
 K PSOVO(1)
 D ENCODE^XLFJSON("ECM",.PSOVRT)
 S ZXC=@(PSOVRT_"(1)")
 S ZXC=$$SWAP^PSOUTCRM(ZXC,"\/","/")
 S @PSOVRT=ZXC
 K ECM,ECMER
 Q
 ;
 ;
TRNSFRM(X,SEP,BRC) ; remove extra quotes from string
 ;
 ; X   - string processes
 ; SEP - delimiter on which string is parsed
 ; BRC - opening or closing curly brace
 ;
 Q $P(X,SEP)_SEP_""":"_BRC_$P(X,BRC,4,$L(X,BRC))
 ;
TIDY() ; tidy up output string
 ;
 S PSOVO(1)="{"_$P(PSOVO(1),"{",2,$L(PSOVO(1),"{"))
 N PSOVA1,PSOVA2,CT
 S CT=$L(PSOVO(1),"}, {")
 M PSOVA1=PSOVO(1)
 M PSOVA2("data","items")=PSOVA1
 S PSOVA2("data","updated")=$$FMTHL7^XLFDT($$HTFM^XLFDT($H))
 S PSOVA2("data","total items")=CT
 D ENCODE^XLFJSON("PSOVA2","PSOVO")
 S PSOVO(1)=$TR(PSOVO(1),"\\\")
 S PSOVO=$$CHOP(PSOVO(1))
 K PSOVO(0)
 ;
 S PSOVO=$$TRNSFRM(PSOVO,"items","{")
 S PSOVO=$RE($$TRNSFRM($RE(PSOVO),"smeti latot","}"))
 S PSOVO=$RE($P($RE(PSOVO),":",1,3)_","_$P($RE(PSOVO),":",4,$L($RE(PSOVO),":")))
 ;
 Q
 ;
MERGE(CT) ; merge into output array as json
 ;
 M ECM("data","items")=ECMER
 S ECM("data","updated")=$$FMTHL7^XLFDT($$HTFM^XLFDT($H))
 S ECM("data","total items")=CT
 Q
 ;
 ;
NTOS(X) ; convert numbers to strings
 ;
 N W,Y,L,M,I
 S L=$P(X,":",1),M=$TR($P(X,":",2,$L(X,":")),"][")
 S W=$P($P(X,"[",2),"]",1)
 F I=1:1:$L(W,", ") I $P(W,", ",I)=+$P(W,", ",I) D
 .S $P(M,", ",I)=""""_$P(M,", ",I)_""""
 S $P(L,":",2)="["_M_"]"
 Q L
 ;
CHOP(S) ; remove "\ and \" from input S
 N P,B,C,I
 S P="""\"
 S B="" F I=1:1:$L(S,P) S B=B_$P(S,P,I)
 S P="\"""
 S C="" F I=1:1:$L(B,P) S C=C_$P(B,P,I)
 Q C
 ;
