import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_cheez/Resources/Constants.dart';
import 'package:flutter_cheez/Widgets/Forms/NextPageAppBar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatelessWidget {
  final String url;
  final String title;
  const WebPage({Key key, @required this.url, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    return Scaffold(
      appBar: NextPageAppBar(
        height: ParametersConstants.appBarHeight,
        title: title,
      ),
      body: Container(
        decoration: BoxDecoration(color: ColorConstants.mainAppColor,
            //borderRadius: BorderRadius.circular(ParametersConstants.largeImageBorderRadius),
            // border: Border.all(color: ColorConstants.goodsBorder),
            boxShadow: [ParametersConstants.shadowDecoration]),
        child: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
