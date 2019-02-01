import 'package:database_ally/pages/account/account.dart';
import 'package:flutter/material.dart';
import 'package:database_ally/core/database.dart';
import 'package:database_ally/database/account.dart';
import 'package:database_ally/database/database.dart';

class AccountChangeName extends StatefulWidget {
  static String tag = 'user-account-change-name-page';

String userName;
AccountChangeName({
  this.userName
});

  @override
  AccountChangeNameState createState() {
    return new AccountChangeNameState();
  }
}

class AccountChangeNameState extends State<AccountChangeName> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameTextFieldController ;

  String _name;

  @override
  void initState() { 
    super.initState();
    nameTextFieldController = TextEditingController(text: widget.userName);
  }

  Widget _instructionNewPhoneEmailText() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: MediaQuery.of(context).size.width,
      height: 20.0,
      child: Text(
        "Change you name",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget buildNameTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60.0,
        width: 200.0,
        child: TextFormField(
          controller: nameTextFieldController,
          keyboardType: TextInputType.emailAddress,
          onSaved: (nameInput) => _name = nameInput,
          validator: (emailInput) {
            if (emailInput.isEmpty) {
              return 'Public Name';
            }
          },
          decoration: InputDecoration(labelText: 'Public name'),
        ),
      ),
    );
  }

  Widget _newEmail() {
    return Row(
      children: <Widget>[
        SizedBox(width: 10.0),
        buildNameTextField(),
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
                if (nameTextFieldController.text != null &&
                    nameTextFieldController.text.isNotEmpty) {
                  var conn = await AllyDatabase().db;

                  UserAccountProfile().updateAValue(
                      DatabaseAllyColumns.userName,
                      nameTextFieldController.text,
                      conn);
                }

                Navigator.pop(
                    context,
                    nameTextFieldController.text == null
                        ? "name"
                        : nameTextFieldController.text);
              }
            },
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Text(
              'Change name',
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
        title: new Text("Change Name"),
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
