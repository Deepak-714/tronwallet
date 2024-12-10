import 'package:flutter_inappwebview/flutter_inappwebview.dart';

InAppWebViewController? webViewController;

///TRON address Validation checkers
bool isValidTronAddress(String address) {
  final pattern = r'^T[1-9A-HJ-NP-Za-km-z]{33}$';
  final regExp = RegExp(pattern);
  return regExp.hasMatch(address);
}

String consolevalue = "";

///RPC Url for testnet
String NileTestnet = "https://nile.trongrid.io/";

///RPC Url for Tron Mainnet URL's
String Mainnet = "https://trongrid.io/";
