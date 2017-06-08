ADXTADI5 ;523/KC stuff follow-up tumor status 165.573 ;07-MAY-1993
 ;;1.1;;
 ; (update TUMOR STATUS MULTIPLE -- when patient is deceased)
EN ;
 ; INPUT VARIABLES:
 ; ADXT(""): WHERE DIFFERENT MRS FIELD VALUES ARE STORED BY SUBSCRIPT
 ; ADXTDA: DA OF THE 165.5 ENTRY TO ADD TO
 ; ADXTFILE: text description of file adding entries to
 ; OUTPUT VARIABLES: NONE
 ;
 N ADXTFNUM,ADXTFLD,ADXTLINE,ADXTSBDA,ADXTSBF,ADXTI,X
 ;
 U IO
 S ADXTFNUM=165.5
 S ADXTFLD=73
 ;
 S ADXTPDA=$$GTPP^ADXTUT(ADXT("PID"))
 I '+ADXTPDA D  Q
 .W !!,"Could not match ",ADXT("PID")," to a patient. Not updating tumor status from follow-up!",!!
 ;
 ; if not deceased, don't stuff tumor status on DOD based on DPRE
 S X=$$DOD^ADXTUT(ADXTPDA) Q:'+X
 ;
 ; if deceased, make sure DATE@TIME OF DEATH field = MRS DATE OF DEATH
 ; before stuffing tumor status for deceased patient
 I $P($G(^ONCO(160,ADXTPDA,1)),"^",8)'=X D
 .S $P(^ONCO(160,ADXTPDA,1),"^",8)=X
 ;
 ; quit if conversion already ran
 Q:$D(^ONCO(165.5,ADXTDA,"TS","A523000","MRS DATE OF DEATH"))
 ;
 S ADXTSBDA=0
 I $D(^ONCO(165.5,ADXTDA,"TS","B",X)) D
 .S ADXTSBDA=$O(^ONCO(165.5,ADXTDA,"TS","B","X",0))
 I '+ADXTSBDA D ^ADXTMULT I +ADXTSBDA D  ; add conversionid since created
 .S ADXTLINE=$P($TEXT(ID+1),";;",2)
 .S ADXTSBF=$P(ADXTLINE,"^",2)
 .D ^ADXTEDIT
 I ADXTSBDA>0 D
 .S ADXTLINE=$P($TEXT(FIELDS+1),";;",2)
 .S ADXTSBF=$P(ADXTLINE,"^",2)
 .D ^ADXTEDIT
EXIT ;
 K ADXTFNUM,ADXTFLD,ADXTLINE,ADXTSBDA,ADXTSBF,X
 Q
 ;
 ; PIECE LISTING:
 ; ==============
 ; 1: VA file MRS var to be added into
 ; 2: VA field MRS var to be added into
 ; 3: MRS field to add
 ; 4: 3 or 4 for number of slashes to stuff, W for Word processing
 ; 5-50: input transform
ID ;
 ;;165.573^523000^DPRE^3^S X="MRS DATE OF DEATH"
FIELDS ;
 ;;165.573^.02^DPRE^3^
