/*
  * model snake case.
  * class Camel case

*/ 
 
 class GroupModel{
   final int id;
   final String name;
   final String status;
   final String number;
   final String avatarUrl;

   GroupModel({
     this.id,
      this.name,
      this.status,
      this.number,
      this.avatarUrl
   });
 }
 List<GroupModel> dummyData = [
      new GroupModel(
        id: 1,
        name: "Christ the King",
        status: "message item here",
        number: "12",
        avatarUrl: "assets/images/logo.png"
      ),
       new GroupModel(
         id: 2,
        name: "Holy Trinity",
        status: "message item here",
        number: "12",
        avatarUrl: "assets/images/logo 2.jpg"
      )
   ];
 