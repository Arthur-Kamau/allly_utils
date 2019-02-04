import 'dart:convert';

import 'package:ally_chat/core/urls.dart';
import 'package:ally_chat/model/user_login_model.dart';
import 'package:ally_chat/model/user_register_model.dart';
import 'package:ally_chat/model/user_code_confirmation.dart';
import 'package:dio/dio.dart';

class Post {
  //post login data
 Future<LoginResponse> postLoginData(String uniqueId, String phoneNumber,String userAgent) async {
    Dio dio = new Dio();
    Response response;
    var map = <POSTSTATUS,String> {};
    try {
      //404
      response = await dio.post(URLS.login, 
      data: {
        "unique_id": uniqueId, 
        "phone_number": phoneNumber, 
        "user_agent": userAgent
        }
      );
         Map userMap = jsonDecode(response.data);
var res = new LoginResponse.fromJson(userMap);

      return res;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response.toString().isNotEmpty) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.response.toString());
        print(e.message);
      }
      return null;
    }
   
  }

  //post register data
Future<RegisterResponse> postRegisterData(String uniqueId, String phoneNumber,String userAgent,String userName,String userLat,String userLong) async {
    Dio dio = new Dio();
    Response response;
    var map = <POSTSTATUS,String> {};
    try {
    
      response = await dio.post(URLS.register, 
      data: {
        "unique_id": uniqueId, 
        "phone_number": phoneNumber, 
        "user_agent": userAgent,
        "user_name": userName, 
        "user_lat": userLat, 
        "user_long": userLong
        }
      );
      Map userMap = jsonDecode(response.data);
var res = new RegisterResponse.fromJson(userMap);

      return res;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response.toString().isNotEmpty) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.response.toString());
        print(e.message);
      }
     
      return null;
    }
    
  }

  //post code confirmatrion data
Future<UserCodeConfirmationModel> postCodeConfirmationData(String uniqueId, String phoneNumber,String userAgent,String codeConfirmation) async {
    Dio dio = new Dio();
    Response response;
    
    try {
      //404
      response = await dio.post(URLS.codeConfirmation, 
      data: {
        "unique_id": uniqueId, 
        "phone_number": phoneNumber, 
        "confirmation_code" :codeConfirmation, 
        "user_agent": userAgent
        }
      );

Map userMap = jsonDecode(response.data);
var auth = new UserCodeConfirmationModel.fromJson(userMap);


      return  auth;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response.toString().isNotEmpty) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.response.toString());
        print(e.message);
      }
    
return null;
    }
    
  }

}

enum POSTSTATUS { OK, ERR }
