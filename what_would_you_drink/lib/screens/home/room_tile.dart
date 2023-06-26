import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;
import 'package:what_would_you_drink/models/room.dart';
import 'package:what_would_you_drink/screens/room/room_widget.dart';
import 'package:what_would_you_drink/services/roomService.dart';
import 'package:what_would_you_drink/services/userService.dart';

import '../../models/light_user.dart';
import '../../models/user.dart';

class RoomTile extends StatelessWidget {
  const RoomTile({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10.0,),
        ListTile(
          tileColor: dc.colorBg,
          title: Text(room.name),
          subtitle: StreamBuilder<UserDb>(
            stream: UserService(uid: room.userId).user, 
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Text(snapshot.data!.name);
              }
              return const Text('...');
            },
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.brown[100],
          ),
          trailing: IconButton(
            onPressed: () {
              RoomService(uid: room.uid)
                .addIfNotExist(Provider.of<LightUser?>(context, listen: false)!.uid);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => RoomWidget(uid: room.uid, roomName: room.name,))
              );
            }, 
            icon: const Icon(Icons.double_arrow_rounded), 
          ),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
      ],
    );
  }
}
