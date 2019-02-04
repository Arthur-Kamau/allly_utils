import 'package:ally_chat/core/contact.dart';
import 'package:ally_chat/core/user.dart';
import 'package:ally_chat/database/contacts.dart';
import 'package:ally_chat/database/database.dart';
import 'package:ally_chat/model/chat_history_model.dart';
import 'package:ally_chat/pages/person/person_chat_view.dart';
import 'package:ally_chat/pages/contacts/contacts_select_one.dart';
import 'package:flutter/material.dart';
import 'package:ally_chat/pages/group/groups_chat_view.dart';
import 'package:ally_chat/pages/bottom_modal/main_bottom_modal.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart'; 

class ChatHistory extends StatefulWidget {
  static String tag = 'chat-history-page';
  _ChatHistoryState createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory>
    with SingleTickerProviderStateMixin {

      String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
List<Contact> userContacts = [];

  List<ChatHistoryModel> chatData;

void getAllContacts() async{
  Database conn = await AllyDatabase().db;
userContacts = await ContactDB().getAllContact(conn);
print("user contacts lenth ${userContacts.length}");
}


@override
  void initState() {

    getAllContacts();

    super.initState();
    //get messages
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() => _connectionStatus = result.toString());
    });


  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Widget appBar(BuildContext context) {
    return new AppBar(
        leading: Stack(
          children: <Widget>[
            Container(
             margin: EdgeInsets.only(left: 3.0,top: 4.0),
             height: 40.0,
             width: 40.0,
             child: IconButton(
                
                icon: Icon(Icons.menu,size: 28.0,),
                onPressed: () {
                  //  MainBottomModal(context: context).MainBottomModalDialog();
                  MainBottomModal(context: context).MainBottomModalDialog();
                },
              ),
            ),
            // new Positioned(
            //     // draw a red marble
            //     top: 6.0,
            //     right: 5.0,
            //     child: Container(
            //       padding: EdgeInsets.all(3.0),
            //       child: Text(
            //        "",// " 2 ",
            //         style: TextStyle(color: Colors.white, fontSize: 8.0),
            //       ),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(30.0),
            //         color: Colors.red,
            //       ),
            //     ))
          ],
        ),
        backgroundColor: Colors.blue,
        title: new Text("Chats"),
        elevation: 0.7,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ChatHistoryDataSearch(),
              );
            },
          )
        ]);
  }

  String getUserName(String phoneNumber){

for (var i = 0; i < userContacts.length; i++) {
  if(userContacts[i].phoneNumber ==  phoneNumber){
   
    return userContacts[i].name;
  }
}
return phoneNumber;
  }

  Widget _personTile(ChatHistoryModel personChatHistory) {
    return new ListTile(
      onTap: () {
        //this.chatId, this.senderId, this.recepientId

        print(
            "\n\n tap list item peer senderid  ${personChatHistory.senderId} phone number -->${personChatHistory.senderPhoneNumber} \n\n");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => P2PChatView(
                  chatId: personChatHistory.groupId,
                  senderId: personChatHistory.senderId,
                  recepientId: personChatHistory.recepientId,
                  senderPhoneNumber: personChatHistory.senderPhoneNumber,
                  recepientPhoneNumber: User.phoneNumber,
                ),
          ),
        );
      },
      leading: new CircleAvatar(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.grey,
          backgroundImage: new AssetImage(personChatHistory.avatarUrl)),
      title: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(
        


              //show name from local name based on sender id=Userid or number
            getUserName(personChatHistory.senderPhoneNumber ) ,
              // chatHistory.groupName,
              style: new TextStyle(fontWeight: FontWeight.bold)),
          new Text(personChatHistory.numberMessage,
              style: new TextStyle(color: Colors.grey, fontSize: 12.0))
        ],
      ),
      subtitle: new Container(
        padding: const EdgeInsets.only(top: 2.0),
        child: new Text(personChatHistory.status.toString(),
            style: new TextStyle(color: Colors.grey, fontSize: 12.0)),
      ),
    );
  }

  Widget _groupTile(ChatHistoryModel chatHistory) {
    return new ListTile(
      onTap: () {
        print(
            "tap list item chat type --> ${chatHistory.chattype} groupname  --> ${chatHistory.groupName}  phone number---> ${chatHistory.senderPhoneNumber} ");

        print("\n\n tap list item group \n\n ");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => P2GChatView(
                  //  chatId: chatHistory.chatId,
                  groupId: chatHistory.groupId,
                  groupName: chatHistory.groupName,
                ),
          ),
        );
      },
      leading: new CircleAvatar(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.grey,
          backgroundImage: new AssetImage(chatHistory.avatarUrl)),
      title: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(chatHistory.groupName,
              style: new TextStyle(fontWeight: FontWeight.bold)),
          new Text(chatHistory.numberMessage,
              style: new TextStyle(color: Colors.grey, fontSize: 12.0))
        ],
      ),
      subtitle: new Container(
        padding: const EdgeInsets.only(top: 2.0),
        child: new Text(chatHistory.status.toString(),
            style: new TextStyle(color: Colors.grey, fontSize: 12.0)),
      ),
    );
  }

  Widget _chatTile(ChatHistoryModel chatHistory) {
    /**
 *  *chat type
    0 => p2p
    1 => peer/person to group
 */
    if (chatHistory.chattype == 0) {
      return _personTile(chatHistory);
    } else {
      return _groupTile(chatHistory);
    }
  }



   // Platform messages are asynchronous, so we initialize in an async method.
  Future<Null> initConnectivity() async {
    String connectionStatus;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } on PlatformException catch (e) {
      print(e.toString());
      connectionStatus = 'Failed to get connectivity.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      _connectionStatus = connectionStatus;
    });
  }

  Widget _messages() {
    if (chatData != null && chatData.length > 0) {
      return Container(
        child: new ListView.builder(
          itemCount: chatData.length,
          itemBuilder: (context, i) => new Column(
                children: <Widget>[
                  _chatTile(chatData[i]),
                  new Divider(
                    height: 5.0,
                  ),
                ],
              ),
        ),
      );
    } else {
      return Center(
        child: Container(
          child: Text("No recent chats"),
        ),
      );
    }
  }

  var divide = Container(
    margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
    child: new Divider(
      height: 10.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: appBar(context),
      body: Container(color: Colors.white, child: _messages()),
      floatingActionButton: FloatingActionButton(
        tooltip: "messages",
        backgroundColor: Colors.blue,
        onPressed: () async {
          //Navigator.pushNamed(context, ContactsSelectOne.tag);
          print("select comtact");
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactSelectOne(
                    intent: 1,
                  ),
            ),
          );
        },
        child: Icon(Icons.message),
      ),
    );
  }
}

class ChatHistoryDataSearch extends SearchDelegate<String> {
  final cities = [
    "Nairobi",
    "Nakuru",
    "Thika",
    "Kiambu",
    "Nyeri",
    "Mombasa",
    "kwale",
    "Nyali",
    "Mtwapa",
    "Githurai"
  ];
  final recentCity = ["Mombasa", "kwale", "Nyali", "Mtwapa", "Githurai"];

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show results bass on search
    return Text("results");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches
    //["nairobi","nakuru","kiambu","Eldorete"]

    final suggestionList = this.query != null
        ? //test if not null
        this.query.isEmpty || this.query == null
            ? //if not null check if empty
            recentCity
            : //if empty return recent
            cities // cities.where((p){p.contains(this.query); }).toList()  //if not null or empty return item that contains
        : recentCity; //if null return rescent

    print(suggestionList);

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
            onTap: () {
              showResults(context);
            },
            leading: Icon(Icons.location_city),
            title: RichText(
              text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: suggestionList[index].substring(query.length),
                        style: TextStyle(color: Colors.grey))
                  ]),
            ),
          ),
      itemCount: suggestionList.length,
    );
  }
}
