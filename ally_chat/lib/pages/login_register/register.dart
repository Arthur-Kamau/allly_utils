import 'package:ally_chat/database/db.dart';
import 'package:ally_chat/model/user_register_model.dart';
import 'package:ally_chat/sharedPreferences/name.dart';
import 'package:ally_chat/sharedPreferences/phoneNumber.dart';
import 'package:flutter/material.dart';
import 'package:ally_chat/pages/login_register/code_confirmation.dart';
import 'package:ally_chat/pages/login_register/login.dart';


class RegisterPage extends StatefulWidget {
  static String tag = 'register-page';
  RegisterPage({
    Key key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _name, _phonenumber;


  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController countryCodeController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

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
        'Register',
        style: TextStyle(fontSize: 42.0, color: Colors.blue),
      ),
    );
  }

  Widget buildPhoneNumberTextField() {
    return Container(
      child: TextFormField(
        controller: phoneNumberController,
        keyboardType: TextInputType.number,
        onSaved: (phonenumberInput) => _phonenumber = phonenumberInput,
        validator: (phonenumberInput) {
          if (phonenumberInput.isEmpty) {
            return 'Please enter your phone number';
          }
        },
        // decoration: InputDecoration(labelText: 'Phone Number'),
      ),
    );
  }

  Widget countryCodeTextField() {
    return Container(
      // margin: EdgeInsets.only(top: 25.0),
      width: 40.0,
      height: 60.0,
      child: TextFormField(
        controller: countryCodeController,
        // initialValue: "+254",
        keyboardType: TextInputType.numberWithOptions(),
        onSaved: (phonenumberInput) => _phonenumber = phonenumberInput,
        validator: (phonenumberInput) {
          if (phonenumberInput.isEmpty) {
            return 'Enter your nold phone number';
          }
        },
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

  TextFormField buildNameTextField() {
    return TextFormField(
      controller: nameController,
      onSaved: (nameInput) => _name = nameInput,
      validator: (nameInput) {
        if (nameInput.isEmpty) {
          return 'Please enter an Name';
        }
      },
      decoration: InputDecoration(labelText: 'Name '),
    );
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 50.0,
        width: 270.0,
        child: FlatButton(
          onPressed: () async {
            
              RegisterResponse regResponse = Post().postRegisterData();

              if (regResponse.okay) {
                String countryCodeStr = countryCodeController.text;
                String phoneNumberstr = phoneNumberController.text;
                String name = nameController.text;

                await UserPhoneNumberAndCountryCodePreferenceAsset()
                    .setCountryCode(countryCodeStr);
                await UserPhoneNumberAndCountryCodePreferenceAsset()
                    .setPhoneNumber(phoneNumberstr);
                await ContactNamePreferenceAsset().setUserName(name);

                Navigator.of(context).pushNamed(ConfirmCode.tag);
              
            }else{
                String errorstr = regResponse.reason;
                setState(() {
                  error = errorstr;
                });
            }

          },
          color: Colors.blue, //grey[900],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Text(
            'Register',
            style: Theme.of(context).primaryTextTheme.button,
          ),
        ),
      ),
    );
  }

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
              text: 'Do you have an account?',
              style: TextStyle(fontSize: 12.0, color: Colors.blue),
              children: <TextSpan>[
                TextSpan(
                    text: '',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.blue)),
              ]),
        ),
        FlatButton(
          child: Text(' Log In',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.black)),
          onPressed: () {
            print("login");
            Navigator.of(context).pushNamed(LogInPage.tag);
          },
        )
      ]),
    );
  }

  Widget buildNewPhoneNumberCountryCodeTextField() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        margin: EdgeInsets.only(top: 25.0),
        width: 40.0,
        height: 60.0,
        child: TextFormField(
          initialValue: "+254",
          keyboardType: TextInputType.numberWithOptions(),
          onSaved: (phonenumberInput) => _phonenumber = phonenumberInput,
          validator: (phonenumberInput) {
            if (phonenumberInput.isEmpty) {
              return 'Enter your nold phone number';
            }
          },
        ),
      ),
    );
  }

  Widget buildNewPhoneNumberTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60.0,
        width: 200.0,
        child: TextFormField(
          keyboardType: TextInputType.number,
          onSaved: (phonenumberInput) => _phonenumber = phonenumberInput,
          validator: (phonenumberInput) {
            if (phonenumberInput.isEmpty) {
              return 'Enter your  phone number';
            }
          },
          decoration: InputDecoration(labelText: 'Phone Number'),
        ),
      ),
    );
  }

  Widget _userNumber() {
    return Row(
      children: <Widget>[
        buildNewPhoneNumberCountryCodeTextField(),
        SizedBox(width: 10.0),
        buildNewPhoneNumberTextField()
      ],
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
              height: 50.0,
            ),
            errorText(),
            SizedBox(
              height: 10.0,
            ),
            buildNameTextField(),
            SizedBox(
              height: 30.0,
            ),
            _userNumber(),
            SizedBox(
              height: 60.0,
            ),
            buildLoginButton(context),
            SizedBox(
              height: 30.0,
            ),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(height: 10.0),
            buildSignUpText()
          ],
        ),
      ),
    );
  }
}
