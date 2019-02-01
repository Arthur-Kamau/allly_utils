import 'package:database_ally/pages/account/account.dart';
import 'package:flutter/material.dart';
import 'package:database_ally/core/database.dart';
import 'package:database_ally/database/account.dart';
import 'package:database_ally/database/database.dart';

class AccountChangeWhatIDo extends StatefulWidget {
  static String tag = 'user-account-change-what-i-do-page';

String userWhatIDo;

AccountChangeWhatIDo({this.userWhatIDo});

  @override
  AccountChangeWhatIDoState createState() {
    return new AccountChangeWhatIDoState();
  }
}

class AccountChangeWhatIDoState extends State<AccountChangeWhatIDo> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController buildWhatIDoTextFieldController ;

  String _what_i_do;


@override
void initState() { 
  super.initState();
  buildWhatIDoTextFieldController =
      TextEditingController(text: widget.userWhatIDo);
}

  Widget _instructionNewPhoneEmailText() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: MediaQuery.of(context).size.width,
      height: 20.0,
      child: Text(
        "What i do",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget buildWhatIDoTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60.0,
        width: 200.0,
        child: TextFormField(
          controller: buildWhatIDoTextFieldController,
          keyboardType: TextInputType.emailAddress,
          onSaved: (whatIDo) => _what_i_do = whatIDo,
          validator: (whatIDo) {
            if (whatIDo.isEmpty) {
              return 'Enter you do';
            }
          },
          decoration: InputDecoration(labelText: 'What you do'),
        ),
      ),
    );
  }

  Widget _newEmail() {
    return Row(
      children: <Widget>[
        SizedBox(width: 10.0),
        buildWhatIDoTextField(),
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

                if (buildWhatIDoTextFieldController.text != null &&
                    buildWhatIDoTextFieldController.text.isNotEmpty) {
                  var conn = await AllyDatabase().db;

                  UserAccountProfile().updateAValue(
                      DatabaseAllyColumns.userEmail,
                      buildWhatIDoTextFieldController.text,
                      conn);
                }

                Navigator.pop(
                    context,
                    buildWhatIDoTextFieldController.text == null
                        ? ""
                        : buildWhatIDoTextFieldController.text);
              }
            },
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Text(
              'Change Do status',
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
        title: new Text("Change Do Status"),
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
