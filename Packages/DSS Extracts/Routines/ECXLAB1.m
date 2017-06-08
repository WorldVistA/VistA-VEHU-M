ECXLAB1 ;BIR/CML-Driver Routine for DSS Lab Extract; [ 03/20/97  11:54 AM ]
V ;;2.0T11;DSS EXTRACTS;**21**;DEC 18,1996
 I '$O(^ECX(728,0)) W $C(7),!!,"You have not yet defined your facility in the DSS Extract file (#728)!" G QUIT
 ;Check for LMIP flag (field .5) in DSS EXTRACT file (#728), if "1" go immediately to new LAB format in ^ECXLABN
 I $G(^ECX(728,1,"LMIP")) G ^ECXLABN
 S $P(LN,"-",80)=""
MSG W $C(7),@IOF,!,LN,!,"     ARE YOU COMPLETELY READY TO SEND LMIP CODES FOR DSS LAB FEEDER KEYS?      ",!,LN
 W !!,"To answer ""YES"" to this question, Lab CO directives for LMIP MUST have"
 W !,"been completed at your facility. This means that your Lab Service must"
 W !,"have matched all entries in the LABORATORY TEST file (#60) to an LMIP"
 W !,"code.  After this is accomplished, you are ready to send LMIP codes to"
 W !,"DSS for your initial LAB Feeder Key Values."
 W !!?30,"**IMPORTANT NOTES**",!,"- Once you answer ""YES"" to send LMIP Codes, you will not be asked this"
 W !,"  question again. This and all future LAB extracts will send LMIP Codes."
 W !,"- Answering ""NO"" will generate DSS LAB data with local feeder key values"
 W !,"  (not LMIP codes)."
 W !,"- If you are not sure, enter an ""^"" at the next prompt and check with"
 W !,"  your LAB ADPAC or LAB Service before continuing."
ASK3 ;
 W ! K DIR D HELP S DIR(0)="Y",DIR("A")="Are you ready to send LMIP codes",DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT) QUIT
 I 'Y W !!,"Your LAB Extract data will be generated without LMIP Codes." H 2 K LN,X,Y G ^ECXLABO
 W !!,"Your LAB Extract data will be generated with LMIP Codes." H 2 K LN,X,Y S ^ECX(728,1,"LMIP")=1 G ^ECXLABN
QUIT K %H,DTOUT,DUOUT,DIRUT,DIROUT,LN,X,Y Q
HELP ;
 S DIR("?",1)="   Enter:"
 S DIR("?",2)="     ""YES"" if you are ready to send LMIP codes,"
 S DIR("?",3)="      ""NO"" to use local feeder key values (not LMIP Codes),"
 S DIR("?")="       ""^"" to exit option."
 Q
SETUP ;
 I $G(^ECX(728,1,"LMIP")) D SETUP^ECXLABN Q
 D SETUP^ECXLABO Q
