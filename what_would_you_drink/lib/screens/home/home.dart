import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_would_you_drink/models/room.dart';
import 'package:what_would_you_drink/screens/home/room_tabs.dart';
import 'package:what_would_you_drink/services/auth.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;
import 'package:what_would_you_drink/services/roomService.dart';
import 'add_room.dart';
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
        appBar: AppBar(
          backgroundColor: dc.colorAppBar,
          title: const Text('Pokoje'),
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
        body: DefaultTabController(
          length: 3, 
          child: Scaffold(
            backgroundColor: dc.colorBgDark,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: dc.colorPrimary,
              title: const TabBar(
                indicatorColor: dc.colorTextPrimary,
                tabs: [
                  Tab(text: "Wszystkie",),
                  Tab(text: "Twoje"),
                  Tab(text: "Uczestnictwo",)
                ],
              ),
            ),
            body: const RoomTabs()
          )),
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