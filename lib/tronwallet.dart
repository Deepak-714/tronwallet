import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tron_wallet/src/data/Content.dart';

class Tronwallet extends StatefulWidget {
  final Widget childwidget;
  const Tronwallet({super.key, required this.childwidget});

  @override
  State<Tronwallet> createState() => _TronwalletState();
}

class _TronwalletState extends State<Tronwallet> {
  @override
  void initState() {
    consolevalue = "";
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: InAppWebView(
              initialFile: 'packages/tron_wallet/asset/TronIndex.html',
              onWebViewCreated: (InAppWebViewController controller) async {
                controller.setSettings(
                    settings: InAppWebViewSettings(
                  allowContentAccess: true,
                  javaScriptEnabled: true,
                ));

                webViewController = controller;
                setState(() {});
              },
              onConsoleMessage:
                  (InAppWebViewController ctrl, ConsoleMessage mssg) {
                consolevalue = mssg.message;
                setState(() {});
              },
              onLoadStop: (controller, url) {},
            ),
          ),
          widget.childwidget
        ],
      ),
    );
  }
}
