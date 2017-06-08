ADXTPCK ;523/KC routine to check matching of MRS ids ;11-AUG-93
 ;;1.1;;
 ;
 ; checks, reports discrepancies for matching, for ONCO PATIENT
 ; and ONCO PRIMARY entries.
EN ;
 N ADXT,ADXUNCPR,ADXUCNT,ADXUCPA,ADXUCPR,ADXUQCPR,ADXUDA,ADXUDAMN,ADXUDCLS,ADXUDDIS,ADXUDEXT,ADXUDGR,ADXUDID,ADXUDLYM,ADXUDMOR,ADXUDPR,ADXUDSQ,ADXUDSZT,ADXUDTOP,ADXUE,ADXUERR,ADXUESTR,ADXUI,ADXUIX,ADXUM,ADXUN,ADXUNAME
 N ADXUNCPA,ADXUNCPR,ADXUPID,ADXUPTR,ADXUQCPA,ADXUQCPR,ADXUREC,ADXUSSN,ADXUSTR,ADXUT,PFNM,PLNM,PMI,PSS,TEXT,ADXTX1,ADXTX2,ADXUVNM1,ADXUVNM2,ADXUNM1,ADXUNM2,ADXUDIX,ADXUVSSN,ADXUY,ADXUPRER
 ;
 F ADXUI=1:1 Q:$TEXT(TEXT+ADXUI)']""  W !?5,$P($TEXT(TEXT+ADXUI),";;",2)
 ;
 S ADXUPRER=20 ; % factor beyond which tumor discrepancies reported
 ;
 S (ADXUCPA,ADXUQCPA,ADXUNCPA,ADXUCPR,ADXUQCPR,ADXUNCPR)=0
 W !!,"Checking match of MRS ids to VA ONCO PATIENT entries..." D PAT
 W !!,"Checking match of MRS ids to VA ONCO PRIMARY entries..." D PRIMARY
EXIT ;
 W !!,"SUMMARY:",!
 W !,ADXUCPA," MRS patients looked at, ",ADXUNCPA," not matched, ",ADXUQCPA," were questionable."
 W !,ADXUCPR," MRS primaries looked at, ",ADXUNCPR," not matched, ",ADXUQCPR," were questionable."
 ;
 K ADXT,ADXUNCPR,ADXUCNT,ADXUCPA,ADXUCPR,ADXUQCPR,ADXUDA,ADXUDAMN,ADXUDCLS,ADXUDDIS,ADXUDEXT,ADXUDGR,ADXUDID,ADXUDLYM,ADXUDMOR,ADXUDPR,ADXUDSQ,ADXUDSZT,ADXUDTOP,ADXUE,ADXUERR,ADXUESTR,ADXUI,ADXUIX,ADXUM,ADXUN,ADXUNAME
 K ADXUNCPA,ADXUNCPR,ADXUPID,ADXUPTR,ADXUQCPA,ADXUQCPR,ADXUREC,ADXUSSN,ADXUSTR,ADXUT,PFNM,PLNM,PMI,PSS,TEXT,ADXTX1,ADXTX2,ADXUVNM1,ADXUVNM2,ADXUNM1,ADXUNM2,ADXUDIX,ADXUVSSN,ADXUY,ADXUPRER
 Q
PAT ; check PATIENT entries
 S (ADXUI,ADXUCNT)=0
 F  S ADXUI=$O(^TMP("ADXT","PAT",ADXUI)) Q:'+ADXUI  D
 .S ADXUREC=$G(^TMP("ADXT","PAT",ADXUI))
 .D VARPAT^ADXTPCK1(ADXUREC)
 .S ADXUCNT=ADXUCNT+1 ;I '+(ADXUCNT#10) W "+"
 .S ADXUDA=$$GTPP^ADXTUT(ADXUPID) I '+ADXUDA D  Q
 ..S ADXUNCPA=ADXUNCPA+1
 ..W !,ADXUPID," not matched with a VA entry!!"
 ..S ADXUI=ADXUI+1 Q  ; skip even nodes in ^TMP
 .S ADXUERR=$$CHKPAT^ADXTPCK1() I +ADXUERR S ADXUQCPA=ADXUQCPA+1
 .S ADXUI=ADXUI+1 Q  ; skip even nodes in ^TMP
 W !,ADXUCNT," MRS patient entries checked!" S ADXUCPA=ADXUCNT
 Q
 ;
PRIMARY ; check PRIMARY entries
 S (ADXUI,ADXUCNT)=0
 F  S ADXUI=$O(^TMP("ADXT","DI",ADXUI)) Q:'+ADXUI  D
 .K ADXT
 .S ADXTX1=$G(^TMP("ADXT","DI",ADXUI,1))
 .S ADXTX2=$G(^TMP("ADXT","DI",ADXUI,2)) D EN^ADXTADI1
 .S ADXUCNT=ADXUCNT+1 I '+(ADXUCNT#10) W "."
 .S ADXUDA=$$GTOPP^ADXTUT(ADXT("PID"),ADXT("DTOP"),ADXT("DSQ"))
 .I '+ADXUDA S ADXUNCPR=ADXUNCPR+1 D  Q
 ..W !,ADXT("PID"),ADXT("DTOP"),ADXT("DSQ")," not matched with a VA entry!!"
 .D VAR1PR^ADXTPCK1
 .S ADXUERR=$$CHKPR^ADXTPCK1(ADXUPRER) I +ADXUERR>ADXUPRER D  Q
 ..S ADXUQCPR=ADXUQCPR+1
 W !,ADXUCNT," MRS primary entries checked!" S ADXUCPR=ADXUCNT
 Q
TEXT ;
 ;;The following list of Oncology patients have different names in MRS
 ;;than they ended up with after the transfer to the VA Oncology package.
 ;;The matching from MRS to the VA was done by social security number,
 ;;not name. Therefore minor differences in the names can be expected.
 ;;Most of the mismatches below are probably from MINOR name differences.
 ;;Please check the following list for MAJOR differences between the VA
 ;;name and the MRS name, however. It is possible that a wrong social
 ;;security number in the MRS database might, rather than matching with
 ;;no VA entry, actually  match with the social security number of a 
 ;;different VA patient. The way to check is to scan this list for 
 ;;unusual name differences. If you find any actual mis-matches, you'll 
 ;;need to re-point the Oncology Patient entry in file #160 to the 
 ;;correct VA patient or lab referral entry.
