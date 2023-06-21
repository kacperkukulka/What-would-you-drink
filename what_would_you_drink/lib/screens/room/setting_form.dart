import 'package:flutter/material.dart';
import 'package:what_would_you_drink/models/brew.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/screens/shared/loading.dart';
import 'package:what_would_you_drink/services/auth.dart';
import 'package:what_would_you_drink/services/brewService.dart';
import 'package:what_would_you_drink/services/database.dart';
import 'package:what_would_you_drink/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key, required this.roomId});

  final String roomId;

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
    return StreamBuilder<Brew>(
      stream: BrewService(userId: Provider.of<LightUser?>(context)!.uid, roomId: widget.roomId).userBrew,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          Brew userBrew = snapshot.data!;

          return Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 40.0, top: 20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // textForm(text: 'Nazwa użytkownika'),
                  // TextFormField(
                  //   initialValue: userBre,
                  //   decoration: textInputDecoration,
                  //   validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                  //   onChanged: (val) => currentName = val,
                  // ),
                  textForm(text: 'Jak mocna?'),
                  Slider(
                    value: (currentStrength ?? userBrew.strength).toDouble(),
                    min: 100,
                    max: 800,
                    divisions: 7,
                    activeColor: Colors.brown[(currentStrength ?? userBrew.strength)],
                    onChanged: (v){
                      setState(() => currentStrength = v.toInt());
                    }
                  ),
                  textForm(text: 'Ilość cukru (łyżeczek)'),
                  Slider(
                    value: (currentSugars ?? userBrew.sugars).toDouble(),
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
                          Navigator.pop(context);
                            BrewService brewService = BrewService(
                              roomId: widget.roomId,
                              userId: Provider.of<LightUser?>(context, listen: false)!.uid
                            );
                            await brewService.update(newValues: {
                              'isActual': false
                            });
                        }, 
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(dc.colorBgDark)
                        ),
                        child: const Text('Pomiń kolejke'),
                      ),
                      const SizedBox(width: 10.0,),
                      ElevatedButton(
                        onPressed: () async {
                          if(formKey.currentState == null) return;
                          if(formKey.currentState!.validate()){
                            BrewService brewService = BrewService(
                              roomId: widget.roomId,
                              userId: Provider.of<LightUser?>(context, listen: false)!.uid
                            );
                            Navigator.pop(context);
                            await brewService.update(newValues: {
                              'sugars': currentSugars ?? userBrew.sugars, 
                              'strength': currentStrength ?? userBrew.strength,
                              'isActual': true
                            });
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