import 'package:flutter/material.dart';
import 'package:register/pages/login_register/code_confirmation.dart';
import 'package:register/pages/login_register/login.dart';

class RegisterExtraInfo extends StatefulWidget {
  static String tag = 'register-page';
  RegisterExtraInfo({
    Key key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterExtraInfo> {
  final _formKey = GlobalKey<FormState>();
  String _name, _phonenumber;
  bool _isObscured = true;
  Color _eyeButtonColor = Colors.grey;

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Additional info',
        style: TextStyle(fontSize: 15.0, color: Colors.blue),
      ),
    );
  }

  Padding buildAddInfoTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Tell us about you,you can skip for know',
        style: TextStyle(fontSize: 9.0, color: Colors.grey),
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
      onSaved: (nameInput) => _name = nameInput,
      validator: (nameInput) {
        if (nameInput.isEmpty) {
          return 'Please enter an Name';
        }
      },
      decoration: InputDecoration(labelText: 'Name '),
    );
  }

  TextFormField buildPhoneNumberTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (phonenumberInput) => _phonenumber = phonenumberInput,
      validator: (phonenumberInput) {
        if (phonenumberInput.isEmpty) {
          return 'Please enter your phone number';
        }
      },
      decoration: InputDecoration(labelText: 'Phone Number'),
    );
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 50.0,
        width: 270.0,
        child: FlatButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              //Only gets here if the fields pass
              _formKey.currentState.save();
              //TODO Check values and navigate to new page

              Navigator.of(context).pushNamed(ConfirmCode.tag);
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
            buildAddInfoTitle(),
            SizedBox(
              height: 50.0,
            ),
            buildNameTextField(),
            SizedBox(
              height: 30.0,
            ),
            buildPhoneNumberTextField(),
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
