import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:what_would_you_drink/models/light_user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  LightUser? _lightUserFromUser(User? user){
    return user != null ? LightUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<LightUser?> get user {
    return _auth.authStateChanges()
      .map(_lightUserFromUser);
  }


  // sign in anonymous
  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _lightUserFromUser(user);
    }
    catch(err){
      debugPrint('Could not sign in anonymously: ${err.toString()}');
      return null;
    }
  }
  // sign in with email and pass

  // register with email and pass

  // sign out
  Future singOut() async {
    try{
      return await _auth.signOut();
    }
    catch(err){
      debugPrint('Could not sign out: ${err.toString()}');
      return null;
    }
  }
}