%AAHGLU ;402,DJB,3/24/92**Utility Routine - ZDELIM,Get File,Heading
 ;;GEM III;;
 ;;David Bolduc - Togus,ME
TRAN(X) ;Substitute ZDELIM with comma in subscript so I can check for $D.
 NEW ZDELIM,I,Y S ZDELIM=$C(127)_$C(124),Y=""
 F I=1:1:$L(X,ZDELIM) S Y=Y_$P(X,ZDELIM,I)_$S(I=$L(X,ZDELIM):"",1:",")
 Q Y
ZDELIM(SUB) ;Replace commas, spaces, and colons (if not between quotes) with variable ZDELIM, ZDELIM1, or ZDELIM2
 I $G(SUB)="" Q ""
 NEW CHK,CNTX,NEWSUB
 S (CHK,CNTX)=0,NEWSUB=$P($E(SUB,1,$L(SUB)-1),"(",2,99)
 F  S CNTX=CNTX+1 Q:$E(NEWSUB,CNTX)=""  S:$E(NEWSUB,CNTX)="""" CHK=CHK=0 I 'CHK D
 .I $E(NEWSUB,CNTX)="," S NEWSUB=$E(NEWSUB,1,CNTX-1)_ZDELIM_$E(NEWSUB,CNTX+1,99),CNTX=CNTX+1 Q
 .I $E(NEWSUB,CNTX)=" " S NEWSUB=$E(NEWSUB,1,CNTX-1)_ZDELIM1_$E(NEWSUB,CNTX+1,99),CNTX=CNTX+1 Q
 .I $E(NEWSUB,CNTX)=":" S NEWSUB=$E(NEWSUB,1,CNTX-1)_ZDELIM2_$E(NEWSUB,CNTX+1,99),CNTX=CNTX+1
 Q NEWSUB
GETFILE ;Select global by entering file name or number
 NEW DIC,GLOBAL,X,Y S ZGL=""
 I '$D(^DIC)!('$D(^DD)) W *7,"   Filemanager is not in this UCI." Q
 S DIC="^DIC(",DIC(0)="QEAM",DIC("A")=" Select FILE: " D ^DIC I Y<0 Q
 S GLOBAL=$G(^DIC(+Y,0,"GL")) I GLOBAL="" W *7,!?1,"^DIC(",+Y,",0,""GL"") is not defined." Q
GETFILE1 W !?13,"Global ",GLOBAL,"//"
 R ZGL:GEMTIME S:'$T ZGL="^" S:ZGL="" ZGL=GLOBAL I ZGL="^" S ZGL=""
 I $E(ZGL)="?" W !?1,"Enter <RETURN> for default global, or enter new global of your choice." G GETFILE1
 Q
HD ;Heading
 I $G(FLAGEDD)="EDD" Q  ;Global Lister called by EDD
 I $G(FLAGARR)="ARR" Q  ;Global Lister called by AE
 W !?1,"The Acme Global Lister . . . . . . . . GEM III . . . . . . . . David Bolduc"
 W !?1,"<RETURN>=Quit   <SPACE>=File Name or Number   ?=Help",!
 Q
