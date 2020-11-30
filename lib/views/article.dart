import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Article extends StatefulWidget {
  final String blogUrl;
  Article({this.blogUrl});
  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {

  final Completer<WebViewController> _complete = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Look"),
            Text("News", style: TextStyle(color: Colors.red),)
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
          )
        ],
        elevation: 0.0,
      ),
    body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: WebView(
        initialUrl: widget.blogUrl,
        onWebViewCreated: ((WebViewController webViewController){
          _complete.complete(webViewController);
        }),
      ),
      ),
    );
  }
}
