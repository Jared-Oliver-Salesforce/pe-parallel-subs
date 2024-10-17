trigger ClosedWonOppTrigger on Closed_Won_Opp__e (after insert) {
    List<Task> taskList = new List<Task>();
    
    for (Closed_Won_Opp__e event : Trigger.new) {
        Task t = new Task(
            Subject = 'Follow up on Closed/Won Opportunity',
            WhatId = event.AccountId__c,
            ActivityDate = Date.today().addDays(7)
        );
        taskList.add(t);
    }
    
    if (!taskList.isEmpty()) {
        insert taskList;
    }
}