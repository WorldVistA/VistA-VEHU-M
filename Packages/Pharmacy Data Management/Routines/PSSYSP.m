PSSYSP ;BIR/WRT-Pharmacy system site parameters routine ;Aug 15, 2021@14:55:34
 ;;1.0;PHARMACY DATA MANAGEMENT;**20,38,87,120,137,140,159,212,247,187**;9/30/97;Build 27
 ; CHANGE TYPE OF ORDER (FINISH) FROM OERR
 W ! S DIE="^PS(59.7,",DR="13;14;16;16.1;16.2;40.16;101;102;96",DA=1 D ^DIE
 K DIE,DA,DR W !
 Q
