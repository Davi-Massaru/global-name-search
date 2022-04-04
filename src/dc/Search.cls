Class dc.Search Extends %RegisteredObject [ Language = objectscript ]
{

ClassMethod Teste()
{
	s lista = ##class(dc.Search).GetListIdsByName(
		"carolina"
	)
	w !, $LL(lista)
}

ClassMethod GetListIdsByName(pFirstName As %String = "", pMiddleName As %String = "", pLastName As %String = "", pTop As %Integer = 500) As %String [ SqlName = GetListIdsByName, SqlProc ]
{
	Return:(pFirstName = "") $LB("")
	
	If (pMiddleName = "") {
		Set tName = ..FormatName(pFirstName)
		Set count = ..FindFirstName("idxFirstName", tName, pTop, .tIDs)
		If (count < pTop) {
			Set count = count + ..FindFirstName("idxMiddleName", tName, pTop - count, .tIDs)
			If (count < pTop) {
				Set count = count + ..FindFirstName("idxLastName", tName, pTop - count, .tIDs)
			}
		}
	}
	ElseIf (pLastName = "") {
		Set firstName = ..FormatName(pFirstName)
		Set middleName = ..FormatName(pMiddleName)
		Set count = ..FindName(pTop, .tIDs, firstName, middleName)
		If (count < pTop) {
			Set count = count + ..FindMiddleName("idxMiddleName", "idxLastName", firstName, middleName, pTop - count, .tIDs)
		}
	}
	Else {
		Set firstName = ..FormatName(pFirstName)
		Set middleName = ..FormatName(pMiddleName)
		Set lastName = ..FormatName(pLastName)
		Set count = ..FindName(pTop, .tIDs, firstName, middleName, lastName)
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
	Set tFinal = tName _ $CHAR(255)
	Set tInit = $EXTRACT(tName, 1, *-1) _ $CHAR($Ascii($EXTRACT(tName,*))-1) _ $CHAR(255) 
	Set tName = $ORDER(^dc.data.PersonI("idxName", tInit))
	Set count = 0, tID = ""
	While (tName '= "") && (tName ']] tFinal) {
		Set tID = $ORDER(^dc.data.PersonI("idxName", tName, tID))
		If tID '= "" {
			Set count = count + 1
			Set pIDs(tID) = ""
			Quit:count=pTop
		}
		Else {
			Set tName = $ORDER(^dc.data.PersonI("idxName", tName))
		}
	}
	Return count
}

ClassMethod FindFirstName(pIdx, pName, pTop, ByRef pIDs) As %Integer
{
	Set tFinal = pName _ $CHAR(255)
	Set tInit = $EXTRACT(pName, 1, *-1) _ $CHAR($Ascii($EXTRACT(pName,*))-1) _ $CHAR(255) 
	
	Set tName = $ORDER(^dc.data.PersonI(pIdx, tInit))
	Set count = 0, tID = ""
	While (tName '= "") && (tName ']] tFinal) {
		Set tID = $ORDER(^dc.data.PersonI(pIdx, tName, tID))
		
		If (tID '= "") {
			Set count = count + 1
			Set pIDs(tID) = ""
			Quit:count=pTop
		}
		Else {
			Set tName = $ORDER(^dc.data.PersonI(pIdx, tName))
		}
	}
	Return count
}

ClassMethod FindMiddleName(pIdx1, pIdx2, pFirstName, pMiddleName, pTop, ByRef pIDs) As %Integer
{
	Set tFinal = pMiddleName _ $CHAR(255)
	Set tInit = $EXTRACT(pMiddleName, 1, *-1) _ $CHAR($Ascii($EXTRACT(pMiddleName,*))-1) _ $CHAR(255) 
	
	Set tName = $ORDER(^dc.data.PersonI(pIdx2, tInit))
	Set count = 0, tID = ""
	
	While (tName '= "") && (tName ']] tFinal) {
		Set tID = $ORDER(^dc.data.PersonI(pIdx2, tName, tID))
		If (tID '= "") {
			If $DATA(^dc.data.PersonI(pIdx1, pFirstName, tID)) {
				Set count = count + 1
				Set pIDs(tID) = ""
				Quit:count=pTop
			}
		}
		Else {
			Set tName = $ORDER(^dc.data.PersonI(pIdx2, tName))
		}
	}
	Return count
}

}
