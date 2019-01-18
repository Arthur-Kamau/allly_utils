import 'package:ally_chat/model/operations_models/chat_model.dart';
import 'package:ally_chat/model/operations_models/contact_model.dart';
import 'package:ally_chat/core/user.dart';
import 'package:ally_chat/database/db.dart';
import 'package:ally_chat/database/p2pChat.dart';
import 'package:ally_chat/pages/attach_items/attach_items.dart';
import 'package:ally_chat/pages/chat/chat_history.dart';
import 'package:ally_chat/pages/person/person_chat_view.dart';
import 'package:ally_chat/pages/person/person_profile.dart';
import 'package:ally_chat/pages/transition/slide_right_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ally_chat/pages/chat/image_overlay.dart';

/**
* int chat type
  *chat type
    0 => p2p
    1 => peer/person to group
*
* int chat status type
*	 0->Sending
*	 1->Received
*	 2->Deleted
*	 3->Viewed
*
* int message status type
*	0->ok (not edited or deleted)
*	1 -> edited
*	2 -> failed
*	3 -> forwaded
*
* int content type
*	 0 -> text
*	 1	-> Image
*	 2  ->Video
*	 3   ->Location(Maps)
*
*  int chat category
*	0 -> main chat
*	1 -> poke
 */

//review this
class P2PChatView extends StatefulWidget {
  static String tag = 'chat-view-page';
  String chatId;
  String senderId;
  String senderPhoneNumber;
  String recepientId;
  String recepientPhoneNumber;

  int chatType = 0;

  int contentText = 0;
  int contentImage = 1;
  int contentVideo = 2;
  int contentLocation = 3;
  int contentImageWthText = 4;
  int contentAudio = 5;
  int contentApk = 6;
  int contentContact = 7;

  int chatCategory = 0;

  int statusSending = 0;
  int statusReceived = 1;
  int statusViewed = 2;
  int statusDeleted = 3;

  int messageStatusOk = 0;
  int messageStatusEdited = 1;
  int messageStatusfailed = 2;
  int messageStatusforwaded = 3;

  P2PChatView(
      {this.chatId,
      this.senderId,
      this.recepientId,
      this.senderPhoneNumber,
      this.recepientPhoneNumber}) {
    if (senderPhoneNumber != User.phoneNumber) {
      print(
          "\n\n cons $senderPhoneNumber - ${User.phoneNumber}am recieivng --------\n\n");
    } else {
      print(
          "\n\n cons $senderPhoneNumber -- ${User.phoneNumber} am, sending -------- \n\n");
    }
  }

  final WebSocketChannel channel =
      IOWebSocketChannel.connect('ws://echo.websocket.org');

  _P2PChatViewState createState() => _P2PChatViewState();
}

class _P2PChatViewState extends State<P2PChatView>
    with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();

  bool _isWritting = false;

  //filter chats list to chat with the chat id
  List<ChatP2PModel> mychattData_ = new List();
  List<ChatP2PModel> mychattData = new List();

  static const platform = const MethodChannel('com.araizen/modules/utils');
  Future<Map<dynamic, dynamic>> contactsData;

  String name = "";
  String phoneNumber = "";

  Future<Map<dynamic, dynamic>> _getContacts() async {
    Map<dynamic, dynamic> _conts = {};

    try {
      _conts =
          await platform.invokeMethod('getContacts') as Map<dynamic, dynamic>;
    } on PlatformException catch (e) {
      print("\n\n Failed to get ciontacts : '${e.message}'. \n\n");
    }

    return _conts;
  }

  void initState() {
    //get all contacts
    // contactsData =  _getContacts();

    super.initState();

    for (var i = 0; i < chattData.person_to_person.length; i++) {
      if (chattData.person_to_person[i].chatId == widget.chatId) {
        mychattData_.add(chattData.person_to_person[i]);
      }
    }

    //sort the list by creation time

    mychattData_.sort((a, b) {
      // return a['name'].toLowerCase().compareTo(b['name'].toLowerCase());
      return a.createTime.compareTo(b.createTime);
    });

    //reverse the sort list
    //list builder starts from the bottom
    //reverse the content s as to match the reverssed lis ( - - - = +)
    Iterable inReverse = mychattData_.reversed;

    mychattData = inReverse.toList();

    print("my chat ${mychattData.length}");

//wait for message
    StreamBuilder(
      stream: widget.channel.stream,
      builder: (context, snapshot) {
        print(snapshot.hasData ? '${snapshot.data}' : '');
        return Text("message");
      },
    );
  } //end of initState

  Widget _renderSenderName(
      Map<dynamic, dynamic> values, String compareAgainst) {
    for (var i = 0; i < values.length; i++) {
      String key = values.keys.elementAt(i);
      print(
          "_renderSenderName am checking ${widget.senderPhoneNumber} vs ${values[key]}");
      if (values[key] == compareAgainst) {
        name = key;
        phoneNumber = values[key];
      }
    }

    if (name != null) {
      if (name.isNotEmpty) {
        return Text(name);
      } else {
        //return number
        return Text(widget.senderPhoneNumber);
      }
    } else {
      return Text("error");
    }
  }

  //string get username
  Widget _getSenderName(BuildContext context, AsyncSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.data;

    if (widget.senderPhoneNumber != User.phoneNumber) {
      print(
          "\n\n ${widget.senderPhoneNumber} -- ${User.phoneNumber}am recieivng --------\n\n");
      return _renderSenderName(values, widget.senderPhoneNumber);
    } else {
      print(
          "\n\n ${widget.senderPhoneNumber} -- ${User.phoneNumber} am, sending -------- \n\n");
      return _renderSenderName(values, widget.recepientPhoneNumber);
    }
  }

  Widget _showAppropriatewidget() {
//    if(_contacts.length > 0){
    return Container(
        child: FutureBuilder<Map<dynamic, dynamic>>(
      future: _getContacts(), //_calculateDistance( model,  store),
      initialData: {"User": "Data"}, //0.0,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _getSenderName(context, snapshot);
        } else if (snapshot.hasError) {
          return Text("errror ${snapshot.error}");
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
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
    ChatP2PModel newChatItem = new ChatP2PModel(
        //  id: 1,

        recepientId: widget.senderId,
        senderId: User.userId,
        statusType: widget.statusSending,
        chatId: widget.chatId,
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

    setState(() {
      mychattData.insert(0, newChatItem);
    });
    // msg.animationController.forward();
    Database con = await AllyNativeDb().db();

    //insert into database message item
    //(ChatP2PModel achat, Database db)
    P2PDB().addp2pChat(newChatItem, con);
  }

  void _submitMsg(String txt) async {
    print("\n\n\n submit message \n\n\n");

    _textController.clear();

    setState(() {
      _isWritting = false;
    });
    ChatP2PModel newChatItem = new ChatP2PModel(
        //  id: 1,

        recepientId: widget.senderId,
        senderId: User.userId,
        statusType: widget.statusSending,
        chatId: widget.chatId,
        messageStatus: widget.messageStatusOk,
        contentType: widget.contentText,
        content: txt,
        createTime: DateTime.now(),
        updateTime: DateTime.now());

    // MyMessage msg = new MyMessage(
    //   chat: newChatItem,
    //   animationController: new AnimationController(
    //       vsync: this, duration: new Duration(milliseconds: 800)),
    // );

    _myMessage(newChatItem, context);
    setState(() {
      mychattData.insert(0, newChatItem);
    });
    // msg.animationController.forward();

    //send to server
    print("online");
    widget.channel.sink.add({
      "name": "kamau",
      "userId": "John",
      "token": "25",
      "userAgent": "techmo m7"
    });
    // Database con = await AllyNativeDb().db();

    //insert into database message item
    //(ChatP2PModel achat, Database db)
    // P2PDB().addp2pChat(newChatItem, con);
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
            showSearch(
              context: context,
              delegate: ChatHistoryDataSearch(),
            );
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

  Widget _myMessage(ChatP2PModel mychat, BuildContext ctxt) {
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
                    //  Navigator.pushNamed(context, AttachItems.tag);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttachItems(
                            intent: 2,
                            chatId: widget.chatId,
                            senderId: widget.senderId,
                            senderPhoneNumber: widget.senderPhoneNumber,
                            recepientId: widget.recepientId,
                            recepientPhoneNumber: widget.recepientPhoneNumber,
                            groupId: "",
                            groupName: ""),
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

  Widget showApprpriateWidget(ChatP2PModel item, BuildContext context) {
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

  Widget _receivedMessage(BuildContext context, ChatP2PModel chat,
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

  Widget _messageItem(BuildContext ctxt, int index, ChatP2PModel mychattData) {
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
                print("\n\n pressed \n\n");
                //show chat history

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatHistory(),
                  ),
                );
              },
            ),
            title: GestureDetector(
              child: _showAppropriatewidget(), //Text(name),//_getSenderName()),
              onTap: () {
                print("public profile view");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserPublicProfilePage(
                          phoneNumber: phoneNumber,
                          userName: name,
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
          body: new Column(children: <Widget>[
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
          ]),
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

class MyMessage extends StatelessWidget {
  MyMessage({this.chat, this.animationController, context});
  final ChatP2PModel chat;
  BuildContext context;
  final AnimationController animationController;

  int contentText = 0;
  int contentImage = 1;
  int contentVideo = 2;
  int contentLocation = 3;

  Widget showApprpriateWidget(ChatP2PModel item) {
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
