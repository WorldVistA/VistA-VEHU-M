SD53P206 ;BP-CIOFO/KEITH - Environment check ; 22 Nov 99  4:42 PM
 ;;5.3;Scheduling;**206**;AUG 13, 1993
 ;
ENV I DUZ(0)'="@" D
 .W !,$C(7),"     To insure that data dictionary changes contained in this patch",!,"     are installed correctly, DUZ(0) must be equal the ""@"" symbol!",!
 .S XPDQUIT=2 Q
 Q
