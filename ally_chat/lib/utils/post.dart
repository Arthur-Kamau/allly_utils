import 'package:ally_chat/core/urls.dart';
import 'package:dio/dio.dart';

class Post {
  //post login data
 Future<Map<POSTSTATUS,String>> postLoginData(String uniqueId, String phoneNumber,String userAgent) async {
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
      map[POSTSTATUS.ERR] = e.message;
      return map;
    }
    print("result-->" + response.data);
    map[POSTSTATUS.OK] = response.data;
    return map;
  }

  //post register data
Future<Map<POSTSTATUS,String>> postRegisterData(String uniqueId, String phoneNumber,String userAgent,String userName,String userLat,String userLong) async {
    Dio dio = new Dio();
    Response response;
    var map = <POSTSTATUS,String> {};
    try {
      //404
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
      map[POSTSTATUS.ERR] = e.message;
      return map;
    }
    print("result-->" + response.data);
    map[POSTSTATUS.OK] = response.data;
    return map;
  }

  //post code confirmatrion data
Future<Map<POSTSTATUS,String>> postCodeConfirmationData(String uniqueId, String phoneNumber,String userAgent,String codeConfirmation) async {
    Dio dio = new Dio();
    Response response;
    var map = <POSTSTATUS,String> {};
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
      map[POSTSTATUS.ERR] = e.message;
      return map;
    }
    print("result-->" + response.data);
    map[POSTSTATUS.OK] = response.data;
    return map;
  }

}

enum POSTSTATUS { OK, ERR }
