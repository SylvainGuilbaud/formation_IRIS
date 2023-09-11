Class cls.common.adapter.inbound.XLStoCSV Extends EnsLib.File.InboundAdapter
{

Parameter SETTINGS = "IPAddress,TimeOut";

Property IPAddress As %String(MAXLEN = 100);

Property TimeOut As %Integer(MAXVAL = 10, MINVAL = 0);

Property Counter As %Integer;

Method OnTask() As %Status
{
	#;Check WorkPath and ArchivePath if defined are accessible
	Set tSC=..testPaths(0)
	If $$$ISERR(tSC) {
		If '..BusinessHost.%PreserveSession {
			#; We do not want to clean %SuperSession if set before %SessionId
			If '..BusinessHost.%SuperSessionCreatedBeforeSession  Set ..BusinessHost.%SuperSession = ""
			Set ..BusinessHost.%SessionId = ""
		}
		Quit tSC
	}

	If ("@"=$E(..FilePath)) {
		#; Dequeue from Agent proxy
		Set tQueueName=$$$getConfigQueueName(..BusinessHost.%ConfigName,"")
		Set tSC = ##class(Ens.Queue).DeQueue(tQueueName,.tHeaderIn,0,.tIsTimedOut,1)  Quit:$$$ISERR(tSC) tSC
		Quit:tIsTimedOut tSC
		Quit:'$IsObject(tHeaderIn) tSC
		Do tHeaderIn.SetStatus($$$eMessageStatusDelivered)
		Set (..BusinessHost.%SessionId,$$$JobSessionId) = tHeaderIn.SessionId

		try {
			If ""'=tHeaderIn.MessageBodyClassName && $classmethod(tHeaderIn.MessageBodyClassName,"%Extends","Ens.StreamContainer") {
				Set tMsgIn = $classmethod(tHeaderIn.MessageBodyClassName,"%OpenId",tHeaderIn.MessageBodyId,,.tSC)
				If '$IsObject(tMsgIn) {
					Set tSC=$$$ERROR($$$EnsErrGeneral,"Could not open MessageBody "_tHeaderIn.MessageBodyId_" for MessageHeader #"_tHeaderIn.%Id()_" with body class "_tHeaderIn.MessageBodyClassName_":"_$$$StatusDisplayString(tSC))
				}
			} Else {
				Set tSC=$$$ERROR($$$EnsErrGeneral,"Only Ens.StreamContainer message bodies are accepted on the agent queue; found message body of class "_tHeaderIn.MessageBodyClassName_" for MessageHeader #"_tHeaderIn.%Id())
			}
		} catch {
			Set tSC=$$$ERROR($$$EnsErrGeneral,"Only Ens.StreamContainer message bodies are accepted on the agent queue; error testing message body for MessageHeader #"_tHeaderIn.%Id()_": "_$ZE)
		}
		If $$$ISERR(tSC) {
			Do tHeaderIn.SetStatus($$$eMessageStatusDiscarded)
		} Else {
			Set tAgent=tHeaderIn.Description
			$$$sysTRACE("Processing stream '"_tMsgIn.OriginalFilename_"' from agent '"_tAgent_"' via proxy '"_tHeaderIn.SourceConfigName_"'")
			Set tPS=..BusinessHost.%PreserveSession, ..BusinessHost.%PreserveSession=1

      set sc = ##class(common.conversion).XLStoCSV()


			Set tSC=..BusinessHost.ProcessInput(tMsgIn.Stream)
			Set ..BusinessHost.%PreserveSession=tPS

			#; archive or delete the file, and remove the file from do-not-process list if successful
			If ""'=..ArchivePath&&$$$ISOK(tSC) {
				Set tArchiveFilename = ..getArchiveFilename(tMsgIn.OriginalFilename)
				Set tArchiveStream=##class(%Library.FileBinaryStream).%New()
				Set tSC=tArchiveStream.FilenameSet(tArchiveFilename)
				Set:$$$ISOK(tSC) tSC=tArchiveStream.CopyFrom(tMsgIn.Stream)
				If $$$ISOK(tSC) {
					$$$sysTRACE("Saved stream from agent '"_tAgent_"' via proxy '"_tHeaderIn.SourceConfigName_"' to Archive file '"_tArchiveFilename_"'")
				} Else {
					If ##class(%File).Exists(tArchiveFilename) {
						$$$LOGERROR("Can't archive '"_tMsgIn.OriginalFilename_"' from agent '"_tAgent_"' because Archive file '"_tArchiveFilename_"' already exists: "_$$$StatusDisplayString(tSC))
					} Else {
						$$$LOGERROR("Failed to move '"_tMsgIn.OriginalFilename_"' from agent '"_tAgent_"' to Archive file '"_tArchiveFilename_"': "_$$$StatusDisplayString(tSC))
					}
				}
			}
			If $$$ISERR(tSC) {
				Do tHeaderIn.SetStatus($$$eMessageStatusError)
			} Else {
				Do tHeaderIn.SetStatus($$$eMessageStatusCompleted)
			}
		}
		Kill $$$EnsActiveMessage($$$SystemName_":"_$Job)
		If $$$ISERR(tSC) {
			$$$LOGSTATUS(tSC)
		}
		Quit $$$OK
	}
#define ErrorFileTable(%tk) $$$EnsRuntimeAppData(..BusinessHost.%ConfigName,"adapter.file",%tk)
#define DoneFileTable(%tk)  $$$EnsStaticAppData(..BusinessHost.%ConfigName,"adapter.file",%tk)

	#; Normal non-Agent file service handling
	Set $ZT="Trap", tSC=$$$OK, (tOneFilename,tFilename,tLockFilename,tTableKey,tSemaphorename)="", tDone=0
	Do {
		Quit:(""=..FilePath)||(""=..FileSpec)
		If '$D(..%CurrResultSet.Data) {
			#; get file list
			$$$catTRACE("connwait","Looking for files '"_..FileSpec_"' in path '"_..FilePath_"'")
			Set tSC=..%CurrResultSet.Execute($this,..FilePath,..FileSpec,..SubdirectoryLevels,,..SemaphoreSpec)  Quit:$$$ISERR(tSC)
			Kill ^||Ens.FileInbound.Found,^||Ens.FileInbound.Semaphore
		}
		#; find the next one that can be processed
		For {
			If '..%CurrResultSet.Next(.tSC) {
				#; Done iterating the ResultSet for the current query execution - clean it up
				Do ..%CurrResultSet.Close()
				Kill ..%CurrResultSet.Data ; clean it out so next loop iteration will re-Execute the query
				#; Remove errored files from the Error global if they no longer exist, and remove processed files from the Done global if they no longer exist
				Quit:$$$ISERR(tSC) ; if the list failed we don't know if the files are still there
				Set tk="" For  Set tk=$O($$$DoneFileTable(tk)) Quit:tk=""   If ""=$G(^||Ens.FileInbound.Found(tk)) $$$sysTRACE("Removed absent file keyed as '"_tk_"' from processed list")  Kill $$$DoneFileTable(tk)
				Set tk="" For  Set tk=$O($$$ErrorFileTable(tk)) Quit:tk=""  If ""=$G(^||Ens.FileInbound.Found(tk)) If ""'=$G($$$ErrorFileTable(tk)) { $$$sysTRACE("Removed absent file keyed as '"_tk_"' from errored list") } If $D($$$DoneFileTable(tk)) { Set $$$ErrorFileTable(tk)="" } Else { Kill $$$ErrorFileTable(tk) }
				#; delete the semaphore files.
				Set tTableKey=$O(^||Ens.FileInbound.Semaphore(""),1,tSemaphorename)
				While tTableKey'="",..DeleteFromServer {
					If ##Class(%File).Delete(tSemaphorename) {
						$$$sysTRACE("Deleted semaphore '"_tSemaphorename_"' after successful processing")
					} Else {
						$$$LOGERROR("Failed to delete semaphore '"_tSemaphorename_"' after successful processing")
					}
					Set tTableKey=$O(^||Ens.FileInbound.Semaphore(tTableKey),1,tSemaphorename)
				}
				Quit
			}
			Set tOneFilename=..%CurrResultSet.Data("Name"), tModified=..%CurrResultSet.Data("DateModified"), tSize=..%CurrResultSet.Data("Size"), tSemaphorename=..%CurrResultSet.Data("SemaphoreName")  $$$ASSERT(""'=tOneFilename)
			Set tTableKey=..getFileSubscript(tOneFilename)
			Set ^||Ens.FileInbound.Found(tTableKey)=tOneFilename
			#;Record semaphore files for deletion. Hash to avoid subscript error from long filename and path
			If tSemaphorename'="" Set ^||Ens.FileInbound.Semaphore($system.Encryption.SHA1Hash(tSemaphorename))=tSemaphorename
			Lock +$$$ErrorFileTable(tTableKey):0 Else  $$$LOGINFO("Skipping locked file key '"_tTableKey_"' for file '"_tOneFilename_"'") Continue
			#; Skip the files we have already processed except if they are modified; if they errored only warn once
			If $G($$$DoneFileTable(tTableKey))=tModified If '$G(^(tTableKey,"done"_$E($G($$$ErrorFileTable(tTableKey)),-1))) { Set ^("done")=1 $$$LOGINFO("Skipping previously processed file '"_tOneFilename_"'") } Lock -$$$ErrorFileTable(tTableKey)  Continue
			If $G($$$ErrorFileTable(tTableKey))=tModified If $G(^(tTableKey,"wrn")) { Kill ^("wrn") $$$LOGWARNING("Skipping previously errored file '"_tOneFilename_"' with timestamp '"_tModified_"'") } Lock -$$$ErrorFileTable(tTableKey)  Continue
			If ..VMSLatestVersionOnly && ..%isVMS && ('..IsVMSLatestVersion(.tOneFilename)) {
				If '$G(^(tTableKey,"ver"_$E($G($$$ErrorFileTable(tTableKey)),-1))) { Set ^("ver")=1  $$$sysTRACE("Skipping not-latest version of file '"_tOneFilename_"'") }
				Lock -$$$ErrorFileTable(tTableKey)  Continue
			}
			Set $$$ErrorFileTable(tTableKey)=tModified, ^(tTableKey,"wrn")=1
			Set tFilename=tOneFilename, tOneFilename=""
			Quit ; found a good one
		}
		Quit:""=tFilename
		$$$sysTRACE("About to process file '"_tFilename_"' (size '"_tSize_"') with timestamp '"_tModified_"', ConfirmComplete="_..ConfirmComplete)
		Set tLockFilename=tFilename
		Set tSC=..processFile(.tLockFilename,tModified,tSize,.tDone,tTableKey,tSemaphorename)  Quit:$$$ISERR(tSC)
		#; mark the file as done if not renamed, whether or not we tried
		Set:tDone>0 $$$DoneFileTable(tTableKey)=tModified
	} While 0
	If $$$ISOK(tSC) {
		#;If Directory invalid or testPaths() failed previously but in this cycle were successful
		If (..BusinessHost.%LastReportedError [ "ERROR #5007")||(..BusinessHost.%LastReportedError [ "ERROR #5021") {
			Set ..BusinessHost.%LastReportedError=""
			$$$SetHostMonitor(..BusinessHost.%ConfigName,$$$eMonitorStatus,"OK")
		}
	}
Exit
	If tDone&&(""'=tLockFilename) {
		If tDone=-1&&..VMSLatestVersionOnly&&..%isVMS {
			#; If renamed on VMS but other VMS versions of the file may exist, suppress messages about them
			Set $$$ErrorFileTable(tTableKey)=""
		} Else {
			Kill $$$ErrorFileTable(tTableKey)
		}
	}
	Lock:""'=tLockFilename -$$$ErrorFileTable(tTableKey)
	Quit tSC
Trap
	Set $ZT="",tSC=$$$EnsSystemError
	Lock:""'=tOneFilename -$$$ErrorFileTable(tTableKey)
	Goto Exit
}

}
