import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_would_you_drink/screens/room/setting_form.dart';
import 'package:what_would_you_drink/services/auth.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;
import 'package:what_would_you_drink/services/brewService.dart';
import 'package:what_would_you_drink/services/roomService.dart';
import 'brew_list.dart';
import 'package:what_would_you_drink/models/brew.dart';

class RoomWidget extends StatelessWidget {
  const RoomWidget({super.key, required this.uid, required this.roomName});

  final String uid;
  final String roomName;

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: ((context){
        return SettingsForm(roomId: uid);
      }));
    }

    return StreamProvider<List<Brew>>.value(
      initialData: List<Brew>.empty(),
      value: BrewService(roomId: uid).brews,
      child: Scaffold(
        backgroundColor: dc.colorBgDark,
        appBar: AppBar(
          backgroundColor: dc.colorAppBar,
          title: Text(roomName),
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
            ),
            IconButton(
              onPressed: (){
                _showSettingsPanel();
              }, 
              icon: const Icon(Icons.settings),
              color: dc.colorTextPrimary,
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}