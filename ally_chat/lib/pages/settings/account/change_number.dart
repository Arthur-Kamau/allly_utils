
import 'package:ally_chat/pages/settings/account/account.dart';
import 'package:flutter/material.dart';

class AccountChangeNumber extends StatefulWidget {
   static String tag = 'user-account-changePhoneNumber-page';

  @override
  AccountChangeNumberState createState() {
    return new AccountChangeNumberState();
  }
}

class AccountChangeNumberState extends State<AccountChangeNumber> {
  final _formKey = GlobalKey<FormState>();

TextEditingController oldNumberTextFieldController = TextEditingController();
TextEditingController newNumberTextFieldController = TextEditingController();




  String _name, _phonenumber;

  bool _isObscured = true;

  Color _eyeButtonColor = Colors.grey;

  Widget _instructionOldPhoneNumberText(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width ,
         height: 50.0,
        child: Text(
          "To change your phone number \n \n Insert your country code and  old phone number ",
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
    );
  }

  Widget _instructionNewPhoneNumberText(){
    return Container(
      margin: EdgeInsets.only(top: 10.0),
       width: MediaQuery.of(context).size.width ,
       height: 20.0,
      child: Text(
        "Insert your country code and your new phone number",
        style: TextStyle(
          color: Colors.black
        ),
      ),
    );
  }

   Widget buildOldPhoneNumberCountryCodeTextField() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        margin: EdgeInsets.only(top: 25.0),
        width: 40.0,
        height: 60.0,
        child: TextFormField(
          initialValue: "+254",
           controller: oldNumberTextFieldController,
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

   Widget buildOldPhoneNumberTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height:60.0 ,
        width: 200.0,
        child: TextFormField(
          keyboardType: TextInputType.number,
          onSaved: (phonenumberInput) => _phonenumber = phonenumberInput,
          validator: (phonenumberInput) {
            if (phonenumberInput.isEmpty) {
              return 'Enter your old phone number';
            }
          },
          decoration: InputDecoration(
            labelText: 'Old Phone Number'
          ),
        ),
      ),
    );
  }

  Widget buildNewPhoneNumberTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height:60.0 ,
        width: 200.0,
        child: TextFormField(
         controller: newNumberTextFieldController,
          keyboardType: TextInputType.number,
          onSaved: (phonenumberInput) => _phonenumber = phonenumberInput,
          validator: (phonenumberInput) {
            if (phonenumberInput.isEmpty) {
              return 'Enter your New phone number';
            }
          },
          decoration: InputDecoration(
            labelText: 'New Phone Number'
          ),
        ),
      ),
    );
  }

Widget _oldNumber (){
  return Row(
    children: <Widget>[
      buildOldPhoneNumberCountryCodeTextField(),
      SizedBox(width: 10.0),
     buildOldPhoneNumberTextField()
    ],
  );
}

Widget _newNumber(){
  return Row(
    children: <Widget>[
      buildNewPhoneNumberCountryCodeTextField(),
       SizedBox(width: 10.0),
      buildNewPhoneNumberTextField()
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
            onPressed: () {
              if (_formKey.currentState.validate()) {
                //Only gets here if the fields pass
                _formKey.currentState.save();
                //TODO Check values and navigate to new page
                
                 
                Navigator.pop(context, newNumberTextFieldController.text);
              }
            },
            color: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            child: Text('Change Number', style: Theme
              .of(context)
              .primaryTextTheme
              .button,),
          ),
        ),
      ),
    );
   }

Widget accountAvatar(){
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
          title: new Text("Phone Number"),
          actions: <Widget>[
            //accountAvatar()
          ],
        ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 22.0),
          children: <Widget>[
            SizedBox(height: kToolbarHeight),
            _instructionOldPhoneNumberText(),
             _oldNumber(),
            _instructionNewPhoneNumberText(),
             _newNumber(),
            _buildSubmitButton(context)
          ],
        ),
      ),
    );
  }
}
