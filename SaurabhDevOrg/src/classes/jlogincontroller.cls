public with sharing class jlogincontroller {

public list<string> token{get;set;}

public void gettoken()
{
token= loginRest.loginintosalesforce();
}

}