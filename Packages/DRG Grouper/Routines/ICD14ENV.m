ICD14ENV ;SSI/ALA-Environment check for ICD v14 ;[ 05/28/97  6:51 PM ]
 ;;14.0;DRG Grouper;;Apr 03, 1997
 ;
EN S ICDVER=$$VERSION^XPDUTL("ICD")
 S ICDPT=$$PATCH^XPDUTL("ICD*13.0*1")
 I +ICDVER=13,ICDPT'=1 S XPDQUIT=1 D  Q
 . W !!,"*** Patch ICD*13.0*1 must be installed prior to loading v. 14.0."
 . W !!,"This install will now abort."
 W !!,">> Environment check complete and okay."
 K ICDVER,ICDPT
 Q
