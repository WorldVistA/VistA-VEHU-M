IBEC704P ;ALB/CLT - POST PROCESSOR LOAD DNS ADDRESS INTO LOGICAL LINK ENTRIES ; 02 Jun 2022  1:08 PM
 ;;2.0;INTEGRATED BILLING;**704**;21-MAR-94;Build 49
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^HLCS(870," in ICR #6409
 ;
 Q
 ;
EN ;ENTRY POINT
 N IBNODE,IBADDR,IEN,DIE,DR,DA
 F IBNODE="IBECEC-DFT","IBECEC-DSR","IBECEC-QRY" S IEN=$O(^HLCS(870,"B",IBNODE,"")) Q:IEN=""  D
 . S IBADDR=$S($$PROD^XUPROD()=1:"ehrm.das.domain.ext",1:"sqa.ehrm.das.domain.ext")
 . S DIE="^HLCS(870,",DR=".08///^S X=IBADDR",DA=IEN
 . D ^DIE
 Q
