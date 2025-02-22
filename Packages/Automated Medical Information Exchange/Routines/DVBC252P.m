DVBC252P ;ALB/BG/CP/JD - PATCH DVBA*2.7*252 POST-INSTALL ROUTINE; SEP 7, 2022@16:20 ; 9/25/24 12:48pm
 ;;2.7;AMIE;**252**;Apr 10, 1995;Build 92
 ; Per VHA Directive 6402 this routine should not be modified
 ; Reference to SUPPORTED PARAMETER TOOL ENTRY POINTS in ICR #2263
 Q
 ;
VUPDATE ; MINIMUM AND PREVIOUS CAPRI VERSION UPDATES
 N DVBVER,DVBTOG
 D MES^XPDUTL("Patch DVBA*2.7*252 post install started")
 S DVBVER=$$ENXPAR("PKG","DVBAB CAPRI GITHUB LINK","https://github.com/department-of-veterans-affairs/dbq-cmt-iepd")
 D UPDMSG("DVBAB CAPRI GITHUB LINK",DVBVER)
 S DVBVER=$$ENXPAR("PKG","DVBAB CAPRI SP IEPD INFO","https://graph.microsoft.com/v1.0/drives/{{DRIVEID}}//root:/IEPD:/children(''{{FILENAME}}'')")
 D UPDMSG("DVBAB CAPRI SP IEPD INFO",DVBVER)
 S DVBVER=$$ENXPAR("PKG","DVBAB CAPRI GITHUB APP ID","297672")
 D UPDMSG("DVBAB CAPRI GITHUB APP ID",DVBVER)
 S DVBVER=$$ENXPAR("PKG","DVBAB CAPRI CMT TOGGLE","1")
 D UPDMSG("DVBAB CAPRI CMT TOGGLE",DVBVER)
 S DVBVER=$$ENXPAR("PKG","DVBAB CAPRI GITHUB ERROR DATE","02/28/23")
 D UPDMSG("DVBAB CAPRI GITHUB ERROR DATE",DVBVER)
 S DVBVER=$$ENXPAR("PKG","DVBAB CAPRI GITHUB INSTALL ID","34553682")
 D UPDMSG("DVBAB CAPRI GITHUB INSTALL ID",DVBVER)
 S DVBVER=$$ENXPAR("PKG","DVBAB CAPRI MINIMUM VERSION","CAPRI GUI V2.7*252.59*1*A*3250303*1.3*1.3")
 D UPDMSG("CAPRI MINIMUM VERSION",DVBVER)
 S DVBVER=$$ENXPAR("PKG","DVBAB CAPRI PREVIOUS VERSION","DVBA*2.7*250.7")
 D UPDMSG("DVBAB CAPRI PREVIOUS VERSION",DVBVER)
 S DVBVER=$$ENXPARS("PKG.AUTOMATED MED INFO EXCHANGE","DVBAB CAPRI CMT SSN VAR",1,5)
 D UPDMSG("DVBAB CAPRI CMT SSN VAR",DVBVER)
 S DVBVER=$$ENXPARS("PKG.AUTOMATED MED INFO EXCHANGE","DVBAB CAPRI CMT SSN VAR",2,"_VETERANSSOCIALSECURITYNUMBER,_CLAIMANTVETERANSSOCIALSECURITYNUMBER,_PATIENTVETERANSSOCIALSECURITYNUMBER,_2SOCIALSECURITYNUMBER,_SOCIALSECURITYNUMBER,_SSN")
 D UPDMSG("DVBAB CAPRI CMT SSN VAR",DVBVER)
 S DVBVER=$$ENXPARS("PKG.AUTOMATED MED INFO EXCHANGE","DVBAB CAPRI CMT SSN VAR",3,"_FIRSTNAME!_MIDDLEINITIAL!_LASTNAME,_NAMEOFVETERAN,_NAMEOFCLAIMANTVETERAN,_NAMEOFPATIENTVETERAN,_NAME")
 D UPDMSG("DVBAB CAPRI CMT SSN VAR",DVBVER)
 ;Next two lines added for CAPRI-13256.  JD - 12/12/24.
 S DVBVER=$$ENXPARS("PKG.AUTOMATED MED INFO EXCHANGE","DVBAB CAPRI CMT SSN VAR",4,"DATEOFEXAMINATIONMMDDYYYY,DATE,DATEOFEXAMINATION")
 D UPDMSG("DVBAB CAPRI CMT SSN VAR",DVBVER)
 S DVBVER=$$ENXPAR("PKG","DVBAB CAPRI SECURITY TOGGLE","3")
 D UPDMSG("DVBAB CAPRI SECURITY TOGGLE",DVBVER)
 S DVBVER=$$ENXPAR("PKG","DVBAB CAPRI PN TOGGLE","0")
 D UPDMSG("DVBAB CAPRI PN TOGGLE",DVBVER)
 S DVBVER=$$ENXPARS("PKG.AUTOMATED MED INFO EXCHANGE","DVBAB CAPRI INVALID CHARACTERS",1,"32,63")
 D UPDMSG("DVBAB CAPRI INVALID CHARACTERS",DVBVER)
 S DVBVER=$$ENXPARS("PKG.AUTOMATED MED INFO EXCHANGE","DVBAB CAPRI INVALID CHARACTERS",2,"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,127,160")
 D UPDMSG("DVBAB CAPRI INVALID CHARACTERS",DVBVER)
 S DVBVER=$$ENXPARS("PKG.AUTOMATED MED INFO EXCHANGE","DVBAB CAPRI INVALID CHARACTERS",3,"128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150")
 D UPDMSG("DVBAB CAPRI INVALID CHARACTERS",DVBVER)
 S DVBTOG(1)="NONE"
 D EN^XPAR("PKG","DVBAB CAPRI DBQ COND LOGIC",1,.DVBTOG,.DVBVER)
 D UPDMSG("DVBAB CAPRI DBQ COND LOGIC",DVBVER)
 D PARAM^DVBC252P2
 D TOKEN
 D CMTUPD^DVBC252P2
 Q
 ;
TOKEN ;
 N DVBTOK
 S DVBTOK(1)="-----BEGIN RSA PRIVATE KEY-----"
 S DVBTOK(2)="MIIEowIBAAKCAQEApi+oxp6e1wzEV6EpJmxd32+T9MzQeDvgMFKzEBRZ5bOsjd2/"
 S DVBTOK(3)="CoSwFIlpSryn8p7L20cGgpPqDOiqnINo6CFZuKTHDZd8EPX+P4P5Txo3S/k+KR5y"
 S DVBTOK(4)="JCfqNJMjWbq99QNkU4bDP94FKwUNG9PvEeEswz7ElFH2nCX65CoijXz34+Sr85tt"
 S DVBTOK(5)="FCf4Nt+8UOzVsgHD192RtnsIk0KEO3qCQQsUibrrgcL5xc2c/V7V/WOKF0v9kv81"
 S DVBTOK(6)="5rFU57EOEGh5P7g2kKNEp5pbgfROgnb13pmJSxzUSGldZ8sgzDz5hrw6IHiTQ7XF"
 S DVBTOK(7)="vvkx6AG0fbp1IQVh9ukhgnxbs2YyoyDwRG9PPQIDAQABAoIBAArXIwhJwoy+nXQl"
 S DVBTOK(8)="5BxIh1sS2TDnx1WAemBMlLegzDhqnv/mDhcujpnYWNDyO3ZdG2kjWe5cnbDX4IEz"
 S DVBTOK(9)="JT23JzYfMYjWb9ZfZYVZI4Mgb6j6Ci7+eG2ZWPKzAmRRBSEdZob4THY3Elk7DB7b"
 S DVBTOK(10)="lUWyTYwy5PnT2uVWqOYHRZe7JiRsZEBlBTVt6ltC8yW4gwLxRc0Wt1j8fp1HmJe7"
 S DVBTOK(11)="DGgx45laf4loSDcPC6BlpXGV+PD7PEeYOb/PRQ/ePixS4WJ/FFywkhp4fJKX1Pxn"
 S DVBTOK(12)="NUWOhKVL9n1N+qrspQQYk23El0SxojlZltsTt2h1cGbcvuABYWzWwG7lrOrGPrv4"
 S DVBTOK(13)="FE94FnUCgYEA28W4ITyVKcqNtz4+a5LVOAtpSbGdigCLVF2YJ5algP3CZK6b1wNe"
 S DVBTOK(14)="i4XyJAm9nLXVWx3tqwmNE67UzLIDRmqwnzvxxN7kX+chfaBP3JvAPSm077uaP5v2"
 S DVBTOK(15)="KV/qaOBROC1Hkwg6vMUvXDk4AJuKpDca8r/Bbg8+MsU6s1VOEwt6OW8CgYEAwZSh"
 S DVBTOK(16)="gjBfYS+UpSj6bBIaPLs8n7ShoqLfE6Rq/7+jNVYR+8g0gyaaQ0NACCtf1SF/a/lR"
 S DVBTOK(17)="5WemY2g1qINmWpJpctDlEiK9WInaNO8TaqgA/Ns/ELpKxsq8PQXTwt8Q8PxrVPfD"
 S DVBTOK(18)="mdpQyDLW003ZAFsjqCatOU9OdY2/nhIw+8o1tBMCgYArK/nxvX7nyLxyBK4qX5u2"
 S DVBTOK(19)="+LbkHRn/Y//6wLAFBtjYMAEh2hMO98B41AUvAyLWR/nzfjuT37pw5WU0GLv/9zFe"
 S DVBTOK(20)="9l2V+NsP4812aimGAqqO2USL22R/nlmK4yafF4Gc8Xgf7/vp3SpiiXLw250uiQyo"
 S DVBTOK(21)="JvcOcbwcKRZQ6C8AGr8VzQKBgQCzs2wy1QDV0TumDmJaDHv6wL3IbABYX+XB8DG7"
 S DVBTOK(22)="9IRnsNzE5NeKoD04D6fTbaBq08vbyfiygwO86DJXmpNbpOrqwOzFZyZqmJ3N4doe"
 S DVBTOK(23)="epNgJ49l0eo0nGMeKtin4Ddz3n8sw0v6+OVg04EFaxD0+aYiJLVNrEdjbRDihnSe"
 S DVBTOK(24)="aNptrQKBgHbNSeTMm18xSZujkxsGXNKq2FUvjbWPjsoADPa1tbfT+nCG7GOQ9Ufj"
 S DVBTOK(25)="/tCJf287EJ/2UeNOBljTmI94OHnhyzvY2coF2aWPK/Dh6uVovlhvErW7rZMv+cNE"
 S DVBTOK(26)="ptff6Lbu2l4K8BS8TsopHMzd5D4JlkUn0ZRZlHpQR74z3KnjpMIg"
 S DVBTOK(27)="-----END RSA PRIVATE KEY-----"
 D EN^XPAR("PKG","DVBAB CAPRI GITHUB TOKEN",1,.DVBTOK,.DVBVER)
 D UPDMSG("DVBAB CAPRI GITHUB TOKEN",DVBVER)
 D BMES^XPDUTL("Patch DVBA*2.7*252 post install finished")
 Q
ENXPAR(DVBENT,DVBPAR,DVBVAL) ;
 N DVBVER
 D EN^XPAR(DVBENT,DVBPAR,1,DVBVAL,.DVBVER)
 Q DVBVER
 ;
ENXPARS(DVBENT,DVBPAR,DVBINS,DVBVAL) ;
 N DVBVER
 D EN^XPAR(DVBENT,DVBPAR,DVBINS,DVBVAL,.DVBVER)
 Q DVBVER
 ;
UPDMSG(DVBPAR,DVBVER) ;
 I DVBVER D
 . D BMES^XPDUTL(DVBPAR_" Update FAILURE.")
 . D MES^XPDUTL("  Failure reason: "_DVBVER)
 E  D
 . D BMES^XPDUTL(DVBPAR_" Updated Successfully")
 Q
