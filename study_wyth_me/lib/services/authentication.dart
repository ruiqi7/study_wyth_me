import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_wyth_me/models/custom_user.dart';

class Authentication {

  final FirebaseAuth _authenticate = FirebaseAuth.instance;

  // create CustomUser based on Firebase's User
  CustomUser? _getCustomUser(User? user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // stream of users whenever there is a change in authentication
  Stream<CustomUser?> get usersStream {
    return _authenticate.authStateChanges().map(_getCustomUser);
  }

  // sign up
  Future customSignUp(String email, String username, String password) async {
    try {
      UserCredential result = await _authenticate.createUserWithEmailAndPassword(email: email, password: password);
      return _getCustomUser(result.user);
    } catch (exception) {
      return null;
    }
  }

  // sign in
  Future customSignIn(String email, String password) async {
    try {
      UserCredential result = await _authenticate.signInWithEmailAndPassword(email: email, password: password);
      return _getCustomUser(result.user);
    } catch (exception) {
      return null;
    }
  }

  // sign out
  Future customSignOut() async {
    try {
      return await _authenticate.signOut();
    } catch (exception) {
      return null;
    }
  }
}