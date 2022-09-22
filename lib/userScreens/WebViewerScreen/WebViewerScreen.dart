import 'package:elandguard/Constants/myColors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewerScreen extends StatefulWidget {
  final String title;
  final String path;
  WebViewerScreen({this.title, this.path});

  @override
  _WebViewerScreenState createState() =>
      _WebViewerScreenState(title: title, path: path);
}

class _WebViewerScreenState extends State<WebViewerScreen> {
  final String title;
  final String path;
  _WebViewerScreenState({this.title, this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundTheme,
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: kPrimaryTheme),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 23,
            color: kPrimaryTheme,
          ),
        ),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: path,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
