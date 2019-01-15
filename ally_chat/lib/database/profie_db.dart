import 'package:sqflite/sqflite.dart';

class UserProfile{

void insertInititialValue(
  Database db,String name,
  String what_i_do,String user_image_local,String user_image_url,
  String user_gender,String user_location,String user_phone_number,
  String user_status,String user_interest,String user_email
  ) async{


    String query = """
      INSERT INTO user_profile (

        user_name,

        user_phone_number ,
        user_status,

        user_what_i_do,
        user_image_local  ,
         user_image_url ,
        user_location ,

        
        user_interest  ,
        user_email ,
       

        createdAt  ,
        updatedAt 

        )
      VALUES (
       $name,$user_phone_number,$user_status,
  $what_i_do,$user_image_url,$user_image_local,
  $user_gender,$user_location,
  $user_interest,$user_email
    """;

    await db.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });


}

  void updateProperty(String property,String newValue, Database db) async {
    
    String query = """"
        UPDATE  user_profile
        SET  $property = $newValue
         WHERE id= 0
        """;

    await db.transaction((transaction) async {
      return await transaction.rawUpdate(query);
    });
  }

Future<List<Map>> getAllProperties(Database db)async{
    List<Map> list = await db.rawQuery('SELECT * FROM user_profile  WHERE id= 0 ');
    return list;
}
 

  /**
   * delete all profile
   */

  void deleteAllprofile(Database db) async {
    String query = """DELETE * FROM user_profile""";

    await db.transaction((transaction) async {
      return await transaction.rawDelete(query);
    });
  }


}