import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:what_would_you_drink/models/brew.dart';
import 'package:what_would_you_drink/models/light_user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference collection = FirebaseFirestore.instance.collection('brews');

  Stream<List<Brew>> get brews {
    return collection.snapshots()
      .map((s) => _snapshotToBrew(s) );
  }

  Future addOrUpdate({required int sugars, required String name, required int strength}) async {
    // also creates a record if it does not exist 
    return await collection.doc(uid).set({
      'sugars' : sugars,
      'name': name,
      'strength' : strength
    });
  }

  List<Brew> _snapshotToBrew(QuerySnapshot snapshot){
    return snapshot.docs
      .map((s) => 
        Brew(
          name: s.get('name') ?? '',
          strength: s.get('strength') ?? 0,
          sugars: s.get('sugars') ?? '0'
        )  
      )
      .toList();
  }

  Stream<UserData> get userData{
    return collection.doc(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid!, 
      brew: Brew(
        name: snapshot.get('name'),
        strength: snapshot.get('strength'),
        sugars: snapshot.get('sugars')
      ) 
    );
  }
}