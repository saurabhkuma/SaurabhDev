public with sharing class ShowAttachmentImage {



   
   


      public Document document {

               get {
        
              if (document == null)
              document = new Document();
        
                return document;
        
                  }
        
            set;
  }
         
          public Transient  Messaging.EmailFileAttachment emailattachment;
          /*
          public   Messaging.EmailFileAttachment emailattachment {
          get{
          if(emailattachment == null)
            emailattachment = new   Messaging.EmailFileAttachment();
           
           return emailattachment;
           }
           set;
           }
*/
        
         public Messaging.EmailFileAttachment getEmailattachment()
         {
           if(emailattachment==null)
            emailattachment = new   Messaging.EmailFileAttachment();
            return emailattachment;
         }
        public class imageClass
        {
        
         public String imageUrl{get; set;}
         public string imagename{get; set;}
         
         }
        
        //public List<imageClass> imageUrlList{get; set;}
        public String firstImage{get; set;}
        public string selectedId{get; set;}
        public List<String> selectedDocId {get; set;}
        public list<selectOption> allOption{get; set;}
        
        public ShowAttachmentImage ()
     {
                
                List<Attachment> attachmentList=[select name, id, parentId from Attachment limit 10];
                 
               
                if(attachmentList.size()>0)
                {
                    string fimage = '/servlet/servlet.FileDownload?file=';
                    firstImage = fimage + attachmentList[0].id;
                    
         
                }
                if(emailattachment == null)
                emailattachment = new   Messaging.EmailFileAttachment();
        
     }
     
     public List<imageClass>  getAllImage()
     {
     
                 allOption= new list<selectOption>();
                list<imageClass> imageslist = new list<imageClass>();
                 List<Attachment> attachmentList=[select name, id, parentId from Attachment limit 10];
                 List<Document> documentList=[select name, id from Document  ];
                 List<ContentDocument>  cdocumentList=[select  id from ContentDocument limit 0];
                if(attachmentList.size()>0)
                {
                    
                    for(attachment att : attachmentList)
                    {
                    imageClass imageURLobj = new imageClass();
                   
                    imageURLobj.imageurl = '/servlet/servlet.FileDownload?file=' + att.id;
                    imageURLobj.imagename = att.name;
                    system.debug(imageURLobj.imageurl);
                    allOption.add(new SelectOption(''+att.id+'',''+att.name+''));
                    imageslist.add(imageURLobj);
                     }
         
                }
                if(documentList.size()>0)
                {
                
                
                
                    for(Document doc : documentList)
                    {
                    imageClass imageURLobj = new imageClass();
                    imageURLobj.imageurl = '/servlet/servlet.FileDownload?file=' + doc.id;
                     imageURLobj.imagename = doc.name;
                    system.debug(imageURLobj.imageurl);
                    allOption.add(new SelectOption(''+doc.id+'',''+doc.name+''));
                    imageslist.add(imageURLobj);
                     }
                
                }
                if(cdocumentList.size()>0)
                {
                
                
                
                    for(ContentDocument doc : cdocumentList)
                    {
                    imageClass imageURLobj = new imageClass();
                    imageURLobj.imageurl = '/' + doc.id;
                    imageURLobj.imagename = '';
                    system.debug(imageURLobj.imageurl);
                    imageslist.add(imageURLobj);
                     }
                
                }
                return imageslist;
     
     
     }
       
     public PageReference sendMail()
     {
     
       
       
       
                     
                                                
                        // the current transaction is committed.
                       // Messaging.reserveSingleEmailCapacity(100);
                        
                        messaging.Singleemailmessage mail = new  Messaging.SingleEmailMessage();
                        
                        // Strings to hold the email addresses to which you are sending the email.
                       
                        String[] toAddresses = new String[] {selectedId}; 
                        String[] ccAddresses = new String[] {'saurabh0801229024@gmail.com'};
                          
                        
                        // Assign the addresses for the To and CC lists to the mail object.
                        mail.setToAddresses(toAddresses);
                        mail.setCcAddresses(ccAddresses);
                        
                        // Specify the address used when the recipients reply to the email. 
                       // mail.setReplyTo('help_booking@travelbooking.com');
                        
                        // Specify the name used as the display name.
                        mail.setSenderDisplayName('SALESFORCE SK');
                        
                        // Specify the subject line for your email address.
                        mail.setSubject(' hi find attachment');
                        
                        // Set to True if you want to BCC yourself on the email.
                        mail.setBccSender(false);
                        
                        // Optionally append the salesforce.com email signature to the email.
                        // The email address of the user executing the Apex Code will be used.
                        mail.setUseSignature(false);
                        
                        // Specify the text content of the email.
                        mail.setPlainTextBody(' hi some attachment has been send to you');
                        
                       // mail.setHtmlBody(   (currentboorower.get(c.bookedby__c)).Name+' Your ticket:<b> ' +c.Id +' </b>has been created.  <p> your journey date'+c.journey_date__c+'</p>'+
                             //'To view your ticket <a href=https://na1.salesforce.com/'+c.Id+'>click here.</a></p>');
                        //attaching attachment to email
                        List<Id> docAttachments = new List<Id>();
                        for(String s :selectedDocId)
                        {
                        Id idis = (Id)s;
                        docAttachments.add(idis);
                        }
                        system.debug('selected att' +selectedDocId);
                        system.debug(docAttachments);
                        mail.setDocumentAttachments(docAttachments);
                        
                        //creating email attachment
                        emailattachment.filename= 'mycompfile';
                        emailattachment.contentType = 'application/pdf';
                        list<Messaging.EmailFileAttachment> allemailattachment = new  list<Messaging.EmailFileAttachment>();
                        allemailattachment.add(emailattachment);
                        mail.setFileAttachments(allemailattachment);
                        List<Messaging.SendEmailResult> sendEmailResults =  new List<Messaging.SendEmailResult>{};
                        integer  numberOfSuccessfulMessages = 0;
                        
                        // Send the email you have created.
                        try{
                        sendEmailResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }, false);
                        
                        }
                        catch(Exception e)
                        {
                            Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Caught email exception: ' + e));
                            //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));
                        
                        }
                        
                        for(Messaging.SendEmailResult sendEmailResult: sendEmailResults){
                                                        
                                                  if(sendEmailResult.isSuccess()){
                                                    numberOfSuccessfulMessages++;
                                                  }
                                                  else {
                                                    for (Messaging.Sendemailerror sendEmailError : 
                                                         sendEmailResult.getErrors()){
                                                      
                                                      Apexpages.addMessage(new ApexPages.Message (
                                                        ApexPages.Severity.ERROR, 
                                                        'Send Email Result Error: ' + 
                                                        sendEmailError.Message));
                                                    }
                                                  }
                                                }
                                                    
                                                // This page messsage should confirm 
                                                // no messages have been sent.
                                                Apexpages.addMessage(new ApexPages.Message (
                                                  ApexPages.Severity.INFO, 
                                                  'You should have just received ' 
                                                  + numberOfSuccessfulMessages + ' emails'));
       return null;
     
     }
     
     
     
     
     
     public PageReference upload() {

  

                        document.AuthorId = UserInfo.getUserId();
                    
                        document.FolderId = UserInfo.getUserId(); // put it in running user's folder
                    
                      
                    
                        try {
                    
                          insert document;
                    
                        } catch (DMLException e) {
                    
                          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));
                    
                          return null;
                    
                        } finally {
                    
                          document.body = null; // clears the viewstate
                    
                          document = new Document();
                    
                        }
                    
                      
                    
                      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));
                    
                        return null;

  }


}