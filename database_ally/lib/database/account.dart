import 'package:database_ally/core/profile.dart';
import 'package:sqflite/sqflite.dart';

class UserAccountProfile {
  void setUserProfile(Database dbConnection, AccountProfile profile) async {
    String sql = """
        INSERT INTO user_Account_Profile
        (
          name,country_code,phone_number,
          email,location,status,whatIDo,
          interest,image_local,image_remote
        ) VALUES (
          '${profile.name}','${profile.countryCode}',  '${profile.phoneNumber}',
          ${profile.email}','${profile.location}',  '${profile.status}','${profile.whatIDO}',
          ${profile.interest}','${profile.imagePathLocal}',  '${profile.imagePathRemote}'
        ) """;

    await dbConnection.transaction((transaction) async {
      return await transaction.rawInsert(sql);
    });
  }

//get a users account profile
  Future<AccountProfile> getUserAccountProfile(
      Database dbConnection) async {
    String sql = "SELECT * FROM  user_Account_Profile WHERE id =0 ";

    List<Map> list = await dbConnection.rawQuery(sql);
   
      AccountProfile profile = new AccountProfile(
        name: list[0]['name'],
        countryCode: list[0]['country_code'],
        phoneNumber: list[0]['phone_number'],
        email: list[0]['email'],
        location: list[0]['location'],
        status: list[0]['status'],
        whatIDO: list[0]['whatIDo'],
        interest: list[0]['interest'],
        imagePathLocal: list[0]['image_local'],
        imagePathRemote: list[0]['image_remote'],
      );
    
    return profile;
  }

//get a column
  Future<String> getAColumn(String column, Database dbConnection) async {
    String sql =
        "SELECT " + column + " FROM  user_Account_Profile where id = 0";
    List<Map> list = await dbConnection.rawQuery(sql);
    return list[0][column];
  }

  //update a colum
  void updateAValue(String column, String value, Database dbConnection) async {
    dbConnection.rawUpdate(
        'UPDATE user_Account_Profile SET ' + column + ' = ? WHERE id = ?',
        [value, 0]);
  }

  //remove a contact
  void removeUserAccount(Database dbConnection) async {
    await dbConnection
        .rawDelete('DELETE FROM user_Account_Profile WHERE id = ?', [0]);
  }
}
