/**  created by - saurabh kumar
     crated date- 5/28/2015
     this is used to convert any csv file to list form which can be used in salesforce for query or any other things
     
    
    **/

        public with sharing class CsvToList {
         
        public Blob CsvAsBlob{get; set;}
        public String CsvAsString{get; set;}
        
        
        public map<String, list<String>>  Mcsv{get; set;}
        
        
        public CsvToList()
        {
            Mcsv  = new map<String, list<String>>();    
        }
        
        public void convertCsv()
        {
        
               
                String[] CsvFileLine =new String[]{};
                try{
                CsvAsString = CsvAsBlob.toString();
                
                }
                catch(Exception e)
                {
                //converting into string of hexadecimal numbers
                 String hexaString = EncodingUtil.convertToHex(CsvAsBlob);
                 //checking number is even or not 
                  System.assertEquals(hexaString.length() & 1 , 0);
                  
                 integer iterator  =  hexaString.length() >> 1;
                
                 String[] bytes  = new String[iterator];
                 
                 for(integer i =0 ; i<iterator ; i++){
                    
                    bytes[i] = hexaString.mid(i << 1, 2);
                 
                 }
                 String incharset = '%' + String.join(bytes, '%'); 
              
                 CsvAsString = EncodingUtil.urlDecode('%' + String.join(bytes, '%') ,'UTF-8');
                 //CsvAsString.replaceall('\'',' ^ ');

                }
               system.debug(CsvAsString.length());
              
              /* // system.debug(CsvAsString);
                CsvFileLine = CsvAsString.split('\n');
                List<String> keyvalue = new List<String>();
                for(integer i=0;i<CsvFileLine.size();i++)
                {
                    if(i==0)
                    {
                        
                        keyvalue = CsvFileLine[i].split(',');
                        for(String s : keyvalue)
                        {
                            Mcsv.put(s, new list<String>());
                        }
                    }
                    else
                    {
                     List<String> tempvalue= CsvFileLine[i].split(','); 
                     for(integer j=0; j< tempvalue.size();j++)
                     {
                        Mcsv.get(keyvalue[j]).add('\''+tempvalue[j]+'\'');
                     }
                        
                    }
                    
                }*/
                
              System.debug('length of string :' +CsvAsString.length());
              CsvFileLine =  StrListProvider(CsvAsString);
              String tempCsvFileLine =CsvFileLine[0];
              Mcsv =  keyProvider(tempCsvFileLine );
              CsvFileLine.remove(0); 
              Mcsv =  mapprovider(Mcsv, CsvFileLine);
              //system.debug(Mcsv);  
              
              
        }
        
        
       
       //method to converting blob to string
        public List<String>  StrListProvider(String csvString)
        {
               String[] TempCsvFileLine=new String[]{};
               TempCsvFileLine = csvString .split('\n');
              
              return TempCsvFileLine ;
               
        
        
        
        }
        
        //method to creating map according to no of column in attahced csv file
        
        public Map<String, List<String>>  keyProvider(String tempCsvFileLine)
        {
            Map<String, List<String>> mapHeadertoValue = new map<String, list<String>>();
            
              List<String> tempkeyvalue = tempCsvFileLine.split(',');
                        for(String s : tempkeyvalue )
                        {
                            mapHeadertoValue .put(s, new list<String>());
                        }
                  //mapHeadertoValue .put('one', new list<String>());
                  // mapHeadertoValue .put('two', new list<String>());
                  //mapHeadertoValue .put('three', new list<String>());
                   //mapHeadertoValue .put('four', new list<String>());
             return mapHeadertoValue;
        }
        
        
        // method to adding value to key of map 
        public Map<String, List<String>>  mapprovider(Map<String, List<String>>  tempMcsv, List<String> tempCsvFileLine)
        {
            
           List<String> tempkey = new List<String> (tempMcsv.keyset());
           for(String singleLine: tempCsvFileLine)
           {
                   List<String> tempvalue= singleLine.split(','); 
                     for(integer j=0; j< tempvalue.size();j++)
                     {
                        tempvalue[j] = tempvalue[j].remove('"');
                        tempvalue[j] = tempvalue[j].remove('\'');
                        //tempvalue[j]  = tempvalue[j].replaceALL('@' ,',');
                        //deleting white space from both ends
                        tempvalue[j] = tempvalue[j].trim();
                        //tempvalue[j] = tempvalue[j].deleteWhitespace();
                       // system.debug('no. is '+j + 'value = '+tempvalue[j]);
                        tempMcsv.get(tempkey[j]).add('\''+tempvalue[j]+'\'');
                     }
                        
           }
              return tempMcsv;      
        
        }

}