@isTest
global class firsttestclass {
    
    public static invoice__c insertmerchadise(boolean addlineitem)
    {
        Merchandise__c m1= new Merchandise__c();
        m1.Name='micromax mobile';
        m1.price__c=	3000;
        m1.quantity__c=2000;
        
        insert m1;
        
        invoice__c c1= new invoice__c();
        c1.Name='inv004';
        insert c1;
        
        //creating and adding  line item into database if boolean value id true
        if(addlineitem)
        	{
            Line_Item__c item = new Line_Item__c(
              name = '1',
              Quantity__c = 7,
				Merchandise__c = m1.Id,
				Invoice__c = c1.Id
								);
				insert item;
                Line_Item__c item1 = new Line_Item__c(
              name = '6',
              Quantity__c = 5,
				Merchandise__c = m1.Id,
				Invoice__c = c1.Id
								);
                insert item1;
                /*
                Line_Item__c item2 = new Line_Item__c(
              name = '8',
              Quantity__c = 9,
				Merchandise__c = m1.Id,
				Invoice__c = c1.Id
								);
                insert item2;
            */
        	}
        
       
        return c1;
        
    }
    
    
    public static Books__c addNewBook()
    {
        
        Books__c b= new Books__c();
          b.bookname__c='headone';
           b.bookprice__c=600;
        return b;
        
            }
    
    public static borrower__c addnewborrower()
    {
         borrower__c bb= new borrower__c();
        bb.email_id__c='saurabh0801229024@gmail.com';
        bb.father_name__c='bk';
        bb.city__c='pune';
        bb.Name='saurabh kumar';
        insert bb;
        return bb;
    }
    
    
    //now testing begin
    public static testmethod void withoutline()
    {
   
    invoice__c withoutlineitem= insertmerchadise(false);
        system.debug(withoutlineitem.Name);
    
    database.DeleteResult result1=    database.delete(withoutlineitem, false);
    system.assert(result1.isSuccess());
    }
    
     public static testmethod void withline()
    {
   
    invoice__c withlineitem= insertmerchadise(true);
        
    
    database.DeleteResult result2=    database.delete(withlineitem, false);
    system.assert(!result2.isSuccess());
    }
    
    public static testmethod void bulktest()
    {
        
        list<invoice__c> invoicelist= new list<invoice__c>();
        invoicelist.add(insertmerchadise(false));
        invoicelist.add(insertmerchadise(true));
        invoicelist.add(insertmerchadise(true));
        
        database.deleteresult[] res= database.delete(invoicelist, false);
        
        
        system.assert(res[0].isSuccess());
        system.assert(!res[1].isSuccess());
        
        
        
    }
   /* public static testmethod void addbooktest()
    {
        
        Books__c b= addNewBook();
        //Test.startTest();
     database.SaveResult res= database.insert(b,false);
       
        //Test.stopTest();
        
    }
*/
    public static testmethod void renumbertest()
    {
        //system.debug('hello to renumber');
        invoice__c newinvoice=  insertmerchadise(true);
        list<invoice__c> invoicelist = [select Name from invoice__c ];
        test.startTest();
        for(invoice__c l:invoicelist)
        {
            system.debug(l.name);
        string succ= invoiceutility.renumberLine(l.Name);
            system.assertEquals(succ, 'your invoice is successfully renumbered');
        }
        test.stopTest();
       
        //invoice__c invoice1= insertmerchadise(true) ;
        //string succ= invoiceutility.renumberLine('INV–0001');       
    }
    /*
    public static testmethod void renumber2()
    {
        string succ= invoiceutility.renumberLine('INV-0001');
            system.assertEquals(succ, 'your invoice is successfully renumbered');
        
    }
    public static testmethod void borrowercheck()
    {
        borrower__c bb= new borrower__c();
        bb.email_id__c='saurabh@gmail.com';
        bb.father_name__c='bk';
        bb.city__c='pune';
        bb.Name='saurabh kumar';
        
        //test.startTest();
        insert bb;
        //test.stopTest();
        
    }
    public static testmethod void borrowercheck1()
    {
        borrower__c bb= new borrower__c();
        bb.email_id__c='saurabh0801229024@gmail.com';
        bb.father_name__c='bk';
        bb.city__c='pune';
        bb.Name='saurabh kumar';
         database.SaveResult res1= database.insert(bb,false);
        
        system.assert(!res1.isSuccess());
        //test.startTest();
        
        //test.stopTest();
        
    }*/
    public static testmethod void deleteallcheck()
    {
      invoice__c inv2= insertmerchadise(true);
        
        
           deleteall.del(inv2.Name);
            
            
       
    
    }
    public static testmethod void deleteallcheck1()
    {
      invoice__c inv2= insertmerchadise(false);
        
        
           deleteall.del(inv2.Name);
            
            
       
    
    }
    public static testmethod void emailalertcheck()
    {
        travel_booking__c newtravel= new travel_booking__c();
        borrower__c bc= addnewborrower();
        newtravel.bookedby__c= bc.Id;
        insert newtravel;
        
    }
    public static testmethod void uniqueemailcheck()
    {
        borrower__c b= addnewborrower();
         borrower__c bb1= new borrower__c();
        bb1.email_id__c='saurabh0801229024@gmail.com';
        bb1.father_name__c='bk';
        bb1.city__c='pune';
        bb1.Name='saurabh kumar singh';
        database.SaveResult savr= database.insert(bb1,false);
        system.assert(!savr.isSuccess());
    }
  /*  public static testmethod void controllertest()
    {
        DescribeSObjectResult res= binding.describeSObject(user);
        Field[] field= res.getField();
        String query1 = '';
        for(int i=0;i<field.length;i++)
        {
            query1+= field[i].getName()+'';
        }
        user u1= database.query('select '+query1+'from user LIMIT 1');
        
    }*/

}