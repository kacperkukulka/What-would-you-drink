import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:what_would_you_drink/models/brew.dart';
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

  Future<List<Brew>> userBrews() async {
    return await _database.brewCollection
      .where('userId', isEqualTo: userId)
      .get().then(_snapshotToBrew);
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
          sugars: s.get('sugars') ?? '0',
          milk: s.get('milk') ?? 0,
        )  
      )
      .toList();
  }

  Brew _snapshotToUserBrew(QuerySnapshot snapshot){
    var data = snapshot.docs[0];
    return Brew(
      userId: data.get('userId'),
      isActual: data.get('isActual'),
      roomId: data.get('roomId'),
      strength: data.get('strength'),
      sugars: data.get('sugars'),
      type: data.get('type'),
      milk: data.get('milk')
    );
  }
}