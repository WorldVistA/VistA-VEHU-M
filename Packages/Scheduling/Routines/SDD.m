SDD ;SF/GFT,ALB/BOK,JSH,LDB,JAS - REMAP A CLINIC ; 24 Jan 2024  12:15 PM
 ;;5.3;Scheduling;**871**;Aug 13, 1993;Build 13
 ;;Per VHA Directive 6402, this routine should not be modified
 W !,"REMAP will set the patterns for the holiday if the clinic was set up",!,"to not schedule on Holidays",!,"REMAP should always be done if a clinic is changed from not scheduling",!,"on holidays to schedule on holidays"
CL W !! D LO^DGUTL D ASK2^SDDIV G:Y<0 END S VAUTNI=1 D CLINIC^VAUTOMA G:Y<0 END
DT D DATE^SDUTL G:POP END S DGVAR="SDBD^SDED^VAUTD#^VAUTC#^DUZ^ENDDATE",DGPGM="START^SDD"
 D ZIS^DGUTQ G:POP END
 ; VSE-5278 - JAS - SD*5*3*871 - Replaced $N's in next line with $O's per VistA SAC guidelines
START D:'$D(DT) DT^SDUTL S (YP,PG,SD,SDU)=0,Y=DT X ^DD("DD") S DAT=Y D HD
 F SCI=0:0 S SD=$S(VAUTC:$O(^SC("B",SD)),1:$O(VAUTC(SD))) Q:SD=""  S SC=0 F SCC=0:0 S SC=$O(^SC("B",SD,SC)) Q:'SC  S SD0=^SC(SC,0) I $P(SD0,U,3)="C" S SDNM=SD D SETX^SDD0 G:SDU END
END K %,%DT,DATE,DAY,DH,DOW,DR,DR1,HSI,I,P,POP,S,SB,SC,SDAPPT,SDAPPT1,SDBD,SDNM,SDED,SDHOL,SD0,SDIN,SDRE,SDRE1,SDSAVX,SDSL,SDSOH,SI,SM,SS,SD,SCI,SCC,ST,STARTDAY,STR,X,MSG,Y,YP,PG,DGVAR,DGPGM,VAUTD,VAUTC,SDU,BEGDATE,ENDDATE D CLOSE^DGUTQ Q
ESC S SDU=0 I $E(IOST,1,2)="C-" W *7 R ESC:DTIME S:U=ESC SDU=1
HD U IO S PG=PG+1 W @IOF,!,DAT,?30,"Clinic Remap Function",?70,"pg ",PG,!!?5,"Clinic Name",?27,"Clinic Date",?50,"Remark",!?5,"-----------",?27,"-----------",?50,"------",! S YP=4 Q
