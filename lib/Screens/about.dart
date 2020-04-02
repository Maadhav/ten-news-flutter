import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      AppBar(
        title: Text('About TEN News'),
      ),
      body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Text("Frustrated of watching a ton of news to update your self and still not getting what you were finding? Hence we have created TEN News which will update you with top 10 stories of hour. Our app has simple concept, we provide the best and latest trending and important news to the user.",style: TextStyle(fontSize: 20),),
SizedBox(height: 20,),
Text("Key features of 'TEN News':",style: TextStyle(fontSize: 20),textAlign: TextAlign.left,),

Text("► Only the Top 10 news of the moment",style: TextStyle(fontSize: 20),textAlign: TextAlign.left,),
Text("► News from the best sources in the world",style: TextStyle(fontSize: 20),),
Text("► No irritating ads",style: TextStyle(fontSize: 20),),
Text("► Share any news with your friends and family with a single click",style: TextStyle(fontSize: 20),),

SizedBox(height: 20,),
Text("Note: 'TEN News' is in it's Beta Stage so the app will be getting major updates.",style: TextStyle(fontSize: 20),),
Text("If you find any bug or want to give your valuable feedback do write it in the Feedback section of the app.",style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );  }
}