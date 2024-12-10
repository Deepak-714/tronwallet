
The Tron Wallet package is a Dart/Flutter library designed to facilitate the integration of Tron blockchain functionality into Flutter applications. It provides a comprehensive set of tools to interact with the Tron network, enabling developers to manage Tron accounts, perform TRX and TRC20 token transactions, retrieve blockchain data, and execute smart contract functions. The package is ideal for building Tron-based wallets, decentralized applications (DApps), or other blockchain-enabled Flutter projects.

## Features
Account Management:
Create Tron accounts on specified networks (e.g., Nile testnet, Mainnet).
Validate Tron wallet addresses.
Retrieve detailed account information, including balances and transaction history.
TRX Transactions:

Send TRX to other Tron wallet addresses.
Convert TRX amounts into Sun (the smallest unit in Tron).
TRC20 Token Support:

Transfer TRC20 tokens between wallets.
Interact with TRC20 smart contracts, including parameter encoding and contract execution.
Smart Contract Interactions:

Trigger smart contracts with custom parameters.
Sign and broadcast smart contract transactions.
Blockchain Data Access:

Retrieve balances of Tron addresses.
Get details of specific transactions using transaction hashes.
Fetch lists of Super Representatives (SRs) and manage voting for SRs.
Resource Management:

Freeze and unfreeze TRX for resource allocation (e.g., bandwidth or energy).
Manage Super Representative voting and proposals.
Error Handling:

Built-in validation for Tron addresses.
Comprehensive error handling and standardized success/error message formats.
Custom Network Support:

Easily switch between Tron networks, including Nile testnet, Mainnet, and Shasta testnet.
Dynamically fetch network configuration details.

## Getting started

'''dart
body:Tronwallet(childwidget: )
'''
Wrap the app or widget with Tronwallet and then 
 you can access the 'TronwalletAction'  method's.

## Usage

Build Tron wallets that support TRX and TRC20 token transactions.
Integrate Tron blockchain features into Flutter-based DApps.
Retrieve and display transaction and account information.
Execute, sign, and broadcast custom smart contract transactions.

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
///Get the new account  of tron chain  with private key.
 await TronwalletAction.createAccount().then((value) {
                  print("Response $value");
                  //Sucess : {"Response": *******}
                  //ERROR: {"Error": *******}
                });

  /// Fetches the balance of a Tron wallet for the given address and network
   await TronwalletAction.getbalance(
                        walletaddress: 'XXXXXXXXXXXXXXXXXXXX')
                    .then((value) {
                  //Sucess : {"Response": *******}
                  //ERROR: {"Error": *******}
                });

  /// Fetches account information for the specified wallet address and network
 await TronwalletAction.getAccouninfo(
                        walletaddress: 'XXXXXXXXXXXXXXXXXXXXXXX')
                    .then((value) {
                  print("Response $value");
                  //Sucess : {"Response": *******}
                  //ERROR: {"Error": *******}
                });

  /// Sends TRX to a recipient's wallet address
    var resp = await TronwalletAction.SendTrx(
    ReceiverAddress: '************************',
    amountinSun: TronwalletAction.getSun(num.parse('x')),
    privatekey: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      resp:-  //Sucess : {"Response": *******}
       resp:-  //ERROR: {"Error": *******}

/// Sends TRC-20 tokens to a recipient's wallet address
 
 var resp = await TronwalletAction.SendTRC20Token(
                    ReceiverAddress: 'xxxxxxxxxxxxxxxxxxxxxx',
                    ContractAddresss: 'xxxxxxxxxxxxxxxxxxxxx',
                    privatekey: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                    OwnerAddress: 'xxxxxxxxxxxxxxxxxxxxxxxx',
                    amountInContactType:
                        TronwalletAction.getSun(num.parse('x')));

/// Fetches transaction information for a specific hash
  var resp = await TronwalletAction.getTransactionInfo(
                    hash: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

///Vote for SR .which can show on  the network     
    var resp = await TronwalletAction.vote(
    Owneraddress: 'xxxxxxxxxxxxxxxxxxxxxxxxx',
    votes: {"****************": 0},
    privatekey: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

```

## Additional information

Others methods like:-
.FreezeBalance & UNFreezeBalance for (Bandwidth and Energy).
.Apply SR, Get SRList,Vote for SR.
.voteProposal,DeleteProposal also added.