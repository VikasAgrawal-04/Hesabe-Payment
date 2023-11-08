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
      baseUrl: 'https://api.hesabe.com',
      secretKey: 'gq6JWP7kZYmN85yzMgN8V32yb14B9XnM',
      ivKey: 'ZYmN85yzMgN8V32y',
      accessCode: '6c134782-9823-408c-b49d-829303bf60c1');

  Future<void> buy() async {
    await hesabe.openCheckout(context, paymentRequestObject: {
      "merchantCode": "84810223",
      "amount": '1.000',
      "paymentType": "${paymentType.index}",
      "responseUrl": "https://sandbox.hesabe.com/customer-response?id=84810223",
      "failureUrl": "https://sandbox.hesabe.com/customer-response?id=84810223",
      "version": "2.0",
      "orderReferenceNumber": "OR-12345"
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
