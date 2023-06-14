import 'package:provider/provider.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/screens/authenticate/authenticate.dart';
import 'package:what_would_you_drink/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final lightUser = Provider.of<LightUser?>(context);
    //either home or authenticate
    if(lightUser == null){
      return const Authenticate();
    }
    else{
      return const Home();
    }
  }
}