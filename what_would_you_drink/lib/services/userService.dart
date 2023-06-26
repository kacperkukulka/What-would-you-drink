import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:what_would_you_drink/models/brew.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/models/room.dart';
import 'package:what_would_you_drink/models/user.dart';
import 'package:what_would_you_drink/services/database.dart';

class UserService {
  final String? uid;
  final DatabaseService _database = DatabaseService();

  UserService({this.uid});

  Stream<UserDb> get user {
    return _database.userCollection.doc(uid).snapshots()
      .map(_snapshotToUser);
  } 


  // Stream<List<Brew>> get brews {
  //   return _database.brewCollection.snapshots()
  //     .map((s) => _snapshotToBrew(s) );
  // }

  // Stream<List<Room>> get allRooms {
  //   return _database.brewCollection.snapshots()
  //     .map(_snapshotToRoom);
  // }

  // Stream<List<Room>> get userRooms {
  //   return _database.brewCollection.where('userId',isEqualTo: uid).snapshots()
  //     .map(_snapshotToRoom);
  // }

  Future addOrUpdate({required String name}) async {
    // also creates a record if it does not exist 
    return await _database.userCollection.doc(uid).set({
      'name': name,
    });
  }

  UserDb _snapshotToUser(DocumentSnapshot snapshot){
    return UserDb(name: snapshot.get('name'));
  }

  // List<Room> _snapshotToRoom(QuerySnapshot snapshot){
  //   return snapshot.docs
  //     .map((s) => Room(
  //       creationDate: s.get('creationDate') ?? Timestamp.now(),
  //       name: s.get('name') ?? 'default',
  //       userId: s.get('userId')
  //     )).toList();
  // }

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