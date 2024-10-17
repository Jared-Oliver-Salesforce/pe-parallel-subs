trigger OpportunityTrigger on Opportunity (after insert, after update) {
    List<Closed_Won_Opp__e> eventList = new List<Closed_Won_Opp__e>();
    
    for (Opportunity opp : Trigger.new) {
        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
        if (opp.StageName == 'Closed Won' && oldOpp.StageName!= 'Closed Won') {
            Closed_Won_Opp__e event = new Closed_Won_Opp__e(
                AccountId__c = opp.AccountId,
                Amount__c = opp.Amount,
                Close_Date__c = opp.CloseDate
            );
            eventList.add(event);
        }
    }
    
    if (!eventList.isEmpty()) {
        EventBus.publish(eventList);
    }
}