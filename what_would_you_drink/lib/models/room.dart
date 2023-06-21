import 'package:cloud_firestore/cloud_firestore.dart';

class Room{
  final String uid;
  final String name;
  final Timestamp creationDate;
  final String userId;

  Room({
    required this.uid,
    required this.name,
    required this.creationDate,
    required this.userId
  });
}