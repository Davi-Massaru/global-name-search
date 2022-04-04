Class dc.REST.Server Extends dc.REST.Base
{

Parameter CHARSET = "utf-8";

Parameter CONVERTINPUTSTREAM = 1;

Parameter CONTENTTYPE = "application/json";

Parameter Version = "1.0.0";

Parameter HandleCorsRequest = 1;

ClassMethod ping() As %Status
{
    Set data = %request.Content

    s startWhen = $HOROLOG

    s lista = ##class(dc.Search).GetListIdsByName(data.pFirstName, data.pMiddleName, data.pLastName, data.pTop)
    
    s fineshedWhen = $HOROLOG

    w fineshedWhen - startWhen

    Return $$$OK
}

ClassMethod GetIdsByNameIdx() As %Status
{
    Set data = %request.Content

    s startWhen = $HOROLOG
    s lista = ##class(dc.Search).GetListIdsByName(data.pFirstName, data.pMiddleName, data.pLastName, data.pTop)
    s fineshedWhen = $HOROLOG

    w fineshedWhen - startWhen

    Return $$$OK
}

ClassMethod GetIdsByNameSql() As %Status
{
    Write { "Say" : "Pong" }.%ToJSON()
    Return $$$OK
}

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
    <Route Url="/ping"                              Method="GET"    Call="ping"             Cors="true"/>
    <Route Url="/GetIdsByNameIdx"                   Method="POST"    Call="GetIdsByNameIdx"             Cors="true"/>
    <Route Url="/GetIdsByNameSql"                   Method="POST"    Call="GetIdsByNameSql"             Cors="true"/>
</Routes>
}

}
