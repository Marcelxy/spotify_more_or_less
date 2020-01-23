import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:spotify_more_or_less/user_interface/loginPage.dart';
import 'package:spotify_more_or_less/helper/systemSettings.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  void initState() {
    super.initState();
    SystemSettings.allowOnlyPortraitOrientation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(218, 0, 0, 0),
        child: Column(
          children: <Widget>[
            Flexible(
              child: Center(
                  child: Text(
                'Ist noch in Arbeit!',
                style: TextStyle(color: Colors.redAccent, fontSize: 24.0),
              )),
            ),
          ],
        ),
      ),
    );
  }

  void _signOut() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
