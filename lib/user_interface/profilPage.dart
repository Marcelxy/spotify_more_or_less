import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:spotify_more_or_less/user_interface/loginPage.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Profil'),
      backgroundColor: Color.fromARGB(204, 27, 27, 27),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.input), onPressed: () => _signOut()),
          ],
    ));
  }

  void _signOut() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
