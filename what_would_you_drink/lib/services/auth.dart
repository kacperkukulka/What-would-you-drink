import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:what_would_you_drink/models/light_user.dart';
import 'package:what_would_you_drink/models/user.dart';
import 'package:what_would_you_drink/services/user_service.dart';

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
  Future singInUserPass(String email, String pass) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      User? user = result.user;
      return _lightUserFromUser(user);
    }
    catch(err){
      debugPrint('Could not log in: ${err.toString()}');
      return null;
    }
  }

  // register with email and pass

  Future register(String email, String pass) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      User? user = result.user;
      if(user != null){
        await UserService(uid: user.uid).addOrUpdate(
          name: user.email!.split('@')[0],
          pictureId: Random().nextInt(picMaxNum)
        );
      }
      return _lightUserFromUser(user);
    }
    catch(err){
      debugPrint('Could not register: ${err.toString()}');
      return null;
    }
  }

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