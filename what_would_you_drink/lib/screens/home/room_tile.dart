import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;
import 'package:what_would_you_drink/models/room.dart';
import 'package:what_would_you_drink/screens/room/room_widget.dart';
import 'package:what_would_you_drink/services/room_service.dart';
import 'package:what_would_you_drink/services/user_service.dart';

import '../../models/light_user.dart';
import '../../models/user.dart';

class RoomTile extends StatelessWidget {
  const RoomTile({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {

    Widget goToRoomButton(){
      return IconButton(
        onPressed: () {
          RoomService(uid: room.uid)
            .addIfNotExist(Provider.of<LightUser?>(context, listen: false)!.uid);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => RoomWidget(uid: room.uid, roomName: room.name,))
          );
        }, 
        icon: const Icon(Icons.double_arrow_rounded), 
      );
    }

    Future<void> deleteDialogBuilder(BuildContext context){
      return showDialog<void>(
        context: context,
        builder: (context){
          return AlertDialog(
            alignment: Alignment.center,
            title: Text('Usuwanie pokoju "${room.name}"'),
            content: const Text('Czy napewno chcesz usunąć ten pokój oraz wszystkie dane o użytkownikach którzy są w tym pokoju?'),
            actions: [
              ElevatedButton(
                child: const Text("Usuń"),
                onPressed: () async { 
                  await RoomService(uid: room.uid).removeRoom().then((_) => Navigator.pop(context));
                },
              ),
              ElevatedButton(
                child: const Text("Anuluj"),
                onPressed: (){ Navigator.pop(context); },
              )
            ],
          );
        }
      );
    }

    Widget deleteRoomButton(){
      return IconButton(
        onPressed: () async {
          await deleteDialogBuilder(context);
        }, 
        icon: const Icon(Icons.delete), 
      );
    }

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
          trailing: room.userId == Provider.of<LightUser?>(context)!.uid ?
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                goToRoomButton(),
                deleteRoomButton()
              ]
            ) : goToRoomButton(),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
      ],
    );
  }
}
