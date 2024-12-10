import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tron_wallet/src/data/Content.dart';
import 'package:tron_wallet/src/data/walletRepo.dart';
import 'package:tron_wallet/src/data/enum.dart';
import 'package:tron_wallet/src/data/tokenfuncation.dart';

/// A utility class for performing actions related to Tron Wallet
class TronwalletAction {
   /// [network] specifies the Tron network to use (default is Nile testnet)
  static Future<Map<String, dynamic>> createAccount(
      {TronwalletNetwork network = TronwalletNetwork.nile}) async {
    String netw = await getNetwork(network);

    try {
      var bal = await webViewController!
          .evaluateJavascript(source: 'createAccount("$netw")');
      String chek = await checkOT();
      return SucessMessage(chek);
    } catch (e) {
      return ErrorMessage(e);
    }
  }

  /// Converts a given amount of TRX into its smallest unit, Sun
  static int getSun(num amount) {
    int result = 1;
    int baseValue = 10;
    for (int i = 0; i < 6; i++) {
      result = result * baseValue;
    }
    return (amount * result).toInt();
  }

  /// Validates if the given wallet address is a valid Tron address
  static bool isAddress({required String walletaddress}) {
    return isValidTronAddress(walletaddress);
  }

  /// Fetches the balance of a Tron wallet for the given address and network

  static Future<Map<String, dynamic>> getbalance(
      {required String walletaddress,
      TronwalletNetwork network = TronwalletNetwork.nile}) async {
    try {
      if (isValidTronAddress(walletaddress) == false) {
        throw FormatException('Invalid tron Address');
      }
      String netw = await getNetwork(network);
      var bal = await webViewController!
          .evaluateJavascript(source: 'getbalance("$walletaddress,$netw")');
      String chek = await checkOT();
      return SucessMessage(chek);
    } catch (e) {
      return ErrorMessage(e);
    }
  }

  /// Fetches account information for the specified wallet address and network
  static Future<Map<String, dynamic>> getAccouninfo(
      {required String walletaddress,
      TronwalletNetwork network = TronwalletNetwork.nile}) async {
    try {
      if (isValidTronAddress(walletaddress) == false) {
        throw FormatException('Invalid  tron Address');
      }
      String netw = await getNetwork(network);
      var bal = await webViewController!
          .evaluateJavascript(source: 'getAccount("$walletaddress","$netw")');
      String chek = await checkOT();
      return SucessMessage(chek);
    } catch (e) {
      return ErrorMessage(e);
    }
  }

  /// Sends TRX to a recipient's wallet address

  static Future<Map<String, dynamic>> SendTrx(
      {required String ReceiverAddress,
      required int amountinSun,
      required String privatekey,
      TronwalletNetwork network = TronwalletNetwork.nile}) async {
    try {
      if (isValidTronAddress(ReceiverAddress) == false) {
        throw FormatException('Invalid tron Address');
      }
      String netw = await getNetwork(network);

      var bal = await webViewController!.evaluateJavascript(
          source:
              'Sendtrx("$privatekey","$ReceiverAddress","$amountinSun","$netw")');

      String chek = await checkOT();
      if (chek.toString().contains('result') == false) {
        throw chek;
      }
      return SucessMessage(chek);
    } catch (e) {
      return ErrorMessage(e);
    }
  }

  /// Fetches transaction information for a specific hash

  static Future<Map<String, dynamic>> getTransactionInfo(
      {required String hash,
      TronwalletNetwork network = TronwalletNetwork.nile}) async {
    try {
      String netw = await getNetwork(network);
      var bal = await webViewController!
          .evaluateJavascript(source: 'getTransactionInfo("$hash","$netw")');
      String chek = await checkOT();
      return SucessMessage(chek);
    } catch (e) {
      return ErrorMessage(e);
    }
  }

  /// Sends TRC-20 tokens to a recipient's wallet address

  static Future<Map<String, dynamic>> SendTRC20Token(
      {required String privatekey,
      required String ContractAddresss,
      required String OwnerAddress,
      required String ReceiverAddress,
      required int amountInContactType,
      TronwalletNetwork network = TronwalletNetwork.nile}) async {
    try {
      if (isValidTronAddress(ContractAddresss) == false ||
          isValidTronAddress(OwnerAddress) == false ||
          isValidTronAddress(ReceiverAddress) == false) {
        throw FormatException('Invalid tron Address');
      }
      String netw = await getNetwork(network);
      var parameter = [
        {'type': 'address', 'value': '$ReceiverAddress'},
        {'type': 'uint256', 'value': amountInContactType.toInt()}
      ];
      String result = convertToFormat(parameter);

      dynamic trigerr = await triggersmartContact(
          contract_address: ContractAddresss,
          parametr: result,
          walletadress: OwnerAddress,
          network: network);
      if (trigerr.toString().contains('ERROR')) {
        throw trigerr['ERROR'];
      }
      log("ytigger $trigerr");
      var bal = await webViewController!.evaluateJavascript(
          source: 'SignBroad(${trigerr},"$privatekey","$netw")');
      String chek = await checkOT();
      if (chek.toString().contains('result') == false) {
        throw chek;
      }
      return SucessMessage(chek);
    } catch (e) {
      return ErrorMessage(e);
    }
  }

  ///Freeze or Stake the trx for Resource (Bandwidth and Energy)
  static Future<Map<String, dynamic>> FreezeBalance(
      {required String Owneraddress,
      required int amountinSun,
      required String privatekey,
      required FreezeResource resource,
      TronwalletNetwork network = TronwalletNetwork.nile}) async {
    try {
      if (isValidTronAddress(Owneraddress) == false) {
        throw FormatException('Invalid tron Address');
      }
      String netw = await getNetwork(network);
      String reso = resource.name.toString();

      var bal = await webViewController!.evaluateJavascript(
          source:
              'freezeBalanceV2("$privatekey","$Owneraddress","$amountinSun","$reso","$netw")');

      String chek = await checkOT();
      if (chek.toString().contains('result') == false) {
        throw chek;
      }
      return SucessMessage(chek);
    } catch (e) {
      return ErrorMessage(e);
    }
  }

  ///UnFreeze or UnStake the trx for Resource (Bandwidth and Energy)
  static Future<Map<String, dynamic>> UnFreezeBalance(
      {required String Owneraddress,
      required int amountinSun,
      required String privatekey,
      required FreezeResource resource,
      TronwalletNetwork network = TronwalletNetwork.nile}) async {
    try {
      if (isValidTronAddress(Owneraddress) == false) {
        throw FormatException('Invalid tron Address');
      }
      String netw = await getNetwork(network);
      String reso = resource.name.toString();

      var bal = await webViewController!.evaluateJavascript(
          source:
              'unfreezeBalanceV2("$privatekey","$Owneraddress","$amountinSun","$reso","$netw")');

      String chek = await checkOT();
      if (chek.toString().contains('result') == false) {
        throw chek;
      }
      return SucessMessage(chek);
    } catch (e) {
      return ErrorMessage(e);
    }
  }

  ///Get the List of all SR
  static Future<Map<String, dynamic>> GetSRList(
      {TronwalletNetwork network = TronwalletNetwork.nile}) async {
    try {
      var netw = await getSRlist(network: network);
      return SucessMessage(json.encode(netw.toString()));
    } catch (e) {
      return ErrorMessage(e);
    }
  }

  ///Apply the new SR of any network
  static Future<Map<String, dynamic>> ApplySR(
      {required String Owneraddress,
      required String privatekey,
      required String url,
      TronwalletNetwork network = TronwalletNetwork.nile}) async {
    try {
      if (isValidTronAddress(Owneraddress) == false) {
        throw FormatException('Invalid tron Address');
      }
      String netw = await getNetwork(network);
      var bal = await webViewController!.evaluateJavascript(
          source: 'applyForSR("$privatekey","$Owneraddress","$url","$netw")');

      String chek = await checkOT();
      if (chek.toString().contains('result') == false) {
        throw chek;
      }
      return SucessMessage(chek);
    } catch (e) {
      return ErrorMessage(e);
    }
  }

  ///Vote for SR .which can show on  the network
  static Future<Map<String, dynamic>> vote(
      {required String Owneraddress,
      required String privatekey,
      required Map<String, int> votes,
      TronwalletNetwork network = TronwalletNetwork.nile}) async {
    try {
      if (isValidTronAddress(Owneraddress) == false) {
        throw FormatException('Invalid tron Address');
      }
      String netw = await getNetwork(network);

      var bal = await webViewController!.evaluateJavascript(
          source:
              'vote("$privatekey","$Owneraddress",${jsonEncode(votes)},"$netw")');

      String chek = await checkOT();
      if (chek.toString().contains('result') == false) {
        throw chek;
      }
      return SucessMessage(chek);
    } catch (e) {
      return ErrorMessage(e);
    }
  }

  ///Vote for SR's Proposal in Community

  static Future<Map<String, dynamic>> voteProposal(
      {required String Owneraddress,
      required String privatekey,
      required String proposalId,
      required bool hasApproval,
      TronwalletNetwork network = TronwalletNetwork.nile}) async {
    try {
      if (isValidTronAddress(Owneraddress) == false) {
        throw FormatException('Invalid tron Address');
      }
      String netw = await getNetwork(network);

      var bal = await webViewController!.evaluateJavascript(
          source:
              'voteProposal("$privatekey","$Owneraddress",$proposalId,"$hasApproval","$netw")');

      String chek = await checkOT();
      if (chek.toString().contains('result') == false) {
        throw chek;
      }
      return SucessMessage(chek);
    } catch (e) {
      return ErrorMessage(e);
    }
  }

  ///Delete the SR Proposal into the Community
  static Future<Map<String, dynamic>> DeleteProposal(
      {required String Owneraddress,
      required String privatekey,
      required String proposalId,
      TronwalletNetwork network = TronwalletNetwork.nile}) async {
    try {
      if (isValidTronAddress(Owneraddress) == false) {
        throw FormatException('Invalid tron Address');
      }
      String netw = await getNetwork(network);

      var bal = await webViewController!.evaluateJavascript(
          source:
              'deleteProposal("$privatekey","$Owneraddress",$proposalId,"$netw")');

      String chek = await checkOT();
      if (chek.toString().contains('result') == false) {
        throw chek;
      }
      return SucessMessage(chek);
    } catch (e) {
      return ErrorMessage(e);
    }
  }

  static Map<String, dynamic> ErrorMessage(dynamic data) => {"Error": data};
  static Map<String, dynamic> SucessMessage(dynamic data) => {"Response": data};
}
