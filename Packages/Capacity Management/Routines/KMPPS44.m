KMPPS44 ;SP/JML - KMP*4*4 POST INSTALL ROUTINE ;11/1/2023
 ;;4.0;CAPACITY MANAGEMENT;**4,10001**;3/1/2018;Build 36
 ;
 ;
PRE ;
 I $ZV["GT.M" QUIT  ; 10001
 ; stop current KMP monitors
 W !,"Stopping Monitors"
 D STOPALL^KMPVCBG
 ; Delete field values being modified
 N DIE,DA,DR,KMPKEY,KMPFIELD
 S DIE=8969
 S KMPKEY=""
 F  S KMPKEY=$O(^KMPV(8969,"B",KMPKEY)) Q:KMPKEY=""  D
 .S DA=$O(^KMPV(8969,"B",KMPKEY,""))
 .F KMPFIELD=1.05,1.06 D
 ..S DR=KMPFIELD_"///@"
 ..D ^DIE
 Q
 ;
POST ;
 I $ZV["GT.M" QUIT  ; 10001
 N %DT,DA,DIC,DIE,DIK,DR,X,Y,KMP,MDEF,XDATA,KMPDATE,KMPKEY,KMPSC,KMPSINF,KMPTEXT
 ; ; Delete original class to get any changes compiled
 ; I ##class(%Dictionary.CompiledClass).%ExistsId("KMP.VistaSystemMonitor") D $System.OBJ.Delete("KMP.VistaSystemMonitor")
 ; ; create new class
 ; S KMP=##class(%Dictionary.ClassDefinition).%New()
 ; S KMP.Name="KMP.VistaSystemMonitor"
 ; S KMP.Super="%CSP.REST"
 ; S KMP.ProcedureBlock=1
 ; ; XDATA - Url Map
 ; S XDATA=##class(%Dictionary.XDataDefinition).%New()
 ; S XDATA.Name="UrlMap"
 ; D XDATA.Data.WriteLine("  <Routes>")
 ; D XDATA.Data.WriteLine("    <Route Url=""/GetNode"" Method=""GET"" Call=""GetNodeG"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/GetConfiguration"" Method=""GET"" Call=""GetConfigurationG"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/GetHttpMetrics"" Method=""GET"" Call=""GetHttpMetricsG"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/KillData"" Method=""GET"" Call=""KillDataG"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/StartMonitor"" Method=""GET"" Call=""StartMonitorG"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/StopMonitor"" Method=""GET"" Call=""StopMonitorG"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/GetRetryData"" Method=""GET"" Call=""GetRetryDataG"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/GetGlobuff"" Method=""GET"" Call=""GetGlobuffG"" />")
 ; D XDATA.Data.WriteLine("")
 ; D XDATA.Data.WriteLine("    <Route Url=""/GetConfig"" Method=""POST"" Call=""GetConfigP"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/SetConfig"" Method=""POST"" Call=""SetConfigP"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/GetError"" Method=""POST"" Call=""GetErrorP"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/GetCtmLog"" Method=""POST"" Call=""GetCtmLogP"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/GetPatientList"" Method=""POST"" Call=""GetPatientListP"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/Retry"" Method=""POST"" Call=""RetryP"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/GetPackages"" Method=""POST"" Call=""GetPackagesP""/>")
 ; D XDATA.Data.WriteLine("    <Route Url=""/GetHttpMetrics"" Method=""POST"" Call=""GetHttpMetricsP"" />")
 ; D XDATA.Data.WriteLine("")
 ; D XDATA.Data.WriteLine("    <Route Url=""/ImAlive"" Method=""POST"" Call=""ImAliveP"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/SynthRcmd"" Method=""POST"" Call=""SynthRcmdP"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/SynthFile"" Method=""POST"" Call=""SynthFileP"" />")
 ; D XDATA.Data.WriteLine("    <Route Url=""/SynthVpr"" Method=""POST"" Call=""SynthVprP"" />")
 ; D XDATA.Data.WriteLine("  </Routes>")
 ; D KMP.XDatas.Insert(XDATA)
 ; ; GetNodeG()
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="GetNodeG"
 ; S MDEF.ReturnType="%Status"
 ; D GETNODEG^KMPPS44A(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; GetConfigurationG
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="GetConfigurationG"
 ; S MDEF.ReturnType="%Status"
 ; D GETCONFIGG^KMPPS44A(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; GetHttpMetricsG
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="GetHttpMetricsG"
 ; S MDEF.ReturnType="%Status"
 ; D GETHTTPG^KMPPS44A(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; KillDataG
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="KillDataG"
 ; S MDEF.ReturnType="%Status"
 ; D KILLDATAG^KMPPS44A(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; StartMonitorG
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="StartMonitorG"
 ; S MDEF.ReturnType="%Status"
 ; D STARTMONG^KMPPS44A(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; StopMonitorG
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="StopMonitorG"
 ; S MDEF.ReturnType="%Status"
 ; D STOPMONG^KMPPS44C(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; GetRetryDataG
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="GetRetryDataG"
 ; S MDEF.ReturnType="%Status"
 ; D GETRETRYDATAG^KMPPS44A(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; GetGlobuffG
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="GetGlobuffG"
 ; S MDEF.ReturnType="%Status"
 ; D GETGLOBUFFG^KMPPS44C(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; GetConfigP
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="GetConfigP"
 ; S MDEF.ReturnType="%Status"
 ; D GETCONFIGP^KMPPS44B(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; SetConfigP
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="SetConfigP"
 ; S MDEF.ReturnType="%Status"
 ; D SETCONFIGP^KMPPS44B(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; GetErrorP
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="GetErrorP"
 ; S MDEF.ReturnType="%Status"
 ; D GETERRORP^KMPPS44B(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; GetCtmLogP
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="GetCtmLogP"
 ; S MDEF.ReturnType="%Status"
 ; D GETCTMLOGP^KMPPS44B(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; GetPatientListP
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="GetPatientListP"
 ; S MDEF.ReturnType="%Status"
 ; D GETPATLISTP^KMPPS44B(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; RetryP
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="RetryP"
 ; S MDEF.ReturnType="%Status"
 ; D RETRYP^KMPPS44B(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; GetPackagesP
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="GetPackagesP"
 ; S MDEF.ReturnType="%Status"
 ; D GETPACKAGESP^KMPPS44B(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; GetHttpMetricsP
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="GetHttpMetricsP"
 ; S MDEF.ReturnType="%Status"
 ; D GETHTTPP^KMPPS44B(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; ImAliveP
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="ImAliveP"
 ; S MDEF.ReturnType="%Status"
 ; D IMALIVEP^KMPPS44C(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; SynthRcmdP
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="SynthRcmdP"
 ; S MDEF.ReturnType="%Status"
 ; D SYNTHRCMDP^KMPPS44C(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; SynthFileP
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="SynthFileP"
 ; S MDEF.ReturnType="%Status"
 ; D SYNTHFILEP^KMPPS44C(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ; SynthVprP
 ; S MDEF=##class(%Dictionary.MethodDefinition).%New()
 ; S MDEF.ClassMethod=1
 ; S MDEF.Name="SynthVprP"
 ; S MDEF.ReturnType="%Status"
 ; D SYNTHVPRP^KMPPS44C(.MDEF)
 ; D KMP.Methods.Insert(MDEF)
 ; ;
 ; D KMP.%Save()
 ; D $system.OBJ.Compile("KMP.VistaSystemMonitor","ck")
 ;
 ; Set values for new fields and date
 S X="T",%DT="ESTX" D ^%DT S KMPDATE=Y
 S DA=0,DIE=8969
 F  S DA=$O(^KMPV(8969,DA)) Q:+DA=0  D
 .S DR="1.05///8000000" D ^DIE
 .S DR="1.06///180" D ^DIE
 .S DR=".05///"_KMPDATE D ^DIE
 ;
 ; Phone home
 S KMPSINF=$$SITEINFO^KMPVCCFG()
 S KMPSC=$P(KMPSINF,"^",5)
 S KMPTEXT("SUBJECT")="VSM Patch KMP*4*4 Loaded: "_KMPSC
 ;D INFOMSG^KMPUTLW(.KMPTEXT)
 Q
