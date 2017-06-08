APUVEXE ; 648/BFD BUILD RENEWAL MAIL MESSAGE FOR MAIL GROUP ; 3-9-07
 ;;5.0; PORTLAND,OR APPLICATION
 ;
 ; VA Utilities for MAudio Care (renewals) 
 ;  INCLUDES CHANGES TO MAKE NEW VEXRX (BAY PINES) WORK
 ;
 ; 3-9-07 Changed APUVEX2 to call FM sections from here.  After run today, remove them from APUVEX2 so clear SACC
 ;
 ; 3-26-07:  Remove sections of code not needed.  This routine is just for FM build.  Now called from
 ;  APUVEXN, APUVEX2, APUVEXU
 ;
 ; 4-11-07:  note this routine is called by other APUVEX* routines so can note the renewal requests that require human intervention and
 ;  could not be sent directly to the provider
 ;
FM0 ; 9-15-04 - If this, then Rx not from pts PCP/MHPCP & program set to only accept PCP/MHPCP
 ;W !,"Came to FM0 because order not signed by PC/MHPCP and parameter is 'P'"
 I TYPE'="N" D
 . S MAFBFD(CNT)=PTNM_" ("_LST4_")        "_DRGNM_"        **"_PROVNM
 . S MMDAT=1
 . S CNT=CNT+1
 . S MAFBFD(CNT)="   **Not patient's PCP or MHPCP"
 . S CNT=CNT+1
 . S NPCP=NPCP+1,MMCONT=1
 .Q
 ;  
 I TYPE="N" D
 . S MAFBFD(CNT)=PTNM_" ("_LST4_")        **"_DRGNM_"        **"_PROVNM
 . S MMDAT=1
 . S CNT=CNT+1
 . S MAFBFD(CNT)="   **Drug not allow auto renewal AND provider is not patient's PCP or MHPCP"
 . S CNT=CNT+1
 . S NPCPDN=NPCPDN+1,MMCONT=1
 .Q
 Q
 ;
FM1 ; Fee Basis patient - must also note that drug not allow auto renewal
 I TYPE="N" D
 . S MAFBFD(CNT)=PTNM_" ("_LST4_")    **"_DRGNM_"        **Verify Correct Contact"
 . S MMDAT=1
 . S CNT=CNT+1
 . S MAFBFD(CNT)="   **Fee Basis Patient and Drug not allow auto renewal"
 . S CNT=CNT+1
 . S FBKTRDN=FBKTRDN+1,MMCONT=1
 . Q
 I TYPE'="N" D
 . S MAFBFD(CNT)=PTNM_" ("_LST4_")      "_DRGNM_"        **Verify Correct Contact"
 . S MMDAT=1
 . S CNT=CNT+1
 . S MAFBFD(CNT)="   **Fee Basis Patient"
 . S CNT=CNT+1
 . S FBKTR=FBKTR+1,MMCONT=1
 . Q
 Q
 ;
FM2 ; Provider  has been disabled - check if must also note that drug not allow auto renewal
 I TYPE="N" D
 . S MAFBFD(CNT)=PTNM_" ("_LST4_")      **"_DRGNM_"        **"_PROVNM
 . S MMDAT=1
 . S CNT=CNT+1
 . S MAFBFD(CNT)="   **Drug not allow auto renewal AND Provider has been 'disabled'"
 . S CNT=CNT+1
 . S PTERMDN=PTERMDN+1,MMCONT=1
 .Q
 I TYPE'="N" D
 . S MAFBFD(CNT)=PTNM_" ("_LST4_")        "_DRGNM_"         **"_PROVNM
 . S MMDAT=1
 . S CNT=CNT+1
 . S MAFBFD(CNT)="   **Provider has been 'disabled.' "
 . S CNT=CNT+1
 . S PTERM=PTERM+1,MMCONT=1
 . Q
 Q
 ;
FM3 ; Human intervention since vet called in so not communicate with provider, kt and quit
 ;  11-10-04:  took out provider name because not looking at order to find out prov vs signed by
 ;             and in sample case a surrogate had signed previous order
 ; 11-23-04:  since mail group does not need to know, don't add to mail message.  
 ; Add to counters for my mail message but leave code for testing purposes (if test, change fm3 to I "n")
 I TYPE="N" S HACTDN=HACTDN+1
 I TYPE'="N" S HACT=HACT+1
 Q
 ; 
 ;W !,"In FM3 because of human intervention since vet called"
 I TYPE="N" D
 . S MAFBFD(CNT)=PTNM_" ("_LST4_")      **"_DRGNM_"           "_"Not captured"
 . S CNT=CNT+1
 . S MAFBFD(CNT)="   ****Action taken on prescription since vet called.  No 'auto' activity taken (Drug not allow auto renewal)"
 . S CNT=CNT+1
 . S HACTDN=HACTDN+1,MMCONT=1
 .Q
 I TYPE'="N" D
 . S MAFBFD(CNT)=PTNM_" ("_LST4_")        "_DRGNM_"           "_"Not captured"
 . S CNT=CNT+1
 . S MAFBFD(CNT)="   **Action taken on prescription since vet called.  No 'auto' activity taken"
 . S CNT=CNT+1
 . S HACT=HACT+1,MMCONT=1
 . Q
 Q
 ;       
FM4 ; Problem from Rob's order program
 ;W !,"Came to FM4 because there was some problem w/order using as sample"
 I TYPE="N" D
 . S MAFBFD(CNT)=PTNM_" ("_LST4_")    **"_DRGNM_"        **"_PROVNM
 . S MMDAT=1
 . S CNT=CNT+1
 . S MAFBFD(CNT)="   **Cannot Create Unsigned Notification - Review Previous Order Using As Template"
 . S CNT=CNT+1
 . S MAFBFD(CNT)="(Drug not allow auto renewal)"
 . S CNT=CNT+1
 . S ORDPDN=ORDPDN+1,MMCONT=1
 . Q
 I TYPE'="N" D
 . S MAFBFD(CNT)=PTNM_" ("_LST4_")      "_DRGNM_"        **"_PROVNM
 . S MMDAT=1
 . S CNT=CNT+1
 . S MAFBFD(CNT)="   ***Cannot Create Unsigned Notification - Review Previous Order Using As Template"
 . S CNT=CNT+1
 . S ORDP=ORDP+1,MMCONT=1
 . Q
 Q
 ;
FM5 ; 9-15-04 - Vet not have PCP/MHPCP assigned & program set to only accept PCP/MHPCP
 ;W !,"Came to FM5 because vet not have a PCP/MHPCP & parameter is 'P'"
 S PROV=$P(^PSRX(PRESC,0),"^",4),PROVNM=$P(^VA(200,PROV,0),"^",1),PROVNM=$E(PROVNM,1,15)
 I TYPE'="N" D
 . S MAFBFD(CNT)=PTNM_" ("_LST4_")        "_DRGNM_"        **"_PROVNM
 . S MMDAT=1
 . S CNT=CNT+1
 . S MAFBFD(CNT)="   **Not patient's PCP or MHPCP (patient not have either one assigned)"
 . S CNT=CNT+1
 . S NPCPA=NPCPA+1,MMCONT=1
 .Q
 ;  
 I TYPE="N" D
 . S MAFBFD(CNT)=PTNM_" ("_LST4_")        **"_DRGNM_"        **"_PROVNM
 . S MMDAT=1
 . S CNT=CNT+1
 . S MAFBFD(CNT)="   **Drug not allow auto renewal AND provider is not patient's PCP or MHPCP"
 . S CNT=CNT+1
 . S MAFBFD(CNT)="       (patient not have either PCP or MHPCP assigned)"
 . S CNT=CNT+1
 . S NPCPADN=NPCPADN+1,MMCONT=1
 .Q
 Q
 ;
FM6 ; Drug is inactive - msg to mail group is the same but have one ktr for 'N' and one for not 'N'
 S PROV=$P(^PSRX(PRESC,0),"^",4),PROVNM=$P(^VA(200,PROV,0),"^",1),PROVNM=$E(PROVNM,1,15)
 S MAFBFD(CNT)=PTNM_" ("_LST4_")        "_DRGNM_"        **"_PROVNM
 S MMDAT=1
 S CNT=CNT+1
 S MAFBFD(CNT)="   ** Drug is Inactive **"
 S CNT=CNT+1
 I TYPE'="N" S DINACT=DINACT+1,MMCONT=1
 I TYPE="N" S NDINACT=NDINACT+1,MMCONT=1
 Q
 ;
FM7 ; The 'placer order' is no longer in 100 for Rob's program to use as template
 S ISDT=0,Y=$P(^PSRX(PRESC,0),"^",13) D DD^%DT S ISDT=Y K Y
 S PROV=$P(^PSRX(PRESC,0),"^",4),PROVNM=$P(^VA(200,PROV,0),"^",1),PROVNM=$E(PROVNM,1,15)
 S MAFBFD(CNT)=PTNM_" ("_LST4_")        "_DRGNM_"        **"_PROVNM
 S MMDAT=1
 S CNT=CNT+1
 S MAFBFD(CNT)=" ** Issued: "_ISDT_".  Order no longer available for auto program"
 S CNT=CNT+1
 I TYPE'="N" S DISDT=DISDT+1,MMCONT=1
 I TYPE="N" S NDISDT=NDISDT+1,MMCONT=1
 Q
