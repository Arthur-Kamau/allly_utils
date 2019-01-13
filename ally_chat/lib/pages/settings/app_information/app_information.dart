
import 'package:ally_chat/pages/settings/app_information/app_information_deails.dart';
import 'package:ally_chat/pages/settings/app_information/app_information_developers.dart';
import 'package:flutter/material.dart';

class AppInformationPolicy extends StatefulWidget {
  static String tag = 'app-information-page';
  _AppInformationPolicyState createState() => _AppInformationPolicyState();
}

class _AppInformationPolicyState extends State<AppInformationPolicy> 
with SingleTickerProviderStateMixin{
 
  TabController _tabController;

  @override
   void initState() {
       // TODO: implement initState
       super.initState();
       _tabController = new TabController(vsync: this,initialIndex: 1,length:  6);
     }

 Widget _appbar(){
   return AppBar(
     backgroundColor: Colors.blue,
     title: Text("App Information"),
     bottom: new TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          isScrollable: true,
          tabs: <Widget>[
           new Tab(
              icon: new Text(
                "Information",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              )
            ),

            new Tab(
              icon: new Text(
                "Developers",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              )
            ),
          ]
     )
   );
 }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar() ,
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
         
          new AppInformtaionDetails(),
          new AppInformationDevelopers(),
      


        ],
      ),
    );
  }
}
//  Widget _contents(){
//    return Container(
//      child:  Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              "Ally Super App",
//              style: TextStyle(
//                fontWeight: FontWeight.bold,
//                fontSize: 18.0
//              ),
//            ),
//            SizedBox(height: 10.0,),

//             Text(
//              "Version 4.0.0",
//              style: TextStyle(
//                fontWeight: FontWeight.normal,
//                fontSize: 15.0
//              ),
//            ),

//            SizedBox(height: 10.0,),

//            CircleAvatar(
//              child: Image.asset("assets/icons/Ally_icon_Blue.png"),
//              maxRadius: 55.0,
//              minRadius: 50.0,
//              backgroundColor: Colors.white,
//            ),

//            SizedBox(height: 20.0,),

//            Text(
//              "\t   2010 - ${DateTime.now().year} \n All rights reserved",
//              style: TextStyle(
//                fontWeight: FontWeight.normal,
//                fontSize: 12.0
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _appbar() ,
//       body: _contents(),//Center( child:  Text("informations"),),
//     );
//   }
// }