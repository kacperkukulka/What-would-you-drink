import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/screens/shared/loading.dart';
import 'package:what_would_you_drink/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/user.dart';
import '../../services/user_service.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  String? currentName;
  late String nameBefore;
  var formKey = GlobalKey<FormState>();
  int currentAvatar = 0;
  List avatarList = List.generate(10, (_) => Random().nextInt(999999));

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserDb>(
      stream: UserService(uid: Provider.of<LightUser?>(context)!.uid).user,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserDb userDb = snapshot.data!;
          nameBefore = userDb.name;

          return Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 40.0, top: 20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  textForm(text: 'Nazwa użytkownika'),
                  TextFormField(
                    initialValue: userDb.name,
                    decoration: textInputDecoration,
                    validator: (val) => 
                      val!.isEmpty ? 'Please enter a name' : 
                      val == nameBefore ? 'You entered the same name' : null,
                    onChanged: (val) => currentName = val,
                  ),
                  const SizedBox(height: 10.0,),
                  textForm(text: "Avatar"),
                  Expanded(
                    child: CarouselSlider.builder(
                      itemCount: 10, 
                      itemBuilder: (context, index, _) => 
                        ClipOval(
                          child: SvgPicture.network(
                            'https://api.dicebear.com/6.x/adventurer/svg?seed=${avatarList[index]}', 
                            width: 200,
                            fit: BoxFit.cover,
                          )
                        ), 
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enlargeFactor: 0.4,
                        viewportFraction: 0.5,
                        onPageChanged: (index, reason) {
                          currentAvatar = index;
                        },
                        initialPage: 0
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if(formKey.currentState == null) return;
                      if(formKey.currentState!.validate()){
                        Navigator.pop(context);
                        await UserService(uid: Provider.of<LightUser?>(context, listen: false)!.uid).addOrUpdate(name: currentName!);
                      }
                    }, 
                    child: const Text('Zapisz')
                  ),
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