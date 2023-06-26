import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/models/room.dart';
import 'package:what_would_you_drink/screens/shared/loading.dart';
import 'package:what_would_you_drink/services/room_service.dart';
import 'room_list.dart';

class RoomTabs extends StatelessWidget {
  const RoomTabs({super.key});

  @override
  Widget build(BuildContext context) {
    List<Room> rooms = Provider.of<List<Room>>(context);
    String userId = Provider.of<LightUser?>(context)!.uid;

    return StreamBuilder<List<String>>(
      stream: RoomService(uid: userId).userJoinedRoomsIds,
      builder: ((context, snapshot) => TabBarView(
        children: [
          RoomList(rooms: rooms.where((room) => room.userId != userId).toList()),
          RoomList(rooms: rooms.where((room) => room.userId == userId).toList()),
          snapshot.hasData? 
            RoomList(rooms: rooms.where(
              (room) => room.userId != userId && snapshot.data!.contains(room.uid)).toList()) 
            : const Loading()
        ]
      ))
    );
  }
}