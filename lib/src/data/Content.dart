import 'package:flutter_inappwebview/flutter_inappwebview.dart';

InAppWebViewController? webViewController;

///TRON address Validation checkers
bool isValidTronAddress(String address) {
  var pattern = r'^T[1-9A-HJ-NP-Za-km-z]{33}$';
  final regExp = RegExp(pattern);
  return regExp.hasMatch(address);
}

String consolevalue = "";

///RPC Url for testnet
const String NileTestnet = "https://nile.trongrid.io/";

///RPC Url for Tron Mainnet URL's
const String Mainnet = "https://trongrid.io/";
