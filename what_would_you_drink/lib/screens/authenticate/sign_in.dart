import 'package:flutter/material.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/screens/shared/loading.dart';
import 'package:what_would_you_drink/services/auth.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;
import 'package:what_would_you_drink/shared/constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, required this.toggleView});

  final Function toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  bool showPass = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  String errMsg = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: dc.colorBgDark,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Logowanie'),
        actions: <Widget>[
          TextButton.icon(
            onPressed: (){ widget.toggleView(); }, 
            icon: const Icon(Icons.person_outline), 
            label: const Text("Zarejestruj się"),
            style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(dc.colorTextPrimary),
            ),
          )
        ],
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
                decoration: textInputDecoration.copyWith(hintText: "Email")
              ),
              const SizedBox(height: 10.0,),
              //password
              TextFormField(
                obscureText: !showPass,
                controller: passController,
                decoration: textInputDecoration.copyWith(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        showPass = !showPass;
                      });
                    },
                    icon: showPass ? 
                      const Icon(Icons.visibility) : 
                      const Icon(Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(height: 10.0,),
              Text(errMsg, style: TextStyle(color: dc.colorError),),
              ElevatedButton(
                onPressed: () async {
                  setState(() => loading = true);
                  String email = emailController.value.text;
                  String pass = passController.value.text;
                  LightUser? lightUser = await _auth.singInUserPass(email, pass);
                  if(lightUser == null){ 
                    setState((){
                      errMsg = 'Dane logowania są niepoprawne';
                      loading = false;
                    }); 
                  }
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