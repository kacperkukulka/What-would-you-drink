import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference roomCollection = FirebaseFirestore.instance.collection('rooms');
}