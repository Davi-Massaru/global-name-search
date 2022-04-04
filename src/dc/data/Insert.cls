Class dc.data.Insert Extends %RegisteredObject [ Language = objectscript ]
{

Parameter ItemsCount = 50000;

ClassMethod insertData()
{
	Try{
		For i=1:1:5 {
			Do ..insertDataGroup()
		}
	}Catch(ex){
		Set err = ex.DisplayString()
		Set a = 1
	}
}

ClassMethod clear()
{
	Do ##class(dc.data.Person).%KillExtent()
}

ClassMethod insertDataGroup()
{
	Do ..insertGroup("JOAO SILVA TESTE")
	Do ..insertGroup("JOSE OLIVEIRA SILVA")
	Do ..insertGroup("CLAUDIA MARIA SOUZA")
	Do ..insertGroup("JOAO VIEIRA OLIVEIRA")
	Do ..insertGroup("JOSE OLIVEIRA SILVA")
	Do ..insertGroup("CARMEM DELGADO MENDES")
	Do ..insertGroup("JOAO SILVA SANTOS")
	Do ..insertGroup("VINICIUS SILVA SANTOS")
	Do ..insertGroup("MARINA CAVALCANTE ROCHA")
	Do ..insertGroup("MATEU LINO AMADO")
	Do ..insertGroup("ALEX GUEDES GOMES",100)
	Do ..insertGroup("RAFAEL VEIGA ROCHA")
	Do ..insertGroup("LICINO CALOURO MELO")
	Do ..insertGroup("MURILO MARTINS FRANCO",10)
	Do ..insertGroup("MARIO MORENO VEIGA",30)
	Do ..insertGroup("RAFAEL ROCHA NUNES",250)
	Do ..insertGroup("ARTHUR GAEL HELENA")
	Do ..insertGroup("HEITOR MIGUEL GABRIEL")
	Do ..insertGroup("HELENA MARIA ALICE")
	Do ..insertGroup("MARIA CLARA")
}

ClassMethod insertGroup(pName As %String, pCountItems As %Integer = {..#ItemsCount})
{
	For i=1:1:pCountItems{
		S o = ##class(dc.data.Person).%New()
		s o.Name = pName
		$$$TOE(st, o.%Save())
	}
}

}
