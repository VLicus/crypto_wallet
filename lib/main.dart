import 'package:crypto_wallet/authentication.dart';
import 'package:flutter/material.dart';
import 'authentication.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();//we need to add to initialize the method
  await Firebase.initializeApp(); //initializing FlutterFire
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Crypto Wallet',
      home: Authentication(),
    );
  }
}
