import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';


const URL = "http://www.bancounion.com.bo/";


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends  State<Home>{
  Future launchURL(String url) async {
    if (await canLaunch(url)){
      await launch(url,  forceSafariVC:true, forceWebView:true);
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('WebView'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child:Text(URL)
              ),
              RaisedButton(
                child: Text("Open Link"),
                onPressed: (){},
              )
            ],
          ),
        ),
      );
  }
  
}