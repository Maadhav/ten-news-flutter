import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:tennews/Screens/headlines.dart';
import 'package:html_unescape/html_unescape.dart';

class NewsList extends StatefulWidget {
  @override
  NewsList(this.url);
  String url;
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final String toi = "https://timesofindia.indiatimes.com";
  var unescape = new HtmlUnescape();
  var getdata;
    bool isLoading = true;

  Future builder() async{
    var response = await http.get(
      Uri.encodeFull(widget.url),
    );
    setState(() {
      getdata = jsonDecode(response.body)['items'][0]['stories'];
      isLoading = false;
    });
    
  }


  Widget getDatafromApi() {
    return FutureBuilder(
      future: builder(),
      builder: (context, snapshot) {
        return Container(
          child: isLoading? Text(""):ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Headlines(
                              webUrl: toi + getdata[index]['link'],
                              i: getdata[index]['title'],
                            ))),
                child: Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(0),
                        width: 90,
                        height: 90,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          child: FadeInImage(
                            image: NetworkImage(
                                toi + getdata[index]['imageurl']),
                            placeholder: AssetImage('Assets/na.jpg'),
                            fit: BoxFit.cover,
                            fadeInDuration: Duration(milliseconds: 1),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            unescape.convert(getdata[index]['title']),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.share,size: 1,),
                      //   onPressed: (){
                      //   Share.share(widget.newsData[index]['title']+'\n'+ toi+widget.newsData[index]['link']+"\n\n" "Download TEN News Now:\nhttp://bit.ly/TENNews");
                      // }
                      // )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return getDatafromApi();
  }
}
