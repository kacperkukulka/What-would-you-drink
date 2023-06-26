import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/models/room.dart';
import 'package:what_would_you_drink/screens/shared/loading.dart';
import 'package:what_would_you_drink/services/auth.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;
import 'package:what_would_you_drink/services/database.dart';
import 'package:what_would_you_drink/services/roomService.dart';
import 'add_room.dart';
import 'room_list.dart';
import 'package:what_would_you_drink/models/brew.dart';
import 'package:what_would_you_drink/screens/home/setting_form.dart';

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