## Global Name Search

This is an implementation using globals for user name search.

You can use this algorithm to favor the search of individuals

This application contains a Person table populated with many users, where the search takes place through the users Name, FirstName, MiddleName and LastName.

## Prerequisites

Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation 

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/Davi-Massaru/global-name-search.git
```

Open the terminal in this directory and run:

```
$ docker-compose build && docker-compose up -d
```


## Get Started

Use this feature in a scenario where there is a many volume of data and you need to return a limited length of records, for example, when selecting selects or datacombos.

This technique allows the data to be returned faster and also with a much smaller amount of global accesses than a "SELECT TOP", for example.

Open the Manegement Portal and try execute the selects:

```
    SELECT TOP 500 ID, Name FROM dc_data.Person WHERE Name LIKE '%jose%'
```
Result:


Compare to

```
	SELECT ID, Name FROM dc_data.Person WHERE ID %INLIST dc.GetListIdsByName('jose',,,500)
```

## Dream team


- [Jailton César Viçôzo](https://community.intersystems.com/user/jailton-vi%C3%A7%C3%B4zo)

- [Davi Massaru Muta](https://community.intersystems.com/user/davi-massaru-teixeira-muta)
