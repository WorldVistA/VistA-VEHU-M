QAQDIU ;WCIOFO/ERC - Delete obsolete file 513.8  ;2/19/98
 ;;1.7;Integration Module;**4**;07/25/1995
 ;This routine deletes files 513.8 (Utilization Review File)
 ;and 513.85 (Utilization Review Configuration), their 
 ;subfiles and the associated templates.
 ;These were used in the Utilization Review package, which
 ;was replaced in 1992.
 ;
 N DIU
 S DIU="^PRMQ(513.8,",DIU(0)="TSD"
 D EN^DIU2
 S DIU="^PRMQ(513.85,",DIU(0)="TSD"
 D EN^DIU2
 Q
