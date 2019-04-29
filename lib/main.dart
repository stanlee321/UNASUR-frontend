import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'header_appbar.dart';
//import 'package:http/http.dart' as http;

String url = "http://192.168.8.6:3003";
//String url = "http://www.youtube.com";

// void main() => runApp(MyApp());

void main() {
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft])
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
      theme: ThemeData(primarySwatch: Colors.indigo),
      routes: {
        "/": (_) => Home(),
        "/webview": (_) => WebviewScaffold(
            url: url,
            appBar: AppBar(
              title: Text("Domótica UNASUR",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold)
                  ),
            ),
            withJavascript: true,
            withLocalStorage: true,
            withZoom: false,
            withLocalUrl: true,
            hidden: true,
            initialChild: Container(
              child: Center(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Si tarda demaciado, Verificar Servidor.',
                            style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold)
                        ),
                        SizedBox(height: 40),
                        CircularProgressIndicator(strokeWidth: 8.0,)
                      ],
                    ),
                  ),
                )
            ),
        ),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final webView = new FlutterWebviewPlugin();
  TextEditingController controller = TextEditingController(text: url);

  // On destroy stream
  StreamSubscription _onDestroy;

  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  StreamSubscription<WebViewHttpError> _onHttpError;

  StreamSubscription<double> _onProgressChanged;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _history = [];

  @override
  void initState() {
    super.initState();
    webView.close();
    webView.onHttpError.skip(1000);

    webView.onStateChanged.listen((WebViewStateChanged state) async {
      print('state');
      print(state);
      if (state.type == WebViewState.finishLoad) {
        String script = 'window.document.title';
        var title = await webView.evalJavascript(script);
        print(title);
        if (title.contains('Web')) {
          webView.dispose();
          webView.close();
        }
      }
    });


    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = webView.onDestroy.listen((_) {
      if (mounted) {
        // Actions like show a info toast.
        _scaffoldKey.currentState.showSnackBar(
            const SnackBar(content: const Text('Webview Destroyed')));
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = webView.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          _history.add('onUrlChanged: $url');
        });
      }
    });

    _onStateChanged =
        webView.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        setState(() {
          _history.add('onStateChanged: ${state.type} ${state.url}');
          print('States___ ${state}');
        });
      }
    });

    _onHttpError = webView.onHttpError.listen((WebViewHttpError error) {
      print('error is ${error} error');
      if (mounted) {
        setState(() {
          _history.add('onHttpError: ${error.code} ${error.url}');
          print('Error ${error}');
        });
      }
    });

    controller.addListener(() {
      url = controller.text;
    });
  }

  @override
  void dispose() {
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    _onProgressChanged.cancel();
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
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: <Widget>[
          HeaderAppBar(),
          Center(
              child: ButtonTheme(
                  minWidth: 200.0,
                  height: 70.0,
                  buttonColor: Colors.orange,
                  child: RaisedButton(
                      child: Text("Abrir panel Domótico",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/webview");
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))))),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: Text("Developed by www.deepmicrosystems.com",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.5,
                fontFamily: 'Lato',
                //fontWeight: FontWeight.bold
              )),
          color: Colors.indigo),
    );
  }
}
