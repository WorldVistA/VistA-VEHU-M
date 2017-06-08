ENXUIEN ;WIRMFO/SAB- ENVIRONMENTAL CHECK ;1/8/97
 ;;7.0;ENGINEERING;**41**;Aug 17, 1993
 I $G(XPDENV) D  ; install package option
 . I '$D(^ENG("MFG",3000,0)) D
 . . S XPDQUIT=2
 . . W !,"Your Manufacturer List File (#6912) does not contain expected"
 . . W !,"entries. You will need to contact your supporting IRM Field"
 . . W !,"Office and request a KIDS installation containing the first"
 . . W !,"3000 entries in the national portion of this file."
 . . W !,"After installing the first 3000 entries, you can install"
 . . W !,"patch EN*7*41 to add the more recent entries."
 . . W !," "
 . . W !,"Do to size considerations, Patch EN*7*41 only includes entries"
 . . W !,"that were added to the national portion of the Manufacturer"
 . . W !,"List file during the last 5 years. All sites were expected"
 . . W !,"to already have earlier Manufacturer entries that were"
 . . W !,"previously exported as part of the Engineering package."
 Q
 ;ENXUIEN
