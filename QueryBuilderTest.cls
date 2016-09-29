@isTest
public class QueryBuilderTest {

    @isTest
    static void testGetQuery() {
        QueryBuilder query = new QueryBuilder();
        String initQuery = query.getQuery();

        query.addSelectField('Id');
        query.addFromObject('Case');
        String query1 = query.getQuery();

        query.addSelectField('Name');
        String query2 = query.getQuery();

        query.addWhereClause('IsActive = true');
        String query3 = query.getQuery();

        query.addSortByField('Name');
        query.setSortDESC();
        String query4 = query.getQuery();

        QueryBuilder subquery = new QueryBuilder();
        subquery.addFromObject('Contacts');
        subquery.addSelectField('Name');
        query.addSelectField(subquery);
        String query5 = query.getQuery();

        query = new QueryBuilder();
        query.addSelectField('Id');
        query.addFromObject('Case');
        query.addWhereClause('IsActive = true');
        query.addWhereClause('Name = \'test\'', 'OR');
        String query6 = query.getQuery();

        query = new QueryBuilder();
        query.setSOSL();
        query.addSelectField('Id');
        query.addSelectField('Name');
        query.addFromObject('Case');
        query.addWhereClause('test string');
        String query7 = query.getQuery();

        System.assertEquals(query1, 'SELECT Id FROM Case');
        System.assertEquals(query2, 'SELECT Id, Name FROM Case');
        System.assertEquals(query3, 'SELECT Id, Name FROM Case WHERE IsActive = true');
        System.assertEquals(query4, 'SELECT Id, Name FROM Case WHERE IsActive = true SORT BY Name DESC');
        System.assertEquals(query5, 'SELECT Id, Name, (SELECT Name FROM Contacts) FROM Case WHERE IsActive = true SORT BY Name DESC');
        System.assertEquals(query6, 'SELECT Id FROM Case WHERE IsActive = true OR Name = \'test\'');
        System.assertEquals(query7, 'FIND {test string} IN ALL FIELDS RETURNING Case (Id, Name)');
    }
}
