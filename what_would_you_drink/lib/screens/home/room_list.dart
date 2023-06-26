import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_would_you_drink/models/brew.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/models/room.dart';
import 'package:what_would_you_drink/screens/home/room_tile.dart';
import 'package:what_would_you_drink/services/brewService.dart';

class RoomList extends StatefulWidget {
  const RoomList({super.key, required this.rooms});
  
  final List<Room> rooms;

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.rooms.length,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      itemBuilder: (context, index){
        return RoomTile(room: widget.rooms[index]);
      }
    );
  }
}