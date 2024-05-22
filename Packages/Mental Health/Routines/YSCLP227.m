YSCLP227 ;BAH/MBS - Pre/Post-Install logic for YS*5.01*227 patch ; Jun 08, 2023@12:13
 ;;5.01;MENTAL HEALTH;**227**;Dec 30, 1994;Build 17
 ;
 Q
POST ; Post-install logic
 N YSFDA
 S YSFDA(603.03,"1,",12)=-30
 S YSFDA(603.03,"1,",13)=74
 D FILE^DIE(,"YSFDA")
 Q
