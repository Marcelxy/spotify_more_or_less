import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:spotify_more_or_less/helper/systemSettings.dart';

class HighscorePage extends StatefulWidget {
  @override
  _HighscorePageState createState() => _HighscorePageState();
}

class _HighscorePageState extends State<HighscorePage> {
  @override
  void initState() {
    super.initState();
    SystemSettings.allowOnlyPortraitOrientation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ranglisten'),
          backgroundColor: Color.fromARGB(204, 27, 27, 27),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('users').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: Text('Loading...'));
              default:
                return ListView(
                  children: snapshot.data.documents.map((DocumentSnapshot document) {
                    return ListTile(
                      title: Text(document['e-mail']),
                      subtitle: Text(document['hpWorldwide']),
                    );
                  }).toList(),
                );
            }
          },
        ));
  }
}
