import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_would_you_drink/models/room.dart';
import 'package:what_would_you_drink/services/auth.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;
import 'package:what_would_you_drink/services/database.dart';
import 'package:what_would_you_drink/services/roomService.dart';
import 'add_room.dart';
import 'room_list.dart';
import 'package:what_would_you_drink/models/brew.dart';
import 'package:what_would_you_drink/screens/home/setting_form.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    void showSettingsPanel(){
      showModalBottomSheet(context: context, builder: ((context){
        return const SettingsForm();
      }));
    }

    void showAddRoomPanel(){
      showModalBottomSheet(context: context, builder: ((context){
        return const AddRoom();
      }));
    }

    return StreamProvider<List<Room>>.value(
      initialData: List<Room>.empty(),
      value: RoomService().allRooms,
      child: Scaffold(
        backgroundColor: dc.colorBgDark,
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
            ),
            IconButton(
              onPressed: (){
                showSettingsPanel();
              }, 
              icon: const Icon(Icons.settings),
              color: dc.colorTextPrimary,
            )
          ],
        ),
        body: RoomList(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showAddRoomPanel();
          },
          backgroundColor: dc.colorPrimary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}