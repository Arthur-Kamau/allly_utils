/*
  * model snake case.
  * class Camel case

    //details
    ->id (int auto increment)
    ->contact details
    ->status (has app,)
*/ 
enum StatusContact{
  HasApp,
  DoesNot
}
class ContactDetails{
  String name;
  String number;
  String email;
  String nickName;
}
class ContactList{
  int id;
  ContactDetails details;
StatusContact statusContact;
   DateTime createdAt;
  DateTime updatedAt;


}