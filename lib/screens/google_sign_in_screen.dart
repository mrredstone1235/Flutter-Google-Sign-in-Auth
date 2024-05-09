import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn(
  clientId:
      '453857130577-6d0s415irhkshs8pb48bestpmptg783h.apps.googleusercontent.com',
);

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In using google account'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final UserCredential? userCredential = await signInWithGoogle();
                if (userCredential != null) {
                  // Signed in
                  print('User: ${userCredential.user!.displayName}');
                  print('Sign in Successful');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Logged in as: ${userCredential.user!.displayName}'),
                  ));
                } else {
                  // Sign in failed
                  print('Sign in failed');
                }
              },
              child: Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow.
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the authentication details for the signed-in user.
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential.
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential.
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      // Handle sign-in errors.
      print("Error signing in with Google: $error");
      return null;
    }
  }
}
