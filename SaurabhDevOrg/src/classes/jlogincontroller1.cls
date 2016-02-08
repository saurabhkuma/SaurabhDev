public with sharing class jlogincontroller1 {




public string token{get;set;}
public string page{get;set;}

public jlogincontroller1()
{
list<string> all= loginRest.loginintosalesforce();
token= all[0];
page= all[1];
}


}