ZPCDSS ;BCP call--gathers DSS data
 ;
EN S DTX=^DD("DD")
RAD ;RADIOLOGY EXTRACT
 S DA=0
 F  S DA=$O(^ECX(727.814,DA)) Q:+DA=0  D  ;
 .S NODE=$G(^ECX(727.814,DA,0))
 .S YRMO=$P(NODE,"^",2)
 .S FLD(1)=$P(NODE,"^",6) ;SSN
 .S DFN=$P(NODE,"^",5),FLD(2)=""
 .I DFN'="" S FLD(2)=$P($G(^DPT(DFN,0)),"^",1) ;patient name
 .S DAY=$P(NODE,"^",9),Y=2_YRMO_DAY X DTX S FLD(3)=Y ;event date
 .S FLD(3)=$TR(FLD(3),"@"," ")
 .S FLD(4)=$P(NODE,"^",10),FLD(5)="" ;CPT code
 .I FLD(4)'="" S FLD(5)=$P($G(^ICPT(FLD(4),0)),"^",2) ;CPT short name
 .S PROC=$P(NODE,"^",11),FLD(6)=""
 .I PROC'="" S FLD(6)=$P($G(^RAMIS(71,PROC,0)),"^",1) ;RAD procedure name
 .S DIAGCD=$P(NODE,"^",15),FLD(7)=""
 .I DIAGCD'="" S FLD(7)=$P($G(^RA(78.3,DIAGCD,0)),"^",1) ;Radiology's diag code
 .S REQDR=$P(NODE,"^",16),FLD(8)="",FLD(9)=""
 .S FILE=$E(REQDR,1,1) ;does this field point to file 200 or 6
 .S REQDR=$E(REQDR,2,$L(REQDR))
 .I FILE=2 S FLD(8)=$P($G(^VA(200,REQDR,0)),"^",1),FLD(9)=$P($G(^VA(200,REQDR,"PS")),"^",3) ;dr_va_num of request dr.
 .S IMGTY=$P(NODE,"^",21),FLD(10)="" ;imaging type
 .I IMGTY'="" S FLD(10)=$P($G(^RA(79.2,IMGTY,0)),"^",1)
 .S PROV=$P(NODE,"^",23),FLD(12)="",FLD(11)="" ;primary provider and dr_va_num
 .I PROV'="" S FLD(11)=$P($G(^VA(200,PROV,0)),"^",1),FLD(12)=$P($G(^VA(200,PROV,"PS")),"^",3)
 .S REC="" F K=1:1:12 S REC=REC_FLD(K)_"^"
 .S REC=$E(REC,1,$L(REC)-1)
 .W REC,!
 Q
