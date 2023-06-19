import 'package:flutter/material.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/screens/shared/loading.dart';
import 'package:what_would_you_drink/services/auth.dart';
import 'package:what_would_you_drink/services/database.dart';
import 'package:what_would_you_drink/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  int? currentStrength;
  int? currentSugars;
  String? currentName;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: Provider.of<LightUser?>(context)!.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data!;

          return Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 40.0, top: 20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  textForm(text: 'Nazwa użytkownika'),
                  TextFormField(
                    initialValue: userData.brew.name,
                    decoration: textInputDecoration,
                    validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => currentName = val,
                  ),
                  textForm(text: 'Jak mocna?'),
                  Slider(
                    value: (currentStrength ?? userData.brew.strength).toDouble(),
                    min: 100,
                    max: 800,
                    divisions: 7,
                    activeColor: Colors.brown[(currentStrength ?? userData.brew.strength)],
                    onChanged: (v){
                      setState(() => currentStrength = v.toInt());
                    }
                  ),
                  textForm(text: 'Ilość cukru (łyżeczek)'),
                  Slider(
                    value: (currentSugars ?? userData.brew.sugars).toDouble(),
                    min: 0,
                    max: 5,
                    divisions: 5,
                    onChanged: (v){
                      setState(() => currentSugars = v.toInt());
                    },
                    label: currentSugars.toString(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(dc.colorError)
                        ),
                        child: const Text('Anuluj'),
                      ),
                      const SizedBox(width: 10.0,),
                      ElevatedButton(
                        onPressed: () async {
                          if(formKey.currentState == null) return;
                          if(formKey.currentState!.validate()){
                            DatabaseService databaseService = DatabaseService(
                              uid: Provider.of<LightUser?>(context, listen: false)!.uid
                            );
                            Navigator.pop(context);
                            await databaseService.addOrUpdate(
                              sugars: currentSugars ?? userData.brew.sugars, 
                              name: currentName ?? userData.brew.name, 
                              strength: currentStrength ?? userData.brew.strength
                            );
                          }
                        }, 
                        child: const Text('Zapisz')
                      ),
                    ],
                  )
                ],
              ),
            )
          );
        }
        else{
          return const Loading();
        }
      }
    );
  }
}