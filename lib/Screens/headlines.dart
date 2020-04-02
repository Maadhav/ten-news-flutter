import 'dart:io';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import '../reusable/newsCard.dart';

class Headlines extends StatefulWidget {
  final String webUrl;
  String i;
   Headlines({Key key, this.webUrl, this.i}) : super(key: key);
   share(){
    return (){
                    Share.share(i+'\n'+ webUrl+"\n\n" "Download TEN News Now:\nhttp://bit.ly/TENNews");
                  };
  }
  @override
  _HeadlinesState createState() => _HeadlinesState();
}

class _HeadlinesState extends State<Headlines> {
  
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
          displayZoomControls: false,
          resizeToAvoidBottomInset: true,
          withOverviewMode: true,
          withZoom: false,
          appCacheEnabled: true,
          enableAppScheme: true,
          scrollBar: false,
          withJavascript: false,
          persistentFooterButtons: <Widget>[

            FlatButton(
              child: Text("😀",style: TextStyle(fontSize: 30),),
              onPressed: (){},
              splashColor: Colors.yellowAccent,
              shape:  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            ),
            FlatButton(
              child: Text("😂",style: TextStyle(fontSize: 30),),
              onPressed: (){},
              splashColor: Colors.yellowAccent,
              shape:  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            ),
            FlatButton(
              child: Text("😔",style: TextStyle(fontSize: 30),),
              onPressed: (){},
              splashColor: Colors.yellowAccent,
              shape:  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            ),
            FlatButton(
              child: Text("😡",style: TextStyle(fontSize: 30),),
              onPressed: (){},
              splashColor: Colors.redAccent,
              shape:  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            )
          ],
          url: widget.webUrl,
          appBar: new AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              
               Text(widget.i),
               Text(widget.webUrl,
               style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),
              ]
            ),
            
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  child: Icon(Icons.share),
                  onTap: widget.share(),
                ),
              )
            ],
          ),  
        );
    }
}