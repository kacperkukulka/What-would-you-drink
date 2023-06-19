// user that has only informations that are needed
import 'package:what_would_you_drink/models/brew.dart';

class LightUser {
  final String uid;

  LightUser({required this.uid});
}

class UserData {
  final String uid;
  final Brew brew;
  UserData({
    required this.uid,
    required this.brew
  });
}