import 'package:crypto_wallet/ui/home_view.dart';
import 'package:flutter/material.dart';

import 'net/flutterfire.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final TextEditingController _emailField = TextEditingController();//adding controllers to catch the information that the user put in the field
  final TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in or Register'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width, //expand the container to fit max width and max height
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(//modify the container
          color: Colors.blueAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _emailField,// passing the information wrote in the email field
                decoration: const InputDecoration(
                  hintText: "something@email.com",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _passwordField,// passing the information wrote in the password field
                obscureText: true, //hide the information wrote in that box
                decoration: const InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,// resizes to the device that it has been displayed
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {//creating the register button
                  bool shouldNavigate = await register(_emailField.text, _passwordField.text);
                  if (shouldNavigate){
                    //Navigate
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView(),
                      ),
                    );
                  }
                  },
                child: const Text('Register'),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNavigate = await signIn(_emailField.text, _passwordField.text);
                  if (shouldNavigate){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeView(),
                        ),
                    );
                  }
                },
                child: const Text('Log in'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
