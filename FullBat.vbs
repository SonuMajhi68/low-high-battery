set oLocator = CreateObject("WbemScripting.SWbemLocator")
set oServices = oLocator.ConnectServer(".","root\wmi")
set oResults = oServices.ExecQuery("select * from batteryfullchargedcapacity")
for each oResult in oResults
   iFull = oResult.FullChargedCapacity
next

while (1)
  set oResults = oServices.ExecQuery("select * from batterystatus")
  for each oResult in oResults
    iRemaining = oResult.RemainingCapacity
    bCharging = oResult.Charging
  next
  iPercent = ((iRemaining / iFull) * 100) mod 100
  if bCharging and (iPercent > 90) Then msgbox "Battery is at " & iPercent & "%",vbInformation, "Battery monitor"
  if not(bCharging) and (iPercent < 30) Then msgbox "Battery is at " & iPercent & "%",vbInformation, "Battery monitor"
  wscript.sleep 5000 ' 5 minutes
wend