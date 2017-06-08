ENLOG10 ;(WASH ISC)/DH-Merge LOG1 Records into 6914 ;3-26-92
 ;;;;
 ;CLASS 3 SOFTWARE - Not officially supported by the ISC's
 S U="^" S:'$D(DTIME) DTIME=600 S IOP="HOME" D ^%ZIS
 D ^ENLOG17 Q:$E(X)=U  K ENADLOG,ENADSPX
ADLOG W @IOF,!!,"Do you wish to automatically add new AEMS/MERS Equipment Records for LOG1",!,"entries that are not presently in AEMS/MERS " S %=2 D YN^DICN G:%<0 ABORT G:%=0 ADLOG
 I %=1 W *7,!,"Are you sure" S %="" D YN^DICN G:%'=1 ABORT S ENADLOG=1
ADSPX W @IOF,!!,"Do you wish to incorporate the LOG1 SPEX fields into your AEMS/MERS",!,"COMMENTS field" S %=2 D YN^DICN G:%<0 ABORT I %=0 D MSG1^ENLOG18 G ADSPX
 I %=1 S ENADSPX=1
 K EN D ^ENLOG14
 I '$D(EN) G ABORT ;User abort - No change to ENG global
 G:'$D(ENADLOG) MAIN
IEN S ENDA="" R !,"Starting EQUIPMENT ENTRY # for any new records: ",ENDA:DTIME I ENDA]"",ENDA'>$P(^ENG(6914,0),U,3) D MSG^ENLOG18 G IEN
 I ENDA>0 L ^ENG(6914,0) S $P(^ENG(6914,0),U,3)=ENDA L
IEN1 W !!,"Should LOG1 records costing less than $300 be added to AEMS/MERS" S %=2 D YN^DICN G:%<0 ABORT I %=0 W !,"   Answer (Y)ES or (N)O." G IEN1
 I %=2 S ENADLOG("CKCOST")=1
MAIN W !!,"Need to check something.  Be right with you...",! S ENRR=0 F I=1:1:500 W:'(I#20) "." I $D(^ENZ(6914.5,I,31)) Q:$P(^(31),U,2)=1
 I $D(^ENZ(6914.5,I,31)),$P(^(31),U,2)=1 D RERUN G:X="^" ABORT
 W *7,!!,"** Merger of LOG1 data with AEMS/MERS is about to begin. **",!!,"Is everything OK" S %="" D YN^DICN I %'=1 G ABORT
 W !!,"LOG1 to AEMS/MERS Data Conversion now in progress" F ENLOG=0:0 S ENLOG=$O(^ENZ(6914.5,ENLOG)) Q:ENLOG'>0  I $P(^ENZ(6914.5,ENLOG,0),U,2)]"" D BRANCH W:'(ENLOG#10) "."
 I $D(ENADLOG),ENDA>0 L ^ENG(6914,0) S ENDA=$P(^ENG(6914,0),U,3)+1,ENDA=(ENDA\1000)+1*1000 S $P(^ENG(6914,0),U,3)=ENDA L
 W !!,"Done.  You should now re-index your Equipment File by:"
CONT W:$D(EN("PO"))!($D(ENADLOG)) !,?10,"PURCHASE ORDER # ('M' INDEX ONLY),"
 W:$D(EN("CSN"))!($D(ENADLOG)) !,?10,"CATEGORY STOCK NUMBER ('J' INDEX ONLY),"
 W:$D(EN("SN"))!($D(ENADLOG)) !,?10,"SERIAL NUMBER ('F' INDEX ONLY),"
 W:$D(EN("CMR"))!($D(ENADLOG)) !,?10,"CMR ('AD' INDEX ONLY),"
 W !,?10,"NXRN ('I' INDEX)."
 ;Clean up the campground
 K EN,ENA,ENDA,ENLOG,ENMERS,ENNXRN,ENCMR,ENUSE,ENOWN,ENB,ENSN,ENY
 K ENPO,ENAD,ENCOST,ENLIFE,ENRD,ENCSN,ENDM,ENSORC,ENSPEX,ENCNT,ENFLG
 K I,J,I1
 G EXIT
 ;
BRANCH I $D(^ENZ(6914.5,ENLOG,31)) Q:$P(^(31),U)=1  I $P(^(31),U,2)=1,'ENRR Q
 I $P(^ENZ(6914.5,ENLOG,0),U,3)="" S ENPMN=$P(^(0),U,2) I $D(^ENG(6914,"C",ENPMN)) S $P(^ENZ(6914.5,ENLOG,0),U,3)=$O(^ENG(6914,"C",ENPMN,0))
 I $P(^ENZ(6914.5,ENLOG,0),U,3)="" D:$D(ENADLOG) ^ENLOG12 Q
 S ENMERS=$P(^ENZ(6914.5,ENLOG,0),U,3) D:$D(^ENG(6914,ENMERS)) ^ENLOG11
 Q
 ;
RERUN W !!,"Looks as though this file merger has been run before."
 W !,"When we encounter LOG1 Equipment Records that have already been merged",!,"into AEMS/MERS, should we skip over them or re-process them?"
RERUN1 W !!,"'S' for SKIP, 'R' for RE-PROCESS: S// " R X:DTIME S:$L(X)>1 X=$E(X) I "SRsr^"'[X W !!,*7,"Enter 'S' to skip processed records, 'R' to re-process them, '^' to escape." G RERUN1
 S:"Rr"[X ENRR=1
 Q
 ;
ABORT W !!,"Conversion has been aborted.  DATA BASE IS UNCHANGED."
EXIT K ENADLOG,ENADSPX,ENLDGR,ENRR
 Q
 ;ENLOG10
