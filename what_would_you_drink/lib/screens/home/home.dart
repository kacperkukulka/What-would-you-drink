import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_would_you_drink/screens/home/setting_form.dart';
import 'package:what_would_you_drink/services/auth.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;
import 'package:what_would_you_drink/services/database.dart';
import 'brew_list.dart';
import 'package:what_would_you_drink/models/brew.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: ((context){
        return SettingsForm();
      }));
    }

    return StreamProvider<List<Brew>>.value(
      initialData: List<Brew>.empty(),
      value: DatabaseService().brews,
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
                _showSettingsPanel();
              }, 
              icon: const Icon(Icons.settings),
              color: dc.colorTextPrimary,
            )
          ],
        ),
        // endDrawer: Drawer(
        //   backgroundColor: dc.colorAppBar,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         TextButton.icon(
        //           onPressed: () async {
        //             await _auth.singOut();
        //           },
        //           icon: const Icon(Icons.logout), 
        //           label: const Text('Wyloguj się'),
        //           style: ButtonStyle(
        //             fixedSize: const MaterialStatePropertyAll(Size(double.maxFinite, 70.0)),
        //             alignment: Alignment.centerLeft,
        //             foregroundColor: const MaterialStatePropertyAll(dc.colorTextSecondary),
        //             backgroundColor: MaterialStatePropertyAll(dc.colorPrimary)
        //           ),
        //         ),
        //         const SizedBox(height: 10.0,),
        //         TextButton.icon(
        //           onPressed: () {
        //             _showSettingsPanel();
        //           },
        //           icon: const Icon(Icons.settings), 
        //           label: const Text('Ustawienia'),
        //           style: ButtonStyle(
        //             fixedSize: const MaterialStatePropertyAll(Size(double.maxFinite, 70.0)),
        //             alignment: Alignment.centerLeft,
        //             foregroundColor: const MaterialStatePropertyAll(dc.colorTextSecondary),
        //             backgroundColor: MaterialStatePropertyAll(dc.colorPrimary)
        //           ),
        //         ),
        //       ],
        //     ),
        //   )
        // ),
        body: BrewList(),
      ),
    );
  }
}