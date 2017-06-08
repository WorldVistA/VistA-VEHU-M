DGYPBT1 ;ALB/SCK - CHECK FOR INCOMPLETE DATA IN bt DISTANCE FILE ;4/6/93
 ;;5.2;REGISTRATION;**27**;JUL 29,1992
 Q
START ;
 S ERR=0 K DIC,DIOBEG
 W @IOF
 F XX=1:1:7 W !?10,$P($T(TEXT+XX),";",3)
START1 ;
 W !!?10,"Continue with reports"
 S %=1 D YN^DICN I %=0 W !?5,"Enter either 'Y'es or 'N'o" G START1
 Q:%'=1
CHECK1 ;  check for missing state identifiers and zip codes
 W !!,"Check for Missing state identifiers and zip codes"
 D YESNO G:%'>0 EXIT  G:%'=1 REMARKS
 S DIC="^DGBT(392.1,",DIC(0)="EMZ",L=0,FLDS=".01;L25,2;L20,4",BY=".01",(FR,TO)=""
 S DIS(1)="I $P($G(^DGBT(392.1,D0,0)),U,4)']""""!($P($G(^(0)),U,2)']"""")"
 S DHD="File entries which are missing either State identifiers or Zip codes"
 S DIOEND="D CHKMSG^DGYPBT1"
 D EN1^DIP K DIC,DIOEND
REMARKS ;  list cities and divisions with incomplete additional information, screening on remarks and add'l flag
 W !!!,"Check for Cities with additional information field set"
 D YESNO G:%'>0 EXIT  G:%'=1 MILES
 S DIC="^DGBT(392.1,",DIC(0)="EMZ",L=0,BY=".01",FLDS=".01;L25,2;L20,5",(FR,TO)=""
 S DIOEND="D RMK^DGYPBT1"
 S DHD="Records showing the ADDITIONAL INFORMATION field as set to 'Y'es"
 S DIS(1)="I $P($G(^DGBT(392.1,D0,0)),U,5)=1"
 D EN1^DIP K DIC,DIOEND
MILES ;  list those cities that have a null default mileage
 W !!!,"Check for Cities that have a 0 default mileage"
 D YESNO G:%'=1 EXIT
 S DIC="^DGBT(392.1,",DIC(0)="EMZ",L=0,DIS(1)="I $P($G(^DGBT(392.1,D0,0)),U,3)']""""",DIS(2)="I $P($G(^DGBT(392.1,D0,0)),U,3)=0"
 S BY=".01",FLDS=".01;S;L25,2;L20,4;R9,3",DIOEND="D MILMSG^DGYPBT1"
 S (FR,TO)="",DHD="Incomplete mileage information" D EN1^DIP K DIC,DIOEND
EXIT ;
 L -^DGBT(392.1)
 K DIC,TO,FLDS,DHD,L,FR,DIS,DIC,BY,DIS,%,ERR,XX,DIOEND
 Q
YESNO ;
 S %=2 D YN^DICN I %=0 W !?5,"Enter either 'Y'es or 'N'o" G YESNO
 Q
RMK ;
 W !!,"The Claims which have the ADDITIONAL INFORMATION field set to true,"
 W !,"will require you to either change the ADDITIONAL INFORMATION field through",!,"a VA FileMan edit before updating to v5.3, or enter the Distance Enter/Edit"
 W !,"option of BENEFICIARY TRAVEL after updating to v5.3 and set the ADDITIONAL"
 W !,"INFORMATION field to 'N'o.  If there are specific reasons why this is set,",!,"you should enter the Distance Enter/Edit option after converting to v5.3"
 W !,"and add the appropriate remarks to the REMARK Field."
 Q
MILMSG ;
 W !!,"You will be required to enter the BENEFICIARY TRAVEL DISTANCE FILE, #392.1,",!,"through the BENEFICIARY TRAVEL DISTANCE Enter/Edit option and enter the"
 W !,"proper one-way mileage value.  This mileage will be used in the later",!,"conversion of the BENEFICIARY TRAVEL DISTANCE file, #392.1"
 Q
CHKMSG ;
 W !!,"For any missing State Identifiers or Zip Codes, you will be required to enter",!,"the BENEFICIARY TRAVEL DISTANCE Enter/Edit option and enter the missing States"
 W !,"and Zip Codes to the BENEFICIARY TRAVEL DISTANCE file, #392.1, before the",!,"data conversion"
 Q
TEXT ;
 ;;Report of Incomplete data in BENEFICIARY DISTANCE File
 ;;
 ;;There are three VA FileMan reports available to show the status
 ;;of incomplete data in the BENEFICIARY TRAVEL DISTANCE file.
 ;;These are missing zipcodes, 0 distance mileage as the default,
 ;;and the Additional Information set to 'YES', which will look
 ;;for a remarks field in the new data structure.
