import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../net/api_methods.dart';
import 'add_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getValues();
  // }
  //
  // getValues() async {
  //   bitcoin = await getPrice('bitcoin');
  //   ethereum = await getPrice('ethereum');
  //   tether = await getPrice('tether');
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if (id == 'bitcoin') {
        return bitcoin * amount;
      } else if (id == 'ethereum') {
        return ethereum * amount;
      } else {
        return tether + amount;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currencies & Amount'),
        backgroundColor: Colors.blueAccent,
        leading: const BackButton(
          color: Colors.redAccent,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('Coins')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          top: 5.0,
                          right: 15.0,
                        ),
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 1.3,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.blue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "Coin: ${document.id}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Amount Owned: ${document["Amount"]}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  if (kDebugMode) {
                                    await removeCoins(document.id);
                                  }
                                },
                              ),
                            ],
                          ),
                        ));
                  }).toList(),
                );
              }),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
      FloatingActionButton(
      child: const Icon(
      Icons.water_damage,
      ),
      onPressed: () => FirebaseAuth.instance.signOut().then((value)=>Navigator.popAndPushNamed(context, '/crypto_walet/lib/authentication.dart')),
      heroTag: null,
    ),
    const SizedBox(
    height: 10,
    ),
    FloatingActionButton(heroTag: null,
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddView()),
    );
    }, //onPressed
    child: const Icon(Icons.add, color: Colors.white),
    backgroundColor: Colors.green,
    ),
    ],
    ),
    );
  }
}
