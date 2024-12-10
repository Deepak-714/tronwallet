import 'package:flutter/material.dart';
import 'package:tron_wallet/tron_wallet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tron wallet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Tron wallet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      /// Wrap the app Screen  widget with TronWallet where you can use TRONWALLET....
      body: Tronwallet(
        childwidget: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Tronwallet Example',
              ),
              const SizedBox(
                height: 30,
              ),
              Clickbutton('Generate Account', () async {
                await TronwalletAction.createAccount().then((value) {
                  print("Response $value");
                  //Sucess : {"Response": *******}
                  //ERROR: {"Error": *******}
                });
              }),
              Clickbutton('Account Balance', () async {
                await TronwalletAction.getbalance(
                        walletaddress: 'TPcdhwnZciir3gz3WYiNdeuYorLn9xQqeK')
                    .then((value) {
                  //Sucess : {"Response": *******}
                  //ERROR: {"Error": *******}
                });
              }),
              Clickbutton('Account Info', () async {
                await TronwalletAction.getAccouninfo(
                        walletaddress: 'TPcdhwnZciir3gz3WYiNdeuYorLn9xQqeK')
                    .then((value) {
                  print("Response $value");
                  //Sucess : {"Response": *******}
                  //ERROR: {"Error": *******}
                });
              }),
              Clickbutton('Send TRX', () async {
                var resp = await TronwalletAction.SendTrx(
                    ReceiverAddress: '************************',
                    amountinSun: TronwalletAction.getSun(num.parse('x')),
                    privatekey: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
                //Sucess : {"Response": *******}
                //ERROR: {"Error": *******}
              }),
              Clickbutton('Send TRC20 Token', () async {
                var resp = await TronwalletAction.SendTRC20Token(
                    ReceiverAddress: 'xxxxxxxxxxxxxxxxxxxxxx',
                    ContractAddresss: 'xxxxxxxxxxxxxxxxxxxxx',
                    privatekey: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                    OwnerAddress: 'xxxxxxxxxxxxxxxxxxxxxxxx',
                    amountInContactType:
                        TronwalletAction.getSun(num.parse('x')));
                //Sucess : {"Response": *******}
                //ERROR: {"Error": *******}
              }),
              Clickbutton('Transaction info', () async {
                var resp = await TronwalletAction.getTransactionInfo(
                    hash: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
                //Sucess : {"Response": *******}
                //ERROR: {"Error": *******}
              }),
              Clickbutton('Vote', () async {
                var resp = await TronwalletAction.vote(
                    Owneraddress: 'xxxxxxxxxxxxxxxxxxxxxxxxx',
                    votes: {"****************": 0},
                    privatekey: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
                //Sucess : {"Response": *******}
                //ERROR: {"Error": *******}
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget Clickbutton(String title, void Function()? onPressed) {
    return ElevatedButton(onPressed: onPressed, child: Text(title));
  }
}
