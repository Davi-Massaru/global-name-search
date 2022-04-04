Class dc.data.Person Extends %Persistent [ Language = objectscript ]
{

Index idxName On Name;

Index idxFirstName On FirstName [ Data = FirstName ];

Index idxMiddleName On MiddleName [ Data = MiddleName ];

Index idxLastName On LastName [ Data = LastName ];

Property Name As %String(MAXLEN = 80);

Property FirstName As %String [ Calculated, SqlComputeCode = {Set {FirstName} = ##class(dc.data.Person).GetPartOfName({Name},1)}, SqlComputed ];

Property MiddleName As %String [ Calculated, SqlComputeCode = {Set {MiddleName} = ##class(dc.data.Person).GetPartOfName({Name},2)}, SqlComputed ];

Property LastName As %String [ Calculated, SqlComputeCode = {Set {LastName} = ##class(dc.data.Person).GetPartOfName({Name},3)}, SqlComputed ];

ClassMethod GetPartOfName(pName As %String, pColumn) As %String
{
	Return $PIECE(pName, " ", pColumn)
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^dc.data.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^dc.data.PersonD</IdLocation>
<IndexLocation>^dc.data.PersonI</IndexLocation>
<StreamLocation>^dc.data.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
