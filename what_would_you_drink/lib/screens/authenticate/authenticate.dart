import 'package:flutter/material.dart';
import 'package:what_would_you_drink/screens/authenticate/register.dart';
import 'package:what_would_you_drink/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isLogin = true;
  void toggleView(){
    setState(() => isLogin = !isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLogin? 
        SignIn(toggleView: toggleView): 
        Register(toggleView: toggleView)
    );
  }
}