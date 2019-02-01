import 'package:database_ally/core/database.dart';
import 'package:database_ally/database/account.dart';
import 'package:database_ally/database/database.dart';
import 'package:database_ally/pages/account/account.dart';
import 'package:flutter/material.dart';

class AccountChangeEmail extends StatefulWidget {
  static String tag = 'user-account-changeEmail-page';

  String userEmail;

  AccountChangeEmail({this.userEmail});

  @override
  AccountChangeEmailState createState() {
    return new AccountChangeEmailState();
  }
}

class AccountChangeEmailState extends State<AccountChangeEmail> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailTextFieldController;

  String emailInput;

  @override
  void initState() {
    super.initState();
    emailTextFieldController = TextEditingController(text: widget.userEmail);
  }

  Widget _instructionNewPhoneEmailText() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: MediaQuery.of(context).size.width,
      height: 20.0,
      child: Text(
        "Insert your new email below",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget buildEmailTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60.0,
        width: 200.0,
        child: TextFormField(
          controller: emailTextFieldController,
          keyboardType: TextInputType.emailAddress,
          onSaved: (emailInput) => emailInput = emailInput,
          validator: (emailInput) {
            if (emailInput.isEmpty) {
              return 'Enter your email';
            }
          },
          decoration: InputDecoration(labelText: 'Email Address'),
        ),
      ),
    );
  }

  Widget _newEmail() {
    return Row(
      children: <Widget>[
        SizedBox(width: 10.0),
        buildEmailTextField(),
      ],
    );
  }

  Align _buildSubmitButton(BuildContext context) {
    return Align(
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: SizedBox(
          height: 50.0,
          width: 270.0,
          child: FlatButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                //Only gets here if the fields pass
                _formKey.currentState.save();
                //TODO Check values and navigate to new page
                //save into database
                if (emailTextFieldController.text != null &&
                    emailTextFieldController.text.isNotEmpty) {
                  var conn = await AllyDatabase().db;

                  UserAccountProfile().updateAValue(
                      DatabaseAllyColumns.userEmail,
                      emailTextFieldController.text,
                      conn);
                }
                Navigator.pop(
                    context,
                    emailTextFieldController.text == null
                        ? ""
                        : emailTextFieldController.text);
              }
            },
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Text(
              'Change Email',
              style: Theme.of(context).primaryTextTheme.button,
            ),
          ),
        ),
      ),
    );
  }

  Widget accountAvatar() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: CircleAvatar(
        minRadius: 18.0,
        maxRadius: 20.0,
        backgroundImage: new AssetImage('assets/images/avatar.jpg'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        // leading: accountAvatar(),
        backgroundColor: Colors.blue,
        title: new Text("Change Email"),
        actions: <Widget>[],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 22.0),
          children: <Widget>[
            SizedBox(height: kToolbarHeight),
            _instructionNewPhoneEmailText(),
            _newEmail(),
            _buildSubmitButton(context)
          ],
        ),
      ),
    );
  }
}
