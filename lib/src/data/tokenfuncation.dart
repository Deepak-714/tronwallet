import 'dart:async';
import 'dart:convert';

import 'package:dart_bs58/dart_bs58.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart' as http;
import 'package:tron_wallet/src/data/walletRepo.dart';
import 'package:tron_wallet/src/data/enum.dart';

String convertToFormat(List<Map<String, dynamic>> data) {
  String result = '';
  for (var item in data) {
    if (item['type'] == 'address') {
      String addressValue = item['value'];
      result += addressToFormat(addressValue);
    } else if (item['type'] == 'uint256') {
      int intValue = item['value'];
      result += uint256ToFormat(intValue);
    } else if (item['type'] == 'bool') {
      String value =
          item['value'].toString().toLowerCase() == "true" ? "1" : "0";
      result += boolvalue(value);
    }
  }
  return result;
}

String addressToFormat(String addressValue) {
  var addres = bs58.decode(addressValue);
  var hex = HEX.encode(addres);
  var hex2 = hex.substring(2);
  var finalhex = hex2.substring(0, hex2.length - 8);
  return finalhex.padLeft(64, '0');
}

String uint256ToFormat(int intValue) {
  String hexValue = intValue.toRadixString(16).padLeft(64, '0');
  if (hexValue.length > 64) {
    throw Exception('Integer value exceeds 64 bits');
  }
  return hexValue;
}

String boolvalue(String value) {
  return value.padLeft(64, '0');
}

Future<dynamic> triggersmartContact(
    {required String parametr,
    required String contract_address,
    required String walletadress,
    TronwalletNetwork network = TronwalletNetwork.Nile}) async {
  String netw = await getNetwork(network);
  var url = netw + 'wallet/triggersmartcontract';
  final paradic = {
    "owner_address": walletadress.toString(),
    "contract_address": contract_address,
    "function_selector": "transfer(address,uint256)",
    "parameter": parametr.toString(),
    "fee_limit": 10000000,
    "call_value": 0,
    "visible": true
  };
  var respom =
      await http.post(Uri.parse(url), body: jsonEncode(paradic), headers: {
    "accept": "application/json",
  });
  var data = json.decode(respom.body);
  if (data['result']['result'] == true) {
    return json.encode(data['transaction']);
  } else {
    return {"ERROR": data};
  }
}
