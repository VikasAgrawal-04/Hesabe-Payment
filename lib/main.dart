import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hesabe/hesabe.dart';

enum PaymentType { DEFAULT, KNET, MPGS }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  PaymentType paymentType = PaymentType.DEFAULT;
  Hesabe hesabe = Hesabe(
      baseUrl: 'https://sandbox.hesabe.com',
      secretKey: 'PkW64zMe5NVdrlPVNnjo2Jy9nOb7v1Xg',
      ivKey: '5NVdrlPVNnjo2Jy9',
      accessCode: 'c333729b-d060-4b74-a49d-7686a8353481');

  Future<void> buy() async {
    await hesabe.openCheckout(context, paymentRequestObject: {
      "merchantCode": "842217",
      "amount": '1.000',
      "paymentType": "${paymentType.index}",
      "responseUrl": "https://sandbox.hesabe.com/customer-response?id=842217",
      "failureUrl": "https://sandbox.hesabe.com/customer-response?id=842217",
      "version": "2.0",
      "orderReferenceNumber": "OR-${Random().nextInt(999999)}"
    });

    hesabe.on(Hesabe.EVENT_PAYMENT_SUCCESS, (data) {
      print("Success DAta ${data}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: IntrinsicHeight(
          child: Card(
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                    'https://www.dpreview.com/files/p/articles/3382512956/both_back.jpeg'),
                const SizedBox(height: 20),
                Text("Price : 1 KWD",
                    style: Theme.of(context).textTheme.titleLarge),
                Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                      onPressed: () async {
                        await buy();
                      },
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
