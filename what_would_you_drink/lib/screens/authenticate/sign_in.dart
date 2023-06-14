import 'package:flutter/material.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  bool showPass = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Logowanie')
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40.0,),
              //username
              TextFormField(
                controller: emailController,
              ),
              const SizedBox(height: 10.0,),
              //password
              TextFormField(
                obscureText: !showPass,
                controller: passController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        showPass = !showPass;
                      });
                    },
                    icon: showPass ? 
                      const Icon(Icons.visibility) : 
                      const Icon(Icons.visibility_off),
                  )
                ),
              ),
              const SizedBox(height: 10.0,),
              ElevatedButton(
                onPressed: (){
                  String email = emailController.value.text;
                  String pass = passController.value.text;
                }, 
                child: const Text('Zaloguj się')
              )
            ],
          )
        )
      ),
    );
  }
}