import 'package:ally_chat/database/database.dart';
import 'package:ally_chat/database/p2gChat.dart';
import 'package:ally_chat/model/chat_model.dart';
import 'package:ally_chat/core/user.dart';
import 'package:ally_chat/pages/attach_items/attach_items.dart';
import 'package:ally_chat/pages/group/group_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ally_chat/pages/chat/image_overlay.dart';

class P2GChatView extends StatefulWidget {
  static String tag = 'groups-chat-page';
  String groupId;
  String groupName;

  int contentText = 0;
  int contentImage = 1;
  int contentVideo = 2;
  int contentLocation = 3;

  int chatCategory = 0;

  int statusSending = 0;
  int statusReceived = 1;
  int statusViewed = 2;
  int statusDeleted = 3;

  int messageStatusOk = 0;
  int messageStatusEdited = 1;
  int messageStatusfailed = 2;
  int messageStatusforwaded = 3;

  P2GChatView({this.groupId, this.groupName});

  final WebSocketChannel channel =
      IOWebSocketChannel.connect('ws://echo.websocket.org');

  _P2GChatViewState createState() => _P2GChatViewState();
}

class _P2GChatViewState extends State<P2GChatView>
    with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();

  bool _isWritting = false;



  static const platform = const MethodChannel('com.araizen/modules/utils');
  Future<Map<dynamic, dynamic>> contactsData;

  String name = "";

  void initState() {
    super.initState();

//wait for message
    StreamBuilder(
      stream: widget.channel.stream,
      builder: (context, snapshot) {
        print(snapshot.hasData ? '${snapshot.data}' : '');
        return Text("message");
      },
    );
  } //end of initState

  // final List<Message> _message = <Message>[];

  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();
  Color primaryColor = Colors.grey;

  Color greyColor = Colors.grey;
  Color greyColor2 = Colors.black12;

  Widget showImage(String imagePath) {
    return new Container(
      height: 120.0,
      width: 120.0,

      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(60.0),
        shape: BoxShape.rectangle,
        image: DecorationImage(image: CachedNetworkImageProvider(imagePath)),
        color: Colors.red, //transparent,
      ),
      // new AssetImage(
      //     'assets/images/kenn.jpg'),
    );
  }

  Widget buildInput() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: <Widget>[
          // Button send image

          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.attach_file),
                onPressed: () {},
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: primaryColor, fontSize: 15.0),
                controller: _textController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: greyColor),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                // onPressed: () => onSendMessage(_textController.text, 0),
                color: primaryColor,
                onPressed:
                    _isWritting ? () => _submitMsg(_textController.text) : null,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  void _submitImage(String imagePath) async {
    _textController.clear();
    setState(() {
      _isWritting = false;
    });
    ChatP2GModel newChatItem = new ChatP2GModel(
        //  id: 1,

        senderPhoneNumber: User.phoneNumber,
        senderPublicName: User.name,
        senderId: User.userId,
        groupId: widget.groupId,
        statusType: widget.statusSending,
        messageStatus: widget.messageStatusOk,
        contentType: widget.contentImage,
        content: imagePath,
        createTime: DateTime.now(),
        updateTime: DateTime.now());

    // MyMessage msg = new MyMessage(
    //   chat: newChatItem,
    //   animationController: new AnimationController(
    //       vsync: this, duration: new Duration(milliseconds: 800)),
    // );

    _myMessage(newChatItem, context);

  
    // msg.animationController.forward();
    

    //insert into database message item
    //(ChatP2GModel achat, Database db)
    Database con =  await AllyDatabase().db;
    P2GDB().addp2gChat(newChatItem, con);

      setState(() {
     // mychattData.insert(0, newChatItem);
    });
  }

  void _submitMsg(String txt) async {
    print("\n\n\n submit message \n\n\n");

    _textController.clear();

    setState(() {
      _isWritting = false;
    });
    ChatP2GModel newChatItem = new ChatP2GModel(
        //  id: 1,
        senderPhoneNumber: User.phoneNumber,
        senderPublicName: User.name,
        senderId: User.userId,
        groupId: widget.groupId,
        statusType: widget.statusSending,
        messageStatus: widget.messageStatusOk,
        contentType: widget.contentImage,
        content: txt,
        createTime: DateTime.now(),
        updateTime: DateTime.now());

    // MyMessage msg = new MyMessage(
    //   chat: newChatItem,
    //   animationController: new AnimationController(
    //       vsync: this, duration: new Duration(milliseconds: 800)),
    // );

    _myMessage(newChatItem, context);
    
    // msg.animationController.forward();

    //send to server
    
     //insert into database message item
    //(ChatP2GModel achat, Database db)
    Database con =  await AllyDatabase().db;
    P2GDB().addp2gChat(newChatItem, con);

      setState(() {
     // mychattData.insert(0, newChatItem);
    });
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }

  Widget _menuVert(BuildContext context) {
    return PopupMenuButton(
        onSelected: (choice) {
          if (choice == PopMenuDetails.clearChatHistory) {
            print("clear chat history");
          } else if (choice == PopMenuDetails.deleteChat) {
            print("delete chat history item");
          } else if (choice == PopMenuDetails.peerCall) {
            print("call");
            _showCallOptionDialogue(context);
          } else if (choice == PopMenuDetails.reportChat) {
            print("report");
            // _showFeedbackDialog();
          } else if (choice == PopMenuDetails.searchtems) {
            print("search");
            // showSearch(
            //   context: context,
            //   delegate: ChatHistoryDataSearch(),
            // );
          }
        },
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (BuildContext context) {
          return PopMenuDetails.choices.map((String choice) {
            return PopupMenuItem(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        });
  }

  Widget _myMessage(ChatP2GModel mychat, BuildContext ctxt) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.blue,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("${mychat.content}"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          " ${mychat.updateTime.hour} : ${mychat.updateTime.minute} ",
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 8.0,
                              fontStyle: FontStyle.normal),
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Icon(
                          Icons.check,
                          size: 10.0,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.check,
                          size: 10.0,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateTody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
          height: 21.0,
          width: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.blue,
          ),
          child: Center(
            child: Text(
              "today",
              style:
                  TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  Widget _videoCallButton() {
    return GestureDetector(
      onTap: () {
        //call page
      },
      child: Container(
        margin: EdgeInsets.all(1.0),
        width: 55.0,
        height: 90.0,
        child: Column(
          children: <Widget>[
            Material(
              type: MaterialType.circle,
              child: InkWell(
                  child: Container(
                    child:
                        Icon(Icons.video_call, size: 20.0, color: Colors.white),
                    width: 40.0,
                    height: 40.0,
                  ),
                  onTap: () {}),
              elevation: 12.0,
              color: Colors.blue,
            ),
            SizedBox(height: 15.0),
            Text(
              "Video",
              style: TextStyle(color: Colors.black, fontSize: 15.0),
            )
          ],
        ),
      ),
    );
  }

  Widget _audioCallButton() {
    return GestureDetector(
      onTap: () {
        //audio call
      },
      child: Container(
        margin: EdgeInsets.all(1.0),
        width: 55.0,
        height: 90.0,
        child: Column(
          children: <Widget>[
            Material(
              type: MaterialType.circle,
              child: InkWell(
                  child: Container(
                    child: Icon(Icons.mic, size: 20.0, color: Colors.white),
                    width: 40.0,
                    height: 40.0,
                  ),
                  onTap: () {}),
              elevation: 12.0,
              color: Colors.blue,
            ),
            SizedBox(height: 15.0),
            Text(
              "Audio",
              style: TextStyle(color: Colors.black, fontSize: 15.0),
            )
          ],
        ),
      ),
    );
  }

  Future<Null> _showCallOptionDialogue(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Call Option'),
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.all(1.0),
                // height: 150.0,
                // width: 450.0,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 5.0,
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        /* Navigator.pop(context, Department.treasury); */
                      },
                      child: _videoCallButton(),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        /* Navigator.pop(context, Department.state); */
                      },
                      child: _audioCallButton(),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget _cameraButton() {
    return Container(
      margin: EdgeInsets.all(1.0),
      width: 40.0,
      height: 40.0,
      child: Row(
        children: <Widget>[
          Material(
            type: MaterialType.circle,
            child: InkWell(
                child: Container(
                  child:
                      Icon(Icons.camera_alt, size: 20.0, color: Colors.white),
                  width: 40.0,
                  height: 40.0,
                ),
                onTap: () {}),
            elevation: 12.0,
            color: Colors.blue,
          ),
          SizedBox(width: 10.0),
          Text(
            "Camera",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          )
        ],
      ),
    );
  }

  Widget _videoButton() {
    return Container(
      margin: EdgeInsets.all(1.0),
      width: 40.0,
      height: 40.0,
      child: Row(
        children: <Widget>[
          Material(
            type: MaterialType.circle,
            child: InkWell(
                child: Container(
                  child:
                      Icon(Icons.video_call, size: 20.0, color: Colors.white),
                  width: 40.0,
                  height: 40.0,
                ),
                onTap: () {}),
            elevation: 12.0,
            color: Colors.blue,
          ),
          SizedBox(width: 10.0),
          Text(
            "Video",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          )
        ],
      ),
    );
  }

  Widget _galleryButton() {
    return Container(
      margin: EdgeInsets.all(1.0),
      width: 40.0,
      height: 40.0,
      child: Row(
        children: <Widget>[
          Material(
            type: MaterialType.circle,
            child: InkWell(
                child: Container(
                  child: Icon(Icons.photo_size_select_actual,
                      size: 20.0, color: Colors.white),
                  width: 40.0,
                  height: 40.0,
                ),
                onTap: () {}),
            elevation: 12.0,
            color: Colors.blue,
          ),
          SizedBox(width: 10.0),
          Text(
            "Gallery",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          )
        ],
      ),
    );
  }

  Future<Null> _showAttachDialogue(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('File Source'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  /* Navigator.pop(context, Department.treasury); */
                },
                child: _cameraButton(),
              ),
              SimpleDialogOption(
                onPressed: () {/* Navigator.pop(context, Department.state); */},
                child: _videoButton(),
              ),
              SimpleDialogOption(
                onPressed: () {/* Navigator.pop(context, Department.state); */},
                child: _galleryButton(),
              ),
            ],
          );
        });
  }

  Widget _buildComposer(BuildContext context) {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 9.0),
          child: new Row(
            children: <Widget>[
              new Container(
                child: IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttachItems(
                            intent: 3,
                            chatId: "",
                            senderId: "",
                            senderPhoneNumber: "",
                            recepientId: "",
                            recepientPhoneNumber: "",
                            groupId: widget.groupId,
                            groupName: widget.groupName),
                      ),
                    );
                  },
                ),
              ),
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onChanged: (String txt) {
                    setState(() {
                      _isWritting = txt.length > 0;
                    });
                  },
                  onSubmitted: _submitMsg,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Enter Message"),
                ),
              ),
              new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 3.0),
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? new CupertinoButton(
                          child: new Text("Submit"),
                          onPressed: _isWritting
                              ? () => _submitMsg(_textController.text)
                              : null)
                      : new IconButton(
                          icon: new Icon(Icons.send),

//send message
                          onPressed: _isWritting
                              ? () => _submitMsg(_textController.text)
                              : null,
                        ))
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border:
                      new Border(top: new BorderSide(color: Colors.brown[200])))
              : null),
    );
  }

  int contentText = 0;
  int contentImage = 1;
  int contentVideo = 2;
  int contentLocation = 3;

  Widget showApprpriateWidget(ChatP2GModel item, BuildContext context) {
    print("show result text ${item.contentType}");
    if (item.contentType == contentText) {
      return _showTextWidget(item.content, context);
    } else if (item.contentType == contentImage) {
      return _showImageWidget(item.content, context);
    } else if (item.contentType == contentVideo) {
      return _showVideoWidget(item.content);
    } else if (item.contentType == contentLocation) {
      return _showLocationWidget(item.content);
    } else {
      return _showerrorWidget();
    }
  }

  Widget _showerrorWidget() {
    return Text("error");
  }

  Widget _showTextWidget(String txt, BuildContext context) {
    print("show  text $txt");
    return Text("$txt");
  }

  void _showOverlay(BuildContext context, String imagePath) {
    Navigator.of(context).push(ImageOverlay(imagePath: imagePath));
  }

  Widget _showImageWidget(String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showOverlay(context, imagePath);
      },
      child: Container(
        height: 130.0,
        width: 130.0,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(60.0),
          shape: BoxShape.rectangle,
          image: DecorationImage(image: CachedNetworkImageProvider(imagePath)),
          color: Colors.red, //transparent,
        ),
      ),
    );
  }

  Widget _showVideoWidget(String videoPath) {
    return Text(videoPath);
  }

  Widget _showLocationWidget(String location) {
    return Text(location);
  }

  Widget _receivedMessage(BuildContext context, ChatP2GModel chat,
      AnimationController animationController) {
    print("receievd function  mesage ${chat.content}");
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.blue,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: Center(
                      child: showApprpriateWidget(chat, context),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        " ${chat.updateTime.hour} : ${chat.updateTime.second} ",
                        style: TextStyle(
                            fontSize: 8.0, fontStyle: FontStyle.normal),
                      ),
                      Icon(
                        Icons.check,
                        size: 15.0,
                        color: Colors.white,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _messageItem(BuildContext ctxt, int index, ChatP2GModel mychattData) {
    if (mychattData.senderId == User.userId) {
      print("my mesage ${mychattData.content}");
      return _myMessage(mychattData, ctxt);
      //
      //   animationController: new AnimationController(
      //       vsync: this, duration: new Duration(milliseconds: 800)),
      // );
    } else {
      print("receievd  mesage ${mychattData.content}");

      return _receivedMessage(
          ctxt,
          mychattData,
          new AnimationController(
              vsync: this, duration: new Duration(milliseconds: 800)));
    }
  }


Future<List<ChatP2GModel>> getGroupChatsFromDatabase() async{
  

 Database conn = await AllyDatabase().db;
     Future<List<ChatP2GModel>> mychattData_ =  P2GDB().getp2gChats(conn, widget.groupId);


return mychattData_;
}

Widget bodyContainerContents(List<ChatP2GModel> mychattData){
  return  new Column(children: <Widget>[
            new Flexible(
                child: ListView.builder(
              itemCount: mychattData.length,
              itemBuilder: (BuildContext ctxt, int index) {
                //BuildContext ctxt, int index,ChatModel  mychattData
                return _messageItem(ctxt, index, mychattData[index]);
              },
              reverse: true,
              padding: new EdgeInsets.all(6.0),
            )),
            new Divider(height: 1.0),
            new Container(
              child: _buildComposer(context),
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
            ),
          ]);
}

List<ChatP2GModel> sortSnapShortData(List<ChatP2GModel> myChattData ){
  //sort the list by creation time

    myChattData.sort((a, b) {
      // return a['name'].toLowerCase().compareTo(b['name'].toLowerCase());
      return a.createTime.compareTo(b.createTime);
    });

    //reverse the sort list
    //list builder starts from the bottom
    //reverse the content s as to match the reverssed lis ( - - - = +)
    Iterable inReverse = myChattData.reversed;

 List<ChatP2GModel>    mychattData = inReverse.toList();

    print("my chat ${mychattData.length}");

return mychattData;

}

Widget _bodyContainer(){
   return new FutureBuilder(
        future: getGroupChatsFromDatabase(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            //sor the list and pass it into bodyContainerContents
            return bodyContainerContents(sortSnapShortData(snapshot.data));
          } else if (snapshot.error) {
            return Center(
              child: Text("No Chats"),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.blue,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: GestureDetector(
              child: Text(widget.groupName), //Text(name),//_getSenderName()),
              onTap: () {
                print("public profile view");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupsDetails(
                          groupId: widget.groupId,
                        ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.call),
                onPressed: () {
                  _showCallOptionDialogue(context);
                },
              ),
              _menuVert(context),
            ],
          ),
          body: _bodyContainer()
        ));
  }
}

class PopMenuDetails {
  static const String exportChat = 'Export chat ';
  static const String reportChat = 'Report';
  static const String searchtems = 'Search';
  static const String attachItems = 'Attach item';
  static const String peerCall = 'Call';
  static const String background = 'Background';
  static const String styleMessages = 'Colorify';

  static const String deleteChat = 'delete chat';
  static const String clearChatHistory = 'clear history';

  static const List<String> choices = [
    // attachItems,
    // exportChat,
    searchtems,
    // background,
    // styleMessages,
    reportChat,
    deleteChat,
    clearChatHistory,
  ];
}


class MyMessage extends StatelessWidget {
  MyMessage({this.chat, this.animationController, context});
  final ChatP2GModel chat;
  BuildContext context;
  final AnimationController animationController;

  int contentText = 0;
  int contentImage = 1;
  int contentVideo = 2;
  int contentLocation = 3;

  Widget showApprpriateWidget(ChatP2GModel item) {
    if (item.contentType == contentText) {
      return _showTextWidget(item.content);
    } else if (item.contentType == contentImage) {
      return _showImageWidget(item.content);
    } else if (item.contentType == contentVideo) {
      return _showVideoWidget(item.content);
    } else if (item.contentType == contentLocation) {
      return _showLocationWidget(item.content);
    } else {
      return _showerrorWidget();
    }
  }

  Widget _showerrorWidget() {
    return Text("error");
  }

  Widget _showTextWidget(String txt) {
    return Text(txt);
  }

  Widget _showImageWidget(String imagePath) {
    return new Container(
      height: 120.0,
      width: 120.0,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(60.0),
        shape: BoxShape.circle,
        image: DecorationImage(
            image: CachedNetworkImageProvider(
                'https://images.pexels.com/photos/935969/pexels-photo-935969.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')),
        color: Colors.red, //transparent,
      ),
    );
  }

  Widget _showVideoWidget(String videoPath) {
    return Text(videoPath);
  }

  Widget _showLocationWidget(String location) {
    return Text(location);
  }

  Widget _myMessage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.blue,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(8.0),
                      child: showApprpriateWidget(chat)),
                  Container(
                    margin: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "${chat.updateTime.hour} : ${chat.updateTime.second}",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 8.0,
                              fontStyle: FontStyle.normal),
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Icon(
                          Icons.check,
                          size: 10.0,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.check,
                          size: 10.0,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext ctx) {
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController, curve: Curves.bounceOut),
        axisAlignment: 0.0,
        child: _myMessage(ctx));
  }
}
