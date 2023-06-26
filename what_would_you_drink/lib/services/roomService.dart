import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:what_would_you_drink/models/brew.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/models/room.dart';
import 'package:what_would_you_drink/models/user.dart';
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

  // Future addOrUpdate({required int sugars, required String name, required int strength}) async {
  //   // also creates a record if it does not exist 
  //   return await _database.brewCollection.doc(uid).set({
  //     'sugars' : sugars,
  //     'name': name,
  //     'strength' : strength
  //   });
  // }

  // List<Brew> _snapshotToBrew(QuerySnapshot snapshot){
  //   return snapshot.docs
  //     .map((s) => 
  //       Brew(
  //         isActual: s.get('isActual') ?? true,
  //         roomId: s.get('roomId'),
  //         type: s.get('type') ?? 'coffee',
  //         userId: s.get('userId') ?? uid,
  //         strength: s.get('strength') ?? 0,
  //         sugars: s.get('sugars') ?? '0'
  //       )  
  //     )
  //     .toList();
  // }

  List<Room> _snapshotToRoom(QuerySnapshot snapshot){
    return snapshot.docs
      .map((s) => Room(
        uid: s.reference.id,
        creationDate: s.get('creationDate') ?? Timestamp.now(),
        name: s.get('name') ?? 'default',
        userId: s.get('userId')
      )).toList();
  }

  // Stream<UserData> get userData{
  //   return _database.userCollection.doc(uid).snapshots()
  //     .map(_userDataFromSnapshot);
  // }

  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  //   return UserData(
  //     uid: uid!, 
  //     brew: 
  //   );
  // }
}