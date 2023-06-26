import 'package:flutter/material.dart';
import 'package:what_would_you_drink/models/brew.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;
import 'package:what_would_you_drink/models/user.dart';
import 'package:what_would_you_drink/services/user_service.dart';

class BrewTile extends StatelessWidget {
  const BrewTile({super.key, required this.brew});

  final Brew brew;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10.0,),
        Opacity(
          opacity: brew.isActual ? 1 : 0.4,
          child: ListTile(
            tileColor: brew.isActual ? dc.colorBg! : dc.colorBg!.withOpacity(0.4),
            title: StreamBuilder<UserDb>(
              stream: UserService(uid: brew.userId).user, 
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Text(snapshot.data!.name);
                }
                return const Text('...');
              },
            ),
            subtitle: Text(brew.sugarStringPL()),
            leading: CircleAvatar(
              backgroundColor: Colors.brown[brew.strength],
            ),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          ) ,
        )
      ],
    );
  }
}
