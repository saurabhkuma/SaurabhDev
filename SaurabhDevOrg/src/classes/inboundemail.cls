global class inboundemail implements Messaging.InboundEmailHandler {
	global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
      Messaging.InboundEnvelope envelope) {
          
		  Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
       
          email_record__c erc= new email_record__c();
              erc.emailADDES__c= envelope.fromAddress;
          erc.name__c=email.fromname.substring(0,email.fromname.indexOf(' '));
          erc.message__c= email.subject;
          erc.body_text__c= email.plainTextBody;
          
          insert erc;
          
          
          system.debug( 'record created'+erc.Id);
          
          if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) {
      for (integer i = 0 ; i < email.binaryAttachments.size() ; i++) {
        Attachment attachment = new Attachment();
        // attach to the newly created contact record
        attachment.ParentId = erc.Id;
        attachment.Name = email.binaryAttachments[i].filename;
        attachment.Body = email.binaryAttachments[i].body;
        insert attachment;
      }
    }
       
          
          
          
          
          return result;
      }
  }