trigger emailalert on travel_booking__c (before insert) {
Set<Id> booking = new Set<Id>();
    for(travel_booking__c c2: trigger.new)
    {
        booking.add(c2.bookedby__c);
    }
    


    for(travel_booking__c c : trigger.new)
    {
        
        
        // First, reserve email capacity for the current Apex transaction to ensure
                        
// that we won't exceed our daily email limits when sending email after
                        
// the current transaction is committed.
Messaging.reserveSingleEmailCapacity(2);

// Processes and actions involved in the Apex transaction occur next,
// which conclude with sending a single email.

// Now create a new single email message object
// that will send out a single email to the addresses in the To, CC & BCC list.
messaging.Singleemailmessage mail = new  Messaging.SingleEmailMessage();

// Strings to hold the email addresses to which you are sending the email.
//system.debug(c.bookedby__c);
//borrower__c tr = [select email_id__c from borrower__c where name=:c.bookedby__c ];
Map<Id,borrower__c> currentboorower = new Map<Id,borrower__c>([select Name ,Email_id__c from borrower__c where Id in :booking]);
String[] toAddresses = new String[] {(currentboorower.get(c.bookedby__c)).Email_id__c}; 
//String[] ccAddresses = new String[] {'saurabh0801229024@gmail.com'};
  

// Assign the addresses for the To and CC lists to the mail object.
mail.setToAddresses(toAddresses);
//mail.setCcAddresses(ccAddresses);

// Specify the address used when the recipients reply to the email. 
mail.setReplyTo('help_booking@travelbooking.com');

// Specify the name used as the display name.
mail.setSenderDisplayName('booking system');

// Specify the subject line for your email address.
mail.setSubject(' hi '+ (currentboorower.get(c.bookedby__c)).Name+' your ticket has been booked : ticket id no is ' +c.Id );

// Set to True if you want to BCC yourself on the email.
mail.setBccSender(false);

// Optionally append the salesforce.com email signature to the email.
// The email address of the user executing the Apex Code will be used.
mail.setUseSignature(false);

// Specify the text content of the email.
mail.setPlainTextBody(' hi '+ c.bookedby__c+' your ticket has been booked : ticket id no is ' +c.Id);

mail.setHtmlBody(   (currentboorower.get(c.bookedby__c)).Name+' Your ticket:<b> ' +c.Id +' </b>has been created.  <p> your journey date'+c.journey_date__c+'</p>'+
     'To view your ticket <a href=https://na1.salesforce.com/'+c.Id+'>click here.</a></p>');

// Send the email you have created.
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        
        
    }
    
    

}