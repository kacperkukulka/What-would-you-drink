import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:what_would_you_drink/models/brew.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/models/room.dart';
import 'package:what_would_you_drink/models/user.dart';
import 'package:what_would_you_drink/services/database.dart';

class BrewService {
  final String? roomId;
  final String? userId;
  final DatabaseService _database = DatabaseService();

  BrewService({this.roomId, this.userId});

  Future<String> findBrewId() async {
    var doc = await _database.brewCollection
      .where('userId', isEqualTo: userId)
      .where('roomId', isEqualTo: roomId)
      .limit(1)
      .get();
    return doc.docs[0].id;
  }

  Stream<Brew> get userBrew {
    return _database.brewCollection
      .where('userId', isEqualTo: userId)
      .where('roomId', isEqualTo: roomId)
      .snapshots().map(_snapshotToUserBrew);
  }

  Stream<List<Brew>> get brews {
    return _database.brewCollection
      .where('roomId', isEqualTo: roomId)
      .snapshots()
      .map(_snapshotToBrew);
  }

  Future addOrUpdate({required int sugars, required int strength}) async {
    // also creates a record if it does not exist 
    return await _database.brewCollection.doc(roomId).set({
      'sugars' : sugars,
      'strength' : strength
    });
  }

  Future update({required Map<Object,Object?> newValues}) async {
    String brewId = await findBrewId();
    return await _database.brewCollection.doc(brewId).update(newValues);
  }

  List<Brew> _snapshotToBrew(QuerySnapshot snapshot){
    return snapshot.docs
      .map((s) => 
        Brew(
          isActual: s.get('isActual') ?? true,
          roomId: s.get('roomId'),
          type: s.get('type') ?? 'coffee',
          userId: s.get('userId') ?? userId,
          strength: s.get('strength') ?? 0,
          sugars: s.get('sugars') ?? '0'
        )  
      )
      .toList();
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

  Brew _snapshotToUserBrew(QuerySnapshot snapshot){
    var data = snapshot.docs[0];
    return Brew(
      userId: data.get('userId'),
      isActual: data.get('isActual'),
      roomId: data.get('roomId'),
      strength: data.get('strength'),
      sugars: data.get('sugars'),
      type: data.get('type')
    );
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