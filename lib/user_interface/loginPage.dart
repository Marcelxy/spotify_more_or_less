import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:spotify_more_or_less/user_interface/mainPage.dart';

void main() => runApp(SpotifyApp());

class SpotifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify More or Less',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  ProgressDialog progressDialog;

  @override
  Widget build(BuildContext context) {
    progressDialog = new ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    progressDialog.style(
        message: 'Login...',
      progressWidget: CircularProgressIndicator(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Spotify More or Less'),
        backgroundColor: Color.fromARGB(204, 27, 27, 27),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 260,
              child: GoogleSignInButton(
                onPressed: () => _signInWithGoogle(),
                darkMode: true,
                borderRadius: 10.0,
                text: 'Anmelden mit Google',
              ),
            ),
            SizedBox(
              width: 260,
              child: FacebookSignInButton(
                onPressed: () => _signInWithFacebook(),
                borderRadius: 10.0,
                text: 'Anmelden mit Facebook',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _signInWithGoogle() async {
    progressDialog.show();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    final FirebaseUser currentUser = await _auth.currentUser();
    print("Angemeldet über Google mit " + currentUser.email);
    Future.delayed(Duration(seconds: 1)).then((value) {
      progressDialog.hide().whenComplete(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      });
    });
    return 'signInWithGoogle erfolgreich: $user';
  }

  void _signInWithFacebook() async {}
}
