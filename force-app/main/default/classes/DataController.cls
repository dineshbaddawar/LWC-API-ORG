public with sharing class DataController {
    @AuraEnabled (cacheable=true)
    public static List<Account> retrieveAccounts(){
        return [SELECT Id, Name, Type, BillingCountry, Industry, Email__c
                FROM Account
                LIMIT 2000];
    }
}