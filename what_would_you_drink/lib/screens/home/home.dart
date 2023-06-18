import 'package:flutter/material.dart';
import 'package:what_would_you_drink/screens/shared/loading.dart';
import 'package:what_would_you_drink/services/auth.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    bool loading = false;

    return Scaffold(
      backgroundColor: dc.colorBg,
      appBar: AppBar(
        backgroundColor: dc.colorAppBar,
        title: const Text('Home'),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(dc.colorTextPrimary)
            ),
            onPressed: () async {
              await _auth.singOut();
            }, 
            icon: const Icon(Icons.person_outline_outlined), 
            label: const Text('Wyloguj się'),
            
          )
        ],
      ),
    );
  }
}