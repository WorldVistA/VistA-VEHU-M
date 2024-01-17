PSOERX1H ;ALB/MFR - eRx Holding Queue Rx View INIT section Cont. ;Aug 14, 2020@12:43:34
 ;;7.0;OUTPATIENT PHARMACY;**700**;DEC 1997;Build 261
 ;
DEANOTE ; DEA Note for CS Digitally Signed eRx records
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"This prescription meets the requirements of the Drug Enforcement Administration")
 S LINE=LINE+1 D SET^VALM10(LINE,"(DEA) electronic prescribing for controlled substances rules (21 CFR Parts 1300,")
 S LINE=LINE+1 D SET^VALM10(LINE,"1304, 1306, & 1311).")
 Q
