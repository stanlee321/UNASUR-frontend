import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'header_appbar.dart';

String url = "http://192.168.8.6:3003";
//String url = "http://www.youtube.com";


// void main() => runApp(MyApp());


void main() {
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft])
    .then((_) {
      runApp(new MyApp());
    });
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to UNASUR',
      //theme: ThemeData(brightness: Brightness.dark),
      theme: ThemeData(
              primarySwatch: Colors.indigo),
      routes: {
        "/": (_) => Home(),
        "/webview": (_) => WebviewScaffold(
              url: url,                                                                                                                                                                                                         
              appBar: AppBar(
                title: Text(
                    "Domótica UNASUR",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
              withJavascript: true,
              withLocalStorage: true,
              withZoom: false,
            )
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends  State<Home>{

  final webView  = FlutterWebviewPlugin();
  TextEditingController controller = TextEditingController(text: url);

  @override
  void initState(){
    super.initState();

    webView.close();
    controller.addListener(() {
      url= controller.text;
    });

  }

  @override
  void dispose() {
    webView.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "UNASUR",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          
        ),
        body: Stack(
          children: <Widget>[
            HeaderAppBar(),
            Center(
              child: 
              ButtonTheme(
                minWidth: 200.0,
                height: 70.0,
                buttonColor: Colors.orange,
                child: RaisedButton(
                  child: Text(
                    "Abrir panel Domótico",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold
                    )
                  ),

                  onPressed: () {
                      Navigator.of(context).pushNamed("/webview");
                  },
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                )
              )
            ),
          ],
        ),
      bottomNavigationBar: BottomAppBar(
        child: Text(
          "Developed by www.deepmicrosystems.com",
          style: TextStyle(
          color: Colors.white,
          fontSize: 14.5,
          fontFamily: 'Lato',
          //fontWeight: FontWeight.bold
          )
        ),
        color: Colors.indigo),
      );
  }
}
