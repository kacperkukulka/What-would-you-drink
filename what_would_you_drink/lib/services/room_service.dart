import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:what_would_you_drink/models/room.dart';
import 'package:what_would_you_drink/services/database.dart';

class RoomService {
  final String? uid;
  final DatabaseService _database = DatabaseService();

  RoomService({this.uid});

  Stream<List<Room>> get allRooms {
    return _database.roomCollection.snapshots()
      .map(_snapshotToRoom);
  }

  Stream<List<Room>> get userRooms {
    return _database.roomCollection.where('userId',isEqualTo: uid).snapshots()
      .map(_snapshotToRoom);
  }

  Stream<List<String>> get userJoinedRoomsIds {
    return _database.brewCollection.where('userId', isEqualTo: uid).snapshots()
      .map((event) => event.docs.map((e) => e.get('roomId') as String).toList());
  }

  Future<String> addRoom({required String name, required String userId}) async {
    var room = await _database.roomCollection.add({
      'name' : name,
      'userId' : userId,
      'creationDate' : Timestamp.now(),
    });
    return room.id;
  }

  void addIfNotExist(String userId) async {
    var potentialBrew = await _database.brewCollection
      .where("userId", isEqualTo: userId)
      .where("roomId", isEqualTo: uid)
      .limit(1).get();
      
    if(potentialBrew.size == 0){
      _database.brewCollection.add({
        "isActual" : true,
        "roomId" : uid,
        "strength" : 400,
        "sugars" : 4,
        "type" : "coffee",
        "userId" : userId
      });
    }
  }

  List<Room> _snapshotToRoom(QuerySnapshot snapshot){
    return snapshot.docs
      .map((s) => Room(
        uid: s.reference.id,
        creationDate: s.get('creationDate') ?? Timestamp.now(),
        name: s.get('name') ?? 'default',
        userId: s.get('userId')
      )).toList();
  }
}