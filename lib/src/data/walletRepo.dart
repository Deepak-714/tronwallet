import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:hex/hex.dart';
import 'package:tron_wallet/src/data/Content.dart';
import 'package:bs58check/bs58check.dart' as bs58check;
import 'package:tron_wallet/src/data/enum.dart';
import 'package:http/http.dart' as http;

Future<String> getNetwork(TronwalletNetwork _network) async {
  if (_network == TronwalletNetwork.Mainnet) {
    return Mainnet;
  } else {
    return NileTestnet;
  }
}

String GetTronAddress_base58(String toAddress) {
  final Uint8List decodedBase58 = bs58check.decode(toAddress);
  final String encodedHex = HEX.encode(decodedBase58);
  log("===> $encodedHex");
  return encodedHex;
}

Future<List> getSRlist(
    {TronwalletNetwork network = TronwalletNetwork.nile}) async {
  String netw = await getNetwork(network);
  var url = netw + '/wallet/listwitnesses';
  var respom = await http.get(Uri.parse(url), headers: {
    "accept": "application/json",
  });
  var data = json.decode(respom.body);
  return data['witnesses'];
}

///Check the value get  aa JS Function then execute
Future<String> checkOT() async {
  Completer<void> completer = Completer();
  Timer.periodic(Duration(milliseconds: 500), (timer) {
    if (consolevalue.isNotEmpty) {
      timer.cancel();
      completer.complete();
    }
  });
  await completer.future;
  String capturedValue = consolevalue;
  consolevalue = "";
  return capturedValue;
}
