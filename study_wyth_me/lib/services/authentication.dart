import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_wyth_me/models/custom_user.dart';
import 'package:study_wyth_me/services/database.dart';

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
  Future<String> customSignUp(String email, String username, String password) async {
    try {
      bool usernameUsed = false;
      Query query = FirebaseFirestore.instance.collection('userDatabase').where('username', isEqualTo: username);
      await query.get().then((result) => usernameUsed = result.size != 0);

      if (usernameUsed) {
        return 'This username has been taken up.';
      } else {
        UserCredential result = await _authenticate
            .createUserWithEmailAndPassword(email: email, password: password);

        // create a new document for the user with the uid
        await DatabaseService(uid: result.user!.uid).createNewUser(username);
        return '';
      }
    } on FirebaseAuthException catch (authException) {
      String error = authException.code;
      if (error == 'email-already-in-use') {
        return 'There exists an account with this email.';
      } else {
        return 'Please try again.';
      }
    } catch (exception) {
      return 'Please try again.';
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

  Future<String> customResetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'Email sent!';
    } on FirebaseAuthException catch (authException) {
      String error = authException.code;
      if (error == 'invalid-email') {
        return 'Invalid email.';
      } else if (error == 'user-not-found') {
        return 'No account found with that email.';
      } else {
        return 'Please try again.';
      }
    } catch (exception) {
      return 'Please try again.';
    }
  }
}