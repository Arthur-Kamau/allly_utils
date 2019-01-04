import 'package:chat/model/operations_models/chat_history_model.dart';
import 'package:chat/pages/contacts/contacts_select_one.dart';
import 'package:chat/pages/person/person_chat_view.dart';
import 'package:flutter/material.dart';
import 'package:chat/pages/chat/chat_view.dart';

class ChatHistory extends StatefulWidget {
  static String tag = 'chat-history-page';
  _ChatHistoryState createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> 
with SingleTickerProviderStateMixin {
 
 Widget appBar (BuildContext context){
  return  new AppBar(
            
            // leading: IconButton(
            //   icon: Icon(Icons.menu),
            //   onPressed: (){
            //      MainBottomModal(context: context).MainBottomModalDialog();
            //   },
            // ),
            // backgroundColor: GetAppStyle.getColor(),
            title: new Text("Chats"),
            elevation: 0.7,
            
            actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(
                  context: context,
                  delegate: ChatHistoryDataSearch(),
                );
              },
            )

            ]
         );
 }


  
    
  String getPersonName(String userId) {

    for (var i = 0; i < dummyContacts.length; i++) {
      if(dummyContacts[i].userId == userId){
        return  dummyContacts[i].name;
      }
    }
    return "";
  }

  Widget _personTile(ChatHistoryModel personChatHistory) {
    return new ListTile(
      onTap: () {
        print("tap list item  ${personChatHistory.senderId}");

        //this.chatId, this.senderId, this.recepientId

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => P2PChatView(
                  chatId: personChatHistory.chatId,
                  recepientId: personChatHistory.recepientId,
                  senderId: personChatHistory.senderId,
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
              getPersonName(personChatHistory.senderId).isEmpty
                  ? personChatHistory.phoneNumber
                  : getPersonName(personChatHistory.senderId),
              // groupChatHistory.groupName,
              style: new TextStyle(fontWeight: FontWeight.bold)),
          new Text(personChatHistory.number,
              style: new TextStyle(color: Colors.grey, fontSize: 12.0))
        ],
      ),
      subtitle: new Container(
        padding: const EdgeInsets.only(top: 2.0),
        child: new Text(personChatHistory.status,
            style: new TextStyle(color: Colors.grey, fontSize: 12.0)),
      ),
    );
  }

  Widget _groupTile(ChatHistoryModel groupChatHistory) {
    return new ListTile(
      onTap: () {
        print("tap list item  ${groupChatHistory.groupName}");

        //this.chatId, this.senderId, this.recepientId

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => P2PChatView(
        //           chatId: .chatId,
        //           recepientId: dummyData[i].recepientId,
        //           senderId: dummyData[i].senderId,
        //         ),
        //   ),
        // );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => P2GChatView(
                  chatId: groupChatHistory.chatId,
                    groupId: groupChatHistory.groupId,
                ),
          ),
        );
      },
      leading: new CircleAvatar(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.grey,
          backgroundImage: new AssetImage(groupChatHistory.avatarUrl)),
      title: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(groupChatHistory.groupName,
              style: new TextStyle(fontWeight: FontWeight.bold)),
          new Text(groupChatHistory.number,
              style: new TextStyle(color: Colors.grey, fontSize: 12.0))
        ],
      ),
      subtitle: new Container(
        padding: const EdgeInsets.only(top: 2.0),
        child: new Text(groupChatHistory.status,
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

  Widget _messages() {
    return Container(
      child: new ListView.builder(
        itemCount: dummyData.length,
        itemBuilder: (context, i) => new Column(
              children: <Widget>[
                _chatTile(dummyData[i]),
                new Divider(
                  height: 5.0,
                ),
              ],
            ),
      ),
    );
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
      body:   Container(color: Colors.white, child: _messages()),
      floatingActionButton: FloatingActionButton(
        tooltip: "messages",
        // backgroundColor: GetAppStyle.getColor(),
        onPressed: (){

  Navigator.pushNamed(context, ContactsSelectOne.tag);

        },
        
        child: Icon(Icons.message),
      ),
    );
  }
}

class ChatHistoryDataSearch extends SearchDelegate<String>{
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
final recentCity = [
    "Mombasa",
  "kwale",
  "Nyali",
  "Mtwapa",
  "Githurai"
];


  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
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
      onPressed: (){
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
    
    final suggestionList = this.query != null  ?  //test if not null
                                  this.query.isEmpty || this.query==null ?  //if not null check if empty
                                          recentCity :  //if empty return recent
                                          cities // cities.where((p){p.contains(this.query); }).toList()  //if not null or empty return item that contains
                                  : recentCity ; //if null return rescent
    
     

    print(suggestionList);

    return ListView.builder(
      itemBuilder: (context,index )  =>
        ListTile(
          onTap: (){
            showResults(context);
          },
          leading: Icon(Icons.location_city),
          title:RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0,query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey)
                )
              ]
            ),
          ),
        ),
    
      itemCount: suggestionList.length,
    );
  }

}