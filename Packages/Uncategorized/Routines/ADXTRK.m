ADXTRK ;523/RES ; SETUP CALL TO RECEIVE^XTKERMIT       ;SEP 21, 1992
 ;;1.1;;
 ;
 S U="^"
 W !,"The parameters for Kernal Kermit are:"
 W !!,"CONTROL QUOTE CHARACTER           35 (ASCII)"
 W !,"MAXIMUM PACKET SIZE               94"
 W !,"PAD CHARACTER                     32 (ASCII)"
 W !,"NUMBER OF PAD CHARACTERS           0"
 W !,"8TH BIT QUOTE CHARACTER           38 (ASCII)"
 W !,"HANDSHAKE CHARACTER                0"
 W !,"END OF LINE CHARACTER             13 (ASCII)"
 W !,"FILE TYPE                         BINARY"
 W !,"BLOCK CHECK TYPE                   1 BYTE CHECKSUM"
 W !,"BLOCK START CHARACTER              1 (ASCII)",!!!
 S DIR(0)="Y",DIR("A")="OK to start Kermit ",DIR("B")="Y" D ^DIR Q:Y=0
START ;
 ;
 W !!,"Please prepare to send: ",!,"PATFILE.T01, SCDFILE.T01, DOCFILE.T01, DAGFILE.T01, or FLWFILE.T01.",!
 K DIC,DD,DO S XTKERR=1,DLAYGO=8980,DIC="^DIZ(8980,",DIC(0)="",X="XXX",DIC("DR")="1///NOW;2///Y;3///TEXT" D FILE^DICN Q:Y'>0
 S XTKDA=+Y,XTKFILE=$P(Y,U,2) S Y(0)=^DIZ(8980,XTKDA,0)
 S XTKERR=0,XTKDIC="^DIZ(8980,"_XTKDA_",2,",XTKR("RFN")=$P(Y(0),U,3),XTKMODE=$P(Y(0),U,4)
 S @(XTKDIC_"0)")="" K DIC,DIE,DA,DR
 D RECEIVE^XTKERMIT
 K DWLC,XTKDIC,XTKMODE
 S DIR(0)="Y",DIR("A")="Do you have another file to upload?",DIR("B")="Y"
 D ^DIR Q:Y=0
 G START
 Q
