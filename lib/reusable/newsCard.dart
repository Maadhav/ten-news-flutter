import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:tennews/Screens/headlines.dart';
import 'newsList.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html_unescape/html_unescape.dart';

class NewsCard extends StatefulWidget {
  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard>
    with SingleTickerProviderStateMixin {
 var unescape = new HtmlUnescape();
List intList;
  TabController tabController;
  static DateTime now = DateTime.now();
  String formattedDate;
  List newsData;
  List topNews1;

  bool isLoading = true;
  final String toi= "https://timesofindia.indiatimes.com/";
  final String topNews =
      "https://timesofindia.indiatimes.com/navjson/nav-48986328.cms?preload=1";
  final String sportsNews =
      "https://timesofindia.indiatimes.com/navjson/nav-4719148.cms?preload=1";

  final String businessNews =
      "https://timesofindia.indiatimes.com/navjson/nav-1898055.cms?preload=1";

  final String worldNews =
      "https://timesofindia.indiatimes.com/navjson/nav-296589292.cms?preload=1 ";
  final String entertainmentNews =
      "https://timesofindia.indiatimes.com/navjson/nav-1081479906.cms?preload=1 ";
  final String educationNews =
      "https://timesofindia.indiatimes.com/navjson/nav-913168846.cms?preload=1 ";
  final String tvNews =
      "https://timesofindia.indiatimes.com/navjson/nav-17781976.cms?preload=1 ";
  final String electionNews =
      "https://timesofindia.indiatimes.com/navjson/nav-55110838.cms?preload=1";
  final String lifeNews =
      "https://timesofindia.indiatimes.com/navjson/nav-2886704.cms?preload=1 ";
  
  final String url =
      "https://newsapi.org/v2/top-headlines?sources=google-news-in&apiKey=ca8dea2ced7f40e6a26012eacad204ed";

  Future getData() async {
    List<Future> responseFutures = [
    http.get(
      Uri.encodeFull(url),
      headers: {
        HttpHeaders.authorizationHeader: "ca8dea2ced7f40e6a26012eacad204ed"
      },
    ),
    http.get(
      Uri.encodeFull(topNews),
    ),
    ];
    List response = await Future.wait(responseFutures);
    List data = jsonDecode(response[0].body)['articles'];
    List topNewsData = jsonDecode(response[1].body)['stories'];
    setState(() {
      newsData = data;
      topNews1 = topNewsData;
      isLoading = false;
      now = DateTime.now();
      formattedDate = DateFormat('kk:mm \n EEE d MMM').format(now);
       var length = newsData.length;
    intList= List.generate(length, (int index)=>index);
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData();
   
    tabController = TabController(vsync: this, length: 9);
  }

  @override
  Widget build(BuildContext context) {
    _feedback() async {
      const url = 'mailto:maadhav2001@gmail.com?subject=Feedback';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    // void _shareBottomSheet(context, index) {
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (BuildContext bc) {
    //         return Container(
    //           color: Colors.transparent,
    //           child: Container(
    //             padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
    //             decoration: new BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.only(
    //                     topLeft: const Radius.circular(25.0),
    //                     topRight: const Radius.circular(25.0))),
    //             child: Wrap(
    //               children: <Widget>[
    //                 ListTile(
    //                     leading: Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: GestureDetector(
    //                         child: Image.network(
    //                           newsData[index]['urlToImage'],
    //                         ),
    //                       ),
    //                     ),
    //                     title: Text(
    //                       newsData[index]['title'],
    //                       style: TextStyle(
    //                         fontSize: 20.0,
    //                         fontWeight: FontWeight.bold,
    //                         fontFamily: 'Nunito',
    //                       ),
    //                     ),
    //                     subtitle: Text(
    //                       newsData[index]['publishedAt'][11] +
    //                           newsData[index]['publishedAt'][12] +
    //                           newsData[index]['publishedAt'][13] +
    //                           newsData[index]['publishedAt'][14] +
    //                           newsData[index]['publishedAt'][15],
    //                       style: TextStyle(
    //                           fontWeight: FontWeight.bold,
    //                           color: Colors.grey[600]),
    //                     ),
    //                     onTap: () {}),
    //                 Divider(),
    //                 ListTile(
    //                     leading: Icon(Icons.share),
    //                     title: Text('Share this News'),
    //                     onTap: () {
    //                       Share.share(newsData[index]['title'] +
    //                           "  " +
    //                           newsData[index]['url']);
    //                     }),
    //                 ListTile(
    //                     leading: Icon(Icons.settings),
    //                     title: Text('Settings'),
    //                     onTap: () {}),
    //                 ListTile(
    //                     leading: Icon(Icons.help),
    //                     title: Text('Help & Feedback'),
    //                     onTap: _feedback),
    //               ],
    //             ),
    //           ),
    //         );
    //       });
    // }

    return RefreshIndicator(
        backgroundColor: Colors.black,
        onRefresh: getData,
        child: Center(
          child: Container(
            child: 
            isLoading
                ?Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ),
                  Text("Waiting for news to load..."),
                ]
          )
                : 
                ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      MoreNews("Top Ten Headlines"),
                      TopSlideshow(),
                      MoreNews("Categories"),
                      //         Padding(
                      //             padding: const EdgeInsets.only(left: 8.0, top: 10),
                      //             child: Text(
                      //               'Top News',
                      //               style:
                      //                   TextStyle(fontSize: 24, color: Colors.grey[700]),
                      //               textAlign: TextAlign.center,
                      //             ),
                      //           ),
                      //         TopSlideshow(),
                      //         Divider(thickness: 3),
                      //         MoreNews(),
                      TabBar(
                        labelPadding: EdgeInsets.all(5),
                        controller: tabController,
                        indicatorColor: Colors.blue,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey.withOpacity(1),
                        isScrollable: true,
                        tabs: <Widget>[
                          Tab(
                            child:category('National'),
                          ),
                          Tab(
                            child: category('World'),
                          ),
                          Tab(
                            child: category('Election'),
                          ),
                          Tab(
                            child: category('Sports'),
                          ),
                          Tab(
                            child: category('Business'),
                          ),
                          
                          Tab(
                            child: category('Education'),
                          ),
                          Tab(
                            child: category('Life and Style'),
                          ),
                          Tab(
                            child: category('Entertainment'),
                          ),
                          Tab(
                            child: category('TV'),
                          ),
                          ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight:1400,),
                        child: TabBarView(
                            controller: tabController,
                            children: <Widget>[
                              TopNews(),
                              NewsList(worldNews),
                              NewsList(electionNews),
                              NewsList(sportsNews),
                              NewsList(businessNews),
                              NewsList(educationNews),
                              NewsList(lifeNews),
                              NewsList(entertainmentNews),
                              NewsList(tvNews),
                            ]),
                            
                      ),
                     
                    ],
                  ),
          ),
        ));
  }

  category(text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(115)),
        color: Colors.blueAccent,
        border: Border.all(color: Colors.blueAccent, width: 3),
      ),
      padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
      child: Text(
        text,
        style: TextStyle(color: Colors.white,fontFamily: 'Nunito',fontWeight: FontWeight.bold,fontSize: 16),
      ),
    );
  }
  TopNews(){
    return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Headlines(
                              webUrl: toi + topNews1[index]['link'],
                              i: topNews1[index]['title'],
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
                                toi + topNews1[index]['imageurl']),
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
                            unescape.convert(topNews1[index]['title']),
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
          );
  }
  MoreNews(text2) {
    return Center(
      child: Text(
        text2,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );
  }

  TopSlideshow() {


    return Column(
      children: <Widget>[
        
        CarouselSlider(
          autoPlayInterval: Duration(seconds: 4),
             pauseAutoPlayOnTouch: Duration(seconds: 10),
          autoPlay: true,
          enlargeCenterPage: true,
          height: 300.0,
          items: intList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Headlines(webUrl: newsData[i]['url'], i: newsData[i]['title'],))),
                                      child: Container(
                      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                        margin: EdgeInsets.only(top: 25, right: 5, bottom: 25),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(newsData[i]['urlToImage']),
                                fit: BoxFit.cover),
                            border: Border.all(color: Colors.black, width: 3),
                            borderRadius: BorderRadius.all(Radius.circular(18))),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft:  Radius.circular(15),bottomRight:  Radius.circular(15)),
                                  color: Colors.black.withOpacity(1),
                                  border: Border.all(color: Colors.transparent, width: 3),
                                ),
                                child: Text(
                                  "${i+1}.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16.0,color: Colors.white),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  color: Colors.white.withOpacity(0.8),
                                  border: Border.all(color: Colors.transparent, width: 3),
                                ),
                                child: Text(
                                  newsData[i]['title'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          )),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
