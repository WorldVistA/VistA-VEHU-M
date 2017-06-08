ADXTAFL5 ;523/KC stuff follow-up tumor status 165.573 ;22-DEC-1992
 ;;1.1;;
 ; (TUMOR STATUS MULTIPLE)
EN ;
 ; INPUT VARIABLES:
 ; ADXT(""): WHERE DIFFERENT MRS FIELD VALUES ARE STORED BY SUBSCRIPT
 ; ADXTDA: DA OF THE 165.5 ENTRY TO ADD TO
 ; ADXTFILE: test description of file adding entries to
 ; OUTPUT VARIABLES: NONE
 ;
 N ADXTFNUM,ADXTFLD,ADXTLINE,ADXTDASV,ADXTDDX,ADXTI,ADXTPDA,ADXTPS,ADXTSBDA,ADXTSBF,ADXTZBDA,ADXTZDAT,DA,DIE,DR,X
 ;
 U IO
 S ADXTFNUM=165.5
 S ADXTFLD=73
 ;
 ; quit if tumor status from this fup already processed.
 Q:$D(^ONCO(165.5,ADXTDA,"TS","A523000",ADXT("PID")_ADXT("DTOP")_ADXT("DSQ")_ADXT("FDT")))
 ;
 S ADXTPDA=$$GTPP^ADXTUT(ADXT("PID"))
 I '+ADXTPDA W !!,"Could not match ",ADXT("PID")," to a patient. Not updating tumor status from follow-up!",!!
 S X=$$DTCVT^ADXTUT(ADXT("FDT")) Q:'+X
 ;
 ; if deceased, tumor status handled by DPRE from ADXTADI routines
 Q:'+$$ALIVE^ADXTUT(X,ADXTPDA)
 ;
 S ADXTSBDA=0
 I $D(^ONCO(165.5,ADXTDA,"TS","B",X)) D
 .S ADXTSBDA=$O(^ONCO(165.5,ADXTDA,"TS","B",X,0))
 I '+ADXTSBDA D ^ADXTMULT
 ; add conversionid
 I (+ADXTSBDA)>0,$G(^ONCO(165.5,ADXTDA,"TS",ADXTSBDA,523000))']"" D
 .S ADXTLINE=$P($TEXT(ID+1),";;",2)
 .S ADXTSBF=$P(ADXTLINE,"^",2)
 .D ^ADXTEDIT
 I ADXTSBDA>0 D
 .S ADXTLINE=$P($TEXT(ALIVE+1),";;",2)
 .S ADXTSBF=$P(ADXTLINE,"^",2)
 .Q:$P($G(^ONCO(165.5,ADXTDA,"TS",ADXTSBDA,0)),"^",2)=+ADXT("FLEV")
 .Q:'+ADXT("FLEV")
 .D ^ADXTEDIT
 .;W !,"Changed Tumor Status# ",ADXTSBDA," for primary# ",ADXTDA,": ",$G(^ONCO(165.5,ADXTDA,"TS",ADXTSBDA,0))
 .;
EXIT ;
 K ADXTFNUM,ADXTFLD,ADXTLINE,ADXTDASV,ADXTDDX,ADXTI,ADXTPDA,ADXTPS,ADXTSBDA,ADXTSBF,ADXTZBDA,ADXTZDAT,DA,DIE,DR,X
 Q
 ;
 ; PIECE LISTING:
 ; ==============
 ; 1: VA file MRS var to be added into
 ; 2: VA field MRS var to be added into
 ; 3: MRS field to add
 ; 4: 3 or 4 for number of slashes to stuff, W for Word processing
 ; 5-50: input transform
 ;
ID ;
 ;;165.573^523000^FDT^3^S X=ADXT("PID")_ADXT("DTOP")_ADXT("DSQ")_ADXT("FDT")
ALIVE ;
 ;;165.573^.02^FLEV^3^
