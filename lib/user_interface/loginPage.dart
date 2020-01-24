import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:spotify_more_or_less/user_interface/mainPage.dart';
import 'package:spotify_more_or_less/datastructures/user.dart';
import 'package:spotify_more_or_less/helper/systemSettings.dart';

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
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookSignIn = FacebookLogin();
  ProgressDialog _progressDialog;

  @override
  void initState() {
    super.initState();
    SystemSettings.allowOnlyPortraitOrientation();
    _progressDialog =
        new ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    _progressDialog.style(
      message: 'Login...',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(218, 0, 0, 0),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/loginPageImage.jpg"),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.90), BlendMode.softLight),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                  child: Opacity(
                    opacity: 0.92,
                    child: SizedBox(
                      width: 260,
                      child: Builder(
                        builder: (context) => GoogleSignInButton(
                          onPressed: () => _signInWithGoogle(),
                          darkMode: true,
                          borderRadius: 10.0,
                          text: 'Anmelden mit Google',
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                  child: Opacity(
                    opacity: 0.92,
                    child: SizedBox(
                      width: 260,
                      child: Builder(
                        builder: (context) => FacebookSignInButton(
                          onPressed: () => _signInWithFacebook(context),
                          borderRadius: 10.0,
                          text: 'Anmelden mit Facebook',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    try {
      _progressDialog.show();
      final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
      final AuthResult authResult = await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;
      final FirebaseUser currentUser = await _auth.currentUser();
      _createUserInCloudFirestore(user);
      Future.delayed(Duration(milliseconds: 100)).then((value) {
        _progressDialog.hide().whenComplete(() {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
        });
      });
      print("Erfolgreich angemeldet über Google mit " + currentUser.email);
    } catch (error) {
      print('SIGN IN ERROR: ' + error);
      _progressDialog.hide();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: const Text("Anmeldung fehlgeschlagen. Bitte erneut versuchen."),
      ));
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      _progressDialog.show();
      _facebookSignIn.loginBehavior = FacebookLoginBehavior.webViewOnly;
      final FacebookLoginResult facebookLoginResult = await _facebookSignIn.logIn(['email']);
      if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
        FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
        final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: facebookAccessToken.token);
        final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
        final FirebaseUser currentUser = await _auth.currentUser();
        _createUserInCloudFirestore(user);
        print("Erfolgreich angemeldet über Facebook mit " + currentUser.email);
        Future.delayed(Duration(seconds: 1)).then((value) {
          _progressDialog.hide().whenComplete(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
          });
        });
      }
    } catch (error) {
      print('SIGN IN ERROR: ' + error);
      _progressDialog.hide();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: const Text("Anmeldung fehlgeschlagen. Bitte erneut versuchen."),
      ));
    }
  }

  Future<void> _createUserInCloudFirestore(FirebaseUser currentUser) async {
    final userSnapShot = await Firestore.instance.collection('users').document(currentUser.uid).get();
    if (userSnapShot == null || !userSnapShot.exists) {
      Map<String, int> map = {'global': 0, 'germany': 0, 'greatBritain': 0, 'america': 0, 'eighty': 0, 'ninety': 0};
      User user = new User(currentUser.email, map);
      Firestore.instance
          .collection('users')
          .document(currentUser.uid)
          .setData({'e-mail': user.email, 'highscorePoints': map});
    }
  }
}
