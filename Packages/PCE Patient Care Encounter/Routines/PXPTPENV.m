PXPTPENV ; SLC/DLT -- Environment Check rtn ;1/10/94  12:56
 ;;1.0;PCE Patient/IHS Subset;;Nov 01, 1994
EN ; entry point
 I $S('($D(DUZ)#2):1,'($D(DUZ(0))#2):1,'DUZ:1,1:0) D  K DIFQ Q
 . W !!,$C(7),"DUZ and DUZ(0) must be defined as an active user."
 . W !,"Please sign-on before running PXPTINIT."
 I DUZ(0)'="@" D  K DIFQ Q
 . W !!,$C(7),"You must have programmer access <DUZ(0)=""@""> "
 . W !,"to run this init routine."
 S DIR("A")="Select Institution to be associated with Patient entries in 9000001"
 S DIR("B")=$P(^XMB(1,1,"XUS"),"^",17)
 S DIR(0)="P^4:QAMEZ" D ^DIR S PXPTLOC=+Y
 I $D(DIRUT) D  K DIFQ,DIR Q
 .K DIRUT,Y
 .W !," ! ! The name of the institution is necessary to continue ! !"
