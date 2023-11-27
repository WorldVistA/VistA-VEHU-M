ECXPRO1 ;ALB/GTS - Prosthetics Extract for DSS (Continued) ;2/27/19  15:47
 ;;3.0;DSS EXTRACTS;**9,11,13,15,21,24,33,37,39,100,105,112,132,154,174,187**;Dec 22, 1997;Build 163
 ;
 ; Reference to ^RMPR(600, in ICR #2528
 ; Reference to EN^DIQ1 in ICR #10015
 ; Reference to GET1^DIQ in ICD #2056
 ; Reference to ^DIC(4 in ICR #10090
 ; Reference to ^RMPR(661.1 in ICR #5754
 ; Reference to ^TMP supported by SACC 2.3.2.5.1 
 ; Reference to $$CPT^ICPTCOD in ICR # 1995
 ; Reference to ^ICPT( in ICR #5408
 ;
NTEG(ECXDFN,ECXLNE,ECXPIEN,ECXN0,ECXNLB,ECINST,ECXFORM) ;** Check for required fields
 ;   Input
 ;    ECXDFN   - ien in file #2
 ;    ECXLNE   - line number variable (passed by reference)
 ;    ECXPIEN  - IEN for the Prosthetics record
 ;    ECXN0    - zero node of the Prosthetics record
 ;    ECXNLB   - LB node of the Prosthetics record
 ;    ECINST   - station number being extracted
 ;    ECXFORM  - Form Requested On
 ;   Output (to be KILLed by calling routine)
 ;    ^TMP("ECX-PRO EXC",$J) - Array for the exception message       
 ;    ECXLNE                 - The number of the next line in the msg
 ;    ECXSTAT2               - Patient Station Number
 ;    ECXDATE                - Delivery Date of Prosthesis
 ;    ECXTYPE                - Type of Transaction work performed
 ;    ECXSRCE                - Source of prosthesis
 ;    ECXHCPCS               - CPT/HCPCS code for prosthesis
 ;    ECXRQST                - Requesting Station
 ;    ECXRCST                - Receiving Station
 ;    ECXPHCPC               - PSAS HCPCS code; if 'unknown', then use CPT/HCPCS code
 ;    ECXPHPCD               - PSAS HCPCS Code Description ;187
 ;    ECXNPPDC               - NPPD code for repairs or new issues
 ;    ECXHCPCD               - PSAS HCPCS/CPT HCPCS Description
 ;   Output (KILLed by NTEG)
 ;    ECXMISS                - 1 indicates missing information
 ;    ECXGOOD                - 0 indicates record should not be extracted
 ;
 N ECXGOOD,ECXMISS
 N CPTSTR ;187
 S (ECXRCST,ECXRQST,ECXNPPDC)="",ECXGOOD=1,ECXSTAT2=$P(ECXN0,U,10)
 I ECXSTAT2]"" D
 .K ECXDIC
 .S DA=ECXSTAT2,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 .D EN^DIQ1 S ECXSTAT2=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 .S:(ECINST'=$E(ECXSTAT2,1,3)) ECXGOOD=0 ;*Screen for incorrect Station
 ;
 ;** Screen out records
 S:($P(ECXN0,U,17)'="") ECXGOOD=0 ;*SHIP/DEL is not NULL
 S:($P(ECXN0,U,26)'="") ECXGOOD=0 ;*PICKUP/DEL is not NULL
 S:(+($P($G(^RMPR(660,ECXPIEN,"AM")),U,2))=1) ECXGOOD=0 ;*NO ADMIN CT=1
 S:(($P(ECXN0,U,15))'="") ECXGOOD=0 ;*HISTORICAL DATA is not NULL
 ;
 S ECXDATE=$P(ECXN0,U,12),ECXTYPE=$P(ECXN0,U,4),ECXSRCE=$P(ECXN0,U,14)
 S ECXHCPCS=$P($G(^ICPT(+$P(ECXN0,U,22),0)),U,1),ECXCMOD=""
 S ECXHCPCS=$$CPT^ECXUTL3(ECXHCPCS,ECXCMOD)
 ;get psas hcpcs code from file #661.1
 S ECXPHCPC=$P($G(^RMPR(660,ECXPIEN,1)),U,4) D
 .;get nppd code for repairs and new issues 10 characters in length.
 .I "X5"[ECXTYPE S ECXNPPDC=$TR($$GET1^DIQ(661.1,ECXPHCPC_",",5)," ","_")
 .I "ISR"[ECXTYPE S ECXNPPDC=$TR($$GET1^DIQ(661.1,ECXPHCPC_",",6)," ","_")
 .I +ECXPHCPC D  ;187 Get PSAS HCPC Code and Code Description
 ..S DA=ECXPHCPC,DIC="^RMPR(661.1,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;.02"
 ..D EN^DIQ1
 ..S ECXPHCPC=ECXDIC(661.1,DA,.01,"I") ;Code
 ..S ECXPHCPD=ECXDIC(661.1,DA,.02,"I") ;Description
 ..K DIC,DIQ,DA,DR,ECXDIC
 .I ECXPHCPC="UNKNOWN" S ECXPHCPC=$E(ECXHCPCS,1,5) D
 .. S ECXPHPCD=$P($$CPT^ICPTCOD(ECXPHCPC,""),U,3) ; 187 Get the versioned shortname
 ;
 ;* Get Requesting Station Number
 I ECXFORM["-3" D
 .S ECXRQST=$P(ECXNLB,U,1)
 .I ECXRQST]"" D
 ..S DA=ECXRQST,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 ..D EN^DIQ1 S ECXRQST=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 S:(ECXFORM'["-3") ECXRQST=""
 ;
 ;* Screen out records
 S:(+$P(ECXFORM,U,2)=13) ECXGOOD=0 ;*FORM REQUESTED ON = 13
 ;
 ;* Get Receiving Station Number
 I ECXFORM["-3" D
 .S ECXRCST=$P(ECXNLB,U,4)
 .I ECXRCST]"" D
 ..S DA=ECXRCST,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 ..D EN^DIQ1 S ECXRCST=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 S:(ECXFORM'["-3") ECXRCST=""
 ;
 ;** Check for integrity and set up the problem variable if right DIV
 I ECXGOOD D CHK
 Q ECXGOOD
 ;
CHK ;*Check variables
 ; Input
 ;  Variables set in and Output from NTEG^ECXPRO1
 ; Output
 ;  ^TMP("ECX-PRO EXC",$J,   - Global of records with integrity problems
 ;
 S ECXMISS=""
 I ECXSTAT2']"" S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 I ECXDFN=0 S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 ;I ECXSSN']"" S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 ;I ECXNA="    " S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 I ECXDATE']"" S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 I ECXTYPE']"" S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 I ECXSRCE']"" S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 I ECXHCPCS']"" S ECXGOOD=0 ;S ECXMISS=ECXMISS_"1" ;*HCPCS code check disabled
 S ECXMISS=ECXMISS_U
 I ECXFORM["-3" D
 .I ECXRQST']"" S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 I ECXFORM']"" S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 I ECXFORM["-3" D
 .I ECXRCST']"" S ECXMISS=ECXMISS_"1"
 I ECXMISS'="^^^^^^^^^^" D
 .S ECXGOOD=0
 .D ECXMISLN^ECXPRO2(ECXMISS,.ECXLNE,ECXPIEN)
 Q
 ;
PROSINFO(ECXDA,ECXLB,ECX0,ECXFORM) ;*Get Prosthetics Information
 ;
 ;  Input
 ;    ECDA    - The IEN for the Prosthetics record
 ;    ECX0    - The zero node of the Prosthetics record
 ;    ECXLB   - The LB node of the Prosthetics record
 ;    ECXFORM - The Form Requested On (to determine Lab transactions)
 ;
 ;  Output (to be KILLed by calling routine)
 ;    ECXCTAMT   - The Cost of Transaction
 ;    ECXLLC     - The Lab Labor Cost
 ;    ECXLMC     - The Lab Material Cost
 ;    ECXGRPR    - The AMIS Grouper number
 ;    ECXBILST   - The Billing Status
 ;    ECXQTY     - The Quantity
 ;    ECXNCOST   - The New Cost of Transaction, implemented in Patch 174
 ;    ECXNLLC    - The New Lab Labor Cost, implemented in Patch 174
 ;    ECXNLMC    - The New Lab Material Cost, implemented in Patch 174
 ;
 N MAXAMT  ;174
 S MAXAMT=$S(ECXLOGIC>2019:999999999,1:999999)  ;174
 S (ECXLLC,ECXLMC,ECXCTAMT)="",ECXBILST=$P($G(^RMPR(660,ECXDA,"AM")),U,3)
 S ECXQTY=$P(ECX0,U,7)
 S:(+ECXQTY=0) ECXQTY=1
 ;
 ;- Set Quantity field to 8 chars (right-justified & padded w/zeros)
 S ECXQTY=$$RJ^XLFSTR(ECXQTY,8,0)
 S ECXGRPR=$P($G(^RMPR(660,ECXDA,"AMS")),U,1),ECXCTAMT=$P(ECX0,U,16)
 I ECXFORM["-3" D
 .S ECXCTAMT=$P(ECXLB,U,9),ECXLLC=$P(ECXLB,U,7),ECXLMC=$P(ECXLB,U,8)
 ;
 ;- If Stock Issue or Inventory Issue, Cost of Transaction=0
 ;I $P(ECXFORM,U,2)=11!($P(ECXFORM,U,2)=12) S ECXCTAMT=0 ;154 Commented out line to allow costs to come through for inventory or stock issue
 S:ECXCTAMT="" ECXCTAMT=0 S:ECXCTAMT>MAXAMT ECXCTAMT=MAXAMT
 S:ECXLLC="" ECXLLC=0 S:ECXLLC>MAXAMT ECXLLC=MAXAMT
 S:ECXLMC="" ECXLMC=0 S:ECXLMC>MAXAMT ECXLMC=MAXAMT
 ;
 ;- Round to next dollar amount
 I (ECXCTAMT#1)>.50 S ECXCTAMT=(ECXCTAMT+1)\1
 I (ECXLLC#1)>.50 S ECXLLC=(ECXLLC+1)\1
 I (ECXLMC#1)>.50 S ECXLMC=(ECXLMC+1)\1
 ;
 I ECXLOGIC>2019 S ECXNCOST=ECXCTAMT S ECXNLLC=ECXLLC S ECXNLMC=ECXLMC  ;174
 Q
