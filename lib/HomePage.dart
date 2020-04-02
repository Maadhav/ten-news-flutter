import 'package:flutter/material.dart';
import 'reusable/newsCard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:io';



class HomePage extends StatefulWidget {

  //Step1 for bottomSheet
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var now = new DateTime.now();
  AssetImage newsLogo = AssetImage('Assets/google-news-logo.png');

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: widget.scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(),
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: FittedBox(
                              child: Text(
                  'top ten news',
                  style: TextStyle(
                      fontFamily: 'Notable', color: Colors.black, fontSize: 35),
                ),
              ),
            ),
            
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap:(){ 
                _userBottomSheet(context);
               //2nd and last Step for bottomsheet
          //       widget.scaffoldKey.currentState
          // .showBottomSheet((context) => Container(
          //       color: Colors.red,
          //       height: 200,
          //     ));
              },
                child:Icon(
                    Icons.info_outline,
                    color: Colors.black,
                    size: 30,
                  )
            ),
          ),
        ],
      ),
      drawer: _drawerMenu(context),
      body: NewsCard(),
    );
  }
}
_feedback() async {
  const url = 'mailto:maadhav2001@gmail.com?subject=Feedback';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
_rate() async {
  const url = 'http://bit.ly/TENNews';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
Drawer _drawerMenu(context){
      
      return Drawer( 
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("ten news",style: TextStyle(fontFamily: 'Notable',color: Colors.white,fontSize: 20),),
              accountEmail: Text('Top 10 news of the moment',
              style: TextStyle(fontFamily: 'Nunito',fontSize: 16),),
              currentAccountPicture: CircleAvatar(
                child: Image.network('https://lh3.googleusercontent.com/kpoUSQ69R95UAH_Af7wfjhfNsVso4kGroO8F2NuDwm2_RIXNGxIqKMRoJ2EX98VUSF0=s360-rw')
              ),
            ),
           ListTile(
              title: Text('Version: 0.6',style: TextStyle(fontWeight: FontWeight.bold),),
              onTap:  (){}
            ),
            ListTile(
              title: Text('Feedback'),
              trailing: Icon(Icons.feedback),
              onTap:  _feedback,
            ),
            ListTile(
              onTap: _rate,
              title: Text('Rate Us'),
              trailing: Icon(Icons.star),
             ),
             ListTile(
              enabled: true,
              title: Text('About'),
              trailing: Icon(Icons.help_outline),
              onTap: () => Navigator.of(context).pushNamed("/about"),
            ),
             
             Divider(),
            //   ListTile(
            //   title: Text('MAscot'),
            //   trailing: Icon(Icons.android),
            // ),
            ListTile(
              title: Text('Close'),
              trailing: Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
       )
        );
}
void _userBottomSheet(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
          return Container(
      child: Container(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
        decoration: new BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0))),
        child: Wrap(
          children: <Widget>[
            ListTile(   
              contentPadding: EdgeInsets.all(10),
                leading: Image.network('https://lh3.googleusercontent.com/kpoUSQ69R95UAH_Af7wfjhfNsVso4kGroO8F2NuDwm2_RIXNGxIqKMRoJ2EX98VUSF0=s360-rw'),
                title: Text('TEN NEWS',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                subtitle: Text("Keep updating yourselves",style: TextStyle(fontSize: 19),),
                trailing: Text('0.6',style: TextStyle(fontWeight: FontWeight.bold),),
                onTap: () {}),
            Divider(),
            ListTile(
                leading: Icon(Icons.help),
                title: Text('Help & Feedback'),
                onTap: _feedback),
            ListTile(
                enabled: false,
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
                onTap: () {}),
            ListTile(
              enabled: false,
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {}),
            
          ],
        ),
      ),
    );
      }
    );
}
