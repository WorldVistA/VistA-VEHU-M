XUS8P788 ;BP/BDT - set locks for options; Aug 02, 2023@06:28:12
 ;;8.0;KERNEL;**788**;Jul 10, 1995;Build 2
 ;Per VA Directive 6402, this routine should not be modified.
 ;Post routine for XU*8*788
 Q
 ;
POST ; Post rouitne for XU*8*788
 D SETAUDTS
 Q
 ;
BACKOUT ; backout patch section. This wil be rollback the original data before the patch.
 D BACKOUTF
 Q
 ;
SETAUDTS ; set AUDIT for FILES/FIELDS
 N XUI S XUI=""
 K ^XTMP("XU788 KERNEL PATCH FILES")
 F XUI=1:1:100 S XUFILE=$T(FILES+XUI) Q:$P(XUFILE,";;",2)="$$END"  D
 . D SETAUDT($P(XUFILE,";;",2),$P(XUFILE,";;",3),"y")
 . Q
 Q
 ;
SETAUDT(XUFILE,XUFIELD,KFL) ;set Audit for a field
 ;XUFILE = file number
 ;XUIELD = field number
 ;---------------------
 N XUI,XUY,XUF S XUI=""
 F XUI=1:1:100 S XUF=$P(XUFIELD,";",XUI) Q:XUF=""  D
 . S ^XTMP("XU788 KERNEL PATCH FILES",$J,XUFILE,XUF)=$G(^DD(XUFILE,XUF,"AUDIT"),"n")
 . DO TURNON^DIAUTL(XUFILE,XUF,KFL)
 . Q
 Q
 ;
BACKOUTF ; backout Audit fields
 N XUI S XUI=""
 K ^XTMP("XU788 KERNEL PATCH FILES")
 F XUI=1:1:100 S XUFILE=$T(FILES+XUI) Q:$P(XUFILE,";;",2)="$$END"  D
 . D SETAUDT($P(XUFILE,";;",2),$P(XUFILE,";;",3),"n")
 . Q
 Q
 ;
PRINTFLS ;backing up patch data for the listed AUDIT files/fields
 N XUI,XUY,XUFILE S XUI=""
 F XUI=1:1:100 S XUFILE=$T(FILES+XUI) Q:$P(XUFILE,";;",2)="$$END"  D
 . D PRINTFL($P(XUFILE,";;",2),$P(XUFILE,";;",3))
 Q
 ;
PRINTFL(XUFILE,XUFIELDS) ;backing up patch data for a AUDIT single file/fields
 N XUI,XUY S XUY=""
 F XUI=1:1:100 S XUFIELD=$P(XUFIELDS,";",XUI) Q:XUFIELD=""  D
 . W !,"FILE:  ",?8,XUFILE,?15," FIELD  :",XUFIELD
 . W ?30,"AUDIT SET: ",$G(^DD(XUFILE,XUFIELD,"AUDIT"),"n")
 Q
 ;
FILES ; List files and field to set AUDIT
 ;;8989.3;;.01;9;9.8;9.81;11;11.2;21;30.1;31.1;31.2;31.3;41;51;202;203;204;205;206;207;209;210;211;214;217;218;219;220;230;320;320.2
 ;;3.5;;.01;.02;1;3
 ;;14.7;;.01;2;3;4;5;6;7;8;9;11;12;13;21
 ;;14.5;;.01;.1;1;2;3;4;5;6;7;8;9;10
 ;;200;;2;3;7;7.2;9.2;9.4;11;30;31.1;32;51;200.1
 ;;$$END;;
 ;
