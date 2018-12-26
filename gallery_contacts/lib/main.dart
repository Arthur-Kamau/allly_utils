import 'package:flutter/material.dart';


/**
 * this is the main entry point of the app
 * all the routes are added to enable navigation.
 */


//chat
import 'pages/chat/whats_app_clone.dart';



void main(){
  runApp(
    AllyHomePage()
  );
}


class AllyHomePage extends StatelessWidget {
 
  final routes = <String,WidgetBuilder>{

   
    //view all chats watsapp clone
    WhatsAppClone.tag : (context) => WhatsAppClone(),

   };

  @override
  Widget build(BuildContext context){
    return MaterialApp(
       title: "Mesages App",
       
       debugShowCheckedModeBanner: false,
       theme: new ThemeData(
        primaryColor: new Color(0xff075E54),
        accentColor: new Color(0xff25D366),
      ),
     
       home: WhatsAppClone(), //SetUpPage(), //MySplashScreen(), //MyLoginPage(),
       routes: routes,
    );
  }
}