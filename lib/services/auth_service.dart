import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/utils/firebase.dart';

class AuthService {
  User getCurrentUser() {
    User user = firebaseAuth.currentUser;
    return user;
  }

//create a firebase user
  Future<bool> createUser(
      {String name,
      User user,
      String email,
      String country,
      String password}) async {
    var res = await firebaseAuth.createUserWithEmailAndPassword(
      email: '$email',
      password: '$password',
    );
    if (res.user != null) {
      await saveUserToFirestore(name, res.user, email, country);
      return true;
    } else {
      return false;
    }
  }

//this will save the details inputted by the user to firestore.
  saveUserToFirestore(
      String name, User user, String email, String country) async {
    await usersRef.doc(user.uid).set({
      'username': name,
      'email': email,
      'time': Timestamp.now(),
      'id': user.uid,
      'bio': "",
      'country': country,
      'photoUrl': user.photoURL ?? ''
    });
  }

//function to login a user with his email and password
  Future<bool> loginUser({String email, String password}) async {
    var res = await firebaseAuth.signInWithEmailAndPassword(
      email: '$email',
      password: '$password',
    );

    if (res.user != null) {
      return true;
    } else {
      return false;
    }
  }

  forgotPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  logOut() async {
    await firebaseAuth.signOut();
  }

  String handleFirebaseAuthError(String e) {
    if (e.contains("ERROR_WEAK_PASSWORD")) {
      return "Хэцүү нууц үг оруулна уу";
    } else if (e.contains("invalid-email")) {
      return "Хүчингүй и-мэйл";
    } else if (e.contains("ERROR_EMAIL_ALREADY_IN_USE") ||
        e.contains('Бүртгэлтэй и-мэйл байна')) {
      return "Бүртгэлтэй и-мэйл байна.";
    } else if (e.contains("ERROR_NETWORK_REQUEST_FAILED")) {
      return "Интернет холболтоо шалгана уу";
    } else if (e.contains("ERROR_USER_NOT_FOUND") ||
        e.contains('firebase_auth/user-not-found')) {
      return "Нэвтрэх нэр буруу байна.";
    } else if (e.contains("ERROR_WRONG_PASSWORD") ||
        e.contains('wrong-password')) {
      return "Нууц үг буруу байна.";
    } else if (e.contains('firebase_auth/requires-recent-login')) {
      return 'This operation is sensitive and requires recent authentication.'
          ' Log in again before retrying this request.';
    } else {
      return e;
    }
  }
}
