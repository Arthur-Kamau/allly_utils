import 'package:ally_chat/database/authDataDB.dart';
import 'package:ally_chat/model/authData.dart';
import 'package:ally_chat/model/user_code_confirmation.dart';
import 'package:ally_chat/pages/login_register/register.dart';
import 'package:ally_chat/pages/chat/chat_history.dart';
import 'package:ally_chat/sharedPreferences/phoneNumber.dart';
import 'package:flutter/material.dart';
import 'package:ally_chat/utils/app_id.dart';
import 'package:ally_chat/utils/random.dart';

// import 'package:ally_native/pages/landing/landing.dart';

class ConfirmCode extends StatefulWidget {
  static String tag = 'confirm-code-page';
  ConfirmCode({
    Key key,
  }) : super(key: key);

  @override
  _ConfirmCodePageState createState() => _ConfirmCodePageState();
}

class _ConfirmCodePageState extends State<ConfirmCode> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
String error;

  Padding errorText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        error,
        style: TextStyle(fontSize: 13.0, color: Colors.blue),
      ),
    );
  }
  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Code Confirmation',
        style: TextStyle(fontSize: 32.0, color: Colors.blue),
      ),
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 38.0,
          height: 1.5,
          color: Colors.black,
        ),
      ),
    );
  }

  TextFormField buildCodeConfirmationTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (phonenumberInput) => _email = phonenumberInput,
      validator: (phonenumberInput) {
        if (phonenumberInput.isEmpty) {
          return 'Please enter your code confirmation';
        }
      },
      decoration: InputDecoration(labelText: 'Code Confirmation'),
    );
  }

  Align confirmCode(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 50.0,
        width: 270.0,
        child: FlatButton(
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              //Only gets here if the fields pass
              _formKey.currentState.save();
              //TODO Check values and navigate to new page

UserCodeConfirmationModel data = Post().postCodeConfirmationData();

if(data.aunthentified){
              //auth confirmation code
              //save app details
String countryCodeStr = await UserPhoneNumberAndCountryCodePreferenceAsset().getCountryCode();
String phoneNumberstr = await UserPhoneNumberAndCountryCodePreferenceAsset().getPhoneNumber();

              //save appdetails
              String getAppToken = AppRandom().randomString(20);
              AppId().getAppId().then((appid) {
                var auth = AuthDetails(
                   phoneNumber: phoneNumberstr,
                   countryCode : countryCodeStr,
                   name: data.name,
                    authTime: DateTime.now(),
                    authtoken: getAppToken,
                    deviceId: appid);


                   AuthDataDB().saveAuthDetails(auth);
              });

              //then naivigate to homepage

              Navigator.pushNamedAndRemoveUntil(
                  context, ChatHistory.tag, (_) => false);
            }
            }else{
String errorstr ="invalid code,try again";
setState(() {
  error = errorstr;
});
            }
          },
          color: Colors.blue, //grey[900],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Text(
            'Confirm',
            style: Theme.of(context).primaryTextTheme.button,
          ),
        ),
      ),
    );
  }

  // Align buildOrText() {
  //   return Align(
  //     alignment: Alignment.center,
  //     child: Text('or login with', style: TextStyle(fontSize: 12.0, color: Colors.grey),),
  //   );
  // }

  Container buildSocialMediaButtons(IconData icon, Color iconColor) {
    return Container(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(30.0),
        child: Icon(icon, color: iconColor),
      ),
      height: 46.0,
      width: 46.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 0.5)),
    );
  }

  Align buildSignUpText() {
    return Align(
      child: Row(children: <Widget>[
        RichText(
          text: TextSpan(
              text:
                  "Didn't get Confirmation Code", // 'You Don\'t have an account?',
              style: TextStyle(fontSize: 12.0, color: Colors.blue),
              children: <TextSpan>[
                TextSpan(
                    text: '',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.black)),
              ]),
        ),
        FlatButton(
          child: Text(' RESEND',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.black)),
          onPressed: () {
            print("register");
            Navigator.of(context).pushNamed(RegisterPage.tag);
          },
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 22.0),
          children: <Widget>[
            SizedBox(height: kToolbarHeight),
            buildTitle(),
            buildTitleLine(),
            SizedBox(
              height: 10.0,
            ),
            errorText(),
             SizedBox(
              height: 10.0,
            ),
            buildCodeConfirmationTextField(),
            SizedBox(
              height: 30.0,
            ),
            // buildPasswordInput(context),

            SizedBox(
              height: 50.0,
            ),
            confirmCode(context),
            SizedBox(
              height: 30.0,
            ),
            // buildOrText(),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(height: 40.0),
            buildSignUpText()
          ],
        ),
      ),
    );
  }
}

Post() {
}

// import 'package:flutter/material.dart';

// class ConfirmCode extends StatefulWidget {
//   static String tag = 'confirm-code-page';
//   _ConfirmCodeState createState() => _ConfirmCodeState();
// }

// class _ConfirmCodeState extends State<ConfirmCode> {
//   @override
//   Widget build(BuildContext context) {

// var codeTextField = Container(
//   height: 30.0,
//   width: 200.0,
//   child:   TextFormField(
//     keyboardType: TextInputType.numberWithOptions(),
//     autofocus: true,

//     decoration: InputDecoration(
//       hintText: 'code',

//       //contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//       // border: OutlineInputBorder(
//       //   borderRadius: BorderRadius.circular(0.0)
//       // )
//     ),

//   ),
// );

//     var confirmCodeButton = Material(
//     borderRadius: BorderRadius.circular(0.0),
//     shadowColor: Colors.lightBlueAccent.shade100,
//     child: new MaterialButton(
//       minWidth: 150.0,
//       height: 40.0,
//       color: Colors.lightBlue,
//       child: Text('Confirm',style: TextStyle(color: Colors.white) ),
//       onPressed: (){
//       print("confirm pressed");
//       },
//   ),
//     );

//   var formContainer =

//             Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[

//             SizedBox(height: 5.0,),
//             codeTextField,
//             SizedBox(height: 25.0,),
//             confirmCodeButton
//           ],
//         );

//   var bodyContainer = new Scaffold(
//     backgroundColor: Colors.white,
//     body: formContainer ,
//   );

//     return bodyContainer;
//   }
// }
