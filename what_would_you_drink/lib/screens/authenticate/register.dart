import 'package:flutter/material.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/screens/authenticate/authenticate.dart';
import 'package:what_would_you_drink/screens/shared/loading.dart';
import 'package:what_would_you_drink/services/auth.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;
import 'package:what_would_you_drink/shared/constants.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.toggleView});

  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool showPass = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  String errorMsg = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: dc.colorBgDark,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Rejestracja'),
        actions: [
          TextButton.icon(
            onPressed: (){ widget.toggleView(); }, 
            icon: const Icon(Icons.person_outline), 
            label: const Text("Zaloguj się"),
            style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(dc.colorTextPrimary),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40.0,),
              //username
              TextFormField(
                validator: (value) => value!.isEmpty ? "Pole nie może być puste" : null,
                controller: emailController,
                decoration: textInputDecoration.copyWith(hintText: "Email"),
              ),
              const SizedBox(height: 10.0,),
              //password
              TextFormField(
                validator: (value) => value!.length < 6 || value.length > 50 ? "Hasło musi posiadać od 6 do 50 znaków" : null,
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
              Text(errorMsg, style: TextStyle(color: dc.colorError),),
              ElevatedButton(
                onPressed: () async {
                  String email = emailController.value.text;
                  String pass = passController.value.text;
                  if(_formKey.currentState == null) return;
                  if(_formKey.currentState!.validate()){
                    setState(() => loading = true);
                    LightUser? lightUser = await _auth.register(email, pass); 
                    if(lightUser == null){
                      setState((){
                        errorMsg = 'Podaj poprawne dane do rejestracji';
                        loading = false;
                      });
                    }
                  }
                }, 
                child: const Text('Zarejestruj się')
              )
            ],
          )
        )
      ),
    );
  }
}