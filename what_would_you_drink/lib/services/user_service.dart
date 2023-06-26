import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future addOrUpdate({required String name}) async {
    // also creates a record if it does not exist 
    return await _database.userCollection.doc(uid).set({
      'name': name,
    });
  }

  UserDb _snapshotToUser(DocumentSnapshot snapshot){
    return UserDb(name: snapshot.get('name'));
  }
}