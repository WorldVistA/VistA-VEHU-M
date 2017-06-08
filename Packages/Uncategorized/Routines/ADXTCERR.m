ADXTCERR ;523/KC log errors in Fileman file ; 15-SEP-1992
 ;;1.1;;
 ;
 ; do error reporting when fields are rejected by input transforms
 ;
 ; INPUT VARIABLES:
 ;
 ; ADXTFLD: FLD #
 ; ADXTDA: INTERNAL ENTRY #
 ; ADXT(): ARRAY MRS VALUES CONSIDERED
 ; ADXTMRS: MRS FIELD NAME CONSIDERED
 ; ADXTFNUM: FILE #
 ; ADXTMETH: 3, 4, OR W SLASH METHOD
 ; ADXTDD: 0 IF REJECTED BY ADXT TRANSFORM,
 ;         1 IF REJECTED BY ONCO TRANSFORM.
 ; ADXTSTFF: VALUE ATTEMPTED TO STUFF, IF 3 SLASHES
 ; ADXTLBL : MRS SOURCE FILE
 ; ADXTRN : TMP SUBSCRIPT
 ; ADXTSBDA : 2ND LEVEL INTERNAL # (IF ANY)
 ; ADXTSBF : 2ND LEVEL FIELD # (IF ANY)
 ;
 N ADXTNAME,ADXTERRN,X
QUIT ;
 ; DON'T RECORD WORTHLESS ERRORS
 ;
 ; new stuff fld 69 -- if T-code doesn't contain M
 Q:(ADXTFNUM=165.5)&(ADXTFLD=69)&(ADXT(ADXTMRS)'["M")&(ADXT(ADXTMRS)'["m")
 ; empty size/depth
 I ADXTFLD=29,ADXT(ADXTMRS)="  . ",ADXTFNUM=165.5 Q
 ; don't error WP fields
 I ADXTMETH'=3,ADXTMETH'=4 Q
 ; bogus dates (null)
 I ADXT(ADXTMRS)="00/00/00" Q
 ; doctors where value was N/A
 I ADXTFNUM=165.5,$$TRIM^ADXTUT(ADXT(ADXTMRS))="N/A",$P(ADXTFLD,".")=2 Q
 ; doctors where value was "9999  "
 I ADXTFNUM=165.5,ADXT(ADXTMRS)="9999  ",$P(ADXTFLD,".")=2 Q
 ; doctors from follow-up where value was "9999  "
 I ADXTFNUM=160,ADXT(ADXTMRS)="9999  ",ADXTMRS="FCTMD" Q
 ; doctors from follow-up where value was "N/A"
 I ADXTFNUM=160,$$TRIM^ADXTUT(ADXT(ADXTMRS))="N/A",ADXTMRS="FCTMD" Q
 ; quit if value was just blank
 I $L($$TRIM^ADXTUT(ADXT(ADXTMRS)))=0 Q
 ; quit if storing MRS state and already stored
 I ADXTFNUM=165.5,(ADXTFLD=523004)!(ADXTFLD=523005),$L($P($G(^ONCO(165.5,ADXTDA,1)),"^",2)) Q
 ;
MSG ;
 U IO(0)
 W !,"ERR adding to file ",ADXTFNUM,", DA ",ADXTDA,", fld ",ADXTFLD
 I $D(ADXTSBF) W ", Sub-fld ",ADXTSBF,", Sub-fld-DA ",ADXTSBDA
 W ", MRS value ",ADXT(ADXTMRS)
 ;
 ;S ADXTNAME="" S ADXTNAME=$O(^DD(ADXTFNUM,0,"NM",ADXTNAME))
 ;W !,"Error adding field for entry ",ADXTDA," in ",ADXTNAME," file (",ADXTFNUM,"). Failed"
 ;W !,"for field ",ADXTFLD," (",$P($G(^DD(ADXTFNUM,ADXTFLD,0)),"^"),")."
 ;I $D(ADXTSBF) W !?5,"Sub field entry # was ",ADXTSBDA," and sub-field was ",ADXTSBF,"(",$P($G(^DD(+$P(^DD(ADXTFNUM,ADXTFLD,0),"^",2),ADXTSBF,0)),"^"),")."
 ;W !,"Original MRS value was ->",ADXT(ADXTMRS),"<-."
 ;I ($G(ADXTSBDA)=-1) W !,"Error: Addition of a multiple field failed; attempted value: ->",ADXTSTFF,"<-" G EXIT
 ;I +ADXTDD W !,"Rejected by ONCO package's input transform; attempted value: ->",ADXTSTFF,"<-"
 ;I '+ADXTDD W !,"Rejected by conversion's input transform."
EXIT ;
 D STORE
 K ADXTNAME,ADXTERRN,X
 Q
STORE ; log a field addition error into TMP
 ; input variables:
 ;  ADXTFNUM, ADXTDA, ADXTFLD, ADXTSBDA, ADXTSBF, ADXT(ADXTMRS), ADXTMRS,
 ;  ADXTSTFF, ADXTRN, ADXTLBL
 ;
 N DIE,DA,DR,DIC,D0,X
 S X=+$O(^DIZ(523701,"AB",""))
 S:+X X=999999999-X+1 S:'+X X=1
 S DIC="^DIZ(523701,",DIC(0)="L" K DD,D0 D FILE^DICN
 I +Y<1 W !!,"Error storing error in error file..." Q
 K DA S DA=+Y
 K DIE,DR,DIC,D0
 S DIE="^DIZ(523701,"
 S DR="1///"_ADXTFNUM_";"
 I +$L(ADXTDA) S DR=DR_"2///"_$TR(ADXTDA,";:",",,")_";"
 I +$L(ADXTFLD) S DR=DR_"3///"_ADXTFLD_";"
 I +$G(ADXTSBDA) S DR=DR_"4///"_ADXTSBDA_";"
 I +$G(ADXTSBF) S DR=DR_"5///"_ADXTSBF_";"
 I +$L($G(ADXTSTFF)) S DR=DR_"7///"_$TR(ADXTSTFF,";:",",,")_";"
 I +$L(ADXT(ADXTMRS)) S DR=DR_"8///"_$TR(ADXT(ADXTMRS),";:",",,")_";"
 D ^DIE
 K DR
 S DR="9///NOW;"
 I +$L(ADXTMRS) S DR=DR_"10///"_ADXTMRS_";"
 I +$L(ADXTLBL) S DR=DR_"11///"_ADXTLBL_";"
 I +$L(ADXTRN) S DR=DR_"14///"_ADXTRN_";"
 S DR=DR_"15///"_$S(((ADXTFLD=".01")&('$D(ADXTSBDA))&('$D(ADXTSBF))&(ADXTFNUM'=165.5)):"A",1:"F")
 D ^DIE
 Q
 ;
ADDERR ; log a record addition failure in TMP
 ; input variables:
 ;  ADXTRN (record number in ^TMP of MRS record)
 ;  ADXTLBL (Abbreviation representing MRS source file)
 ;  ADXTFILE (text description of problem)
 ;
 N DIE,DA,DR,DIC,D0,X
 N ADXTMSG
 ;
 S ADXTMSG="ERR: Couldn't add MRS "
 S ADXTMSG=ADXTMSG_$S(ADXTLBL="DI":"Diagnosis",ADXTLBL="FL":"Follow-up",ADXTLBL="PAT":"Patient",ADXTLBL="DOC":"Doctor",ADXTLBL="SCD":"Secondary",1:"Unknown")
 S ADXTMSG=ADXTMSG_" record # "_ADXTRN_" to "_ADXTFILE
 ;
 S X=+$O(^DIZ(523701,"AB",""))
 S:+X X=999999999-X+1 S:'+X X=1
 S DIC="^DIZ(523701,",DIC(0)="L" K DD,D0 D FILE^DICN
 I +Y<1 W !!,"Error storing error in error file..." Q
 K DA S DA=+Y
 K DIE,DR,DIC,D0
 S DIE="^DIZ(523701,"
 S DR="9///NOW;11///"_ADXTLBL_";14///"_ADXTRN_";"
 D ^DIE
 S DR="15////A;16///"_$TR(ADXTMSG,";:",",,")
 D ^DIE
 U IO(0) W !,ADXTMSG ;," Check Error log error # ",DA," for more information.",!
 K ADXTMSG
 Q
VERERR ;
 N DIE,DA,DR,DIC,D0,X
 S X=+$O(^DIZ(523701,"AB",""))
 S:+X X=999999999-X+1 S:'+X X=1
 S DIC="^DIZ(523701,",DIC(0)="L" K DD,D0 D FILE^DICN
 I +Y<1 W !!,"Error storing error in error file..." Q
 K DA S DA=+Y
 K DIE,DR,DIC,D0
 S DIE="^DIZ(523701,"
 S DR="9///NOW;11///"_ADXTLBL_";14///"_ADXTRN_";15///V"
 D ^DIE
 Q
