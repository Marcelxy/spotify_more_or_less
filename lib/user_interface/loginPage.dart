import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import'package:flutter_facebook_login/flutter_facebook_login.dart';
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _signInWithGoogle() async {
    _progressDialog.show();
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    final FirebaseUser currentUser = await _auth.currentUser();
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      _progressDialog.hide().whenComplete(() {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
      });
    });
    print("Angemeldet über Google mit " + currentUser.email);
    return 'signInWithGoogle erfolgreich: $user';
  }

  Future<FirebaseUser> _signInWithFacebook() async {
    FirebaseUser currentUser;
    _facebookSignIn.loginBehavior = FacebookLoginBehavior.webViewOnly;
    try {
      _progressDialog.show();
      final FacebookLoginResult facebookLoginResult = await _facebookSignIn.logIn(['email']);
      if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
        FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
        final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: facebookAccessToken.token);
        final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
        currentUser = await _auth.currentUser();
        _createUserInCloudFirestore(user);
        print("Angemeldet über Facebook mit " + currentUser.email);
        Future.delayed(Duration(seconds: 1)).then((value) {
          _progressDialog.hide().whenComplete(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
          });
        });
        return currentUser;
      }
    } catch (e) {
      print(e);
      return currentUser;
    }
    return null;
  }

  void _createUserInCloudFirestore(FirebaseUser currentUser) {
    Map<String, int> map = {'global': 0, 'germany': 0, 'greatBritain': 0, 'eighty': 0, 'ninety': 0};
    User user = new User(currentUser.email, map);
    Firestore.instance
        .collection('users')
        .document(currentUser.uid)
        .setData({'e-mail': user.email, 'highscorePoints': map});
  }
}
