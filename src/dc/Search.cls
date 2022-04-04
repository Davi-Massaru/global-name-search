Class dc.Search Extends %RegisteredObject [ Language = objectscript ]
{

ClassMethod GetListIdsByName(pFirstName As %String = "", pMiddleName As %String = "", pLastName As %String = "", pTop As %Integer = 500) As %String [ SqlName = GetListIdsByName, SqlProc ]
{
	Return:(pFirstName = "") $LB("")
	
	If (pMiddleName = "") {
		Set tName = ..FormatName(pFirstName)
		Set tCtd = ..FindFirstName("idxFirstName", tName, pTop, .tIDs)
		If (tCtd < pTop) {
			Set tCtd = tCtd + ..FindFirstName("idxMiddleName", tName, pTop - tCtd, .tIDs)
			If (tCtd < pTop) {
				Set tCtd = tCtd + ..FindFirstName("idxLastName", tName, pTop - tCtd, .tIDs)
			}
		}
	}
	ElseIf (pLastName = "") {
		Set firstName = ..FormatName(pFirstName)
		Set middleName = ..FormatName(pMiddleName)
		Set tCtd = ..FindName(pTop, .tIDs, firstName, middleName)
		If (tCtd < pTop) {
			Set tCtd = tCtd + ..FindMiddleName("idxMiddleName", "idxLastName", firstName, middleName, pTop - tCtd, .tIDs)
		}
	}
	Else {
		Set firstName = ..FormatName(pFirstName)
		Set middleName = ..FormatName(pMiddleName)
		Set lastName = ..FormatName(pLastName)
		Set tCtd = ..FindName(pTop, .tIDs, firstName, middleName, lastName)
	}
	
	Return ..GetListIds(.tIDs)
}

ClassMethod GetListIds(ByRef pIDs) As %List
{
	Set count = 0
	Set listIds = ""
	
	Set id = $ORDER(pIDs(""))
	While (id) {
		Set count = count + 1
		Set $LIST(listIds, count) = id
		Set id = $ORDER(pIDs(id))
	}
	
	Return listIds
}

ClassMethod FormatName(pName As %String) As %String
{
	Return " "_$ZStrip($ZConvert(pName,"U"),"<>W")
}

ClassMethod FindName(pTop, ByRef pIDs, pNames...) As %Integer
{
	Set tName = ""
	For tI=1:1:pNames {
		Set tName = tName _ pNames(tI)
	}
	Set tFim = tName _ $CHAR(255)
	Set tInicio = $EXTRACT(tName, 1, *-1) _ $CHAR($Ascii($EXTRACT(tName,*))-1) _ $CHAR(255) 
	Set tName = $ORDER(^dc.data.PersonI("idxName", tInicio))
	Set tCtd = 0, tID = ""
	While (tName '= "") && (tName ']] tFim) {
		Set tID = $ORDER(^dc.data.PersonI("idxName", tName, tID))
		If tID '= "" {
			Set tCtd = tCtd + 1
			Set pIDs(tID) = ""
			Quit:tCtd=pTop
		}
		Else {
			Set tName = $ORDER(^dc.data.PersonI("idxName", tName))
		}
	}
	Return tCtd
}

ClassMethod FindFirstName(pIdx, pName, pTop, ByRef pIDs) As %Integer
{
	Set tFim = pName _ $CHAR(255)
	Set tInicio = $EXTRACT(pName, 1, *-1) _ $CHAR($Ascii($EXTRACT(pName,*))-1) _ $CHAR(255) 
	
	Set tName = $ORDER(^dc.data.PersonI(pIdx, tInicio))
	Set tCtd = 0, tID = ""
	While (tName '= "") && (tName ']] tFim) {
		Set tID = $ORDER(^dc.data.PersonI(pIdx, tName, tID))
		
		If (tID '= "") {
			Set tCtd = tCtd + 1
			Set pIDs(tID) = ""
			Quit:tCtd=pTop
		}
		Else {
			Set tName = $ORDER(^dc.data.PersonI(pIdx, tName))
		}
	}
	Return tCtd
}

ClassMethod FindMiddleName(pIdx1, pIdx2, pFirstName, pMiddleName, pTop, ByRef pIDs) As %Integer
{
	Set tFim = pMiddleName _ $CHAR(255)
	Set tInicio = $EXTRACT(pMiddleName, 1, *-1) _ $CHAR($Ascii($EXTRACT(pMiddleName,*))-1) _ $CHAR(255) 
	
	Set tName = $ORDER(^dc.data.PersonI(pIdx2, tInicio))
	Set tCtd = 0, tID = ""
	
	While (tName '= "") && (tName ']] tFim) {
		Set tID = $ORDER(^dc.data.PersonI(pIdx2, tName, tID))
		If (tID '= "") {
			If $DATA(^dc.data.PersonI(pIdx1, pFirstName, tID)) {
				Set tCtd = tCtd + 1
				Set pIDs(tID) = ""
				Quit:tCtd=pTop
			}
		}
		Else {
			Set tName = $ORDER(^dc.data.PersonI(pIdx2, tName))
		}
	}
	Return tCtd
}

}
