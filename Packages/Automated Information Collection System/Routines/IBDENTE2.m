IBDENTE2 ;ISC/XTSUMBLD KERNEL - Package checksum checker ;2960528.111934
 ;;0.0;
 ;;7.3;2960528.111934
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 G CONT^IBDENTE3
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
IBDEI0CO ;;3600285
IBDEI0CP ;;3621530
IBDEI0CQ ;;3636582
IBDEI0CR ;;3625845
IBDEI0CS ;;3753018
IBDEI0CT ;;3734012
IBDEI0CU ;;3664620
IBDEI0CV ;;3723980
IBDEI0CW ;;3772319
IBDEI0CX ;;3734101
IBDEI0CY ;;3897080
IBDEI0CZ ;;3696188
IBDEI0D0 ;;3628802
IBDEI0D1 ;;3713703
IBDEI0D2 ;;3716175
IBDEI0D3 ;;3784843
IBDEI0D4 ;;4088578
IBDEI0D5 ;;3811940
IBDEI0D6 ;;3791750
IBDEI0D7 ;;3719034
IBDEI0D8 ;;3844169
IBDEI0D9 ;;3840184
IBDEI0DA ;;3616976
IBDEI0DB ;;3618601
IBDEI0DC ;;3683442
IBDEI0DD ;;3701514
IBDEI0DE ;;3626690
IBDEI0DF ;;3639973
IBDEI0DG ;;3726691
IBDEI0DH ;;3807580
IBDEI0DI ;;3665909
IBDEI0DJ ;;3696034
IBDEI0DK ;;3590070
IBDEI0DL ;;3753312
IBDEI0DM ;;3672780
IBDEI0DN ;;3867966
IBDEI0DO ;;3736018
IBDEI0DP ;;3655119
IBDEI0DQ ;;3592551
IBDEI0DR ;;3606319
IBDEI0DS ;;3619516
IBDEI0DT ;;3630401
IBDEI0DU ;;3848049
IBDEI0DV ;;3666888
IBDEI0DW ;;3698815
IBDEI0DX ;;3659954
IBDEI0DY ;;3690783
IBDEI0DZ ;;3899485
IBDEI0E0 ;;3673165
IBDEI0E1 ;;3595524
IBDEI0E2 ;;3644774
IBDEI0E3 ;;3708012
IBDEI0E4 ;;3653835
IBDEI0E5 ;;3643483
IBDEI0E6 ;;3600110
IBDEI0E7 ;;3756617
IBDEI0E8 ;;3575830
IBDEI0E9 ;;3711571
IBDEI0EA ;;1418679
IBDEI0EB ;;3787583
IBDEI0EC ;;3493869
IBDEI0ED ;;3787919
IBDEI0EE ;;3707092
IBDEI0EF ;;3688163
IBDEI0EG ;;3657201
IBDEI0EH ;;3490337
IBDEI0EI ;;3862881
IBDEI0EJ ;;3766301
IBDEI0EK ;;3755903
IBDEI0EL ;;3765835
IBDEI0EM ;;3897656
IBDEI0EN ;;3768278
IBDEI0EO ;;3996939
IBDEI0EP ;;3833095
IBDEI0EQ ;;3865747
IBDEI0ER ;;3461794
IBDEI0ES ;;2628552
IBDEI0ET ;;3633332
IBDEI0EU ;;3716674
IBDEI0EV ;;3778876
IBDEI0EW ;;3794016
IBDEI0EX ;;3836316
IBDEI0EY ;;3829154
IBDEI0EZ ;;3831937
IBDEI0F0 ;;3854354
IBDEI0F1 ;;4080966
IBDEI0F2 ;;3840559
IBDEI0F3 ;;3860496
IBDEI0F4 ;;3858486
IBDEI0F5 ;;3833009
IBDEI0F6 ;;3849597
IBDEI0F7 ;;3859508
IBDEI0F8 ;;3896804
IBDEI0F9 ;;4350550
IBDEI0FA ;;3862392
IBDEI0FB ;;3846046
IBDEI0FC ;;3897084
IBDEI0FD ;;3865470
IBDEI0FE ;;3919114
IBDEI0FF ;;3839324
IBDEI0FG ;;3863512
IBDEI0FH ;;3788217
IBDEI0FI ;;3876513
IBDEI0FJ ;;4083352
IBDEI0FK ;;3853548
IBDEI0FL ;;3877919
IBDEI0FM ;;3855171
IBDEI0FN ;;3852021
IBDEI0FO ;;3871569
IBDEI0FP ;;3857046
IBDEI0FQ ;;3855084
IBDEI0FR ;;3807311
IBDEI0FS ;;3901039
IBDEI0FT ;;3870297
IBDEI0FU ;;4233361
IBDEI0FV ;;3938218
IBDEI0FW ;;3879056
IBDEI0FX ;;3873491
IBDEI0FY ;;3860880
IBDEI0FZ ;;3848463
IBDEI0G0 ;;3877199
IBDEI0G1 ;;3829048
IBDEI0G2 ;;3849672
IBDEI0G3 ;;3877066
IBDEI0G4 ;;3851559
IBDEI0G5 ;;3869468
IBDEI0G6 ;;3843200
IBDEI0G7 ;;3865533
IBDEI0G8 ;;3881148
IBDEI0G9 ;;3877223
IBDEI0GA ;;3861738
IBDEI0GB ;;3905471
IBDEI0GC ;;3953646
IBDEI0GD ;;4028403
IBDEI0GE ;;3845466
IBDEI0GF ;;3877652
IBDEI0GG ;;3895328
IBDEI0GH ;;3882275
IBDEI0GI ;;4031987
IBDEI0GJ ;;4187883
IBDEI0GK ;;4035645
IBDEI0GL ;;3915733
IBDEI0GM ;;4383981
IBDEI0GN ;;3836395
IBDEI0GO ;;3930828
IBDEI0GP ;;3920821
IBDEI0GQ ;;3928525
IBDEI0GR ;;4020738
IBDEI0GS ;;3910870
IBDEI0GT ;;3926446
IBDEI0GU ;;3890272
IBDEI0GV ;;3904359
