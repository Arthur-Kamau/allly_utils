import 'dart:math';
import 'package:flutter/material.dart';
import 'package:database_ally/model/operations_models/interest_model.dart';


class SelectInterestMany extends StatefulWidget {
  static String tag = 'interests-select-many-page';
  _SelectInterestManyState createState() => _SelectInterestManyState();
}

class _SelectInterestManyState extends State<SelectInterestMany> {

List <String> users_interst_db = [];

  void initState() { 
    super.initState();
    //get users interest from db
    get_users_interest_from_db();
  }

  void get_users_interest_from_db(){

  }
  Widget appBar(BuildContext context) {
    return new AppBar(

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            
                Navigator.pop(context, users_interst_db);
          },
        ),
        backgroundColor: Colors.blue,
        title: new Text("Selct interests"),
        elevation: 0.7,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SelectInterestManyDataSearch(),
              );
            },
          )
        ]);
  }

  final List<String> popupRoutes = <String>["Properties", "Delete", "Leave"];

  String selectedPopupRoute = "Properties";


  void _showPopupMenu(BuildContext context) {
    showMenu<String>(
      context: context,
      //initialValue: selectedPopupRoute,
      //position: new RelativeRect.fromLTRB(40.0, 60.0, 100.0, 100.0),
      items: popupRoutes.map((String popupRoute) {
        return new PopupMenuItem<String>(
          child: new ListTile(
              //leading: const Icon(Icons.visibility),
              title: new Text(popupRoute),
              onTap: () {
                setState(() {
                  print("onTap [${popupRoute}] ");
                  selectedPopupRoute = popupRoute;

                  Navigator.pop(context);
                });
              }),
          value: popupRoute,
        );
      }).toList(),
    );
  }

  double posx = 100.0;
  double posy = 100.0;

  void onTapDown(BuildContext context, TapDownDetails details) {
    print('tapdown ${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
    });
  }

  Widget _generateUserChar(String userInterest,String category) {
  

var  random = Random();
int colorint = random.nextInt(10);
List<Color> colors = [
  Colors.yellow,
    Colors.black38,  Colors.brown,
    Colors.blue, Colors.amberAccent,  Colors.teal,
    Colors.orange,  Colors.indigo,  Colors.cyanAccent,


];
    return Container(
      
         height: 50.0,
        width: 50.0,
        alignment: Alignment.center,
         decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(45.0)),
        color:colors[colorint],
      ),
      child: Text("$category",style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
        color: Colors.white
      ),),
    );
  }

  Widget _userPicture(String imagePath) {
    return Container(
      child: Image.asset(
        imagePath,
        height: 50.0,
        width: 50.0,
      ), //Image.asset('/assets/images/avatar.jpg'),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(45.0)),
        color: Colors.transparent,
      ),
    );
  }

  bool _interestIsSelected (String interest){
    if(users_interst_db != null && users_interst_db.length > 0 && users_interst_db.contains(interest) ) {
return true;
                      }else{
                        return false;
                      }
  }

  Widget interestList(BuildContext context) {
    return new ListView.builder(
      itemCount: interest_list.length,
      itemBuilder: (context, i) => new Column(
            children: <Widget>[
              
              new ListTile(
                
                onTap: () {
                  print("contact choi");
                },
              // leading:_generateUserChar(interest_list[i].interst,interest_list[i].category) ,
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      interest_list[i].interst,
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    Checkbox(
                      value: _interestIsSelected(interest_list[i].interst),
                      
                      onChanged: (newVal) {
                        print("$newVal");
                        setState(() {
                          if(newVal){
                          users_interst_db.add(interest_list[i].interst);
                          }else{
                            users_interst_db.remove(interest_list[i].interst);
                          }
                          //_interestIsSelected(interest_list[i].interst);
                        //if( _interestIsSelected(interest_list[i].interst))  ? false : true;                       
                        });
                      },
                    )
                  ],
                ),
                // subtitle: new Container(
                //   padding: const EdgeInsets.only(top: 2.0),
                //   child: new Text(interest_list[i].category,
                //       style: new TextStyle(color: Colors.grey, fontSize: 12.0)),
                // ),
              ),
              new Divider(
                height: 2.0,
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: appBar(context),
      body: interestList(context),
    );
  }
}

class SelectInterestManyDataSearch extends SearchDelegate<String> {
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
