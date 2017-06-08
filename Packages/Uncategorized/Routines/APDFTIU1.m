APDFTIU1 ;PHI/KPM - Embedded Objects ;8/10/98
 ;;1.0;TEXT INTEGRATION UTILITIES;;Aug 10.1998
RELIG(DFN) ;Patient RELIGION
 I '$D(VADM(9)) D DEM^TIULO(DFN,.VADM)
 Q $S(VADM(9)]"":$P(VADM(9),"^",2),1:"Religious Preference UNKNOWN")
NEXTAPPT(DFN) ; -- entry point for next scheduled appointment
 N INFO
 D SDA^VADPT
 S INFO=$S($D(^UTILITY("VASD",$J,1,"E")):$P(^("E"),U)_" "_$P(^("E"),U,2),1:"No Future Appointments Scheduled")
 K ^UTILITY("VASD",$J)
 Q INFO
