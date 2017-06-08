QAC3ENV ;WCIOFO/ERC-ENVIRONMENTAL CHECK FOR PATCH QAC*2*3 ;9/29/97 @15:41
 ;;2.0;Patient Representative;**3**;7/25/95
 ; Routine will check that field #2 of file #745.2 is editable.
 K XPDQUIT
 I $P($G(^DD(745.2,2,0)),U,2)["I" D
 . W !!,"The NAME field of the CONTACT ISSUE CODE file (field #2 of file"
 . W !,"#745.2) is uneditable.  You cannot install this patch unless "
 . W !,"this field is editable.  Please check the Installation Instructions."
 . W !,"and then re-install."
 . S XPDQUIT=2
 Q
