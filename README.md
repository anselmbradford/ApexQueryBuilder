# ApexQueryBuilder
Provides an API wrapper around Salesforce SOQL/SOSL queries. Written in Apex.

**Only supports basic query strings currently. Pull requests welcome.**

## Installation 

1. Open Salesforce Developer Console.
2. Go to `File` > `New` > `Apex Class`.
3. Name the new class as `QueryBuilder`.
4. Copy the contents of `QueryBuilder.cls` into the new class.
5. Go to `File` > `New` > `Apex Class` again.
6. Name the new class as `QueryBuilderTest`.
7. Copy the contents of `QueryBuilderTest.cls` into the new class.
8. Click `Run Test` to makes sure the tests pass.

## Usage 

```
// Build a query:
QueryBuilder query = new QueryBuilder();
query.addSelectField('Id');
query.addSelectField('Name');
QueryBuilder subquery = new QueryBuilder();
subquery.addFromObject('Contacts');
subquery.addSelectField('Name');
query.addSelectField(subquery);
query.addFromObject('Case');
query.addWhereClause('IsActive = true');
query.addSortByField('Name');
query.setSortDESC();

String queryStr = query.getQuery(); 
// Outputs `SELECT Id, Name, (SELECT Name FROM Contacts) FROM Case WHERE IsActive = true SORT BY Name DESC`
```

See test class for other formats.
