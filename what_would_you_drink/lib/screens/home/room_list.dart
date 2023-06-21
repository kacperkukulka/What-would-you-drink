import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_would_you_drink/models/brew.dart';
import 'package:what_would_you_drink/models/room.dart';
import 'package:what_would_you_drink/screens/home/room_tile.dart';

class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  @override
  Widget build(BuildContext context) {

    final rooms = Provider.of<List<Room>>(context);
    
    return ListView.builder(
      physics: BouncingScrollPhysics() ,
      itemCount: rooms.length,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      itemBuilder: (context, index){
        return RoomTile(room: rooms[index]);
      }
    );
  }
}